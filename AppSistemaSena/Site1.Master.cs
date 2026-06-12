using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppSistemaSena
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Rol"] == null)
            {
                Response.Redirect("~/Index.aspx");
                return;
            }

            string rol = Session["Rol"].ToString();

            // Muestra el panel correcto, oculta los demás
            pnlMenuAprendiz.Visible = (rol == "Aprendiz");
            pnlMenuInstructor.Visible = (rol == "Instructor");
            pnlMenuAdmin.Visible = (rol == "AdministradorCentro");
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Index.aspx");
        }
    }
}