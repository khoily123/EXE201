using ECommerceMVC.Data;
using ECommerceMVC.Helpers;
using ECommerceMVC.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace ECommerceMVC.Controllers
{
    public class NhaCungCapController : Controller
    {
        private readonly Hshop2023Context _context;

        public NhaCungCapController(Hshop2023Context hshop2023Context)
        {
            _context = hshop2023Context;
        }
        public IActionResult Dashboard()
        {
            var maNcc = HttpContext.Session.GetString("MaNCC");
            if (string.IsNullOrEmpty(maNcc))
            {
                return RedirectToAction("DangNhapNCC", "TaiKhoanNhaCungCap");
            }

            // Tổng sản phẩm
            ViewBag.TongSanPham = _context.HangHoas.Count(sp => sp.MaNcc == maNcc);

            // Tổng đơn hàng
            ViewBag.TongDonHang = (from ct in _context.VChiTietHoaDons
                                   join sp in _context.HangHoas on ct.MaHh equals sp.MaHh
                                   where sp.MaNcc == maNcc
                                   select ct.MaHd).Distinct().Count();

            // Tổng doanh thu
            var tongDoanhThu = (from ct in _context.VChiTietHoaDons
                                join sp in _context.HangHoas on ct.MaHh equals sp.MaHh
                                where sp.MaNcc == maNcc
                                select (ct.DonGia * ct.SoLuong * (1 - ct.GiamGia))).Sum();
            ViewBag.TongDoanhThu = tongDoanhThu.ToString("N0") + " VNĐ";

            // Đơn chờ xác nhận
            ViewBag.DonChoXacNhan = (from ct in _context.VChiTietHoaDons
                                     join sp in _context.HangHoas on ct.MaHh equals sp.MaHh
                                     join hd in _context.HoaDons on ct.MaHd equals hd.MaHd
                                     where sp.MaNcc == maNcc && hd.MaTrangThai == 0
                                     select ct.MaHd).Distinct().Count();

            // Sản phẩm bán chạy nhất
            var spBanChay = (from ct in _context.VChiTietHoaDons
                             join sp in _context.HangHoas on ct.MaHh equals sp.MaHh
                             where sp.MaNcc == maNcc
                             group ct by ct.TenHh into g
                             orderby g.Sum(x => x.SoLuong) descending
                             select new { Ten = g.Key, SoLuong = g.Sum(x => x.SoLuong) }).FirstOrDefault();
            ViewBag.SPBanChay = spBanChay != null ? $"{spBanChay.Ten} ({spBanChay.SoLuong} sản phẩm)" : "Chưa có dữ liệu";

            return View();
        }

        public IActionResult Index()
        {
            var maNcc = HttpContext.Session.GetString("MaNCC");
            var products = _context.HangHoas
                            .Where(p => p.MaNcc == maNcc)
                            .Include(p => p.MaLoaiNavigation)
                            .ToList();

            return View(products);
        }

        public IActionResult DonHang()
        {
            var maNcc = HttpContext.Session.GetString("MaNCC");

            var data = from hd in _context.HoaDons
                       join ct in _context.ChiTietHds on hd.MaHd equals ct.MaHd
                       join hh in _context.HangHoas on ct.MaHh equals hh.MaHh
                       where hh.MaNcc == maNcc
                       group new { ct, hd } by new
                       {
                           hd.MaHd,
                           hd.HoTen,
                           hd.NgayDat,
                           hd.MaTrangThai
                       } into g
                       select new DonHangViewModel
                       {
                           MaHD = g.Key.MaHd,
                           HoTen = g.Key.HoTen,
                           NgayDat = g.Key.NgayDat,
                           MaTrangThai = g.Key.MaTrangThai,
                           TongTien = g.Sum(x => x.ct.DonGia * x.ct.SoLuong * (1 - x.ct.GiamGia))
                       };

            return View(data.ToList());
        }

        // GET: SanPham/Create
        public IActionResult Create()
        {
            ViewBag.LoaiList = new SelectList(_context.Loais.ToList(), "MaLoai", "TenLoai");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(HangHoa model, IFormFile HinhFile)
        {
            // Lấy mã nhà cung cấp từ session
            model.MaNcc = HttpContext.Session.GetString("MaNCC");
            model.NgaySx = DateTime.Now;
            model.SoLanXem = 0;
            model.GiamGia = 0;

            if (HinhFile != null && HinhFile.Length > 0)
            {
                var fileName = Path.GetFileName(HinhFile.FileName);
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/Hinh/icons", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    HinhFile.CopyTo(stream);
                }

                model.Hinh = fileName;
            }
            ModelState.Remove("MaNcc");
            ModelState.Remove("MaNccNavigation");
            ModelState.Remove("MaLoaiNavigation");

            if (ModelState.IsValid)
            {
                _context.HangHoas.Add(model);
                _context.SaveChanges();
                TempData["SuccessMessage"] = "Thêm sản phẩm thành công!";
                return RedirectToAction("Index");
            }

            foreach (var entry in ModelState)
            {
                foreach (var error in entry.Value.Errors)
                {
                    Console.WriteLine($"[ModelState Error] Field: {entry.Key}, Error: {error.ErrorMessage}");
                }
            }

            ViewBag.LoaiList = new SelectList(_context.Loais, "MaLoai", "TenLoai", model.MaLoai);
            return View(model);
        }



        // GET: SanPham/Edit/5
        public IActionResult Edit(int id)
        {
            var product = _context.HangHoas.FirstOrDefault(p => p.MaHh == id);
            if (product == null) return NotFound();

            ViewBag.LoaiList = new SelectList(_context.Loais.ToList(), "MaLoai", "TenLoai", product.MaLoai);
            return View(product);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, HangHoa model, IFormFile? HinhFile)
        {
            if (id != model.MaHh) return NotFound();

            var existing = _context.HangHoas.FirstOrDefault(p => p.MaHh == id);
            if (existing == null) return NotFound();

            // Nếu có ảnh mới
            if (HinhFile != null)
            {
                var fileName = Path.GetFileName(HinhFile.FileName);
                var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/Hinh/icons", fileName);
                using (var stream = new FileStream(path, FileMode.Create))
                {
                    HinhFile.CopyTo(stream);
                }
                existing.Hinh = fileName;
            }

            // Cập nhật các trường còn lại
            existing.TenHh = model.TenHh;
            existing.TenAlias = model.TenAlias;
            existing.DonGia = model.DonGia;
            existing.GiamGia = model.GiamGia;
            existing.MaLoai = model.MaLoai;
            existing.MoTa = model.MoTa;
            existing.MoTaDonVi = model.MoTaDonVi;
            existing.NgaySx = model.NgaySx;

            // Không cập nhật MaNcc vì không đổi NCC

            _context.SaveChanges();
            TempData["SuccessMessage"] = "Cập nhật sản phẩm thành công!";
            return RedirectToAction("Index");
        }



        [HttpPost]
        [Route("SanPham/DeleteViaAjax/{id}")]
        public IActionResult DeleteViaAjax(int id)
        {
            var product = _context.HangHoas.FirstOrDefault(p => p.MaHh == id);
            if (product == null) return NotFound();

            _context.HangHoas.Remove(product);
            _context.SaveChanges();

            return Ok();
        }

        [HttpGet]
        public IActionResult DoiMatKhau()
        {
            return View();
        }
    }
}

