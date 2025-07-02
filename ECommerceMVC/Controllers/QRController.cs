using Microsoft.AspNetCore.Mvc;
using QRCoder;
using System.Drawing;
using System.Drawing.Imaging;

namespace ECommerceMVC.Controllers
{
    public class QRController : Controller
    {
        [HttpGet]
        public IActionResult Generate(string modelUrl)
        {
            if (string.IsNullOrWhiteSpace(modelUrl))
                return BadRequest("Missing model URL");

            string fullUrl = $"https://www.mydreamhouse.io.vn/ar?url={Uri.EscapeDataString(modelUrl)}";

            using (var qrGenerator = new QRCodeGenerator())
            using (var qrCodeData = qrGenerator.CreateQrCode(fullUrl, QRCodeGenerator.ECCLevel.Q))
            {
                var qrCode = new PngByteQRCode(qrCodeData);
                byte[] qrCodeImage = qrCode.GetGraphic(20);
                return File(qrCodeImage, "image/png");
            }
        }
    }
}
