using AppSistemaSena.Datos;
using AppSistemaSena.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppSistemaSena.Logica
{
    public class LoginL
    {
        public UsuarioLogin MtLogin(UsuarioLogin oDatos, string tipoUsuario)
        {
            LoginD oLoginD = new LoginD();
            UsuarioLogin oDatosUser = oLoginD.MtLogin(oDatos, tipoUsuario);
            return oDatosUser;
        }
    }
}