<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IndexAprendiz.aspx.cs"
    Inherits="AppSistemaSena.Vista.Aprendiz.IndexAprendiz" MasterPageFile="~/Site1.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            min-height: calc(100vh - 52px);
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

            .nav-header .role {
                font-size: 12px;
                color: #888;
                font-weight: 500;
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
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
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
           CAJA DE EVIDENCIAS
           ============================================= */
        .evidencias-box {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
        }

        .ev-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 14px;
            background: #f8f8f8;
            border-bottom: 1px solid #e0e0e0;
        }

            .ev-header span {
                font-size: 13px;
                font-weight: 500;
            }

        .empty-state {
            padding: 32px 16px;
            text-align: center;
            color: #aaa;
            font-size: 13px;
        }

            .empty-state i {
                font-size: 28px;
                display: block;
                margin-bottom: 8px;
                color: #ccc;
            }

        /* =============================================
           BOTÓN SUBIR
           ============================================= */
        .upload-btn {
            font-size: 12px;
            color: #185FA5;
            background: #E6F1FB;
            border: 1px solid #378ADD;
            border-radius: 6px;
            padding: 5px 10px;
            cursor: pointer;
        }

            .upload-btn:hover {
                background: #cce0f5;
            }

        /* =============================================
           ZONA DE ARRASTRE
           ============================================= */
        .drop-zone {
            border: 1px dashed #bbb;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            color: #aaa;
            font-size: 13px;
            margin-top: 12px;
        }

            .drop-zone i {
                font-size: 24px;
                display: block;
                margin-bottom: 6px;
                color: #ccc;
            }

        /* =============================================
           PÍLDORAS DE FORMATOS
           ============================================= */
        .fmt-pills {
            display: flex;
            gap: 6px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 8px;
        }

        .fmt-pill {
            font-size: 10px;
            background: #f0f0f0;
            border: 1px solid #ddd;
            border-radius: 99px;
            padding: 2px 8px;
            color: #888;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="sidebar">

        <!-- Barra lateral -->
        <nav class="nav">
            <div class="nav-header">
                <div class="role">Portal del aprendiz</div>
            </div>

            <div class="nav-section-label">Mi perfil</div>
            <div class="nav-item" onclick="showPage('datos', this)"><i class="ti ti-user"></i><a href="misDatos.aspx">Ver mis datos</a></div>
            <div class="nav-item" onclick="showPage('ficha', this)"><i class="ti ti-id-badge"></i>Ficha asignada</div>
            <div class="nav-item" onclick="showPage('estado', this)"><i class="ti ti-chart-line"></i>Estado académico</div>

            <div class="nav-section-label">Académico</div>
            <div class="nav-item" onclick="showPage('resultados', this)"><i class="ti ti-clipboard-list"></i>Resultados pendientes</div>
            <div class="nav-item" onclick="showPage('planes', this)"><i class="ti ti-file-description"></i>Planes asignados</div>
            <div class="nav-item" onclick="showPage('observaciones', this)"><i class="ti ti-message-circle"></i>Observaciones</div>

            <div class="nav-section-label">Evidencias</div>
            <div class="nav-item active" onclick="showPage('evidencias', this)"><i class="ti ti-paperclip"></i>Gestión de evidencias</div>
        </nav>

        <!-- Contenido principal -->
        <main class="main">

            <!-- Evidencias -->
            <div id="page-evidencias">
                <div class="page-title">Gestión de evidencias</div>
                <div class="page-sub">Sube y consulta tus evidencias del plan de mejoramiento</div>

                <div class="cards-grid">
                    <div class="stat-card">
                        <div class="label">Total subidas</div>
                        <div class="value">0</div>
                        <div class="sub">archivos</div>
                    </div>
                    <div class="stat-card">
                        <div class="label">Pendientes</div>
                        <div class="value">0</div>
                        <div class="sub">por revisar</div>
                    </div>
                    <div class="stat-card">
                        <div class="label">Aprobadas</div>
                        <div class="value">0</div>
                        <div class="sub">aceptadas</div>
                    </div>
                </div>

                <div class="section-title">Evidencias subidas</div>
                <div class="evidencias-box">
                    <div class="ev-header">
                        <span>Mis archivos</span>
                        <asp:Button ID="btnSubir" runat="server" Text="⬆ Subir evidencia"
                            CssClass="upload-btn" OnClick="btnSubir_Click" />
                    </div>
                    <div class="empty-state">
                        <i class="ti ti-folder-open"></i>
                        Aún no hay evidencias subidas
                    </div>
                </div>

                <div class="drop-zone">
                    <i class="ti ti-cloud-upload"></i>
                    Arrastra tu archivo aquí o haz clic para seleccionar
                    <div class="fmt-pills">
                        <span class="fmt-pill">PDF</span>
                        <span class="fmt-pill">DOCX</span>
                        <span class="fmt-pill">JPG</span>
                        <span class="fmt-pill">PNG</span>
                        <span class="fmt-pill">ZIP</span>
                    </div>
                </div>
            </div>

            <!-- Mis datos -->
            <div id="page-datos" class="hidden">
                <div class="page-title">Mis datos</div>
                <div class="page-sub">Información personal del aprendiz</div>
            </div>

            <!-- Ficha -->
            <div id="page-ficha" class="hidden">
                <div class="page-title">
                    Ficha asignada
                </div>
                <div class="page-sub">Datos de la ficha de formación</div>
            </div>

            <!-- Estado académico -->
            <div id="page-estado" class="hidden">
                <div class="page-title">Estado académico</div>
                <div class="page-sub">Resumen de tu situación académica actual</div>
            </div>

            <!-- Resultados -->
            <div id="page-resultados" class="hidden">
                <div class="page-title">Resultados pendientes</div>
                <div class="page-sub">Resultados de aprendizaje sin evaluar</div>
            </div>

            <!-- Planes -->
            <div id="page-planes" class="hidden">
                <div class="page-title">Planes asignados</div>
                <div class="page-sub">Planes de mejoramiento asignados por el instructor</div>
            </div>

            <!-- Observaciones -->
            <div id="page-observaciones" class="hidden">
                <div class="page-title">Observaciones</div>
                <div class="page-sub">Observaciones registradas por los instructores</div>
            </div>

        </main>
    </div>

    <asp:HiddenField ID="hfPaginaActiva" runat="server" Value="evidencias" />

    <script>
function showPage(name, el) {
    document.querySelectorAll('[id^="page-"]').forEach(p => p.classList.add('hidden'));
    document.getElementById('page-' + name).classList.remove('hidden');
    document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
    el.classList.add('active');
    document.getElementById('<%= hfPaginaActiva.ClientID %>').value = name;
}

window.onload = function () {
    var pagina = document.getElementById('<%= hfPaginaActiva.ClientID %>').value || 'evidencias';
    var items = document.querySelectorAll('.nav-item');
    items.forEach(function (item) {
        if (item.getAttribute('onclick') && item.getAttribute('onclick').includes("'" + pagina + "'")) {
            showPage(pagina, item);
        }
    });
};
    </script>

</asp:Content>
