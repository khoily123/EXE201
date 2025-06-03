using AutoMapper;
using ECommerceMVC.Data;
using ECommerceMVC.Helpers;
using ECommerceMVC.ViewModels;
using Microsoft.AspNetCore.Mvc;

namespace ECommerceMVC.Controllers
{
	public class KhachHangController : Controller
	{
		private readonly Hshop2023Context db;
		private readonly IMapper _mapper;

		public KhachHangController(Hshop2023Context context, IMapper mapper)
		{
			db = context;
			_mapper = mapper;
		}

		[HttpGet]
		public IActionResult DangKy()
		{
			return View();
		}

        [HttpPost]
        public IActionResult DangKy(RegisterVM model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var khachHang = _mapper.Map<KhachHang>(model);
                    khachHang.RandomKey = MyUtil.GenerateRamdomKey();
                    khachHang.MatKhau = model.MatKhau.ToMd5Hash(khachHang.RandomKey);
                    khachHang.HieuLuc = true; 
                    khachHang.VaiTro = 0;
                    db.Add(khachHang);
                    db.SaveChanges();

                    TempData["SuccessMessage"] = "Đăng ký tài khoản thành công!";

                    return RedirectToAction("DangNhap", "KhachHang");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "Đã xảy ra lỗi khi đăng ký: " + ex.Message);
                }
            }
            return View(model);
        }


        [HttpGet]
        public IActionResult DangNhap()
        {
            return View();
        }

        [HttpPost]
        public IActionResult DangNhap(LoginVM model)
        {
            if (ModelState.IsValid)
            {
                // Tìm khách hàng theo email hoặc tên đăng nhập
                var kh = db.KhachHangs
                    .FirstOrDefault(k => k.MaKh == model.Email);

                if (kh == null)
                {
                    ModelState.AddModelError("Email", "Tên đăng nhập không đúng");
                    return View(model);
                }

                if (!kh.HieuLuc)
                {
                    ModelState.AddModelError("", "Tài khoản chưa được kích hoạt");
                    return View(model);
                }

                // Mã hóa mật khẩu nhập vào để so sánh
                var matKhauMaHoa = model.Password.ToMd5Hash(kh.RandomKey);
                if (kh.MatKhau != matKhauMaHoa)
                {
                    ModelState.AddModelError("Password", "Mật khẩu không đúng");
                    return View(model);
                }

                // Đăng nhập thành công
                HttpContext.Session.SetString("MaKh", kh.MaKh.ToString());
                HttpContext.Session.SetString("HoTen", kh.HoTen);
                HttpContext.Session.SetString("VaiTro", kh.VaiTro.ToString());

                return RedirectToAction("Index", "HangHoa");
            }

            return View(model);
        }
        public IActionResult DangXuat()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }

        public IActionResult Profile()
        {
            var maKhachHang = HttpContext.Session.GetString("MaKh");
            if (string.IsNullOrEmpty(maKhachHang))
            {
                return RedirectToAction("DangNhap");
            }

            var khach = db.KhachHangs.FirstOrDefault(k => k.MaKh == maKhachHang);
            if (khach == null)
            {
                return RedirectToAction("DangNhap");
            }

            return View(khach);
        }
        [HttpGet]
        public IActionResult UpdateProfile()
        {
            var maKh = HttpContext.Session.GetString("MaKh");
            if (string.IsNullOrEmpty(maKh)) return RedirectToAction("DangNhap");

            var kh = db.KhachHangs.FirstOrDefault(k => k.MaKh == maKh);
            if (kh == null) return NotFound();

            var model = new EditProfileVM
            {
                MaKh = kh.MaKh,
                HoTen = kh.HoTen,
                NgaySinh = kh.NgaySinh,
                Email = kh.Email,
                DienThoai = kh.DienThoai,
                DiaChi = kh.DiaChi
            };

            return View(model);
        }

        [HttpPost]
        public IActionResult Updateprofile(EditProfileVM model)
        {
            if (ModelState.IsValid)
            {
                var kh = db.KhachHangs.FirstOrDefault(k => k.MaKh == model.MaKh);
                if (kh == null) return NotFound();

                kh.HoTen = model.HoTen;
                kh.NgaySinh = (DateTime)model.NgaySinh;
                kh.Email = model.Email;
                kh.DienThoai = model.DienThoai;
                kh.DiaChi = model.DiaChi;

                db.SaveChanges();
                TempData["Success"] = "Cập nhật hồ sơ thành công!";
                return RedirectToAction("Profile");
            }

            return View(model);
        }


    }

}
