<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
--%>
<%@page import="java.util.List"%>
<%@page import="Entity.Cliente"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%
    List<Cliente> Lista = (List<Cliente>) request.getAttribute("Lista");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Cliente</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">       
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <c:forEach var="cliente" items="${Lista}">
                <h2 class="title is-3 has-text-centered">Editar Cliente ${cliente.getIdCliente()}</h2>
                <form action="ControllerCliente" method="post">
                    <input class="input" type="hidden" name="Id" value="${cliente.getIdCliente()}">
                    <div class="columns">
                        <div class="column is-half is-hidden">
                            <div class="field">
                                <label class="label">DNI<span class="has-text-danger"> *</span></label>
                                <div class="control">
                                    <input class="input" type="text" id="dni" name="DNI" placeholder="Ingrese DNI" value="${cliente.getDNI()}">
                                </div>
                            </div>
                        </div>
                        <div class="column is-half">
                            <div class="field">
                                <label class="label">DNI<span class="has-text-danger"> *</span></label>
                                <div class="control">
                                    <input class="input" type="text" placeholder="Ingrese DNI" value="${cliente.getDNI()}" disabled>
                                </div>
                            </div>
                        </div>        
                        <div class="column is-half">
                            <div class="field">
                                <div class="control">
                                    <label class="label">&nbsp;</label>
                                    <button class="button is-secondary" id="api_sunat" type="button" disabled>
                                        <i class="mdi mdi-account-search"></i> Consultar Api Sunat
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Nombres<span class="has-text-danger"> *</span></label>
                        <div class="control">
                            <input class="input" type="text" name="nombres" placeholder="Ingrese Nombres" value="${cliente.getNombres()}" maxlength="50" oninput="this.value = this.value.replace(/[^a-zA-Z]/g, '')" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Apellidos<span class="has-text-danger"> *</span></label>
                        <div class="control">
                            <input class="input" type="text" name="apellidos" placeholder="Ingrese Apellidos" value="${cliente.getApellidos()}" maxlength="50" oninput="this.value = this.value.replace(/[^a-zA-Z]/g, '')" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Dirección<span class="has-text-danger"> *</span></label>
                        <div class="control">
                            <input class="input" type="text" name="direccion" placeholder="Ingrese Dirección" maxlength="100" value="${cliente.getDireccion()}" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Telefono<span class="has-text-danger"> *</span></label>
                        <div class="control">
                            <input class="input" type="text" name="telefono" placeholder="Ingrese Telefono" value="${cliente.getTelefono()}" maxlength="10" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Celular<span class="has-text-danger"> *</span></label>
                        <div class="control">
                            <input class="input" type="text" name="movil" placeholder="Ingrese Celular" value="${cliente.getMovil()}" minlength="9" maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required>
                        </div>
                    </div>
                    <div class="control">
                        <button class="button is-primary" type="submit">
                            <i class="mdi mdi-content-save"></i> Modificar
                        </button>
                        <a href="${pageContext.request.contextPath}/ControllerCliente?Op=Listar" class="button is-danger">
                            Cancelar
                        </a>
                    </div>
                </form>
            </c:forEach>
        </div>
    </body>
</html>


