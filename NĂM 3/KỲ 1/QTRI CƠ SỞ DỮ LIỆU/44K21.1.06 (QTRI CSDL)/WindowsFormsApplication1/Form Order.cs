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
    public partial class Form_Order : Form
    {
        String sCon = "Data Source=NVMINH;Initial Catalog=QUANLY_CAFE;Integrated Security=True";
        public Form_Order()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button21_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button20_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button19_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button18_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button15_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button14_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button13_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button12_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button16_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button17_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button11_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            FormHoaDon f = new FormHoaDon();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void Form_Order_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Bạn có thật sự muốn thoát?", "Thông báo ", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }
      
        private void nướcUốngToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            FormNuocUong f = new FormNuocUong();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }

        private void đăngXuấtToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            FormDangNhap f = new FormDangNhap();
            this.Hide();
            f.ShowDialog();
            this.Show();

        }

        private void Form_Order_Load(object sender, EventArgs e)
        {

        }
    }
}
