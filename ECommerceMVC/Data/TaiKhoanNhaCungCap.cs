using System;
using System.Collections.Generic;

namespace ECommerceMVC.Data;

public partial class TaiKhoanNhaCungCap
{
    public int MaTk { get; set; }

    public string MaNcc { get; set; } = null!;

    public string TenDangNhap { get; set; } = null!;

    public string MatKhau { get; set; } = null!;

    public DateTime? NgayTao { get; set; }

    public bool? TrangThai { get; set; }

    public virtual NhaCungCap MaNccNavigation { get; set; } = null!;
}
