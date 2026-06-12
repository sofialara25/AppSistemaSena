using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppSistemaSena.Vista.Instructor
{
    public partial class Fichas : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConexionBD"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarFichas();
            }
        }

        private int ObtenerIdInstructor()
        {
            // El instructor inicia sesión con su NumeroDocumento guardado en Session
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

        private void CargarFichas()
        {
            int idInstructor = ObtenerIdInstructor();

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                string sql = @"
                    SELECT f.Id, f.Codigo, f.Jornada, f.Estado,
                           p.Nombre AS NombrePrograma
                    FROM Ficha f
                    INNER JOIN Programa p ON f.IdPrograma = p.Id
                    INNER JOIN FichaInstructor fi ON f.Id = fi.IdFicha
                    WHERE fi.IdInstructor = @IdInstructor
                    ORDER BY f.Codigo";

                SqlCommand cmd = new SqlCommand(sql, cn);
                cmd.Parameters.AddWithValue("@IdInstructor", idInstructor);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptFichas.DataSource = dt;
                rptFichas.DataBind();
            }
        }

        protected void rptFichas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "VerFicha")
            {
                int idFicha = int.Parse(e.CommandArgument.ToString());
                CargarAprendicesFicha(idFicha);
            }
        }

        private void CargarAprendicesFicha(int idFicha)
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();

                // Código de la ficha para el título
                SqlCommand cmdCodigo = new SqlCommand(
                    "SELECT Codigo FROM Ficha WHERE Id = @Id", cn);
                cmdCodigo.Parameters.AddWithValue("@Id", idFicha);
                lblCodigoFicha.Text = cmdCodigo.ExecuteScalar().ToString();

                string sql = @"
                    SELECT a.Id, a.TipoDocumento, a.NumeroDocumento,
                           a.Nombre, a.Apellido, a.Correo,
                           e.TipoEstado AS NombreEstado
                    FROM Aprendiz a
                    INNER JOIN AprendizFicha af ON a.Id = af.IdAprendiz
                    INNER JOIN Estado e ON a.IdEstado = e.Id
                    WHERE af.IdFicha = @IdFicha
                    ORDER BY a.Nombre";

                SqlCommand cmd = new SqlCommand(sql, cn);
                cmd.Parameters.AddWithValue("@IdFicha", idFicha);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvAprendices.DataSource = dt;
                gvAprendices.DataBind();
            }

            pnlAprendices.Visible = true;
            // Guardar el id de ficha actual para futuras acciones
            ViewState["IdFichaActual"] = idFicha;
        }

        protected void gvAprendices_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CrearPlan")
            {
                int idAprendiz = int.Parse(e.CommandArgument.ToString());
                // Redirige a Planes.aspx pasando el id del aprendiz
                Response.Redirect($"~/Vista/Instructor/Planes.aspx?idAprendiz={idAprendiz}");
            }
        }
    }
}