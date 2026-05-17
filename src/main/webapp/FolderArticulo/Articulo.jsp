<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="java.util.List"%>
<%@page import="Entity.Articulo"%>
    <%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  
        if (session.getAttribute("user")==null){
            response.sendRedirect("login.jsp");
        }
    %>
<%
    List<Articulo> Lista= (List<Articulo>) request.getAttribute("Lista");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Categorias</title>
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
        <jsp:include page="../Componentes/navMain.jsp"/>
        <section class="main-content">
            <h1 class="title has-text-centered">Categorias</h1>
            <table class="table is-fullwidth is-striped is-hoverable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Descripción</th>
                        <th>Estado</th>
                        <th>Consultar</th>
                        <th>Modificar</th>
                        <th>Eliminar</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="articulo" items="${Lista}">
                        <tr>
                            <td>${articulo.getId_Articulo()}</td>
                            <td>${articulo.getDescripcion()}</td>
                            <td class="has-text-centered">
                                <span class="${articulo.getEstado() ? 'has-background-success' : 'has-background-danger'} 
                                             has-text-white box is-rounded px-3 py-1 is-size-7">
                                    ${articulo.getEstado() ? 'Activo' : 'Inactivo'}
                                </span>
                            </td>
                            <td>
                                <form action="ControllerArticulo" method="get">
                                    <input class="is-hidden" value="Consultar" name="Op"/>
                                    <input class="is-hidden" value="${articulo.getId_Articulo()}" name="Id"/>
                                    <button class="button is-success" type="submit">
                                        <i class="mdi mdi-text-box-search-outline"></i> Consultar
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form action="ControllerArticulo" method="get">
                                    <input class="is-hidden" value="Modificar" name="Op"/>
                                    <input class="is-hidden" value="${articulo.getId_Articulo()}" name="Id"/>
                                    <button class="button is-warning" type="submit">
                                        <i class="mdi mdi-file-document-edit-outline"></i> Modificar
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form action="ControllerArticulo" method="get">
                                    <input class="is-hidden" value="Eliminar" name="Op"/>
                                    <input class="is-hidden" value="${articulo.getId_Articulo()}" name="Id"/>
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

