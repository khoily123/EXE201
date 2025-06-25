namespace ECommerceMVC.ViewModels
{
	public class HangHoaVM
	{
		public int MaHh { get; set; }
		public string TenHH { get; set; }
		public string Hinh { get; set; }
		public double? DonGia { get; set; }
		public string MoTaNgan { get; set; }
		public string TenLoai { get; set; }
        public int SoLuotXem { get; set; }
    }

    public class ChiTietHangHoaVM
	{
		public int MaHh { get; set; }
		public string TenHH { get; set; }
		public string Hinh { get; set; }
		public double DonGia { get; set; }
		public string MoTaNgan { get; set; }
		public string TenLoai { get; set; }
		public string ChiTiet { get; set; }
		public int DiemDanhGia { get; set; }
		public int SoLuongTon { get; set; }
        public int SoLuotXem { get; set; }

    }
    public class HangHoaPagingVM
    {
        public IEnumerable<HangHoaVM> Items { get; set; } = new List<HangHoaVM>();
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public int TotalItems { get; set; }

    }

}
