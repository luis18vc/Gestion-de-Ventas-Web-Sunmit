<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
--%>
<%@page import="java.util.List"%>
<%@page import="Entity.Pedido"%>
<%@page import="Entity.DetallePedido"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%
    List<Pedido> Lista = (List<Pedido>) request.getAttribute("Lista");
    List<DetallePedido> ListaDet = (List<DetallePedido>) request.getAttribute("ListaDet");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar Pedido</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">   
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <c:forEach var="pedido" items="${Lista}">
                <h2 class="title is-3 has-text-centered">Consultar Pedido ${pedido.getId_Pedido()}</h2>
                <div class="columns">
                    <div class="column is-half">
                        <div class="field">
                            <label class="label">Cod.Cliente</label>
                            <div class="control">
                                <input disabled class="input" type="text" name="idCliente" value="${pedido.getId_Cliente()}">
                            </div>
                        </div>
                    </div>
                    <div class="column is-half">
                        <div class="field">
                            <label class="label">Nombres</label>
                            <div class="control">
                                <input disabled class="input" type="text" id="nombres" value="${pedido.getNombres()} ${pedido.getApellidos()}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column is-full">
                        <div class="field">
                            <label class="label">Dirección</label>
                            <div class="control">
                                <input disabled class="input" type="text" id="direccion" value="${pedido.getDireccion()}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column is-5">
                        <div class="field">
                            <label class="label">Fecha</label>
                            <div class="control">
                                <input disabled class="input" type="date" name="txtFecha" value="${pedido.getFecha()}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column is-full">
                        <jsp:include page="../FolderPedido/Partials/tablaCarritoConsultar.jsp" />
                    </div>
                </div>
                <div class="columns">
                    <div class="column is-half">
                        <div class="field is-grouped">
                            <div class="control">
                                <a class="button is-danger" href="${pageContext.request.contextPath}/ControllerPedido?Op=Listar">Salir</a>
                            </div>
                        </div>
                    </div>
                    <div class="column is-half">
                        <div class="box">
                            <h2 class="title is-4">Totales</h2>
                            <div class="field">
                                <label class="label">Subtotal:</label>
                                <div class="control">
                                    <input disabled type="text" id="subtotal" name="subtotal" value="${pedido.getSubTotal()}" />
                                </div>
                            </div>

                            <div class="field">
                                <label class="label">IGV (18%):</label>
                                <div class="control">
                                    <input disabled type="text" id="igv_total" name="igv_total" value="${pedido.totalVenta - pedido.subTotal}" />
                                </div>
                            </div>

                            <div class="field">
                                <label class="label">Total:</label>
                                <div class="control">
                                    <input disabled type="text" id="totalVenta" name="totalVenta" value="${pedido.getTotalVenta()}" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>
</html>


