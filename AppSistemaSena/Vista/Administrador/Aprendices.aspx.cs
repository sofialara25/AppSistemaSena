using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppSistemaSena.Vista.Administrador
{
    public partial class Aprendices : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConexionBD"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarEstados();
                CargarFichas();
                CargarAprendices();
            }
        }

        private void CargarEstados()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT Id, TipoEstado FROM Estado ORDER BY TipoEstado", cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlEstado.DataSource = dt;
                ddlEstado.DataTextField = "TipoEstado";
                ddlEstado.DataValueField = "Id";
                ddlEstado.DataBind();
                ddlEstado.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
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

                // Dropdown del modal
                ddlFichaAsignar.DataSource = dt;
                ddlFichaAsignar.DataTextField = "Codigo";
                ddlFichaAsignar.DataValueField = "Id";
                ddlFichaAsignar.DataBind();
                ddlFichaAsignar.Items.Insert(0, new ListItem("-- Seleccione --", "0"));

                // Dropdown de carga Excel
                ddlFichaExcel.DataSource = dt;
                ddlFichaExcel.DataTextField = "Codigo";
                ddlFichaExcel.DataValueField = "Id";
                ddlFichaExcel.DataBind();
                ddlFichaExcel.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
            }
        }

        private void CargarAprendices()
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                string sql = @"
                    SELECT a.Id, a.TipoDocumento, a.NumeroDocumento,
                           a.Nombre, a.Apellido, a.Correo, a.Telefono,
                           e.TipoEstado AS NombreEstado
                    FROM Aprendiz a
                    INNER JOIN Estado e ON a.IdEstado = e.Id
                    ORDER BY a.Nombre";

                SqlDataAdapter da = new SqlDataAdapter(sql, cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvAprendices.DataSource = dt;
                gvAprendices.DataBind();
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
                ddlEstado.SelectedValue == "0")
            {
                MostrarMensaje("Por favor completa todos los campos.", false);
                return;
            }

            int id = int.Parse(hfIdAprendiz.Value);

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                SqlCommand cmd;

                if (id == 0)
                {
                    cmd = new SqlCommand(@"
                        INSERT INTO Aprendiz
                            (TipoDocumento, NumeroDocumento, Nombre, Apellido,
                             Correo, Contraseña, Telefono, IdEstado, IdRol)
                        VALUES
                            (@TipoDoc, @NumDoc, @Nombre, @Apellido,
                             @Correo, @Contrasena, @Telefono, @IdEstado, 2)", cn);

                }
                else
                {
                    cmd = new SqlCommand(@"
                            UPDATE Aprendiz SET
                                TipoDocumento   = @TipoDoc,
                                NumeroDocumento = @NumDoc,
                                Nombre          = @Nombre,
                                Apellido        = @Apellido,
                                Correo          = @Correo,
                                Telefono        = @Telefono,
                                IdEstado        = @IdEstado
                            WHERE Id = @Id", cn);
                    

                    cmd.Parameters.AddWithValue("@Id", id);
                }

                cmd.Parameters.AddWithValue("@TipoDoc", ddlTipoDoc.SelectedValue);
                cmd.Parameters.AddWithValue("@NumDoc", txtNumDoc.Text.Trim());
                cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text.Trim());
                cmd.Parameters.AddWithValue("@Apellido", txtApellido.Text.Trim());
                cmd.Parameters.AddWithValue("@Correo", txtCorreo.Text.Trim());
                cmd.Parameters.AddWithValue("@Telefono", txtTelefono.Text.Trim());
                cmd.Parameters.AddWithValue("@IdEstado", int.Parse(ddlEstado.SelectedValue));

                cmd.ExecuteNonQuery();
            }

            LimpiarFormulario();
            CargarAprendices();
            MostrarMensaje(id == 0 ? "Aprendiz registrado correctamente."
                                   : "Aprendiz actualizado correctamente.", true);
        }

        // ── CARGA MASIVA EXCEL ──
        protected void btnCargarExcel_Click(object sender, EventArgs e)
        {
            if (!fuExcel.HasFile)
            {
                MostrarMensaje("Selecciona un archivo Excel.", false);
                return;
            }

            if (ddlFichaExcel.SelectedValue == "0")
            {
                MostrarMensaje("Selecciona una ficha para asignar.", false);
                return;
            }

            int idFicha = int.Parse(ddlFichaExcel.SelectedValue);
            var errores = new List<string>();
            int registrados = 0;

            // Guardar el archivo temporalmente
            string fileName = System.IO.Path.GetFileName(fuExcel.FileName);
            string tempPath = Server.MapPath("~/Temp/") + fileName;

            // Crear carpeta Temp si no existe
            if (!System.IO.Directory.Exists(Server.MapPath("~/Temp/")))
                System.IO.Directory.CreateDirectory(Server.MapPath("~/Temp/"));

            fuExcel.SaveAs(tempPath);

            string connExcel = $"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={tempPath};" +
                               "Extended Properties='Excel 12.0 Xml;HDR=YES;IMEX=1';";

            DataTable dt = new DataTable();

            using (System.Data.OleDb.OleDbConnection cnExcel =
                new System.Data.OleDb.OleDbConnection(connExcel))
            {
                cnExcel.Open();

                // Obtener el nombre de la primera hoja
                DataTable hojas = cnExcel.GetOleDbSchemaTable(
                    System.Data.OleDb.OleDbSchemaGuid.Tables, null);
                string hoja = hojas.Rows[0]["TABLE_NAME"].ToString();

                System.Data.OleDb.OleDbDataAdapter da =
                    new System.Data.OleDb.OleDbDataAdapter(
                        $"SELECT * FROM [{hoja}]", cnExcel);
                da.Fill(dt);
            }

            // Validar columnas
            string[] columnas = { "TipoDocumento", "NumeroDocumento",
                          "Nombre", "Apellido", "Correo", "Telefono" };
            foreach (var col in columnas)
            {
                if (!dt.Columns.Contains(col))
                {
                    MostrarMensaje($"El archivo no tiene la columna '{col}'.", false);
                    System.IO.File.Delete(tempPath);
                    return;
                }
            }

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int fila = i + 2;
                    string tipoDoc = dt.Rows[i]["TipoDocumento"].ToString().Trim();
                    string numDoc = dt.Rows[i]["NumeroDocumento"].ToString().Trim();
                    string nombre = dt.Rows[i]["Nombre"].ToString().Trim();
                    string apell = dt.Rows[i]["Apellido"].ToString().Trim();
                    string correo = dt.Rows[i]["Correo"].ToString().Trim();
                    string tel = dt.Rows[i]["Telefono"].ToString().Trim();

                    if (string.IsNullOrWhiteSpace(tipoDoc) ||
                        string.IsNullOrWhiteSpace(numDoc) ||
                        string.IsNullOrWhiteSpace(nombre) ||
                        string.IsNullOrWhiteSpace(apell) ||
                        string.IsNullOrWhiteSpace(correo) ||
                        string.IsNullOrWhiteSpace(tel))
                    {
                        errores.Add($"Fila {fila}: campos incompletos.");
                        continue;
                    }

                    // Verificar duplicado
                    SqlCommand cmdCheck = new SqlCommand(
                        "SELECT COUNT(*) FROM Aprendiz WHERE NumeroDocumento = @NumDoc", cn);
                    cmdCheck.Parameters.AddWithValue("@NumDoc", numDoc);
                    int existe = (int)cmdCheck.ExecuteScalar();

                    if (existe > 0)
                    {
                        errores.Add($"Fila {fila}: documento '{numDoc}' ya existe.");
                        continue;
                    }

                    // Insertar aprendiz
                    SqlCommand cmdInsert = new SqlCommand(@"
                INSERT INTO Aprendiz
                    (TipoDocumento, NumeroDocumento, Nombre, Apellido,
                     Correo, Contraseña, Telefono, IdEstado, IdRol)
                VALUES
                    (@TipoDoc, @NumDoc, @Nombre, @Apellido,
                     @Correo, '12345', @Telefono, 1, 2);
                SELECT SCOPE_IDENTITY();", cn);

                    cmdInsert.Parameters.AddWithValue("@TipoDoc", tipoDoc);
                    cmdInsert.Parameters.AddWithValue("@NumDoc", numDoc);
                    cmdInsert.Parameters.AddWithValue("@Nombre", nombre);
                    cmdInsert.Parameters.AddWithValue("@Apellido", apell);
                    cmdInsert.Parameters.AddWithValue("@Correo", correo);
                    cmdInsert.Parameters.AddWithValue("@Telefono", tel);

                    int idAprendiz = Convert.ToInt32(cmdInsert.ExecuteScalar());

                    // Asignar a ficha
                    SqlCommand cmdFicha = new SqlCommand(@"
                INSERT INTO AprendizFicha (IdAprendiz, IdFicha)
                VALUES (@IdAprendiz, @IdFicha)", cn);
                    cmdFicha.Parameters.AddWithValue("@IdAprendiz", idAprendiz);
                    cmdFicha.Parameters.AddWithValue("@IdFicha", idFicha);
                    cmdFicha.ExecuteNonQuery();

                    registrados++;
                }
            }

            // Eliminar archivo temporal
            System.IO.File.Delete(tempPath);

            if (errores.Count > 0)
            {
                pnlErroresExcel.Visible = true;
                blErrores.Items.Clear();
                foreach (var err in errores)
                    blErrores.Items.Add(err);
            }

            CargarAprendices();
            MostrarMensaje($"{registrados} aprendiz(ces) cargados correctamente.", true);
        }

        protected void gvAprendices_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Editar")
            {
                using (SqlConnection cn = new SqlConnection(connectionString))
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(
                        "SELECT * FROM Aprendiz WHERE Id = @Id", cn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        hfIdAprendiz.Value = id.ToString();
                        ddlTipoDoc.SelectedValue = dr["TipoDocumento"].ToString();
                        txtNumDoc.Text = dr["NumeroDocumento"].ToString();
                        txtNombre.Text = dr["Nombre"].ToString();
                        txtApellido.Text = dr["Apellido"].ToString();
                        txtCorreo.Text = dr["Correo"].ToString();
                        txtTelefono.Text = dr["Telefono"].ToString();
                        string idEstado = dr["IdEstado"].ToString();
                        dr.Close();

                        CargarEstados();
                        ddlEstado.SelectedValue = idEstado;
                    }
                }

                lblTituloForm.Text = "Editar Aprendiz";
            }
            else if (e.CommandName == "Eliminar")
            {
                using (SqlConnection cn = new SqlConnection(connectionString))
                {
                    cn.Open();
                    new SqlCommand("DELETE FROM Aprendiz WHERE Id = @Id", cn)
                    {
                        Parameters = { new SqlParameter("@Id", id) }
                    }.ExecuteNonQuery();
                }

                CargarAprendices();
                MostrarMensaje("Aprendiz eliminado correctamente.", true);
            }
            else if (e.CommandName == "AsignarFicha")
            {
                hfIdAprendizAsignar.Value = id.ToString();
                CargarFichas();
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

            int idAprendiz = int.Parse(hfIdAprendizAsignar.Value);
            int idFicha = int.Parse(ddlFichaAsignar.SelectedValue);

            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();

                SqlCommand cmdCheck = new SqlCommand(@"
                    SELECT COUNT(*) FROM AprendizFicha
                    WHERE IdAprendiz = @IdAprendiz AND IdFicha = @IdFicha", cn);
                cmdCheck.Parameters.AddWithValue("@IdAprendiz", idAprendiz);
                cmdCheck.Parameters.AddWithValue("@IdFicha", idFicha);
                int existe = (int)cmdCheck.ExecuteScalar();

                if (existe > 0)
                {
                    MostrarMensaje("Este aprendiz ya está asignado a esa ficha.", false);
                    return;
                }

                SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO AprendizFicha (IdAprendiz, IdFicha)
                    VALUES (@IdAprendiz, @IdFicha)", cn);
                cmd.Parameters.AddWithValue("@IdAprendiz", idAprendiz);
                cmd.Parameters.AddWithValue("@IdFicha", idFicha);
                cmd.ExecuteNonQuery();
            }

            CargarAprendices();
            MostrarMensaje("Ficha asignada correctamente.", true);
        }

        private void LimpiarFormulario()
        {
            hfIdAprendiz.Value = "0";
            ddlTipoDoc.SelectedIndex = 0;
            txtNumDoc.Text = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtCorreo.Text = "";
            txtTelefono.Text = "";
            CargarEstados();
            lblTituloForm.Text = "Nuevo Aprendiz";
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