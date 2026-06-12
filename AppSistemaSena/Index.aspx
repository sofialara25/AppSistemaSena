<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="AppSistemaSena.Index" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Portal Académico - Universidad Nacional</title>
    <link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@300;400;700&family=Source+Sans+3:wght@300;400;500;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="login.css" />
    <style>
        /* RESET */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        /* PÁGINA*/
        body {
            min-height: 100vh;
            background: #f4f1ec;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            font-family: 'Source Sans 3', sans-serif;
        }

        /* TARJETA PRINCIPAL*/
        .u-card {
            background: #ffffff;
            border-radius: 4px;
            border: 0.5px solid #ddd;
            width: 100%;
            max-width: 420px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        }

        /* ENCABEZADO*/
        .u-header {
            background: #0c9f2e;
            padding: 1.75rem 2.5rem;
            border-bottom: 4px solid #C8A94A;
        }

        .u-name-main {
            font-family: 'Merriweather', serif;
            font-size: 20px;
            font-weight: 700;
            color: #f5f0e8;
            letter-spacing: 0.01em;
            line-height: 1.3;
            margin-bottom: 6px;
        }

        .u-portal-title {
            font-size: 13px;
            font-weight: 400;
            color: #000000;
            letter-spacing: 0.1em;
            text-transform: uppercase;
        }

        /*CUERPO DEL FORMULARIO*/
        .u-body {
            padding: 2rem 2.5rem 2.25rem;
        }

        .u-portal-desc {
            font-size: 13px;
            color: #666;
            margin-bottom: 1.75rem;
            line-height: 1.5;
        }

        .u-label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            color: #555;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .u-field {
            margin-bottom: 1.1rem;
        }

        /*INPUTS Y SELECT */
        .u-input,
        .u-select {
            width: 100%;
            height: 40px;
            padding: 0 12px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 14px;
            background: #f8f8f8;
            border: 1px solid #ccc;
            border-radius: 3px;
            color: #222;
            outline: none;
            transition: border-color 0.15s, box-shadow 0.15s;
        }

        .u-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%23888' d='M6 8L0 0h12z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            cursor: pointer;
        }

            .u-input:focus,
            .u-select:focus {
                border-color: #1B3A6B;
                box-shadow: 0 0 0 3px rgba(27, 58, 107, 0.1);
            }

        /* FILA TIPO + NÚMERO */
        .u-doc-row {
            display: grid;
            grid-template-columns: 1fr 1.6fr;
            gap: 8px;
        }

        /* FILA RADIO + RECUPERAR */
        .u-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            margin-top: 0.10rem;
            gap: 12px;
        }

        .u-radio-group {
            display: flex;
            gap: 16px;
        }

        .u-radio-label {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            color: #555;
            cursor: pointer;
        }

        .u-forgot {
            font-size: 14px;
            color: #1B3A6B;
            text-decoration: none;
            font-weight: 600;
            white-space: nowrap;
        }

            .u-forgot:hover {
                text-decoration: underline;
            }

        /* BOTÓN */
        .u-btn {
            width: 100%;
            height: 42px;
            background: #0c9f2e;
            color: #fff;
            border: none;
            border-radius: 3px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 14px;
            font-weight: 600;
            letter-spacing: 0.05em;
            cursor: pointer;
            transition: background 0.15s;
        }

            .u-btn:hover {
                background: #152e55;
            }

        /* PIE DE PÁGINA */
        .u-footer {
            background: #f8f8f8;
            border-top: 0.5px solid #ddd;
            padding: 0.85rem 2.5rem;
            text-align: center;
        }

        .u-footer-text {
            font-size: 11px;
            color: #888;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="u-card">

            <div class="u-header">
                <div class="u-name-main">Inicio de sesión</div>
                <div class="u-portal-title">Ingresa tus datos para acceder al sistema</div>
            </div>

            <div class="u-body">

                <!-- TIPO Y NÚMERO DE DOCUMENTO -->
                <div class="u-field">
                    <label class="u-label">Tipo y número de documento</label>
                    <div class="u-doc-row">
                        <asp:DropDownList ID="ddlTipoDoc" runat="server" CssClass="u-select">
                            <asp:ListItem Text="Tipo" Value="" />
                            <asp:ListItem Text="CC - Cédula" Value="CC" />
                            <asp:ListItem Text="TI - Tarjeta Identidad" Value="TI" />
                            <asp:ListItem Text="CE - Cédula Extranjería" Value="CE" />
                            <asp:ListItem Text="PA - Pasaporte" Value="PA" />
                        </asp:DropDownList>
                        <asp:TextBox ID="txtDocumento" runat="server" CssClass="u-input" placeholder="Número de documento" />
                    </div>
                </div>

                <!-- CONTRASEÑA -->
                <div class="u-field">
                    <label class="u-label" for="txtPassword">Contraseña</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="u-input" placeholder="••••••••" TextMode="Password" />
                </div>

                <!-- TIPO DE USUARIO + RECUPERAR CONTRASEÑA -->
                <div class="u-row">
                    <div class="u-radio-group">

                        <label class="u-radio-label">
                            <input type="radio"
                                name="tipo"
                                value="Instructor"
                                runat="server"
                                id="rbInstructor"
                                checked />
                            Instructor
                        </label>

                        <label class="u-radio-label">
                            <input type="radio"
                                name="tipo"
                                value="Aprendiz"
                                runat="server"
                                id="rbAprendiz" />
                            Aprendiz
                        </label>

                        <label class="u-radio-label">
                            <input type="radio"
                                name="tipo"
                                value="Administrador"
                                runat="server"
                                id="rbAdministrador" />
                            Administrador
                        </label>
                    </div>
                </div>
                <a href="#" class="u-forgot">Recuperar contraseña</a>


                <!-- MENSAJE DE ERROR / VALIDACIÓN -->
                <asp:Label ID="lblMensaje" runat="server" CssClass="u-mensaje" Text="" />

                <!-- BOTÓN INGRESAR -->
                <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" CssClass="u-btn" OnClick="btnIngresar_Click" />

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </form>
</body>

</html>
