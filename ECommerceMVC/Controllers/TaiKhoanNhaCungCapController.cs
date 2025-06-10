using ECommerceMVC.Data;
using ECommerceMVC.Helpers;
using ECommerceMVC.ViewModels;
using Microsoft.AspNetCore.Mvc;

namespace ECommerceMVC.Controllers
{
    public class TaiKhoanNhaCungCapController : Controller
    {
        private readonly Hshop2023Context db;
        private readonly string saltKey = "qwertyuiopasdfghjklzxcvbnm123456789";

        public TaiKhoanNhaCungCapController(Hshop2023Context context)
        {
            db = context;
        }
        public IActionResult DangNhapNCC()
        {
            return View();
        }


        [HttpPost]
        public IActionResult DangNhapNCC(LoginVM model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var tk = db.TaiKhoanNhaCungCaps
                       .FirstOrDefault(x => x.TenDangNhap == model.Username);

            if (tk == null)
            {
                ModelState.AddModelError("Username", "Tên đăng nhập không đúng");
                return View(model);
            }

            if (tk.TrangThai == false)
            {
                ModelState.AddModelError("", "Tài khoản của bạn đang bị khóa");
                return View(model);
            }

            // Uncomment and update password hashing if needed
            // var hashedPassword = model.Password.ToMd5Hash(saltKey);
            // if (tk.MatKhau != hashedPassword)
            // {
            //     ModelState.AddModelError("Password", "Mật khẩu không đúng");
            //     return View(model);
            // }

            // Set session
            HttpContext.Session.SetString("MaNCC", tk.MaNcc);
            HttpContext.Session.SetString("TenDangNhap", tk.TenDangNhap);

            // Store cookies for NCC if RememberMe is checked
            if (model.RememberMe)
            {
                CookieOptions options = new CookieOptions
                {
                    Expires = DateTime.Now.AddDays(7),
                    HttpOnly = false,
                    IsEssential = true
                };

                Response.Cookies.Append("UsernameNCC", model.Username, options);
                Response.Cookies.Append("PasswordNCC", model.Password, options);
            }
            else
            {
                Response.Cookies.Delete("UsernameNCC");
                Response.Cookies.Delete("PasswordNCC");
            }

            return RedirectToAction("Dashboard", "NhaCungCap");
        }

        public IActionResult DangXuat()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("DangNhapNCC");
        }

    }
}

