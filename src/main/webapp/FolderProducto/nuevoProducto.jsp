<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
--%>
<%@page import="java.util.List"%>
<%@page import="Entity.Producto"%>
<%@page import="Entity.Articulo"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%
    List<Articulo> Lista = (List<Articulo>) request.getAttribute("ListaArticulo");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nuevo Producto</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">   
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <h2 class="title is-3 has-text-centered">Nuevo Producto</h2>
            <form action="ControllerProducto" method="post">
                <div class="field is-hidden">
                    <label class="label">ID</label>
                    <div class="control">
                        <input class="input" type="text" name="Id">
                    </div>
                </div>
                <div class="field">
                    <label class="label">Descripcion<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" name="descripcion" maxlength="50" placeholder="Ingrese Descripción" required>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Categoria<span class="has-text-danger"> *</span></label>
                    <div class="select">
                        <select class="select" name="Id_Arti" required>
                            <c:forEach var="articulo" items="${Lista}">
                                <option value="${articulo.getId_Articulo()}">${articulo.getDescripcion()}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Costo<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" name="costo" placeholder="Ingrese Costo" oninput="this.value = this.value.replace(/[^0-9.]/g, '')" required>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Precio<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" name="precio" placeholder="Ingrese Precio" oninput="this.value = this.value.replace(/[^0-9.]/g, '')" required>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Cantidad<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" name="cantidad" placeholder="Ingrese Cantidad" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required>
                    </div>
                </div>
                <div class="control">
                    <button class="button is-primary" type="submit">
                        <i class="mdi mdi-content-save"></i> Guardar
                    </button>
                    <a href="${pageContext.request.contextPath}/ControllerProducto?Op=Listar" class="button is-danger">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
    </body>
</html>


