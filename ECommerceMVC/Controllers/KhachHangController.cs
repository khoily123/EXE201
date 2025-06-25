using AutoMapper;
using ECommerceMVC.Data;
using ECommerceMVC.Helpers;
using ECommerceMVC.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ECommerceMVC.Controllers
{
	public class KhachHangController : Controller
	{
		private readonly Hshop2023Context _context;
		private readonly IMapper _mapper;

		public KhachHangController(Hshop2023Context context, IMapper mapper)
		{
			_context = context;
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
                    _context.Add(khachHang);
                    _context.SaveChanges();

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
                var kh = _context.KhachHangs.FirstOrDefault(k => k.MaKh == model.Username);

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

                var matKhauMaHoa = model.Password.ToMd5Hash(kh.RandomKey);
                if (kh.MatKhau != matKhauMaHoa)
                {
                    ModelState.AddModelError("Password", "Mật khẩu không đúng");
                    return View(model);
                }

                // Set session
                HttpContext.Session.SetString("MaKh", kh.MaKh);
                HttpContext.Session.SetString("HoTen", kh.HoTen);
                HttpContext.Session.SetString("VaiTro", kh.VaiTro.ToString());
                // Save full KhachHang object
                HttpContext.Session.Set<KhachHang>("KhachHang", kh);

                // Store cookies if RememberMe
                if (model.RememberMe)
                {
                    CookieOptions option = new CookieOptions
                    {
                        Expires = DateTime.Now.AddDays(7),
                        HttpOnly = false,
                        IsEssential = true
                    };
                    Response.Cookies.Append("UsernameKH", model.Username, option);
                    Response.Cookies.Append("PasswordKH", model.Password, option);
                }
                else
                {
                    Response.Cookies.Delete("UsernameKH");
                    Response.Cookies.Delete("PasswordKH");
                }

                if (kh.VaiTro == 1)
                {
                    return RedirectToAction("Dashboard", "Admin");
                }
                else
                {
                    return RedirectToAction("Index", "HangHoa");
                }
            }

            return View(model);
        }


        public IActionResult DangXuat()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("DangNhap", "KhachHang");
        }

        public IActionResult Profile()
        {
            var maKhachHang = HttpContext.Session.GetString("MaKh");
            if (string.IsNullOrEmpty(maKhachHang))
            {
                return RedirectToAction("DangNhap");
            }

            var khach = _context.KhachHangs.FirstOrDefault(k => k.MaKh == maKhachHang);
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

            var kh = _context.KhachHangs.FirstOrDefault(k => k.MaKh == maKh);
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
                var kh = _context.KhachHangs.FirstOrDefault(k => k.MaKh == model.MaKh);
                if (kh == null) return NotFound();

                kh.HoTen = model.HoTen;
                kh.NgaySinh = (DateTime)model.NgaySinh;
                kh.Email = model.Email;
                kh.DienThoai = model.DienThoai;
                kh.DiaChi = model.DiaChi;

                _context.SaveChanges();
                TempData["Success"] = "Cập nhật hồ sơ thành công!";
                return RedirectToAction("Profile");
            }

            return View(model);
        }
        [HttpGet]
        public IActionResult DoiMatKhau()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult DoiMatKhau(string matKhauCu, string matKhauMoi, string matKhauMoiNhapLai)
        {
            var maKH = HttpContext.Session.GetString("MaKh");
            var kh = _context.KhachHangs.FirstOrDefault(x => x.MaKh == maKH);

            if (kh == null) return NotFound();

            var matKhauCuHash = matKhauCu.ToMd5Hash(kh.RandomKey);
            if (kh.MatKhau != matKhauCuHash)
            {
                ModelState.AddModelError("", "Mật khẩu cũ không chính xác.");
                return View();
            }

            if (matKhauMoi != matKhauMoiNhapLai)
            {
                ModelState.AddModelError("", "Mật khẩu mới không khớp.");
                return View();
            }

            kh.MatKhau = matKhauMoi.ToMd5Hash(kh.RandomKey);
            _context.SaveChanges();

            TempData["Success"] = "Đổi mật khẩu thành công!";
            return View();
        }


    }

}
