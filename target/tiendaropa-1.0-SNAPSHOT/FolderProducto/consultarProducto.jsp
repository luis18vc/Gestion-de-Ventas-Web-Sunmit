<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : consultarArticulo
    Created on : 8 nov. 2024, 22:34:13
    Author     : Leonardo
--%>
<%@page import="java.util.List"%>
<%@page import="Entity.Producto"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%
    List<Producto> Lista= (List<Producto>) request.getAttribute("Lista");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consultar Producto</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">   
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <c:forEach var="producto" items="${Lista}">
                <h2 class="title is-3 has-text-centered">Consultar Producto ${producto.getId_Producto()}</h2>
                <input class="input" type="hidden" name="Id" value="${producto.getId_Producto()}">
                <div class="field">
                    <label class="label">Descripcion</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="nombres" value="${producto.getDescripcion()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">Categoria</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="apellidos" value="${producto.getDescripcion_Articulo()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">Costo</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="direccion" value="${producto.getCosto()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">Precio</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="DNI" value="${producto.getPrecio()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">Cantidad</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="telefono" value="${producto.getCantidad()}">
                     </div>
                </div>
                <div class="control">
                    <a href="${pageContext.request.contextPath}/ControllerProducto?Op=Listar" class="button is-danger">
                            Salir
                    </a>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
