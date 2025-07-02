using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ECommerceMVC.Data;
namespace ECommerceMVC.Controllers
{
    public class ARController : Controller
    {
        private readonly Hshop2023Context _context;

        public ARController(Hshop2023Context context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult ViewAR(int id)
        {
            var product = _context.HangHoas.FirstOrDefault(p => p.MaHh == id);
            if (product == null) return NotFound();
            if (product.ModelUrl == null || !product.ModelUrl.EndsWith(".glb"))
            {
                return RedirectToAction("Index");
            }
            return View(product); // product.ModelUrl should be a .glb file
        }

    }
}
