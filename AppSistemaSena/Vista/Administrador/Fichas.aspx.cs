using AppSistemaSena.Vista.Instructor;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace AppSistemaSena.Vista.Administrador
{
    public partial class Fichas : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConexionBD"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProgramas();
                CargarFichas();
            }
        }

        private void CargarProgramas()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT Id, Nombre FROM Programa ORDER BY Nombre", cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlPrograma.DataSource = dt;
                ddlPrograma.DataTextField = "Nombre";
                ddlPrograma.DataValueField = "Id";
                ddlPrograma.DataBind();
                ddlPrograma.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
            }
        }

        private void CargarFichas()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                string sql = @"
                    SELECT f.Id, f.Codigo, f.FechaInicio, f.FechaFin,
                           f.Jornada, f.Descripcion, f.Estado,
                           p.Nombre AS NombrePrograma
                    FROM Ficha f
                    INNER JOIN Programa p ON f.IdPrograma = p.Id
                    ORDER BY f.Codigo";

                SqlDataAdapter da = new SqlDataAdapter(sql, cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvFichas.DataSource = dt;
                gvFichas.DataBind();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtCodigo.Text) ||
                ddlPrograma.SelectedValue == "0" ||
                string.IsNullOrWhiteSpace(txtFechaInicio.Text) ||
                string.IsNullOrWhiteSpace(txtFechaFin.Text) ||
                ddlJornada.SelectedValue == "" ||
                ddlEstado.SelectedValue == "" ||
                string.IsNullOrWhiteSpace(txtDescripcion.Text))
            {
                MostrarMensaje("Por favor completa todos los campos.", false);
                return;
            }

            int id = int.Parse(hfIdFicha.Value);

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                SqlCommand cmd;

                if (id == 0)
                {
                    cmd = new SqlCommand(@"
                        INSERT INTO Ficha 
                            (Codigo, FechaInicio, FechaFin, Jornada, 
                             Descripcion, Estado, IdPrograma)
                        VALUES 
                            (@Codigo, @FechaInicio, @FechaFin, @Jornada,
                             @Descripcion, @Estado, @IdPrograma)", cn);
                }
                else
                {
                    cmd = new SqlCommand(@"
                        UPDATE Ficha SET
                            Codigo      = @Codigo,
                            FechaInicio = @FechaInicio,
                            FechaFin    = @FechaFin,
                            Jornada     = @Jornada,
                            Descripcion = @Descripcion,
                            Estado      = @Estado,
                            IdPrograma  = @IdPrograma
                        WHERE Id = @Id", cn);
                    cmd.Parameters.AddWithValue("@Id", id);
                }

                cmd.Parameters.AddWithValue("@Codigo", txtCodigo.Text.Trim());
                cmd.Parameters.AddWithValue("@FechaInicio", DateTime.Parse(txtFechaInicio.Text));
                cmd.Parameters.AddWithValue("@FechaFin", DateTime.Parse(txtFechaFin.Text));
                cmd.Parameters.AddWithValue("@Jornada", ddlJornada.SelectedValue);
                cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text.Trim());
                cmd.Parameters.AddWithValue("@Estado", ddlEstado.SelectedValue);
                cmd.Parameters.AddWithValue("@IdPrograma", int.Parse(ddlPrograma.SelectedValue));

                cmd.ExecuteNonQuery();
            }

            LimpiarFormulario();
            CargarFichas();
            MostrarMensaje(id == 0 ? "Ficha registrada correctamente."
                                   : "Ficha actualizada correctamente.", true);
        }

        protected void gvFichas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Editar")
            {
                using (SqlConnection cn = new SqlConnection(connectionString))
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(
                        "SELECT * FROM Ficha WHERE Id = @Id", cn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        hfIdFicha.Value = id.ToString();
                        txtCodigo.Text = dr["Codigo"].ToString();
                        txtFechaInicio.Text = Convert.ToDateTime(dr["FechaInicio"])
                                                        .ToString("yyyy-MM-dd");
                        txtFechaFin.Text = Convert.ToDateTime(dr["FechaFin"])
                                                        .ToString("yyyy-MM-dd");
                        ddlJornada.SelectedValue = dr["Jornada"].ToString();
                        ddlEstado.SelectedValue = dr["Estado"].ToString();
                        txtDescripcion.Text = dr["Descripcion"].ToString();
                        string idPrograma = dr["IdPrograma"].ToString();
                        dr.Close();

                        CargarProgramas();
                        ddlPrograma.SelectedValue = idPrograma;
                    }
                }

                lblTituloForm.Text = "Editar Ficha";
            }
            else if (e.CommandName == "Eliminar")
            {
                using (SqlConnection cn = new SqlConnection(connectionString))
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Ficha WHERE Id = @Id", cn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.ExecuteNonQuery();
                }

                CargarFichas();
                MostrarMensaje("Ficha eliminada correctamente.", true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        private void LimpiarFormulario()
        {
            hfIdFicha.Value = "0";
            txtCodigo.Text = "";
            txtFechaInicio.Text = "";
            txtFechaFin.Text = "";
            ddlJornada.SelectedIndex = 0;
            ddlEstado.SelectedIndex = 0;
            txtDescripcion.Text = "";
            CargarProgramas();
            lblTituloForm.Text = "Nueva Ficha";
        }

        private void MostrarMensaje(string texto, bool exito)
        {
            pnlMensaje.Visible = true;
            lblMensaje.Text = texto;
            lblMensaje.CssClass = exito ? "msg-success" : "msg-error";
        }
    }
}