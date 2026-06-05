<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IndexInstructor.aspx.cs" Inherits="AppSistemaSena.Vista.Instructor.IndexInstructor" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Portal Instructor - AppSistemaSena</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />

    <style>
        /* =============================================
           RESET Y BASE
           ============================================= */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Segoe UI, sans-serif;
            background: #f4f4f4;
        }

        /* =============================================
           LAYOUT PRINCIPAL
           ============================================= */
        .sidebar {
            display: flex;
            min-height: 100vh;
        }

        .main {
            flex: 1;
            padding: 24px 28px;
            background: #fff;
        }

        /* =============================================
           BARRA DE NAVEGACIÓN
           ============================================= */
        .nav {
            width: 220px;
            background: #f8f8f8;
            border-right: 1px solid #e0e0e0;
            flex-shrink: 0;
        }

        .nav-header {
            padding: 16px;
            border-bottom: 1px solid #e0e0e0;
        }

        .nav-header .logo {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-header .logo i {
            font-size: 20px;
            color: #185FA5;
        }

        .nav-header .logo span {
            font-size: 14px;
            font-weight: 500;
        }

        .nav-header .role {
            font-size: 11px;
            color: #888;
            margin-top: 2px;
            padding-left: 28px;
        }

        .nav-section-label {
            font-size: 10px;
            font-weight: 500;
            color: #aaa;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            padding: 14px 16px 4px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 9px 16px;
            font-size: 13px;
            color: #555;
            cursor: pointer;
            border-left: 2px solid transparent;
        }

        .nav-item i {
            font-size: 16px;
        }

        .nav-item:hover {
            background: #fff;
            color: #333;
        }

        .nav-item.active {
            background: #fff;
            color: #185FA5;
            border-left: 2px solid #185FA5;
            font-weight: 500;
        }

        /* =============================================
           PÁGINAS - TÍTULOS Y VISIBILIDAD
           ============================================= */
        .page-title {
            font-size: 16px;
            font-weight: 500;
            color: #222;
            margin-bottom: 4px;
        }

        .page-sub {
            font-size: 13px;
            color: #888;
            margin-bottom: 20px;
        }

        .hidden {
            display: none;
        }

        .section-title {
            font-size: 13px;
            font-weight: 500;
            color: #222;
            margin-bottom: 10px;
        }

        /* =============================================
           TARJETAS DE ESTADÍSTICAS
           ============================================= */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(130px, 1fr));
            gap: 10px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: #f8f8f8;
            border-radius: 8px;
            padding: 14px;
        }

        .stat-card .label {
            font-size: 11px;
            color: #888;
            margin-bottom: 6px;
        }

        .stat-card .value {
            font-size: 22px;
            font-weight: 500;
            color: #222;
        }

        .stat-card .sub {
            font-size: 11px;
            color: #888;
            margin-top: 2px;
        }

        /* =============================================
           CAJAS GENERALES
           ============================================= */
        .box {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 14px;
        }

        .box-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 14px;
            background: #f8f8f8;
            border-bottom: 1px solid #e0e0e0;
        }

        .box-header span {
            font-size: 13px;
            font-weight: 500;
        }

        .empty-state {
            padding: 28px 16px;
            text-align: center;
            color: #bbb;
            font-size: 13px;
        }

        .empty-state i {
            font-size: 26px;
            display: block;
            margin-bottom: 8px;
        }

        /* =============================================
           BOTONES
           ============================================= */
        .btn-primary {
            font-size: 12px;
            color: #185FA5;
            background: #E6F1FB;
            border: 1px solid #378ADD;
            border-radius: 6px;
            padding: 5px 10px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background: #cce0f5;
        }

        /* =============================================
           REGLAS DEL SISTEMA
           ============================================= */
        .rule-box {
            border-radius: 8px;
            padding: 12px 14px;
            margin-bottom: 10px;
        }

        .rule-interno {
            background: #E6F1FB;
            border: 1px solid #378ADD;
        }

        .rule-comite {
            background: #FCEBEB;
            border: 1px solid #E24B4A;
        }

        .rule-title {
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 4px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .rule-interno .rule-title { color: #0C447C; }
        .rule-comite .rule-title  { color: #791F1F; }

        .rule-desc {
            font-size: 12px;
        }

        .rule-interno .rule-desc { color: #185FA5; }
        .rule-comite .rule-desc  { color: #A32D2D; }

        /* =============================================
           BADGES
           ============================================= */
        .badge {
            display: inline-block;
            font-size: 10px;
            padding: 2px 8px;
            border-radius: 99px;
        }

        .badge-info    { background: #E6F1FB; color: #0C447C; }
        .badge-danger  { background: #FCEBEB; color: #791F1F; }
        .badge-warning { background: #FAEEDA; color: #633806; }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="sidebar">

            <!-- Barra lateral -->
            <nav class="nav">
                
                    <div class="role">Portal del instructor</div>

                <div class="nav-section-label">Mis fichas</div>
                <div class="nav-item" onclick="showPage('aprendices', this)"><i class="ti ti-users"></i> Aprendices</div>
                <div class="nav-item" onclick="showPage('resultados', this)"><i class="ti ti-clipboard-list"></i> Resultados pendientes</div>

                <div class="nav-section-label">Planes de mejoramiento</div>
                <div class="nav-item active" onclick="showPage('planes', this)"><i class="ti ti-file-description"></i> Gestión de planes</div>
                <div class="nav-item" onclick="showPage('actividades', this)"><i class="ti ti-checklist"></i> Actividades</div>
                <div class="nav-item" onclick="showPage('observaciones', this)"><i class="ti ti-message-circle"></i> Observaciones</div>
            </nav>

            <!-- Contenido principal -->
            <main class="main">

                <!-- Gestión de planes -->
                <div id="page-planes">
                    <div class="page-title">Gestión de planes de mejoramiento</div>
                    <div class="page-sub">Crea y administra los planes de tus aprendices</div>

                    <div class="cards-grid">
                        <div class="stat-card">
                            <div class="label">Planes activos</div>
                            <div class="value">0</div>
                            <div class="sub">en curso</div>
                        </div>
                        <div class="stat-card">
                            <div class="label">Internos</div>
                            <div class="value">0</div>
                            <div class="sub">planes</div>
                        </div>
                        <div class="stat-card">
                            <div class="label">Por comité</div>
                            <div class="value">0</div>
                            <div class="sub">planes</div>
                        </div>
                        <div class="stat-card">
                            <div class="label">Cerrados</div>
                            <div class="value">0</div>
                            <div class="sub">finalizados</div>
                        </div>
                    </div>

                    <div class="box">
                        <div class="box-header">
                            <span>Planes registrados</span>
                            <asp:Button ID="btnNuevoPlan" runat="server" Text="+ Nuevo plan" CssClass="btn-primary" OnClick="btnNuevoPlan_Click" />
                        </div>
                        <div class="empty-state">
                            <i class="ti ti-file-off"></i>
                            Aún no hay planes registrados
                        </div>
                    </div>
                </div>

                <!-- Aprendices -->
                <div id="page-aprendices" class="hidden">
                    <div class="page-title">Aprendices</div>
                    <div class="page-sub">Aprendices de tus fichas asignadas</div>
                    <div class="box">
                        <div class="box-header"><span>Lista de aprendices</span></div>
                        <div class="empty-state">
                            <i class="ti ti-users"></i>
                            No hay aprendices registrados
                        </div>
                    </div>
                </div>

                <!-- Resultados pendientes -->
                <div id="page-resultados" class="hidden">
                    <div class="page-title">Resultados pendientes</div>
                    <div class="page-sub">Resultados de aprendizaje incumplidos por aprendiz</div>
                    <div class="box">
                        <div class="box-header"><span>Resultados</span></div>
                        <div class="empty-state">
                            <i class="ti ti-clipboard-list"></i>
                            No hay resultados pendientes
                        </div>
                    </div>
                </div>

                <!-- Actividades -->
                <div id="page-actividades" class="hidden">
                    <div class="page-title">Actividades</div>
                    <div class="page-sub">Registra actividades y fechas límite por plan</div>
                    <div class="box">
                        <div class="box-header">
                            <span>Actividades registradas</span>
                            <asp:Button ID="btnNuevaActividad" runat="server" Text="+ Nueva actividad" CssClass="btn-primary" OnClick="btnNuevaActividad_Click" />
                        </div>
                        <div class="empty-state">
                            <i class="ti ti-checklist"></i>
                            No hay actividades registradas
                        </div>
                    </div>
                </div>

                <!-- Observaciones -->
                <div id="page-observaciones" class="hidden">
                    <div class="page-title">Observaciones</div>
                    <div class="page-sub">Registra observaciones sobre el proceso del aprendiz</div>
                    <div class="box">
                        <div class="box-header">
                            <span>Observaciones</span>
                            <asp:Button ID="btnNuevaObservacion" runat="server" Text="+ Nueva observación" CssClass="btn-primary" OnClick="btnNuevaObservacion_Click" />
                        </div>
                        <div class="empty-state">
                            <i class="ti ti-message-circle"></i>
                            No hay observaciones registradas
                        </div>
                    </div>
                </div>

            </main>
        </div>

        <asp:HiddenField ID="hfPaginaActiva" runat="server" Value="planes" />

        <script>
            function showPage(name, el) {
                document.querySelectorAll('[id^="page-"]').forEach(p => p.classList.add('hidden'));
                document.getElementById('page-' + name).classList.remove('hidden');
                document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
                el.classList.add('active');
                document.getElementById('<%= hfPaginaActiva.ClientID %>').value = name;
            }

            window.onload = function () {
                var pagina = document.getElementById('<%= hfPaginaActiva.ClientID %>').value || 'planes';
                var items = document.querySelectorAll('.nav-item');
                items.forEach(function (item) {
                    if (item.getAttribute('onclick') && item.getAttribute('onclick').includes("'" + pagina + "'")) {
                        showPage(pagina, item);
                    }
                });
            };
        </script>

    </form>
</body>
</html>