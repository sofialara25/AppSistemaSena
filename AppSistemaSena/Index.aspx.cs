using AppSistemaSena.Logica;
using AppSistemaSena.Modelo;
using System;
using System.Web.UI;

namespace AppSistemaSena
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDocumento.Text) ||
                string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMensaje.Text = "Faltan Datos";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Leer radio correctamente
            string radioValor = Request.Form["tipo"];
            string tipoUsuario = "";

            if (radioValor == "Instructor")
                tipoUsuario = "Instructor";
            else if (radioValor == "Aprendiz")
                tipoUsuario = "Aprendiz";
            else if (radioValor == "Administrador")
                tipoUsuario = "AdministradorCentro";

            if (string.IsNullOrEmpty(tipoUsuario))
            {
                lblMensaje.Text = "Selecciona un tipo de usuario";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                return;
            }

            UsuarioLogin oDatosUsuario = new UsuarioLogin()
            {
                Documento = txtDocumento.Text.Trim(),
                Password = txtPassword.Text.Trim(),
            };

            LoginL oLoginL = new LoginL();
            UsuarioLogin oDatosSesion = oLoginL.MtLogin(oDatosUsuario, tipoUsuario);

            if (oDatosSesion != null)
            {
                Session["UsuarioId"] = oDatosSesion.Id;
                Session["UsuarioNombre"] = oDatosSesion.Nombre;
                Session["Documento"] = oDatosSesion.Documento;
                Session["Rol"] = tipoUsuario;

                if (tipoUsuario == "Instructor")
                {
                    Response.Redirect("Vista/Instructor/IndexInstructor.aspx");
                }
                else if (tipoUsuario == "Aprendiz")
                {
                    Response.Redirect("Vista/Aprendiz/IndexAprendiz.aspx");
                }
                else if (tipoUsuario == "AdministradorCentro")
                {
                    Response.Redirect("Vista/Administrador/IndexAdmin.aspx");
                }
            }
            else
            {
                lblMensaje.Text = "Documento, contraseña o tipo incorrecto";
                lblMensaje.ForeColor = System.Drawing.Color.Red;

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "mensaje",
                    "Swal.fire('Error', 'Datos incorrectos', 'error');",
                    true
                );
            }
        }
    }
}