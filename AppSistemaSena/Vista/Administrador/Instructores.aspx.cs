using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppSistemaSena.Vista.Administrador
{
    public partial class Instructores : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConexionBD"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarAreas();
                CargarFichas();
                CargarInstructores();
            }
        }

        private void CargarAreas()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT Id, Nombre FROM Area ORDER BY Nombre", cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlArea.DataSource = dt;
                ddlArea.DataTextField = "Nombre";
                ddlArea.DataValueField = "Id";
                ddlArea.DataBind();
                ddlArea.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
            }
        }

        private void CargarFichas()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT Id, Codigo FROM Ficha ORDER BY Codigo", cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlFichaAsignar.DataSource = dt;
                ddlFichaAsignar.DataTextField = "Codigo";
                ddlFichaAsignar.DataValueField = "Id";
                ddlFichaAsignar.DataBind();
                ddlFichaAsignar.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
            }
        }

        private void CargarInstructores()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                string sql = @"
                    SELECT i.Id, i.TipoDocumento, i.NumeroDocumento,
                           i.Nombre, i.Apellido, i.Correo, i.Telefono,
                           a.Nombre AS NombreArea
                    FROM Instructor i
                    INNER JOIN Area a ON i.IdArea = a.Id
                    ORDER BY i.Nombre";

                SqlDataAdapter da = new SqlDataAdapter(sql, cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvInstructores.DataSource = dt;
                gvInstructores.DataBind();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (ddlTipoDoc.SelectedValue == "" ||
                string.IsNullOrWhiteSpace(txtNumDoc.Text) ||
                string.IsNullOrWhiteSpace(txtNombre.Text) ||
                string.IsNullOrWhiteSpace(txtApellido.Text) ||
                string.IsNullOrWhiteSpace(txtCorreo.Text) ||
                string.IsNullOrWhiteSpace(txtTelefono.Text) ||
                ddlArea.SelectedValue == "0")
            {
                MostrarMensaje("Por favor completa todos los campos.", false);
                return;
            }

            int id = int.Parse(hfIdInstructor.Value);

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                SqlCommand cmd;

                if (id == 0)
                {
                    // En INSERT siempre pedimos contraseña
                    if (string.IsNullOrWhiteSpace(txtContrasena.Text))
                    {
                        MostrarMensaje("La contraseña es obligatoria.", false);
                        return;
                    }

                    cmd = new SqlCommand(@"
                        INSERT INTO Instructor
                            (TipoDocumento, NumeroDocumento, Nombre, Apellido,
                             Correo, Contraseña, Telefono, IdArea, IdRol)
                        VALUES
                            (@TipoDoc, @NumDoc, @Nombre, @Apellido,
                             @Correo, @Contrasena, @Telefono, @IdArea, 1)", cn);

                    cmd.Parameters.AddWithValue("@Contrasena", txtContrasena.Text.Trim());
                }
                else
                {
                    // En UPDATE la contraseña es opcional
                    if (!string.IsNullOrWhiteSpace(txtContrasena.Text))
                    {
                        cmd = new SqlCommand(@"
                            UPDATE Instructor SET
                                TipoDocumento  = @TipoDoc,
                                NumeroDocumento= @NumDoc,
                                Nombre         = @Nombre,
                                Apellido       = @Apellido,
                                Correo         = @Correo,
                                Contraseña     = @Contrasena,
                                Telefono       = @Telefono,
                                IdArea         = @IdArea
                            WHERE Id = @Id", cn);
                        cmd.Parameters.AddWithValue("@Contrasena", txtContrasena.Text.Trim());
                    }
                    else
                    {
                        cmd = new SqlCommand(@"
                            UPDATE Instructor SET
                                TipoDocumento  = @TipoDoc,
                                NumeroDocumento= @NumDoc,
                                Nombre         = @Nombre,
                                Apellido       = @Apellido,
                                Correo         = @Correo,
                                Telefono       = @Telefono,
                                IdArea         = @IdArea
                            WHERE Id = @Id", cn);
                    }

                    cmd.Parameters.AddWithValue("@Id", id);
                }

                cmd.Parameters.AddWithValue("@TipoDoc", ddlTipoDoc.SelectedValue);
                cmd.Parameters.AddWithValue("@NumDoc", txtNumDoc.Text.Trim());
                cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text.Trim());
                cmd.Parameters.AddWithValue("@Apellido", txtApellido.Text.Trim());
                cmd.Parameters.AddWithValue("@Correo", txtCorreo.Text.Trim());
                cmd.Parameters.AddWithValue("@Telefono", txtTelefono.Text.Trim());
                cmd.Parameters.AddWithValue("@IdArea", int.Parse(ddlArea.SelectedValue));

                cmd.ExecuteNonQuery();
            }

            LimpiarFormulario();
            CargarInstructores();
            MostrarMensaje(id == 0 ? "Instructor registrado correctamente."
                                   : "Instructor actualizado correctamente.", true);
        }

        protected void gvInstructores_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Editar")
            {
                using (SqlConnection cn = new SqlConnection(connectionString))
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(
                        "SELECT * FROM Instructor WHERE Id = @Id", cn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        hfIdInstructor.Value = id.ToString();
                        ddlTipoDoc.SelectedValue = dr["TipoDocumento"].ToString();
                        txtNumDoc.Text = dr["NumeroDocumento"].ToString();
                        txtNombre.Text = dr["Nombre"].ToString();
                        txtApellido.Text = dr["Apellido"].ToString();
                        txtCorreo.Text = dr["Correo"].ToString();
                        txtTelefono.Text = dr["Telefono"].ToString();
                        string idArea = dr["IdArea"].ToString();
                        dr.Close();

                        CargarAreas();
                        ddlArea.SelectedValue = idArea;
                    }
                }

                lblTituloForm.Text = "Editar Instructor";
            }
            else if (e.CommandName == "Eliminar")
            {
                using (SqlConnection cn = new SqlConnection(connectionString))
                {
                    cn.Open();
                    new SqlCommand("DELETE FROM Instructor WHERE Id = @Id", cn)
                    {
                        Parameters = { new SqlParameter("@Id", id) }
                    }.ExecuteNonQuery();
                }

                CargarInstructores();
                MostrarMensaje("Instructor eliminado correctamente.", true);
            }
            else if (e.CommandName == "AsignarFicha")
            {
                hfIdInstructorAsignar.Value = id.ToString();
                CargarFichas();
                // Abrir modal desde el servidor
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "abrirModal", "abrirModal();", true);
            }
        }

        protected void btnConfirmarAsignar_Click(object sender, EventArgs e)
        {
            if (ddlFichaAsignar.SelectedValue == "0")
            {
                MostrarMensaje("Selecciona una ficha.", false);
                return;
            }

            int idInstructor = int.Parse(hfIdInstructorAsignar.Value);
            int idFicha = int.Parse(ddlFichaAsignar.SelectedValue);

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();

                // Verificar si ya está asignado
                SqlCommand cmdCheck = new SqlCommand(@"
                    SELECT COUNT(*) FROM FichaInstructor 
                    WHERE IdFicha = @IdFicha AND IdInstructor = @IdInstructor", cn);
                cmdCheck.Parameters.AddWithValue("@IdFicha", idFicha);
                cmdCheck.Parameters.AddWithValue("@IdInstructor", idInstructor);
                int existe = (int)cmdCheck.ExecuteScalar();

                if (existe > 0)
                {
                    MostrarMensaje("Este instructor ya está asignado a esa ficha.", false);
                    return;
                }

                SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO FichaInstructor (IdFicha, IdInstructor)
                    VALUES (@IdFicha, @IdInstructor)", cn);
                cmd.Parameters.AddWithValue("@IdFicha", idFicha);
                cmd.Parameters.AddWithValue("@IdInstructor", idInstructor);
                cmd.ExecuteNonQuery();
            }

            CargarInstructores();
            MostrarMensaje("Ficha asignada correctamente.", true);
        }

        private void LimpiarFormulario()
        {
            hfIdInstructor.Value = "0";
            ddlTipoDoc.SelectedIndex = 0;
            txtNumDoc.Text = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtCorreo.Text = "";
            txtContrasena.Text = "";
            txtTelefono.Text = "";
            CargarAreas();
            lblTituloForm.Text = "Nuevo Instructor";
        }

        private void MostrarMensaje(string texto, bool exito)
        {
            pnlMensaje.Visible = true;
            lblMensaje.Text = texto;
            lblMensaje.CssClass = exito ? "msg-success" : "msg-error";
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {

        }
    }
}