<%@ Page Title="Programas" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Programas.aspx.cs" Inherits="AppSistemaSena.Vista.Administrador.Programas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-title {
            font-size: 20px;
            font-weight: 600;
            color: #1B3A6B;
            margin-bottom: 24px;
        }

        /* ── FORMULARIO ── */
        .card {
            background: #fff;
            border-radius: 10px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.08);
        }

        .card-title {
            font-size: 14px;
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
        }

            .btn-primary:hover {
                background: #162f58;
            }

        .btn-secondary {
            background: #f0f0f0;
            color: #555;
            border: none;
            border-radius: 7px;
            padding: 9px 20px;
            font-size: 14px;
            cursor: pointer;
        }

            .btn-secondary:hover {
                background: #e0e0e0;
            }

        /* ── TABLA ── */
        .table-wrapper {
            overflow-x: auto;
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
            font-weight: 500;
            font-size: 12px;
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

        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .badge-activo {
            background: #e6f4ea;
            color: #2e7d32;
        }

        .badge-inactivo {
            background: #fce8e6;
            color: #c62828;
        }

        .btn-edit {
            background: #e8f0fe;
            color: #1B3A6B;
            border: none;
            border-radius: 6px;
            padding: 5px 12px;
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
            padding: 5px 12px;
            font-size: 12px;
            cursor: pointer;
        }

            .btn-delete:hover {
                background: #f5c6c2;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title">Gestión de Programas</div>

    <%-- Mensajes --%>
    <asp:Panel ID="pnlMensaje" runat="server" Visible="false">
        <asp:Label ID="lblMensaje" runat="server" />
    </asp:Panel>

    <%-- Formulario --%>
    <div class="card">
        <div class="card-title">
            <asp:Label ID="lblTituloForm" runat="server" Text="Nuevo Programa" />
        </div>

        <asp:HiddenField ID="hfIdPrograma" runat="server" Value="0" />

        <div class="form-grid">
            <div class="form-group">
                <label>Código</label>
                <asp:TextBox ID="txtCodigo" runat="server" placeholder="Ej: 228118" />
            </div>
            <div class="form-group">
                <label>Nombre</label>
                <asp:TextBox ID="txtNombre" runat="server" placeholder="Ej: Análisis y Desarrollo de Software" />
            </div>
            <div class="form-group">
                <label>Nivel de formación</label>
                <asp:DropDownList ID="ddlNivel" runat="server">
                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    <asp:ListItem Value="Técnico">Técnico</asp:ListItem>
                    <asp:ListItem Value="Tecnólogo">Tecnólogo</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Duración</label>
                <asp:TextBox ID="txtDuracion" runat="server" placeholder="Ej: 24 meses" />
            </div>
            <div class="form-group">
                <label>Estado</label>
                <asp:DropDownList ID="ddlEstado" runat="server">
                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    <asp:ListItem Value="Activo">Activo</asp:ListItem>
                    <asp:ListItem Value="Inactivo">Inactivo</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Competencia</label>
                <asp:DropDownList ID="ddlCompetencia" runat="server" />
            </div>
        </div>

        <div class="form-actions">
            <asp:LinkButton ID="btnGuardar" runat="server" CssClass="btn-primary" OnClick="btnGuardar_Click"><i class="ti ti-device-floppy"></i> Guardar
            </asp:LinkButton>
            <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-primary" OnClick="btnCancelar_Click"><i class="ti ti-device-floppy"></i> Cancelar
            </asp:LinkButton>
        </div>
    </div>

    <%-- Tabla --%>
    <div class="card">
        <div class="card-title">Programas registrados</div>
        <div class="table-wrapper">
            <asp:GridView ID="gvProgramas" runat="server"
                AutoGenerateColumns="false"
                OnRowCommand="gvProgramas_RowCommand"
                EmptyDataText="No hay programas registrados.">
                <Columns>
                    <asp:BoundField DataField="Codigo" HeaderText="Código" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="NivelFormacion" HeaderText="Nivel" />
                    <asp:BoundField DataField="Duracion" HeaderText="Duración" />
                    <asp:BoundField DataField="NombreCompetencia" HeaderText="Competencia" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <span class='badge <%# Eval("Estado").ToString() == "Activo" ? "badge-activo" : "badge-inactivo" %>'>
                                <%# Eval("Estado") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Editar"
                                CssClass="btn-edit"
                                CommandName="Editar"
                                CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button runat="server" Text="Eliminar"
                                CssClass="btn-delete"
                                CommandName="Eliminar"
                                CommandArgument='<%# Eval("Id") %>'
                                OnClientClick="return confirm('¿Eliminar este programa?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
