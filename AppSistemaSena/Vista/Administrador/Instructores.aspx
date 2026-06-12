<%@ Page Title="Instructores" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Instructores.aspx.cs" Inherits="AppSistemaSena.Vista.Administrador.Instructores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-title {
            font-size: 20px;
            font-weight: 600;
            color: #1B3A6B;
            margin-bottom: 24px;
        }

        .card {
            background: #fff;
            border-radius: 10px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.08);
        }

        .card-title {
            font-size: 13px;
            font-weight: 600;
            color: #1B3A6B;
            margin-bottom: 16px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 14px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

            .form-group label {
                font-size: 12px;
                font-weight: 600;
                color: #555;
                text-transform: uppercase;
                letter-spacing: 0.4px;
            }

            .form-group input,
            .form-group select {
                padding: 9px 12px;
                border: 1px solid #ddd;
                border-radius: 7px;
                font-size: 14px;
                color: #333;
                outline: none;
                transition: border 0.15s;
            }

                .form-group input:focus,
                .form-group select:focus {
                    border-color: #1B3A6B;
                }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 18px;
        }

        .btn-primary {
            background: #1B3A6B;
            color: #fff;
            border: none;
            border-radius: 7px;
            padding: 9px 20px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

            .btn-primary:hover {
                background: #162f58;
                color: #fff;
            }

        .btn-secondary {
            background: #f0f0f0;
            color: #555;
            border: none;
            border-radius: 7px;
            padding: 9px 20px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

            .btn-secondary:hover {
                background: #e0e0e0;
                color: #333;
            }

        .btn-success {
            background: #e6f4ea;
            color: #2e7d32;
            border: none;
            border-radius: 7px;
            padding: 9px 20px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

            .btn-success:hover {
                background: #c8e6c9;
                color: #1b5e20;
            }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        thead th {
            background: #1B3A6B;
            color: #fff;
            padding: 11px 14px;
            text-align: left;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.1s;
        }

            tbody tr:hover {
                background: #f7f9ff;
            }

        tbody td {
            padding: 11px 14px;
            color: #444;
        }

        .btn-edit {
            background: #e8f0fe;
            color: #1B3A6B;
            border: none;
            border-radius: 6px;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
            margin-right: 4px;
        }

            .btn-edit:hover {
                background: #d0e2ff;
            }

        .btn-delete {
            background: #fce8e6;
            color: #c62828;
            border: none;
            border-radius: 6px;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
            margin-right: 4px;
        }

            .btn-delete:hover {
                background: #f5c6c2;
            }

        .btn-assign {
            background: #e6f4ea;
            color: #2e7d32;
            border: none;
            border-radius: 6px;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
        }

            .btn-assign:hover {
                background: #c8e6c9;
            }

        .msg-success {
            background: #e6f4ea;
            color: #2e7d32;
            padding: 10px 16px;
            border-radius: 7px;
            margin-bottom: 16px;
            font-size: 14px;
        }

        .msg-error {
            background: #fce8e6;
            color: #c62828;
            padding: 10px 16px;
            border-radius: 7px;
            margin-bottom: 16px;
            font-size: 14px;
        }

        /* ── MODAL ASIGNACIÓN ── */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.4);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

            .modal-overlay.active {
                display: flex;
            }

        .modal {
            background: #fff;
            border-radius: 12px;
            padding: 28px;
            width: 420px;
            max-width: 95%;
            box-shadow: 0 8px 32px rgba(0,0,0,0.15);
        }

        .modal-title {
            font-size: 16px;
            font-weight: 600;
            color: #1B3A6B;
            margin-bottom: 18px;
        }

        .modal select {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid #ddd;
            border-radius: 7px;
            font-size: 14px;
            margin-bottom: 18px;
            outline: none;
        }

            .modal select:focus {
                border-color: #1B3A6B;
            }

        .modal-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title">Gestión de Instructores</div>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false">
        <asp:Label ID="lblMensaje" runat="server" />
    </asp:Panel>

    <%-- Formulario --%>
    <div class="card">
        <div class="card-title">
            <asp:Label ID="lblTituloForm" runat="server" Text="Nuevo Instructor" />
        </div>

        <asp:HiddenField ID="hfIdInstructor" runat="server" Value="0" />

        <div class="form-grid">
            <div class="form-group">
                <label>Tipo documento</label>
                <asp:DropDownList ID="ddlTipoDoc" runat="server">
                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    <asp:ListItem Value="CC">Cédula de Ciudadanía</asp:ListItem>
                    <asp:ListItem Value="CE">Cédula de Extranjería</asp:ListItem>
                    <asp:ListItem Value="PA">Pasaporte</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Número documento</label>
                <asp:TextBox ID="txtNumDoc" runat="server" placeholder="Ej: 1234567890" />
            </div>
            <div class="form-group">
                <label>Nombre</label>
                <asp:TextBox ID="txtNombre" runat="server" placeholder="Ej: Laura" />
            </div>
            <div class="form-group">
                <label>Apellido</label>
                <asp:TextBox ID="txtApellido" runat="server" placeholder="Ej: Martínez" />
            </div>
            <div class="form-group">
                <label>Correo</label>
                <asp:TextBox ID="txtCorreo" runat="server"
                    TextMode="Email" placeholder="correo@sena.edu.co" />
            </div>
            <div class="form-group">
                <label>Contraseña</label>
                <asp:TextBox ID="txtContrasena" runat="server"
                    TextMode="Password" placeholder="••••••••" />
            </div>
            <div class="form-group">
                <label>Teléfono</label>
                <asp:TextBox ID="txtTelefono" runat="server" placeholder="Ej: 3111111111" />
            </div>
            <div class="form-group">
                <label>Área</label>
                <asp:DropDownList ID="ddlArea" runat="server" />
            </div>
        </div>

        <div class="form-actions">
            <asp:LinkButton ID="btnGuardar" runat="server" CssClass="btn-primary" OnClick="btnGuardar_Click"><i class="ti ti-device-floppy"></i>Guardar
            </asp:LinkButton>
            <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-secondary" OnClick="btnCancelar_Click" CausesValidation="false"><i class="ti ti-x"></i>Cancelar
            </asp:LinkButton>
        </div>
    </div>

    <%-- Tabla --%>
    <div class="card">
        <div class="card-title">Instructores registrados</div>
        <div style="overflow-x: auto">
            <asp:GridView ID="gvInstructores" runat="server"
                AutoGenerateColumns="false"
                OnRowCommand="gvInstructores_RowCommand"
                EmptyDataText="No hay instructores registrados.">
                <columns>
                    <asp:BoundField DataField="TipoDocumento" HeaderText="Tipo doc." />
                    <asp:BoundField DataField="NumeroDocumento" HeaderText="Documento" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                    <asp:BoundField DataField="Correo" HeaderText="Correo" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:BoundField DataField="NombreArea" HeaderText="Área" />
                    <asp:TemplateField HeaderText="Acciones">
                        <itemtemplate>
                            <asp:Button runat="server" Text="Editar"
                                CssClass="btn-edit"
                                CommandName="Editar"
                                CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button runat="server" Text="Eliminar"
                                CssClass="btn-delete"
                                CommandName="Eliminar"
                                CommandArgument='<%# Eval("Id") %>'
                                OnClientClick="return confirm('¿Eliminar este instructor?');" />
                            <asp:Button runat="server" Text="Asignar ficha"
                                CssClass="btn-assign"
                                CommandName="AsignarFicha"
                                CommandArgument='<%# Eval("Id") %>' />
                        </itemtemplate>
                    </asp:TemplateField>
                </columns>
            </asp:GridView>
        </div>

        <%-- Modal aquí adentro del card --%>
        <asp:HiddenField ID="hfIdInstructorAsignar" runat="server" Value="0" />
        <div class="modal-overlay" id="modalAsignar">
            <div class="modal">
                <div class="modal-title">
                    <i class="ti ti-clipboard-list"></i>Asignar ficha al instructor
                </div>
                <asp:DropDownList ID="ddlFichaAsignar" runat="server" />
                <div class="modal-actions">
                    <asp:LinkButton ID="btnConfirmarAsignar" runat="server"
                        CssClass="btn-primary" OnClick="btnConfirmarAsignar_Click">
                        <i class="ti ti-check"></i>Asignar
                    </asp:LinkButton>
                    <button type="button" class="btn-secondary" onclick="cerrarModal()">
                        <i class="ti ti-x"></i>Cancelar
                    </button>
                </div>
            </div>
        </div>

    </div>

    <%-- fin card tabla --%>

    <script>
function abrirModal() {
    var modal = document.getElementById('modalAsignar');
    if (modal) modal.classList.add('active');
}
function cerrarModal() {
    var modal = document.getElementById('modalAsignar');
    if (modal) modal.classList.remove('active');
}
</script>
    </asp:Content>
