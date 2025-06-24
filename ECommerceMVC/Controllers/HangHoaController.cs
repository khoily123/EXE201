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

		public IActionResult Index(int? loai)
		{
			var hangHoas = _context.HangHoas.AsQueryable();

			if (loai.HasValue)
			{
				hangHoas = hangHoas.Where(p => p.MaLoai == loai.Value);
			}

			var result = hangHoas.Select(p => new HangHoaVM
			{
				MaHh = p.MaHh,
				TenHH = p.TenHh,
				DonGia = p.DonGia ?? 0,
				Hinh = p.Hinh ?? "",
				MoTaNgan = p.MoTaDonVi ?? "",
				TenLoai = p.MaLoaiNavigation.TenLoai
			});
			return View(result);
		}

		public IActionResult Search(string? query)
		{
			var hangHoas = _context.HangHoas.AsQueryable();

			if (query != null)
			{
				hangHoas = hangHoas.Where(p => p.TenHh.Contains(query));
			}

			var result = hangHoas.Select(p => new HangHoaVM
			{
				MaHh = p.MaHh,
				TenHH = p.TenHh,
				DonGia = p.DonGia ?? 0,
				Hinh = p.Hinh ?? "",
				MoTaNgan = p.MoTaDonVi ?? "",
				TenLoai = p.MaLoaiNavigation.TenLoai
			});
			return View(result);
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

			var result = new ChiTietHangHoaVM
			{
				MaHh = data.MaHh,
				TenHH = data.TenHh,
				DonGia = data.DonGia ?? 0,
				ChiTiet = data.MoTa ?? string.Empty,
				Hinh = data.Hinh ?? string.Empty,
				MoTaNgan = data.MoTaDonVi ?? string.Empty,
				TenLoai = data.MaLoaiNavigation.TenLoai,
				SoLuongTon = 10,//tính sau
				DiemDanhGia = 5,//check sau
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
