using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace AppSistemaSena.Vista.Administrador
{
    public partial class IndexAdmin : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConexionBD"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Nombre del usuario en el saludo
                if (Session["NombreUsuario"] != null)
                    lblNombre.Text = Session["NombreUsuario"].ToString();

                CargarTotales();
            }
        }

        private void CargarTotales()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();

                lblTotalInstructores.Text = ObtenerConteo(cn, "SELECT COUNT(*) FROM Instructor");
                lblTotalAprendices.Text = ObtenerConteo(cn, "SELECT COUNT(*) FROM Aprendiz");
                lblTotalProgramas.Text = ObtenerConteo(cn, "SELECT COUNT(*) FROM Programa");
                lblTotalFichas.Text = ObtenerConteo(cn, "SELECT COUNT(*) FROM Ficha");
            }
        }

        private string ObtenerConteo(SqlConnection cn, string sql)
        {
            SqlCommand cmd = new SqlCommand(sql, cn);
            return cmd.ExecuteScalar().ToString();
        }
    }
}