<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
--%>
<%@page import="java.util.List"%>
<%@page import="Entity.Articulo"%>
<%@page import="Entity.Producto"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%
    List<Producto> Lista= (List<Producto>) request.getAttribute("Lista");
    List<Articulo> ListaA= (List<Articulo>) request.getAttribute("ListaA");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Producto</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">       
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <c:forEach var="producto" items="${Lista}">
                <h2 class="title is-3 has-text-centered">Editar Producto ${producto.getId_Producto()}</h2>
                <form action="ControllerProducto" method="post">
                    <input class="input" type="hidden" name="Id" value="${producto.getId_Producto()}">
                    <div class="field">
                        <label class="label">Descripción<span class="has-text-danger"> *</span></label>
                        <div class="control">
                            <input class="input" type="text" name="descripcion" placeholder="Ingrese Descripción" maxlength="50" value="${producto.getDescripcion()}" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Categoria<span class="has-text-danger"> *</span></label>
                        <div class="select">
                            <select class="select" name="Id_Arti" required>
                                <c:forEach var="articulo" items="${ListaA}">
                                    <option value="${articulo.getId_Articulo()}" ${producto.getId_Articulo() == articulo.getId_Articulo() ? "selected" : ""}>${articulo.getDescripcion()}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Costo<span class="has-text-danger"> *</span></label>
                        <div class="control">
                            <input class="input" type="text" name="costo" placeholder="Ingrese Costo" value="${producto.getCosto()}" oninput="this.value = this.value.replace(/[^0-9.]/g, '')" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Precio<span class="has-text-danger"> *</span></label>
                        <div class="control">
                            <input class="input" type="text" name="precio" placeholder="Ingrese Precio" value="${producto.getPrecio()}" oninput="this.value = this.value.replace(/[^0-9.]/g, '')" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Cantidad<span class="has-text-danger"> *</span></label>
                        <div class="control">
                            <input class="input" type="text" name="cantidad" placeholder="Ingrese Cantidad" value="${producto.getCantidad()}" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required>
                        </div>
                    </div>
                    <div class="control">
                        <button class="button is-primary" type="submit">
                            <i class="mdi mdi-content-save"></i> Modificar
                        </button>
                        <a href="${pageContext.request.contextPath}/ControllerProducto?Op=Listar" class="button is-danger">
                            Cancelar
                        </a>
                    </div>
                </form>
            </c:forEach>
        </div>
    </body>
</html>


