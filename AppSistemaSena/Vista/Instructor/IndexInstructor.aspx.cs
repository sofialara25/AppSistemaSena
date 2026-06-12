using System;
using System.Data.SqlClient;
using System.Configuration;

namespace AppSistemaSena.Vista.Instructor
{
    public partial class IndexInstructor : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConexionBD"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["NombreUsuario"] != null)
                    lblNombre.Text = Session["NombreUsuario"].ToString();

                CargarTotales();
            }
        }

        private int ObtenerIdInstructor()
        {
            string documento = Session["Documento"]?.ToString();

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT Id FROM Instructor WHERE NumeroDocumento = @Documento", cn);
                cmd.Parameters.AddWithValue("@Documento", documento);
                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToInt32(result) : 0;
            }
        }

        private void CargarTotales()
        {
            int idInstructor = ObtenerIdInstructor();

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();

                // Total fichas asignadas
                SqlCommand cmdFichas = new SqlCommand(@"
                    SELECT COUNT(*) FROM FichaInstructor 
                    WHERE IdInstructor = @IdInstructor", cn);
                cmdFichas.Parameters.AddWithValue("@IdInstructor", idInstructor);
                lblTotalFichas.Text = cmdFichas.ExecuteScalar().ToString();

                // Total aprendices a cargo (distintos)
                SqlCommand cmdAprendices = new SqlCommand(@"
                    SELECT COUNT(DISTINCT af.IdAprendiz)
                    FROM AprendizFicha af
                    INNER JOIN FichaInstructor fi ON af.IdFicha = fi.IdFicha
                    WHERE fi.IdInstructor = @IdInstructor", cn);
                cmdAprendices.Parameters.AddWithValue("@IdInstructor", idInstructor);
                lblTotalAprendices.Text = cmdAprendices.ExecuteScalar().ToString();

                // Planes pendientes creados por este instructor
                SqlCommand cmdPlanes = new SqlCommand(@"
                    SELECT COUNT(*) FROM PlanMejoramiento
                    WHERE IdInstructor = @IdInstructor AND EstadoPlan = 'Pendiente'", cn);
                cmdPlanes.Parameters.AddWithValue("@IdInstructor", idInstructor);
                lblPlanesPendientes.Text = cmdPlanes.ExecuteScalar().ToString();
            }
        }
    }
}