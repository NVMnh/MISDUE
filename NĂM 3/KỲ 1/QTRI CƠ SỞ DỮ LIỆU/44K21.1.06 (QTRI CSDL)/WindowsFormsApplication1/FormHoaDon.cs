using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace WindowsFormsApplication1
{
    public partial class FormHoaDon : Form
    {
        String sCon = "Data Source=NVMINH;Initial Catalog=QUANLY_CAFE;Integrated Security=True";
        public FormHoaDon()
        {
            InitializeComponent();
        }
        private void FormHoaDon_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(sCon);
            try
            {
                con.Open();
            }
            catch (Exception)
            {
                MessageBox.Show("Đã xảy ra lỗi trong qúa trình kết nối db");
            }

            String sQuery1 = "Select MaNuocUong,TenMon from NUOCUONG";
            SqlDataAdapter adapter = new SqlDataAdapter(sQuery1, con);
            DataSet ds1 = new DataSet();
            adapter.Fill(ds1, "NUOCUONG");
            cbTenmon.DataSource = ds1.Tables["NUOCUONG"];
            cbTenmon.ValueMember = "MaNuocUong";
            cbTenmon.DisplayMember = "TenMon";
            dtgvHoadon.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            con.Close();

        }


        private void txtSoLuong_TextChanged(object sender, EventArgs e)
        {
            if (txtSoLuong.Text != "")
            {
                int iSoLuong = Convert.ToInt32(txtSoLuong.Text);
                int iDonGia = Convert.ToInt32(txtGia.Text);
                int iThanhTien = iSoLuong * iDonGia;
                txtThanhtien.Text = iThanhTien.ToString();

                int iCount = dtgvHoadon.Rows.Count;
                int ktra = 0;
                for (int i = 0; i < iCount; i++)
                {
                    if
                       (dtgvHoadon.Rows[i].Cells[1].Value == cbTenmon.ToString())

                    {
                        dtgvHoadon.Rows[i].Cells[3].Value = iSoLuong;
                        dtgvHoadon.Rows[i].Cells[3].Value = iSoLuong * iDonGia;
                        ktra = 1;
                    }
                }
                if (ktra == 0)
                {
                    dtgvHoadon.Rows.Add(cbTenmon.SelectedValue, cbTenmon.Text, iDonGia, iSoLuong, iThanhTien);
                }
                long iTongTien;
                if (txtTongTien.Text == "")
                    iTongTien = 0;
                else
                    iTongTien = Convert.ToInt32(txtTongTien.Text);
                iTongTien = iTongTien + iThanhTien;
                txtTongTien.Text = iTongTien.ToString();
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Form_Order f = new Form_Order();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

       

        private void cbTenmon_SelectionChangeCommitted(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(sCon);
            try
            {
                con.Open();
            }
            catch (Exception)
            {
                MessageBox.Show("Đã xảy ra lỗi trong qúa trình kết nối ");
            }
            String sQuery1 = "Select Gia from NUOCUONG where MaNuocUong = " + cbTenmon.SelectedValue.ToString();
            SqlDataAdapter adapter1 = new SqlDataAdapter(sQuery1, con);
            DataSet ds1 = new DataSet();
            adapter1.Fill(ds1, "NUOCUONG");
            txtGia.Text = ds1.Tables["NUOCUONG"].Rows[0][0].ToString();

            con.Close();

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(sCon);
            try
            {
                con.Open();
            }
            catch (Exception)
            {
                MessageBox.Show("Đã xảy ra lỗi trong qúa trình kết nối ");
            }
            int iMHD = Convert.ToInt32(txtMHD.Text);
            int iMaNV = Convert.ToInt32(txtMaNV.Text);
            String sNgayBan = dtpkNgay.Value.ToString("yyyy-MM-dd");
            String sGioBan = dtpGio.Value.ToString("h:mm:ss");
            int iSoBan = Convert.ToInt16(txtBan.Text);
            String sTongTien = txtTongTien.Text;
            int Soluong = Convert.ToInt16(txtSoLuong.Text);

            String sQuery = " insert into HOADON(MaHD,MaNV,NgayBan,GioBan,SoBan,TongTien set TongTien = sum(ThanhTien)From HOADONCT inner join HOADON on HOADONCT.MaHD = HOADON.MaHD) values(@MaHD,@MaNV,@NgayNhap,@GioNhap, @SoBan,@TongTien)";
            SqlCommand cmd = new SqlCommand(sQuery, con);
            cmd.Parameters.AddWithValue("@MaHD", iMHD);
            cmd.Parameters.AddWithValue("@MaNV", iMHD);
            cmd.Parameters.AddWithValue("@NgayBan", sNgayBan);
            cmd.Parameters.AddWithValue("@GioBan", sGioBan);
            cmd.Parameters.AddWithValue("@SoBan", iSoBan);
            cmd.Parameters.AddWithValue("@TongTien", sTongTien);

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }

            int iCount = dtgvHoadon.Rows.Count;
            for (int i = 0; i < iCount; i++)
            {
                String sQuery1 = "insert into HDCT(MaHD,MaNuocUong,SoLuong,Thanh Tien set Thanh Tien = SoLuong * Gia from NUOCUONG inner join HOADONCT on HOADONCT.MaNuocUong = NUOCUONG.MaNuocUong values(@MaHD,@MaNuocUong,@SoLuong,@ThanhTien)";
                SqlCommand cmd1 = new SqlCommand(sQuery1, con);
                cmd1.Parameters.AddWithValue("@MaHD", iMHD);
                cmd1.Parameters.AddWithValue("@MaNuocUong", dtgvHoadon.Rows[i].Cells[1].Value);
                cmd1.Parameters.AddWithValue("@SoLuong", dtgvHoadon.Rows[i].Cells[3].Value);
                cmd1.Parameters.AddWithValue("@ThanhTien", dtgvHoadon.Rows[i].Cells[4].Value);
                try
                {
                    cmd1.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.ToString());
                }
                MessageBox.Show("Thêm mới thành công!", "Thông báo");
            }
        }

        private void button2_Click_1(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            String sMaHDN = "";
            if (txtMHD.Text == "")
            {

            }
            else
                sMaHDN = txtMHD.Text;

            DialogResult ret = MessageBox.Show("Bạn có chắc chắn xóa không", "Thông báo", MessageBoxButtons.OKCancel);
            if (ret == DialogResult.OK)
            {
                SqlConnection con = new SqlConnection(sCon);
                try
                {
                    con.Open();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.ToString());
                }

                String sQuery = "  delete HOADONCT where MaHDN = @MaHDN";
                String sQuery1 = " delete HOADON where MaHDN = @MaHDN";
                SqlCommand cmd = new SqlCommand(sQuery, con);
                cmd.Parameters.AddWithValue("@MaHDN", sMaHDN);
                SqlCommand cmd1 = new SqlCommand(sQuery1, con);
                cmd1.Parameters.AddWithValue("@MaHDN", sMaHDN);

                try
                {
                    cmd.ExecuteNonQuery();
                    cmd1.ExecuteNonQuery();
                    MessageBox.Show("Xóa thành công!", "Thông báo");
                    txtGia.Text = "";
                    txtMHD.Text = "";
                    txtTongTien.Text = "";
                    txtThanhtien.Text = "";
                    txtSoLuong.Text = "";

                }
                catch (Exception)
                {
                    MessageBox.Show("Đã xảy ra lỗi trong quá trình xóa!", "Thông báo");
                }
                con.Close();
            }
        }
        private void cbTenmon_SelectedValueChanged(object sender, EventArgs e)
        {

        }

        private void cbTenmon_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        private void Th_Enter(object sender, EventArgs e)
        {
        }
        private void btTimkiem_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(sCon);
            try
            {
                con.Open();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã xảy ra lỗi trong quá trình kết nối với dữ liệu!");
            }
            string sQuery = "select * from HOADON where MaHD like N'%" + txtTK.Text + "%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sQuery, con);
            DataSet ds = new DataSet();
            try
            {
                adapter.Fill(ds, "HOADON");
            }

            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
            dtgvHoadon.DataSource = ds.Tables["HOADON"];

            con.Close();
        }

        private void dtgvHoadon_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void txtBan_TextChanged(object sender, EventArgs e)
        {

        }

    }
}