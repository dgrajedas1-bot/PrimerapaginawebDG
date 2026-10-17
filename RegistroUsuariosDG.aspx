<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistroUsuariosDG.aspx.cs" Inherits="Clase12_PrimeraPaginaWeb1.RegistroUsuariosDG" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Gestión de Usuarios | Clase 12</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f8f9fc;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }
        .navbar-brand {
            font-weight: 600;
            letter-spacing: -0.3px;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.08);
        }
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #e3e6f0;
            font-weight: 600;
            border-radius: 12px 12px 0 0 !important;
        }
        .btn-primary {
            background-color: #4e73df;
            border-color: #4e73df;
        }
        .btn-primary:hover {
            background-color: #2e59d9;
            border-color: #2653d4;
        }
        .table th {
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #6c757d;
        }
        .sidebar-icon {
            width: 1.2rem;
            margin-right: 0.5rem;
        }
    </style>
</head>
<body>
    <form id="formularioRegistroDG" runat="server">
        <!-- Navbar tipo SaaS -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
            <div class="container-fluid px-4">
                <a class="navbar-brand" href="#">
                    <i class="bi bi-people-fill me-2"></i>UserHub
                </a>
                <span class="navbar-text text-white-50 small">
                    Clase 12 · Gestión de Usuarios
                </span>
            </div>
        </nav>

        <div class="container-fluid px-4 py-4">
            <div class="row g-4">
                <!-- Columna Formulario -->
                <div class="col-lg-5">
                    <div class="card">
                        <div class="card-header py-3">
                            <i class="bi bi-person-plus me-2 text-primary"></i>Registrar nuevo usuario
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <asp:Label runat="server" ID="lblNombresDG" Text="Nombres" CssClass="form-label fw-semibold" AssociatedControlID="tbNombresDG" />
                                <asp:TextBox runat="server" ID="tbNombresDG" CssClass="form-control" placeholder="Daniela Paola" />
                            </div>
                            <div class="mb-3">
                                <asp:Label runat="server" ID="lblApellidosDG" Text="Apellidos" CssClass="form-label fw-semibold" AssociatedControlID="tbApellidosDG" />
                                <asp:TextBox runat="server" ID="tbApellidosDG" CssClass="form-control" placeholder="Grajeda Sandoval" />
                            </div>
                            <div class="mb-3">
                                <asp:Label runat="server" ID="lblFechaNacimientoDG" Text="Fecha de nacimiento" CssClass="form-label fw-semibold" AssociatedControlID="tbFechaNacimientoDG" />
                                <asp:TextBox runat="server" ID="tbFechaNacimientoDG" CssClass="form-control" TextMode="Date" />
                            </div>
                            <hr class="my-4" />
                            <div class="mb-3">
                                <asp:Label runat="server" ID="lblUsuarioDG" Text="Nombre de usuario" CssClass="form-label fw-semibold" AssociatedControlID="tbUsuarioDG" />
                                <asp:TextBox runat="server" ID="tbUsuarioDG" CssClass="form-control" placeholder="daniela.g" />
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <asp:Label runat="server" ID="lblContraseniaDG" Text="Contraseña" CssClass="form-label fw-semibold" AssociatedControlID="tbContraseniaDG" />
                                    <asp:TextBox runat="server" ID="tbContraseniaDG" CssClass="form-control" TextMode="Password" />
                                </div>
                                <div class="col-md-6 mb-3">
                                    <asp:Label runat="server" ID="lblConfirmarContraseniaDG" Text="Confirmar" CssClass="form-label fw-semibold" AssociatedControlID="tbConfirmarContraseniaDG" />
                                    <asp:TextBox runat="server" ID="tbConfirmarContraseniaDG" CssClass="form-control" TextMode="Password" />
                                </div>
                            </div>
                            <asp:Label runat="server" ID="lblErrorDG" CssClass="d-block small mb-3" />
                            <div class="d-grid">
                                <asp:Button ID="btnRegistrarDG" runat="server" Text="Crear usuario" CssClass="btn btn-primary" OnClick="btnRegistrarDG_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Columna Lista + Eliminar -->
                <div class="col-lg-7">
                    <div class="card mb-4">
                        <div class="card-header py-3 d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-table me-2 text-primary"></i>Usuarios registrados</span>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvUsuariosDG" runat="server" CssClass="table table-hover align-middle mb-0"
                                    AutoGenerateColumns="true" GridLines="None" />
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header py-3">
                            <i class="bi bi-trash me-2 text-danger"></i>Eliminar usuario
                        </div>
                        <div class="card-body">
                            <div class="row g-2 align-items-end">
                                <div class="col-md-8">
                                    <asp:Label runat="server" ID="lblEliminarDG" Text="Nombre de usuario" CssClass="form-label fw-semibold" AssociatedControlID="tbEliminarDG" />
                                    <asp:TextBox runat="server" ID="tbEliminarDG" CssClass="form-control" placeholder="Escribe el usuario a eliminar" />
                                </div>
                                <div class="col-md-4">
                                    <asp:Button ID="btnEliminarDG" runat="server" Text="Eliminar" CssClass="btn btn-outline-danger w-100" OnClick="btnEliminarDG_Click" />
                                </div>
                            </div>
                            <asp:Label runat="server" ID="lblMensajeEliminarDG" CssClass="d-block small mt-2" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>