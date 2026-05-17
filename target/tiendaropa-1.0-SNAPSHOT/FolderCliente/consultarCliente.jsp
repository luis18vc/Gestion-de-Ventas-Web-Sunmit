<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : consultarArticulo
    Created on : 8 nov. 2024, 22:34:13
    Author     : Leonardo
--%>
<%@page import="java.util.List"%>
<%@page import="Entity.Cliente"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
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
        <title>Consultar Cliente</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">   
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <c:forEach var="cliente" items="${Lista}">
                <h2 class="title is-3 has-text-centered">Consultar Cliente ${cliente.getIdCliente()}</h2>
                <input disabled class="input" type="hidden" name="Id" value="${cliente.getIdCliente()}">
                <div class="field">
                    <label class="label">Nombres</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="nombres" value="${cliente.getNombres()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">Apellidos</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="apellidos" value="${cliente.getApellidos()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">Dirección</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="direccion" value="${cliente.getDireccion()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">DNI</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="DNI" value="${cliente.getDNI()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">Telefono</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="telefono" value="${cliente.getTelefono()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">Movil</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="movil" value="${cliente.getMovil()}">
                     </div>
                </div>
                <div class="control">
                    <a href="${pageContext.request.contextPath}/ControllerCliente?Op=Listar" class="button is-danger">
                            Salir
                    </a>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
