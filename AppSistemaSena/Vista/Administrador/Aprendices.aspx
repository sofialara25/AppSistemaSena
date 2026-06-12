<%@ Page Title="Aprendices" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Aprendices.aspx.cs" Inherits="AppSistemaSena.Vista.Administrador.Aprendices" %>

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

        .btn-primary:hover { background: #162f58; color: #fff; }

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

        .btn-secondary:hover { background: #e0e0e0; color: #333; }

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

        tbody tr:hover { background: #f7f9ff; }
        tbody td { padding: 11px 14px; color: #444; }

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

        .btn-edit:hover { background: #d0e2ff; }

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

        .btn-delete:hover { background: #f5c6c2; }

        .btn-assign {
            background: #e6f4ea;
            color: #2e7d32;
            border: none;
            border-radius: 6px;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
        }

        .btn-assign:hover { background: #c8e6c9; }

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

        /* ── EXCEL ── */
        .excel-zone {
            border: 2px dashed #ccd6e8;
            border-radius: 10px;
            padding: 24px;
            text-align: center;
            color: #888;
            font-size: 14px;
            margin-bottom: 16px;
        }

        .excel-zone i {
            font-size: 32px;
            color: #1B3A6B;
            display: block;
            margin-bottom: 8px;
        }

        .errores-carga {
            background: #fff8e1;
            border: 1px solid #ffe082;
            border-radius: 8px;
            padding: 14px 18px;
            margin-top: 14px;
            font-size: 13px;
            color: #795548;
        }

        .errores-carga ul {
            margin: 8px 0 0 16px;
        }

        /* ── MODAL ── */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.4);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.active { display: flex; }

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

        .modal select:focus { border-color: #1B3A6B; }

        .modal-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title">Gestión de Aprendices</div>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false">
        <asp:Label ID="lblMensaje" runat="server" />
    </asp:Panel>

    <%-- Formulario manual --%>
    <div class="card">
        <div class="card-title">
            <asp:Label ID="lblTituloForm" runat="server" Text="Nuevo Aprendiz" />
        </div>

        <asp:HiddenField ID="hfIdAprendiz" runat="server" Value="0" />

        <div class="form-grid">
            <div class="form-group">
                <label>Tipo documento</label>
                <asp:DropDownList ID="ddlTipoDoc" runat="server">
                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    <asp:ListItem Value="TI">Tarjeta de Identidad</asp:ListItem>
                    <asp:ListItem Value="CC">Cédula de Ciudadanía</asp:ListItem>
                    <asp:ListItem Value="CE">Cédula de Extranjería</asp:ListItem>
                    <asp:ListItem Value="PA">Pasaporte</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Número documento</label>
                <asp:TextBox ID="txtNumDoc" runat="server" placeholder="Ej: 1001" />
            </div>
            <div class="form-group">
                <label>Nombre</label>
                <asp:TextBox ID="txtNombre" runat="server" placeholder="Ej: Juan" />
            </div>
            <div class="form-group">
                <label>Apellido</label>
                <asp:TextBox ID="txtApellido" runat="server" placeholder="Ej: López" />
            </div>
            <div class="form-group">
                <label>Correo</label>
                <asp:TextBox ID="txtCorreo" runat="server"
                    TextMode="Email" placeholder="correo@soy.sena.edu.co" />
            </div>
            <div class="form-group">
                <label>Teléfono</label>
                <asp:TextBox ID="txtTelefono" runat="server" placeholder="Ej: 3000000001" />
            </div>
            <div class="form-group">
                <label>Estado</label>
                <asp:DropDownList ID="ddlEstado" runat="server" />
            </div>
        </div>

        <div class="form-actions">
            <asp:LinkButton ID="btnGuardar" runat="server"
                CssClass="btn-primary" OnClick="btnGuardar_Click">
                <i class="ti ti-device-floppy"></i> Guardar
            </asp:LinkButton>
            <asp:LinkButton ID="btnCancelar" runat="server"
                CssClass="btn-secondary" OnClick="btnCancelar_Click"
                CausesValidation="false">
                <i class="ti ti-x"></i> Cancelar
            </asp:LinkButton>
        </div>
    </div>

    <%-- Carga masiva Excel --%>
    <div class="card">
        <div class="card-title">Carga masiva por Excel</div>
        <div class="excel-zone">
            <i class="ti ti-file-spreadsheet"></i>
            Selecciona un archivo Excel (.xlsx) con los aprendices
        </div>
        <div class="form-group" style="margin-bottom:14px">
            <label>Archivo Excel</label>
            <asp:FileUpload ID="fuExcel" runat="server" Accept=".xlsx" />
        </div>
        <div class="form-group" style="margin-bottom:14px">
            <label>Ficha a asignar</label>
            <asp:DropDownList ID="ddlFichaExcel" runat="server" />
        </div>
        <asp:LinkButton ID="btnCargarExcel" runat="server"
            CssClass="btn-primary" OnClick="btnCargarExcel_Click">
            <i class="ti ti-upload"></i> Cargar Excel
        </asp:LinkButton>

        <asp:Panel ID="pnlErroresExcel" runat="server" Visible="false">
            <div class="errores-carga">
                <strong>Se encontraron los siguientes errores:</strong>
                <asp:BulletedList ID="blErrores" runat="server" />
            </div>
        </asp:Panel>
    </div>

    <%-- Tabla --%>
    <div class="card">
        <div class="card-title">Aprendices registrados</div>
        <div style="overflow-x:auto">
            <asp:GridView ID="gvAprendices" runat="server"
                AutoGenerateColumns="false"
                OnRowCommand="gvAprendices_RowCommand"
                EmptyDataText="No hay aprendices registrados.">
                <Columns>
                    <asp:BoundField DataField="TipoDocumento"   HeaderText="Tipo doc."  />
                    <asp:BoundField DataField="NumeroDocumento" HeaderText="Documento"  />
                    <asp:BoundField DataField="Nombre"          HeaderText="Nombre"     />
                    <asp:BoundField DataField="Apellido"        HeaderText="Apellido"   />
                    <asp:BoundField DataField="Correo"          HeaderText="Correo"     />
                    <asp:BoundField DataField="Telefono"        HeaderText="Teléfono"   />
                    <asp:BoundField DataField="NombreEstado"    HeaderText="Estado"     />
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
                                OnClientClick="return confirm('¿Eliminar este aprendiz?');" />
                            <asp:Button runat="server" Text="Asignar ficha"
                                CssClass="btn-assign"
                                CommandName="AsignarFicha"
                                CommandArgument='<%# Eval("Id") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <%-- Modal asignación ficha --%>
        <asp:HiddenField ID="hfIdAprendizAsignar" runat="server" Value="0" />
        <div class="modal-overlay" id="modalAsignar">
            <div class="modal">
                <div class="modal-title">
                    <i class="ti ti-clipboard-list"></i> Asignar ficha al aprendiz
                </div>
                <asp:DropDownList ID="ddlFichaAsignar" runat="server" />
                <div class="modal-actions">
                    <asp:LinkButton ID="btnConfirmarAsignar" runat="server"
                        CssClass="btn-primary" OnClick="btnConfirmarAsignar_Click">
                        <i class="ti ti-check"></i> Asignar
                    </asp:LinkButton>
                    <button type="button" class="btn-secondary" onclick="cerrarModal()">
                        <i class="ti ti-x"></i> Cancelar
                    </button>
                </div>
            </div>
        </div>

    </div>

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