<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : consultarArticulo
    Created on : 8 nov. 2024, 22:34:13
    Author     : Leonardo
--%>
<%@page import="java.util.List"%>
<%@page import="Entity.Articulo"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
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
        <title>Consultar Categoria</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">   
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <c:forEach var="articulo" items="${Lista}">
                <h2 class="title is-3 has-text-centered">Consultar Categoria ${articulo.getId_Articulo()}</h2>
                <input disabled class="input" type="hidden" name="txtId" value="${articulo.getId_Articulo()}">
                <div class="field">
                    <label class="label">Descripción</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="txtId" value="${articulo.getDescripcion()}">
                     </div>
                </div>
                <div class="field">
                    <label class="label">Estado</label>
                    <div class="control">
                        <input disabled class="input" type="text" name="txtId" value="${articulo.getEstado() ? 'Activo' : 'Inactivo'}">
                     </div>
                </div>
                <div class="control">
                    <a href="${pageContext.request.contextPath}/ControllerArticulo?Op=Listar" class="button is-danger">
                            Salir
                    </a>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
