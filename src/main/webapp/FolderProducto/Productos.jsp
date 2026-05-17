<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="java.util.List"%>
<%@page import="Entity.Producto"%>
    <%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  
        if (session.getAttribute("user")==null){
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
        <title>Productos</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
        <style>
            .main-content {
                margin-top: 60px; 
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <section class="main-content">
            <h1 class="title has-text-centered">Productos</h1>
            <table class="table is-fullwidth is-striped is-hoverable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Categoria</th>
                        <th>Descripción</th>
                        <th>Costo</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Consultar</th>
                        <th>Modificar</th>
                        <th>Eliminar</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="producto" items="${Lista}">
                        <tr>
                            <td>${producto.getId_Producto()}</td>
                            <td>${producto.getDescripcion_Articulo()}</td>
                            <td>${producto.getDescripcion()}</td>
                            <td>${producto.getCosto()}</td>
                            <td>${producto.getPrecio()}</td>
                            <td>${producto.getCantidad()}</td>
                            <td>
                                <form action="ControllerProducto" method="get">
                                    <input class="is-hidden" value="Consultar" name="Op"/>
                                    <input class="is-hidden" value="${producto.getId_Producto()}" name="Id"/>
                                    <button class="button is-success" type="submit">
                                        <i class="mdi mdi-text-box-search-outline"></i> Consultar
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form action="ControllerProducto" method="get">
                                    <input class="is-hidden" value="Modificar" name="Op"/>
                                    <input class="is-hidden" value="${producto.getId_Producto()}" name="Id"/>
                                    <button class="button is-warning" type="submit">
                                        <i class="mdi mdi-file-document-edit-outline"></i> Modificar
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form action="ControllerProducto" method="get">
                                    <input class="is-hidden" value="Eliminar" name="Op"/>
                                    <input class="is-hidden" value="${producto.getId_Producto()}" name="Id"/>
                                    <button class="button is-danger" type="submit">
                                        <i class="mdi mdi-trash-can-outline"></i> Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </section>
    </body>
</html>
