using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppSistemaSena.Modelo
{
    public class UsuarioLogin
    {
        public int Id { get; set; }
        public string Documento { get; set; }
        public string Password { get; set; }
        public string Nombre { get; set; }

    }
}