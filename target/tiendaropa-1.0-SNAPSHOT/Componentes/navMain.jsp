
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="Entity.Usuarios"%>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("user");
    
    if (usuario == null) {
        response.sendRedirect("login.jsp");
    }
%>

<nav class="navbar is-transparent">
    <div class="navbar-brand" style="">
        <a class="navbar-item" href="${pageContext.request.contextPath}/index.jsp" style=" width: 100%; height: 100%; display: flex; font-size: 26px ; font-weight: bold; align-content: center; background-color: #0A2342; color: yellow;  border-radius: 50% 50% 0 0; padding: 15px;">
            S U N M Y
        </a>
    </div>

    <div id="navbarExampleTransparentExample" class="navbar-menu">
        <div class="navbar-start">
            <a class="navbar-item" href="${pageContext.request.contextPath}/index.jsp"> Inicio</a>
            <div class="navbar-item has-dropdown is-hoverable">
                <a class="navbar-link">
                    Clientes
                </a>
                <div class="navbar-dropdown">
                    <a class="navbar-item" href="${pageContext.request.contextPath}/ControllerCliente?Op=Listar">Listar Clientes</a>
                    <a class="navbar-item" href="${pageContext.request.contextPath}/ControllerCliente?Op=Nuevo">Nuevo Cliente</a>

                </div>
            </div>
            <div class="navbar-item has-dropdown is-hoverable">
                <a class="navbar-link">
                    Productos
                </a>
                <div class="navbar-dropdown">
                    <a class="navbar-item" href="${pageContext.request.contextPath}/ControllerProducto?Op=Listar">Listar Producto</a>
                    <a class="navbar-item" href="${pageContext.request.contextPath}/ControllerProducto?Op=Nuevo">Nuevo Producto</a>
                </div>
            </div>
            <div class="navbar-item has-dropdown is-hoverable">
                <a class="navbar-link">
                    Categorias
                </a>
                <div class="navbar-dropdown">
                    <a class="navbar-item" href="${pageContext.request.contextPath}/ControllerArticulo?Op=Listar">Listar Categorias</a>
                    <a class="navbar-item" href="${pageContext.request.contextPath}/ControllerArticulo?Op=Nuevo">Nueva Categoria</a>
                </div>
            </div>
            <div class="navbar-item has-dropdown is-hoverable">
                <a class="navbar-link">
                    Pedidos
                </a>
                <div class="navbar-dropdown">
                    <a class="navbar-item" href="${pageContext.request.contextPath}/ControllerPedido?Op=Listar">Listar Pedidos</a>
                    <a class="navbar-item" href="${pageContext.request.contextPath}/ControllerPedido?Op=Registrar">Registrar Pedido</a>
                </div>
            </div>
        </div>
        <div class="navbar-item">
            <b><span style="color: black; font-size: 22px;">Bienvenido <%= usuario.getUser()%></span></b>
        </div>
        <div class="navbar-end">
            <div class="navbar-item">
                <div class="field is-grouped">
                    <p class="control">
                        <a class="button is-primary" href="${pageContext.request.contextPath}/ControllerCerrarSesion" style="background-color: #B3FF00; ">
                            <span>Cerrar Sesión</span>
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</nav>
