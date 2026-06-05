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

            UsuarioLogin oDatosUsuario = new UsuarioLogin()
            {
                Documento = txtDocumento.Text.Trim(),
                Password = txtPassword.Text.Trim(),
            };

            // VALIDAR TIPO SELECCIONADO
            string tipoUsuario = "";

            if (rbInstructor.Checked)
            {
                tipoUsuario = "Instructor";
            }
            else if (rbAprendiz.Checked)
            {
                tipoUsuario = "Aprendiz";
            }
            else if (rbAdministrador.Checked)
            {
                tipoUsuario = "AdministradorCentro";
            }

            LoginL oLoginL = new LoginL();

            UsuarioLogin oDatosSesion = oLoginL.MtLogin(oDatosUsuario, tipoUsuario);

            if (oDatosSesion != null)
            {
                lblMensaje.Text = "Ingreso exitoso como " + oDatosSesion.Nombre + " ";
                lblMensaje.ForeColor = System.Drawing.Color.Green;

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "mensaje",
                    "Swal.fire('Bienvenido', 'Has ingresado correctamente', 'success');",
                    true
                );
                if(tipoUsuario == "Instructor")
                {
                    Response.Redirect("Vista/Instructor/IndexInstructor.aspx");
                }
                else if (tipoUsuario == "Aprendiz")
                {
                    Response.Redirect("Vista/Aprendiz/IndexAprendiz.aspx");
                }
                else if (tipoUsuario == "AdministradorCentro")
                {
                    Response.Redirect("Vista/AdministradorCentro/IndexAdministrador.aspx");
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