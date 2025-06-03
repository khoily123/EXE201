using System.ComponentModel.DataAnnotations;

namespace ECommerceMVC.ViewModels
{
    public class EditProfileVM
    {
        public string MaKh { get; set; }

        [Required(ErrorMessage = "Họ tên không được để trống")]
        public string HoTen { get; set; }

        [DataType(DataType.Date)]
        public DateTime? NgaySinh { get; set; }

        [EmailAddress]
        public string Email { get; set; }

        public string DienThoai { get; set; }

        public string DiaChi { get; set; }
    }

}
