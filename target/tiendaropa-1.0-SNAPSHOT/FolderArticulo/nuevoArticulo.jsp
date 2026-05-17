<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
--%>
<%@page import="java.util.List"%>
<%@page import="Entity.Articulo"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nueva Categoria</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">   
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <h2 class="title is-3 has-text-centered">Nueva Categoria</h2>
            <form action="ControllerArticulo" method="post">
                <div class="field is-hidden">
                    <label class="label">ID</label>
                    <div class="control">
                        <input class="input" type="text" name="txtId">
                    </div>
                </div>
                <div class="field">
                    <label class="label">Descripcion<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" name="txtNombre" placeholder="Ingrese Descripción" maxlength="100" oninput="this.value = this.value.replace(/[^a-zA-Z]/g, '')" required>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Estado<span class="has-text-danger"> *</span></label>
                    <div class="select">
                        <select class="select" name="selectEstado" required>
                            <option value=true>Activo</option>
                            <option value=false>Inactivo</option>
                        </select>
                    </div>
                </div>
                <div class="control">
                    <button class="button is-primary" type="submit">
                        <i class="mdi mdi-content-save"></i> Guardar
                    </button>
                    <a href="${pageContext.request.contextPath}/ControllerArticulo?Op=Listar" class="button is-danger">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
    </body>
</html>


