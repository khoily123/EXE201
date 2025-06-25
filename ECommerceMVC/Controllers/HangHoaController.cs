using ECommerceMVC.Data;
using ECommerceMVC.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ECommerceMVC.Controllers
{
	public class HangHoaController : Controller
	{
		private readonly Hshop2023Context _context;

		public HangHoaController(Hshop2023Context conetxt)
		{
			_context = conetxt;
		}

        public IActionResult Index(int? loai, int page = 1)
        {
            int pageSize = 9;

            var hangHoas = _context.HangHoas.AsQueryable();

            if (loai.HasValue)
            {
                hangHoas = hangHoas.Where(p => p.MaLoai == loai.Value);
                ViewBag.CurrentLoai = loai;
            }

            int totalItems = hangHoas.Count();

            var items = hangHoas
                .OrderBy(p => p.MaHh) 
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .Select(p => new HangHoaVM
                {
                    MaHh = p.MaHh,
                    TenHH = p.TenHh,
                    DonGia = p.DonGia ?? 0,
                    Hinh = p.Hinh ?? "",
                    MoTaNgan = p.MoTaDonVi ?? "",
                    TenLoai = p.MaLoaiNavigation.TenLoai
                })
                .ToList();

            var model = new HangHoaPagingVM
            {
                Items = items,
                CurrentPage = page,
                TotalPages = (int)Math.Ceiling((double)totalItems / pageSize),
                TotalItems = totalItems 

            };

            return View(model);
        }


        public IActionResult Search(string? query, int page = 1)
        {
            int pageSize = 9;

            var querysearch = _context.HangHoas.AsQueryable();

            if (!string.IsNullOrEmpty(query))
            {
                querysearch = querysearch.Where(p => p.TenHh.Contains(query));
                ViewBag.Keyword = query;
            }

            int totalItems = querysearch.Count();

            var items = querysearch
                .OrderBy(p => p.MaHh)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .Select(p => new HangHoaVM
                {
                    MaHh = p.MaHh,
                    TenHH = p.TenHh,
                    DonGia = p.DonGia ?? 0,
                    Hinh = p.Hinh ?? "",
                    MoTaNgan = p.MoTaDonVi ?? "",
                    TenLoai = p.MaLoaiNavigation.TenLoai
                })
                .ToList();

            var model = new HangHoaPagingVM
            {
                Items = items,
                TotalItems = totalItems,
                CurrentPage = page,
                TotalPages = (int)Math.Ceiling((double)totalItems / pageSize)
            };

            return View(model);
        }



        public IActionResult Detail(int id)
        {
            var data = _context.HangHoas
                .Include(p => p.MaLoaiNavigation)
                .SingleOrDefault(p => p.MaHh == id);

            if (data == null)
            {
                TempData["Message"] = $"Không thấy sản phẩm có mã {id}";
                return Redirect("/404");
            }

            data.SoLanXem++;
            Console.WriteLine(data.SoLanXem);
            _context.SaveChanges();

            var result = new ChiTietHangHoaVM
            {
                MaHh = data.MaHh,
                TenHH = data.TenHh,
                DonGia = data.DonGia ?? 0,
                ChiTiet = data.MoTa ?? string.Empty,
                Hinh = data.Hinh ?? string.Empty,
                MoTaNgan = data.MoTaDonVi ?? string.Empty,
                TenLoai = data.MaLoaiNavigation.TenLoai,
                SoLuongTon = 10,
                DiemDanhGia = 5,
                SoLuotXem = data.SoLanXem
            };

            return View(result);
        }

        public IActionResult LocTheoGia(double gia)
        {
            var hangHoas = _context.HangHoas
                .Include(h => h.MaLoaiNavigation)
                .Where(h => h.DonGia <= gia)
                .Select(h => new HangHoaVM
                {
                    MaHh = h.MaHh,
                    TenHH = h.TenHh,
                    DonGia = h.DonGia,
                    Hinh = h.Hinh,
                    TenLoai = h.MaLoaiNavigation.TenLoai
                })
                .ToList();

            return View(hangHoas);

        }

    }
}
