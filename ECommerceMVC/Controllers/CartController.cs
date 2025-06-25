using ECommerceMVC.Data;
using ECommerceMVC.ViewModels;
using Microsoft.AspNetCore.Mvc;
using ECommerceMVC.Helpers;
using QRCoder;
using System.Drawing.Imaging;
using Microsoft.EntityFrameworkCore;

namespace ECommerceMVC.Controllers
{
	public class CartController : Controller
	{
		private readonly Hshop2023Context db;

		public CartController(Hshop2023Context context)
		{
			db = context;
		}

		public List<CartItem> Cart => HttpContext.Session.Get<List<CartItem>>(MySetting.CART_KEY) ?? new List<CartItem>();

		public IActionResult Index()
		{
			return View(Cart);
		}

		public IActionResult AddToCart(int id, int quantity = 1)
		{
			var gioHang = Cart;
			var item = gioHang.SingleOrDefault(p => p.MaHh == id);
			if (item == null)
			{
				var hangHoa = db.HangHoas.SingleOrDefault(p => p.MaHh == id);
				if (hangHoa == null)
				{
					TempData["Message"] = $"Không tìm thấy hàng hóa có mã {id}";
					return Redirect("/404");
				}
				item = new CartItem
				{
					MaHh = hangHoa.MaHh,
					TenHH = hangHoa.TenHh,
					DonGia = hangHoa.DonGia ?? 0,
					Hinh = hangHoa.Hinh ?? string.Empty,
					SoLuong = quantity
				};
				gioHang.Add(item);
			}
			else
			{
				item.SoLuong += quantity;
			}

			HttpContext.Session.Set(MySetting.CART_KEY, gioHang);

			return RedirectToAction("Index");
		}

		public IActionResult RemoveCart(int id)
		{
			var gioHang = Cart;
			var item = gioHang.SingleOrDefault(p => p.MaHh == id);
			if (item != null)
			{
				gioHang.Remove(item);
				HttpContext.Session.Set(MySetting.CART_KEY, gioHang);
			}
			return RedirectToAction("Index");
		}

        [HttpPost]
        public IActionResult UpdateQuantity([FromBody] UpdateQuantityModel data)
        {
            var gioHang = Cart;
            var item = gioHang.SingleOrDefault(p => p.MaHh == data.Id);
            if (item != null)
            {
                if (data.Quantity <= 0)
                    gioHang.Remove(item);
                else
                    item.SoLuong = data.Quantity;

                HttpContext.Session.Set(MySetting.CART_KEY, gioHang);

                return Json(new
                {
                    success = true,
                    quantity = item.SoLuong,
                    totalItemPrice = item.ThanhTien,
                    cartTotal = gioHang.Sum(p => p.ThanhTien)
                });
            }

            return Json(new { success = false });
        }

        public class UpdateQuantityModel
        {
            public int Id { get; set; }
            public int Quantity { get; set; }
        }
        public IActionResult Checkout()
        {
            var khachHang = HttpContext.Session.Get<KhachHang>("KhachHang");
            if (khachHang == null)
            {
                TempData["Message"] = "Vui lòng đăng nhập để tiếp tục thanh toán.";
                return RedirectToAction("DangNhap", "KhachHang");
            }

            var cart = Cart;
            if (cart == null || !cart.Any())
            {
                TempData["Message"] = "Giỏ hàng của bạn đang trống.";
                return RedirectToAction("Index");
            }

            var total = cart.Sum(p => p.ThanhTien);

            string bankCode = "MB"; // MB Bank
            string accountNumber = "0962698931"; // Thay bằng STK thực tế
            string accountName = "Ly Tien Khoi";  // KHÔNG dấu
            string content = "Thanh toan don hang " + DateTime.Now.Ticks;

            string qrUrl = $"https://img.vietqr.io/image/{bankCode}-{accountNumber}-compact.png" +
                           $"?amount={total}&addInfo={Uri.EscapeDataString(content)}&accountName={Uri.EscapeDataString(accountName)}";

            ViewBag.QRCodeUrl = qrUrl;
            ViewBag.Total = total;
            ViewBag.Content = content;
            ViewBag.KhachHang = khachHang; // nếu cần hiển thị tên/email

            return View();
        }


        public IActionResult CancelOrder()
        {
            HttpContext.Session.Remove(MySetting.CART_KEY);
            TempData["Message"] = "Đã hủy đơn hàng.";
            return RedirectToAction("Index");
        }
        public IActionResult Bill(int id)
        {
            var hoaDon = db.HoaDons
                .Where(h => h.MaHd == id)
                .Include(h => h.ChiTietHds)
                    .ThenInclude(ct => ct.MaHhNavigation)
                .Include(h => h.MaKhNavigation)
                .Include(h => h.MaTrangThaiNavigation)
                .FirstOrDefault();

            if (hoaDon == null)
                return NotFound();

            return View(hoaDon);
        }

        public IActionResult ConfirmPayment()
        {
            var cart = Cart;
            if (cart == null || !cart.Any())
            {
                TempData["Message"] = "Giỏ hàng trống.";
                return RedirectToAction("Index");
            }


            // Giả sử bạn có thông tin khách hàng từ session
            var khachHang = HttpContext.Session.Get<KhachHang>("KhachHang");
            if (khachHang == null)
            {
                TempData["Message"] = "Vui lòng đăng nhập trước khi thanh toán.";
                return RedirectToAction("DangNhap", "KhachHang");
            }

            var hoaDon = new HoaDon
            {
                MaKh = khachHang.MaKh,
                NgayDat = DateTime.Now,
                CachThanhToan = "Chuyển khoản VietQR",
                CachVanChuyen = "Giao hàng tiêu chuẩn",
                PhiVanChuyen = 0, // tuỳ logic của bạn
                MaTrangThai = 2,  // 2 = Thanh toán thành công
                HoTen = khachHang.HoTen,
                DiaChi = khachHang.DiaChi ?? "Không rõ",
                GhiChu = "Thanh toán qua QR - auto",
            };

            db.HoaDons.Add(hoaDon);
            db.SaveChanges();

            foreach (var item in cart)
            {
                var cthd = new ChiTietHd
                {
                    MaHd = hoaDon.MaHd,
                    MaHh = item.MaHh,
                    DonGia = item.DonGia,
                    SoLuong = item.SoLuong,
                    GiamGia = 0
                };
                db.ChiTietHds.Add(cthd);
            }

            db.SaveChanges();

            // Xoá giỏ hàng sau khi thanh toán
            HttpContext.Session.Remove(MySetting.CART_KEY);

            // Điều hướng tới trang hóa đơn
            return RedirectToAction("Bill", new { id = hoaDon.MaHd });
        }

    }
}

