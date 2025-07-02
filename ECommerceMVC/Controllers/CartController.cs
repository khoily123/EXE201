using Azure.Core;
using ECommerceMVC.Data;
using ECommerceMVC.Helpers;
using ECommerceMVC.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OnlineClothing.Models.MoMo;
using QRCoder;
using System.Drawing.Imaging;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using static QRCoder.PayloadGenerator;

namespace ECommerceMVC.Controllers
{
	public class CartController : Controller
	{
		private readonly Hshop2023Context db;
        private static readonly HttpClient client = new HttpClient();
        private CollectionLinkRequest _request = new CollectionLinkRequest();
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
        public async Task<IActionResult> CheckoutAsync()
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


            string accessKey = "F8BBA842ECF85";
            string secretKey = "K951B6PE1waDMi640xX08PD3vg6EkVlz";

            _request.orderId = Guid.NewGuid().ToString();
            _request.orderInfo = $"Order [{_request.orderId}]";

            //UserVoucher userVoucher = await _context.UserVouchers
            //    .Where(uv => uv.Status == 1 && uv.EndDate < DateTime.UtcNow)
            //    .FirstOrDefaultAsync(uv => uv.UserId == Guid.Parse(userId));

            int? discount = 0;

            _request.amount = (long)total;
            List<MoMoItem> items = new List<MoMoItem>();    
            foreach (var item in cart)
            {
                items.Add(new MoMoItem
                {
                    Id = item.MaHh,
                    Name = item.TenHH,
                    Price = (long)item.DonGia,
                    Currency = "VND",
                    Quantity = item.SoLuong,
                    TotalPrice = (long)item.ThanhTien
                });
            }
            _request.Items = items;
            _request.lang = "vi";

            var userInfo = db.KhachHangs.FirstOrDefault(kh => kh.MaKh == khachHang.MaKh);

            _request.UserInfo = new MoMoUserInfo { Name = userInfo.HoTen, PhoneNumber = userInfo.DienThoai, Address = userInfo.DiaChi };
            _request.partnerCode = "MOMO";
            _request.redirectUrl = "http://localhost:5222/Payment/Result";
            _request.ipnUrl = "localhost:8080/Payment/Result";
            _request.requestId = _request.orderId;
            _request.requestType = "payWithMethod";
            _request.extraData = "";
            _request.storeId = "Online Clothing Shop";
            _request.autoCapture = true;
            //_request.amount = 1000;

            var rawSignature = "accessKey=" + accessKey
                + "&amount=" + _request.amount
                + "&extraData=" + _request.extraData
                + "&ipnUrl=" + _request.ipnUrl
                + "&orderId=" + _request.orderId
                + "&orderInfo=" + _request.orderInfo
                + "&partnerCode=" + _request.partnerCode
                + "&redirectUrl=" + _request.redirectUrl
                + "&requestId=" + _request.requestId
                + "&requestType=" + _request.requestType;
            _request.signature = getSignature(rawSignature, secretKey);

            StringContent httpContent = new StringContent(JsonSerializer.Serialize(_request), System.Text.Encoding.UTF8, "application/json");
            var quickPayResponse = await client.PostAsync("https://test-payment.momo.vn/v2/gateway/api/create", httpContent);
            var contentsString = await quickPayResponse.Content.ReadAsStringAsync();

            //Console.WriteLine("-----------------------------------------------------------------");
            //Console.WriteLine(contentsString);
            //Console.WriteLine("-----------------------------------------------------------------");

            var response = JsonSerializer.Deserialize<PaymentResult>(contentsString);

            if (response == null || string.IsNullOrEmpty(response.PayUrl))
            {
                TempData["error"] = "Không thể tạo link thanh toán";
                return RedirectToAction("Index"); // or return a View if you prefer
            }

            // Nếu có PayUrl, tạo đơn hàng và chi tiết
            HoaDon order = new()
            {
                MaKh = khachHang.MaKh,
                NgayDat = DateTime.Now,
                HoTen = _request.UserInfo.Name,
                DiaChi = _request.UserInfo.Address,
                CachThanhToan = "Online",
                CachVanChuyen = "Standard",
                PhiVanChuyen = 0,
                MaTrangThai = 1,
                GhiChu = "Thanh toán qua MoMo - ",
            };

            await db.HoaDons.AddAsync(order);

            // create order details
            //foreach (CartItem cd in Cart)
            //{
            //    var hangHoa = db.HangHoas.FirstOrDefault(h => h.MaHh == cd.MaHh);
            //    VChiTietHoaDon ct = new()
            //    {
            //        MaHd = order.MaHd,
            //        MaHh = cd.MaHh,
            //        DonGia = cd.DonGia,
            //        SoLuong = cd.SoLuong,
            //        GiamGia = 0,
            //        TenHh = hangHoa?.TenHh ?? "unknown"
            //    };

            //    await db.VChiTietHoaDons.AddAsync(ct);
            //}

            await db.SaveChangesAsync();

            return Redirect(response.PayUrl!);

        }

        private static string getSignature(string text, string key)
        {
            UTF8Encoding encoding = new UTF8Encoding();

            byte[] textBytes = encoding.GetBytes(text);
            byte[] keyBytes = encoding.GetBytes(key);

            using HMACSHA256 hash = new HMACSHA256(keyBytes);
            byte[] hashBytes = hash.ComputeHash(textBytes);

            return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
        }


        public IActionResult CancelOrder()
        {
            //HttpContext.Session.Remove(MySetting.CART_KEY);
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

