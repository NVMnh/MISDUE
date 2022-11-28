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
    public partial class FormNuocUong : Form
    {
        String sCon = "Data Source=NVMINH;Initial Catalog=QUANLY_CAFE;Integrated Security=True";
        public FormNuocUong()
        {
            InitializeComponent();
        }

        private void FormNuocUong_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(sCon);
            try
            {
                con.Open();
            }
            catch (Exception)
            {
                MessageBox.Show("Xảy ra lỗi trong  trong qúa trình kết nối");
            }

            String sQuery = "Select * from NUOCUONG";
            SqlDataAdapter adapter = new SqlDataAdapter(sQuery, con);

            DataSet ds = new DataSet();
            adapter.Fill(ds, "NUOCUONG");
            dataGridView1.DataSource = ds.Tables["NUOCUONG"];
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            String sQuery1 = "Select * from NUOCUONG";
            SqlDataAdapter adapter1 = new SqlDataAdapter(sQuery1, con);
            DataSet ds1 = new DataSet();
            adapter1.Fill(ds1, "NUOCUONG");
            cbTenmon.DataSource = ds1.Tables["NUOCUONG"];
            cbTenmon.ValueMember = "MaNuocUong";
            cbTenmon.DisplayMember = "TenMon";

            con.Close();
       
        }

    

        private void button3_Click(object sender, EventArgs e)
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
            String sMaNuocUong = txtManuoc.Text;
            String sTenmon = cbTenmon.Text;
            String sGia = txtGia.Text;


            String sQuery = "insert into NUOCUONG values (@MaNuocUong, @TenMon, @Gia)";
            SqlCommand cmd = new SqlCommand(sQuery, con);
            cmd.Parameters.AddWithValue("@MaNuocUong", sMaNuocUong);
            cmd.Parameters.AddWithValue("@TenMon", sTenmon);
            cmd.Parameters.AddWithValue("@Gia", sGia);
           
            try
            {
                cmd.ExecuteNonQuery();
                MessageBox.Show("Thêm mới thành công!", "Thông báo");
            }
            catch (Exception)
            {
                MessageBox.Show("Đã xảy ra lỗi trong quá trình thêm mới!", "Thông báo");
            }
            con.Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            DialogResult ret = MessageBox.Show("Bạn có chắc chắn xóa không", "Thông báo", MessageBoxButtons.OKCancel);
            if (ret == DialogResult.OK)
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
                String sMaNuocUong = txtManuoc.Text;
                String sTenmon = cbTenmon.Text;
                String sQuery = "delete NUOCUONG where MaNuocUong = @MaNuocUong";
                SqlCommand cmd = new SqlCommand(sQuery, con);
                cmd.Parameters.AddWithValue("@MaNuocUong", sMaNuocUong);
                try
                {
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Xóa thành công!", "Thông báo");
                }
                catch (Exception)
                {
                    MessageBox.Show("Đã xảy ra lỗi trong quá trình xóa!", "Thông báo");
                }
                con.Close();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
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

            String sTenmon = cbTenmon.Text;
            String sGia = txtGia.Text;
            String sMaNuocUong = txtManuoc.Text;

            String sQuery = "update NUOCUONG set MaNuocUong = @MaNuocUong, TenMon =@TenMon,Gia =@Gia where MaNuocUong = @MaNuocUong";
            SqlCommand cmd = new SqlCommand(sQuery, con);
            cmd.Parameters.AddWithValue("@MaNuocUong", sMaNuocUong);
            cmd.Parameters.AddWithValue("@Tenmon", sTenmon);
            cmd.Parameters.AddWithValue("@Gia", sGia);


            try
            {
                cmd.ExecuteNonQuery();
                MessageBox.Show("Cập nhật thành công!", "Thông báo");
            }
            catch (Exception)
            {
                MessageBox.Show("Đã xảy ra lỗi trong quá trình cập nhật!", "Thông báo");
            }
            con.Close();
        }

        private void dataGridView1_CellClick_1(object sender, DataGridViewCellEventArgs e)
        {
            txtManuoc.Text = dataGridView1.Rows[e.RowIndex].Cells["MaNuocUong"].Value.ToString();
            cbTenmon.Text = dataGridView1.Rows[e.RowIndex].Cells["TenMon"].Value.ToString();
            txtGia.Text = dataGridView1.Rows[e.RowIndex].Cells["Gia"].Value.ToString();
            
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        
      
               
            }

        }
  

