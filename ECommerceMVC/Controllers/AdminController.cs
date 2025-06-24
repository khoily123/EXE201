using ECommerceMVC.Data;
using ECommerceMVC.Helpers;
using Microsoft.AspNetCore.Mvc;

namespace ECommerceMVC.Controllers
{
    public class AdminController : Controller
    {
        private readonly Hshop2023Context _context;

        public AdminController(Hshop2023Context context)
        {
            _context = context;
        }

        public IActionResult Dashboard()
        {
            var tongNguoiDung = _context.KhachHangs.Count();
            var tongNhaCungCap = _context.NhaCungCaps.Count();
            var tongSanPham = _context.HangHoas.Count();
            var tongDonHang = _context.HoaDons.Count();
            var tongDoanhThu = _context.ChiTietHds.Sum(ct => ct.DonGia * ct.SoLuong * (1 - ct.GiamGia));

            // Thống kê thêm
            var donHangChoXuLy = _context.HoaDons.Count(hd => hd.MaTrangThai == 0);
            var donHangDangXuLy = _context.HoaDons.Count(hd => hd.MaTrangThai == 1);
            var donHangThanhCong = _context.HoaDons.Count(hd => hd.MaTrangThai == 2);
            var donHangBiHuy = _context.HoaDons.Count(hd => hd.MaTrangThai == 3);

            ViewBag.TongNguoiDung = tongNguoiDung;
            ViewBag.TongNhaCungCap = tongNhaCungCap;
            ViewBag.TongSanPham = tongSanPham;
            ViewBag.TongDonHang = tongDonHang;
            ViewBag.TongDoanhThu = tongDoanhThu;

            ViewBag.DonHangChoXuLy = donHangChoXuLy;
            ViewBag.DonHangDangXuLy = donHangDangXuLy;
            ViewBag.DonHangThanhCong = donHangThanhCong;
            ViewBag.DonHangBiHuy = donHangBiHuy;
            return View();
        }

        public IActionResult KH()
        {
            var list = _context.KhachHangs.Where(n => n.VaiTro == 0).ToList();
            return View(list);
        }

        public IActionResult EditKH(string id)
        {
            var kh = _context.KhachHangs.FirstOrDefault(k => k.MaKh == id);
            if (kh == null) return NotFound();
            return View(kh);
        }

        [HttpPost]
        public IActionResult EditKH(KhachHang model)
        {
            if (ModelState.IsValid)
            {
                var existing = _context.KhachHangs.FirstOrDefault(k => k.MaKh == model.MaKh);
                if (existing == null) return NotFound();

                existing.HoTen = model.HoTen;
                existing.Email = model.Email;
                existing.DiaChi = model.DiaChi;
                existing.DienThoai = model.DienThoai;
                existing.VaiTro = model.VaiTro;
                existing.HieuLuc = model.HieuLuc;
                existing.GioiTinh = model.GioiTinh;
                existing.NgaySinh = model.NgaySinh;
                existing.Hinh = model.Hinh;

                if (!string.IsNullOrWhiteSpace(model.MatKhau))
                {
                    existing.RandomKey = Guid.NewGuid().ToString().Substring(0, 5);
                    existing.MatKhau = model.MatKhau.ToMd5Hash(existing.RandomKey);
                }

                _context.SaveChanges();
                TempData["SuccessMessage"] = "Cập nhật khách hàng thành công!";
                return RedirectToAction("KH");
            }

            return View(model);
        }


        public IActionResult CreateKH()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CreateKH(KhachHang model)
        {
            if (ModelState.IsValid)
            {
                model.RandomKey = Guid.NewGuid().ToString().Substring(0, 5);
                model.MatKhau = model.MatKhau?.ToMd5Hash(model.RandomKey);
                model.VaiTro = 0; 
                model.Hinh ??= "User.png";

                _context.KhachHangs.Add(model);
                _context.SaveChanges();
                TempData["SuccessMessage"] = "Thêm khách hàng thành công!";
                return RedirectToAction("KH");
            }

            return View(model);
        }


        [HttpPost]
        [Route("Admin/DeleteKHViaAjax/{id}")]
        public IActionResult DeleteKH(string id)
        {
            var kh = _context.KhachHangs.FirstOrDefault(k => k.MaKh == id);
            if (kh != null)
            {
                _context.KhachHangs.Remove(kh);
                _context.SaveChanges();
            }
            return RedirectToAction("KH");
        }

        // ==== NHÀ CUNG CẤP ====
        public IActionResult NCC()
        {
            var list = _context.NhaCungCaps.ToList();
            return View(list);
        }


        // GET: Admin/EditNCC/NT01
        public IActionResult EditNCC(string id)
        {
            var ncc = _context.NhaCungCaps.FirstOrDefault(n => n.MaNcc == id);
            if (ncc == null) return NotFound();

            var taiKhoan = _context.TaiKhoanNhaCungCaps.FirstOrDefault(t => t.MaNcc == id);
            ViewBag.MatKhau = taiKhoan?.MatKhau;

            return View(ncc);
        }
        [HttpPost]
        public IActionResult EditNCC(NhaCungCap model, string? MatKhauMoi)
        {
            if (ModelState.IsValid)
            {
                var ncc = _context.NhaCungCaps.FirstOrDefault(n => n.MaNcc == model.MaNcc);
                var tk = _context.TaiKhoanNhaCungCaps.FirstOrDefault(t => t.MaNcc == model.MaNcc);

                if (ncc == null || tk == null) return NotFound();

                // Cập nhật thông tin NCC
                ncc.TenCongTy = model.TenCongTy;
                ncc.DiaChi = model.DiaChi;
                ncc.DienThoai = model.DienThoai;
                ncc.Email = model.Email;
                if (!string.IsNullOrWhiteSpace(model.Logo))
                {
                    ncc.Logo = model.Logo;
                }

                // Cập nhật mật khẩu nếu nhập mới
                if (!string.IsNullOrWhiteSpace(MatKhauMoi))
                {
                    var randomKey = Guid.NewGuid().ToString().Substring(0, 5);
                    tk.MatKhau = MatKhauMoi.ToMd5Hash(randomKey);
                }

                _context.SaveChanges();
                TempData["SuccessMessage"] = "Cập nhật nhà cung cấp thành công!";
                return RedirectToAction("NCC");
            }

            return View(model);
        }




        public IActionResult CreateNCC()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult CreateNCC(NhaCungCap model, string TaiKhoan, string MatKhau)
        {
            if (ModelState.IsValid)
            {
                model.Logo ??= "default.png";
                _context.NhaCungCaps.Add(model);
                _context.SaveChanges(); // Đảm bảo MaNcc đã được thêm

                var randomKey = Guid.NewGuid().ToString().Substring(0, 5);
                var taiKhoan = new TaiKhoanNhaCungCap
                {
                    MaNcc = model.MaNcc,
                    TenDangNhap = TaiKhoan,
                    MatKhau = MatKhau.ToMd5Hash(randomKey),
                    TrangThai = true

                };

                _context.TaiKhoanNhaCungCaps.Add(taiKhoan);
                TempData["SuccessMessage"] = "Thêm nhà cung cấp thành công!";
                _context.SaveChanges();

                return RedirectToAction("NCC");
            }

            // Debug lỗi nếu có
            foreach (var entry in ModelState)
            {
                foreach (var error in entry.Value.Errors)
                {
                    Console.WriteLine($"[Error] Field: {entry.Key}, Message: {error.ErrorMessage}");
                }
            }

            return View(model);
        }



        [HttpPost]
        [Route("Admin/DeleteNCCViaAjax/{id}")]
        public IActionResult DeleteNCCViaAjax(string id)
        {
            var ncc = _context.NhaCungCaps.FirstOrDefault(n => n.MaNcc == id);
            var taiKhoan = _context.TaiKhoanNhaCungCaps.FirstOrDefault(t => t.MaNcc == id);

            if (ncc == null)
                return NotFound();

            // Xóa tài khoản nếu có
            if (taiKhoan != null)
                _context.TaiKhoanNhaCungCaps.Remove(taiKhoan);

            _context.NhaCungCaps.Remove(ncc);
            _context.SaveChanges();

            return Ok();
        }



    }
}
