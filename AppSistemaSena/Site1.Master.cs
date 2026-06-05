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
            if (Session["Usuario"] != null)
            {
                lblUsuario.Text = Session["Nombre"].ToString();
            }
        }

        protected void lbCerrar_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect(".../Index.aspx");
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {

        }
    }
}