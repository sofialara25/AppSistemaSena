<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="IndexInstructor.aspx.cs" Inherits="AppSistemaSena.Vista.Instructor.IndexInstructor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-title {
            font-size: 20px;
            font-weight: 600;
            color: #028f18;
            margin-bottom: 6px;
        }

        .page-subtitle {
            font-size: 14px;
            color: #888;
            margin-bottom: 28px;
        }

        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 18px;
            margin-bottom: 32px;
        }

        .card-stat {
            background: #fff;
            border-radius: 12px;
            padding: 22px 20px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.07);
            display: flex;
            flex-direction: column;
            gap: 10px;
            border-left: 4px solid #028f18;
        }

        .card-stat-icon {
            font-size: 26px;
            color: #028f18;
        }

        .card-stat-value {
            font-size: 32px;
            font-weight: 700;
            color: #028f18;
            line-height: 1;
        }

        .card-stat-label {
            font-size: 13px;
            color: #888;
        }

        .section-title {
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #028f18;
            margin-bottom: 14px;
        }

        .quick-links {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 14px;
        }

        .quick-link {
            background: #fff;
            border-radius: 10px;
            padding: 18px 16px;
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: #333;
            font-size: 14px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.07);
            transition: box-shadow 0.15s, transform 0.15s;
        }

            .quick-link:hover {
                box-shadow: 0 4px 12px rgba(0,0,0,0.12);
                transform: translateY(-2px);
                color: #1B3A6B;
            }

            .quick-link i {
                font-size: 22px;
                color: #028f18;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-title">Bienvenido
        <asp:Label ID="lblNombre" runat="server" /></div>
    <div class="page-subtitle">Panel del Instructor — SENA</div>

    <div class="cards-grid">
        <div class="card-stat">
            <i class="ti ti-clipboard-list card-stat-icon"></i>
            <div class="card-stat-value">
                <asp:Label ID="lblTotalFichas" runat="server" Text="0" />
            </div>
            <div class="card-stat-label">Fichas asignadas</div>
        </div>
        <div class="card-stat">
            <i class="ti ti-users card-stat-icon"></i>
            <div class="card-stat-value">
                <asp:Label ID="lblTotalAprendices" runat="server" Text="0" />
            </div>
            <div class="card-stat-label">Aprendices a cargo</div>
        </div>
        <div class="card-stat">
            <i class="ti ti-alert-circle card-stat-icon"></i>
            <div class="card-stat-value">
                <asp:Label ID="lblPlanesPendientes" runat="server" Text="0" />
            </div>
            <div class="card-stat-label">Planes pendientes</div>
        </div>
    </div>

    <div class="section-title">Accesos rápidos</div>
    <div class="quick-links">
        <a class="quick-link" href='<%= ResolveUrl("~/Vista/Instructor/Fichas.aspx") %>'>
            <i class="ti ti-users"></i>Mis fichas
        </a>
        <a class="quick-link" href='<%= ResolveUrl("~/Instructor/Planes.aspx") %>'>
            <i class="ti ti-clipboard-list"></i>Planes de mejoramiento
        </a>
        <a class="quick-link" href='<%= ResolveUrl("~/Instructor/Evaluar.aspx") %>'>
            <i class="ti ti-checkbox"></i>Evaluar aprendices
        </a>
    </div>

</asp:Content>
