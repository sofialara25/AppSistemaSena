<%@ Page Title="Fichas" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Fichas.aspx.cs" Inherits="AppSistemaSena.Vista.Instructor.Fichas" %>

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

        .fichas-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 14px;
        }

        .ficha-card {
            border: 1px solid #eee;
            border-radius: 10px;
            padding: 16px;
            cursor: pointer;
            transition: box-shadow 0.15s, border 0.15s;
            text-decoration: none;
            color: #333;
            display: block;
        }

        .ficha-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-color: #1B3A6B;
            color: #333;
        }

        .ficha-card.activa {
            border-left: 4px solid #1B3A6B;
        }

        .ficha-codigo {
            font-size: 16px;
            font-weight: 600;
            color: #1B3A6B;
            margin-bottom: 6px;
        }

        .ficha-info {
            font-size: 13px;
            color: #888;
            margin-bottom: 4px;
        }

        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            margin-top: 6px;
        }

        .badge-activa   { background: #e6f4ea; color: #2e7d32; }
        .badge-inactiva { background: #fce8e6; color: #c62828; }

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

        .btn-plan {
            background: #1B3A6B;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 5px 12px;
            font-size: 12px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .btn-plan:hover { background: #162f58; color: #fff; }

        .estado-pill {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            background: #e8f0fe;
            color: #1B3A6B;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title">Mis Fichas</div>

    <%-- Lista de fichas asignadas --%>
    <div class="card">
        <div class="card-title">Fichas asignadas</div>
        <asp:Repeater ID="rptFichas" runat="server" OnItemCommand="rptFichas_ItemCommand">
            <HeaderTemplate>
                <div class="fichas-grid">
            </HeaderTemplate>
            <ItemTemplate>
                <asp:LinkButton runat="server" CssClass='<%# "ficha-card " + (Eval("Estado").ToString() == "Activa" ? "activa" : "") %>'
                    CommandName="VerFicha" CommandArgument='<%# Eval("Id") %>'>
                    <div class="ficha-codigo"><%# Eval("Codigo") %></div>
                    <div class="ficha-info"><%# Eval("NombrePrograma") %></div>
                    <div class="ficha-info"><%# Eval("Jornada") %></div>
                    <span class='badge <%# Eval("Estado").ToString() == "Activa" ? "badge-activa" : "badge-inactiva" %>'>
                        <%# Eval("Estado") %>
                    </span>
                </asp:LinkButton>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
    </div>

    <%-- Aprendices de la ficha seleccionada --%>
    <asp:Panel ID="pnlAprendices" runat="server" Visible="false">
        <div class="card">
            <div class="card-title">
                Aprendices de la ficha 
                <asp:Label ID="lblCodigoFicha" runat="server" />
            </div>
            <div style="overflow-x:auto">
                <asp:GridView ID="gvAprendices" runat="server"
                    AutoGenerateColumns="false"
                    OnRowCommand="gvAprendices_RowCommand"
                    EmptyDataText="No hay aprendices en esta ficha.">
                    <Columns>
                        <asp:BoundField DataField="TipoDocumento"   HeaderText="Tipo doc." />
                        <asp:BoundField DataField="NumeroDocumento" HeaderText="Documento" />
                        <asp:BoundField DataField="Nombre"          HeaderText="Nombre"    />
                        <asp:BoundField DataField="Apellido"        HeaderText="Apellido"  />
                        <asp:BoundField DataField="Correo"          HeaderText="Correo"    />
                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <span class="estado-pill"><%# Eval("NombreEstado") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CssClass="btn-plan"
                                    CommandName="CrearPlan"
                                    CommandArgument='<%# Eval("Id") %>'>
                                    <i class="ti ti-clipboard-plus"></i> Crear plan
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>

</asp:Content>