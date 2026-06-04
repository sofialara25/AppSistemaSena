using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AppSistemaSena.Datos
{
    public class ConexionBD
    {
        private static readonly string cadena = System.Configuration.ConfigurationManager.ConnectionStrings["conexionBD"].ConnectionString;

        public static SqlConnection MtAbrirConexion()
        {
            if (string.IsNullOrEmpty(cadena))
            {
                throw new Exception("La cadena de conexión no está configurada.");
            }
            return new SqlConnection(cadena);
        }
    }
}