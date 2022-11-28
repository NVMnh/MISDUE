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
    public partial class FormDangNhap : Form
    {
        public FormDangNhap()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection("Data Source=NVMINH;Initial Catalog=QUANLY_CAFE;Integrated Security=True");
            try
            {
                conn.Open();
                String Tendangnhap = txtTendangnhap.Text;
                String Matkhau = txtMatkhau.Text;
                String sql = "select * from TAIKHOAN where TenDangNhap ='" + Tendangnhap + "' and MatKhau='" + Matkhau + "'";
                SqlCommand cmd = new SqlCommand(sql, conn);
                SqlDataReader dta = cmd.ExecuteReader();
                if (dta.Read() == true)
                {
                    MessageBox.Show("Đăng nhập thành công", "Thông báo");
                    Form_Order f = new Form_Order();
                    this.Hide();
                    f.ShowDialog();
                    this.Show();
                }
                else
                {
                    MessageBox.Show("Đăng nhập thất bại", "Thông báo");
                }
            }
            catch (Exception)
            {
                MessageBox.Show("Lỗi kết nối", "Thông báo");
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void FormDangNhap_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Bạn có thật sự muốn thoát?", "Thông báo ", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }

        private void FormDangNhap_Load(object sender, EventArgs e)
        {

        }
    }
}

    
    
           
            


        
    

