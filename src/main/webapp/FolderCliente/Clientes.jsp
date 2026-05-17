<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="java.util.List"%>
<%@page import="Entity.Cliente"%>
    <%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  
        if (session.getAttribute("user")==null){
            response.sendRedirect("login.jsp");
        }
    %>
<%
    List<Cliente> Lista= (List<Cliente>) request.getAttribute("Lista");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú Clientes</title>
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
            <h1 class="title has-text-centered">Clientes</h1>
            <table class="table is-fullwidth is-striped is-hoverable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Dirección</th>
                        <th>DNI/RUC</th>
                        <th>Telefono</th>
                        <th>Movil</th>
                        <th>Consultar</th>
                        <th>Modificar</th>
                        <th>Eliminar</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cliente" items="${Lista}">
                        <tr>
                            <td>${cliente.getIdCliente()}</td>
                            <td>${cliente.getNombres()}</td>
                            <td>${cliente.getApellidos()}</td>
                            <td>${cliente.getDireccion()}</td>
                            <td>${cliente.getDNI()}</td>
                            <td>${cliente.getTelefono()}</td>
                            <td>${cliente.getMovil()}</td>
                            <td>
                                <form action="ControllerCliente" method="get">
                                    <input class="is-hidden" value="Consultar" name="Op"/>
                                    <input class="is-hidden" value="${cliente.getIdCliente()}" name="Id"/>
                                    <button class="button is-success" type="submit">
                                        <i class="mdi mdi-text-box-search-outline"></i> Consultar
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form action="ControllerCliente" method="get">
                                    <input class="is-hidden" value="Modificar" name="Op"/>
                                    <input class="is-hidden" value="${cliente.getIdCliente()}" name="Id"/>
                                    <button class="button is-warning" type="submit">
                                        <i class="mdi mdi-file-document-edit-outline"></i> Modificar
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form action="ControllerCliente" method="get">
                                    <input class="is-hidden" value="Eliminar" name="Op"/>
                                    <input class="is-hidden" value="${cliente.getIdCliente()}" name="Id"/>
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
