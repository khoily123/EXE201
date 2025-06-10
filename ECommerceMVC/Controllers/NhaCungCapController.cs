using Microsoft.AspNetCore.Mvc;

namespace ECommerceMVC.Controllers
{
    public class NhaCungCapController : Controller
    {
        public IActionResult Dashboard()
        {
            if (HttpContext.Session.GetString("MaNCC") == null)
                return RedirectToAction("DangNhapNCC", "TaiKhoanNhaCungCap");

            return View();
        }
    }

}
