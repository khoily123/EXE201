using System.ComponentModel.DataAnnotations;

namespace ECommerceMVC.ViewModels
{
    public class RegisterVM
    {
        [Display(Name = "Tên đăng nhập")]
        [Required(ErrorMessage = "*")]
        [MinLength(3, ErrorMessage = "Tối thiểu 3 kí tự")]
        [MaxLength(20, ErrorMessage = "Tối đa 20 kí tự")]
        public string MaKh { get; set; }

        [Display(Name = "Mật khẩu")]
        [Required(ErrorMessage = "*")]
        [DataType(DataType.Password)]
        [MinLength(6, ErrorMessage = "Tối thiểu 6 kí tự")]
        [MaxLength(20, ErrorMessage = "Tối đa 20 kí tự")]
        //[RegularExpression(@"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$", ErrorMessage = "Mật khẩu phải chứa ít nhất một chữ cái và một số")]
        public string MatKhau { get; set; }

        [Display(Name = "Họ tên")]
        [Required(ErrorMessage = "*")]
        [MinLength(2, ErrorMessage = "Tối thiểu 2 kí tự")]
        [MaxLength(50, ErrorMessage = "Tối đa 50 kí tự")]
        public string HoTen { get; set; }

        [Display(Name = "Ngày sinh")]
        [DataType(DataType.Date)]
        [Range(typeof(DateTime), "01/01/1925", "01/01/2007", ErrorMessage = "Độ tuổi phải từ 18 đến 100 tuổi")]
        public DateTime? NgaySinh { get; set; }

        [Display(Name = "Địa chỉ")]
        [MaxLength(60, ErrorMessage = "Tối đa 60 kí tự")]
        public string DiaChi { get; set; }

        [Display(Name = "Điện thoại")]
        [Required(ErrorMessage = "*")]
        [MaxLength(10, ErrorMessage = "Tối đa 10 kí tự")]
        //[RegularExpression(@"^0[3|5|7|8|9]\d{9}$", ErrorMessage = "Chưa đúng định dạng di động Việt Nam")]
        public string DienThoai { get; set; }

        [Display(Name = "Email")]
        [Required(ErrorMessage = "*")]
        [EmailAddress(ErrorMessage = "Chưa đúng định dạng email")]
        public string Email { get; set; }
    }
}