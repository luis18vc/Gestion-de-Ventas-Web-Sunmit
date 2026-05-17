<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="java.util.List"%>
<%@page import="Entity.Pedido"%>
    <%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  
        if (session.getAttribute("user")==null){
            response.sendRedirect("login.jsp");
        }
    %>
<%
    List<Pedido> Lista= (List<Pedido>) request.getAttribute("Lista");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pedidos</title>
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
            <h1 class="title has-text-centered">Pedidos</h1>
            <table class="table is-fullwidth is-striped is-hoverable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Fecha</th>
                        <th>SubTotal</th>
                        <th>Total</th>
                        <th>Consultar</th>
                        <th>Eliminar</th>
                        <th>Generar</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pedido" items="${Lista}">
                        <tr>
                            <td>${pedido.getId_Pedido()}</td>
                            <td>${pedido.getApellidos()} ${pedido.getNombres()}</td>
                            <td>${pedido.getFecha()}</td>
                            <td>${pedido.getSubTotal()}</td>
                            <td>${pedido.getTotalVenta()}</td>
                            <td>
                                <form action="ControllerPedido" method="get">
                                    <input class="is-hidden" value="Consultar" name="Op"/>
                                    <input class="is-hidden" value="${pedido.getId_Pedido()}" name="Id"/>
                                    <button class="button is-success" type="submit">
                                        <i class="mdi mdi-text-box-search-outline"></i> Consultar
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form action="ControllerPedido" method="get">
                                    <input class="is-hidden" value="Eliminar" name="Op"/>
                                    <input class="is-hidden" value="${pedido.getId_Pedido()}" name="Id"/>
                                    <button class="button is-danger" type="submit">
                                        <i class="mdi mdi-trash-can-outline"></i> Eliminar
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form action="ControllerPedido" method="get" target="_blank">
                                    <input class="is-hidden" value="PDF" name="Op"/>
                                    <input class="is-hidden" value="${pedido.getId_Pedido()}" name="Id"/>
                                    <button class="button is-link" type="submit">
                                        <i class="mdi mdi-file-pdf-box"></i> PDF
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
