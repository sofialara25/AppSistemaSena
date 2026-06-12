using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;

namespace AppSistemaSena.Vista.Administrador
{
    public partial class Programas : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConexionBD"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCompetencias();
                CargarProgramas();
            }
        }

        // ── CARGAR DROPDOWN COMPETENCIAS ──
        private void CargarCompetencias()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                string sql = "SELECT Id, Nombre FROM Competencia ORDER BY Nombre";
                SqlDataAdapter da = new SqlDataAdapter(sql, cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlCompetencia.DataSource = dt;
                ddlCompetencia.DataTextField = "Nombre";
                ddlCompetencia.DataValueField = "Id";
                ddlCompetencia.DataBind();
                ddlCompetencia.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
            }
        }

        // ── CARGAR TABLA DE PROGRAMAS ──
        private void CargarProgramas()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                string sql = @"
                    SELECT p.Id, p.Codigo, p.Nombre, p.NivelFormacion, 
                           p.Duracion, p.Estado, c.Nombre AS NombreCompetencia
                    FROM Programa p
                    INNER JOIN Competencia c ON p.IdCompetencia = c.Id
                    ORDER BY p.Nombre";

                SqlDataAdapter da = new SqlDataAdapter(sql, cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvProgramas.DataSource = dt;
                gvProgramas.DataBind();
            }
        }

        // ── GUARDAR (INSERT o UPDATE) ──
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Validaciones básicas
            if (string.IsNullOrWhiteSpace(txtCodigo.Text) ||
                string.IsNullOrWhiteSpace(txtNombre.Text) ||
                ddlNivel.SelectedValue == "" ||
                string.IsNullOrWhiteSpace(txtDuracion.Text) ||
                ddlEstado.SelectedValue == "" ||
                ddlCompetencia.SelectedValue == "0")
            {
                MostrarMensaje("Por favor completa todos los campos.", false);
                return;
            }

            int id = int.Parse(hfIdPrograma.Value);

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                SqlCommand cmd;

                if (id == 0)
                {
                    // INSERT
                    cmd = new SqlCommand(@"
                        INSERT INTO Programa 
                            (Codigo, Nombre, NivelFormacion, Duracion, Estado, IdCompetencia)
                        VALUES 
                            (@Codigo, @Nombre, @Nivel, @Duracion, @Estado, @IdCompetencia)", cn);
                }
                else
                {
                    // UPDATE
                    cmd = new SqlCommand(@"
                        UPDATE Programa SET
                            Codigo         = @Codigo,
                            Nombre         = @Nombre,
                            NivelFormacion = @Nivel,
                            Duracion       = @Duracion,
                            Estado         = @Estado,
                            IdCompetencia  = @IdCompetencia
                        WHERE Id = @Id", cn);
                    cmd.Parameters.AddWithValue("@Id", id);
                }

                cmd.Parameters.AddWithValue("@Codigo", txtCodigo.Text.Trim());
                cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text.Trim());
                cmd.Parameters.AddWithValue("@Nivel", ddlNivel.SelectedValue);
                cmd.Parameters.AddWithValue("@Duracion", txtDuracion.Text.Trim());
                cmd.Parameters.AddWithValue("@Estado", ddlEstado.SelectedValue);
                cmd.Parameters.AddWithValue("@IdCompetencia", int.Parse(ddlCompetencia.SelectedValue));

                cmd.ExecuteNonQuery();
            }

            LimpiarFormulario();
            CargarProgramas();
            MostrarMensaje(id == 0 ? "Programa registrado correctamente."
                                   : "Programa actualizado correctamente.", true);
        }

        // ── EDITAR / ELIMINAR desde la tabla ──
        protected void gvProgramas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Editar")
            {
                using (SqlConnection cn = new SqlConnection(connectionString))
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(
                        "SELECT * FROM Programa WHERE Id = @Id", cn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        hfIdPrograma.Value = id.ToString();
                        txtCodigo.Text = dr["Codigo"].ToString();
                        txtNombre.Text = dr["Nombre"].ToString();
                        ddlNivel.SelectedValue = dr["NivelFormacion"].ToString();
                        txtDuracion.Text = dr["Duracion"].ToString();
                        ddlEstado.SelectedValue = dr["Estado"].ToString();

                        // El dropdown de competencias necesita recargarse primero
                        dr.Close();
                        CargarCompetencias();
                        ddlCompetencia.SelectedValue =
                            new SqlCommand(
                                "SELECT IdCompetencia FROM Programa WHERE Id = @Id",
                                cn)
                            { Parameters = { new SqlParameter("@Id", id) } }
                            .ExecuteScalar().ToString();
                    }
                }

                lblTituloForm.Text = "Editar Programa";
            }
            else if (e.CommandName == "Eliminar")
            {
                using (SqlConnection cn = new SqlConnection(connectionString))
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Programa WHERE Id = @Id", cn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.ExecuteNonQuery();
                }

                CargarProgramas();
                MostrarMensaje("Programa eliminado correctamente.", true);
            }
        }

        // ── CANCELAR ──
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        // ── HELPERS ──
        private void LimpiarFormulario()
        {
            hfIdPrograma.Value = "0";
            txtCodigo.Text = "";
            txtNombre.Text = "";
            ddlNivel.SelectedIndex = 0;
            txtDuracion.Text = "";
            ddlEstado.SelectedIndex = 0;
            CargarCompetencias();
            lblTituloForm.Text = "Nuevo Programa";
        }

        private void MostrarMensaje(string texto, bool exito)
        {
            pnlMensaje.Visible = true;
            lblMensaje.Text = texto;
            lblMensaje.CssClass = exito ? "msg-success" : "msg-error";
        }
    }
}