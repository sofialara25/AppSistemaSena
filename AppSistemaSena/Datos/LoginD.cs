using AppSistemaSena.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AppSistemaSena.Datos
{
    public class LoginD
    {
        public UsuarioLogin MtLogin(UsuarioLogin oDatos, string tipoUsuario)
        {
            UsuarioLogin oUsuario = null;

            using (SqlConnection cn = ConexionBD.MtAbrirConexion())
            {
                cn.Open();
                string consulta = "";
                if(tipoUsuario == "Aprendiz")
                {
                    consulta = "select * from Aprendiz " +
                        "where NumeroDocumento = @Documento and Contraseña = @Password";
                }
                else if (tipoUsuario == "Instructor")
                {
                    consulta = "select * from Instructor " +
                        "where NumeroDocumento = @Documento and Contraseña = @Password";
                }
                else if (tipoUsuario == "AdministradorCentro")
                {
                    consulta = "select * from AdministradorCentro " +
                        "where NumeroDocumento = @Documento and Contraseña = @Password";
                }
                using (SqlCommand cmd = new SqlCommand(consulta, cn))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Parameters.AddWithValue("@Documento", oDatos.Documento);
                    cmd.Parameters.AddWithValue("@Password", oDatos.Password);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            oUsuario = new UsuarioLogin()
                            {
                                Id = Convert.ToInt32(dr["Id"]),
                                Nombre = dr["Nombre"].ToString(),
                                Documento = dr["NumeroDocumento"].ToString(),
                                Password = dr["Contraseña"].ToString(),
                            };
                        }
                    }
                }
            }
            return oUsuario;
        }
    }
}