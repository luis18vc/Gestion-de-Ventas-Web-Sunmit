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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nuevo Cliente</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">   
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <h2 class="title is-3 has-text-centered">Nuevo Cliente</h2>
            <form action="ControllerCliente" method="post">
                <div class="field is-hidden">
                    <label class="label">ID<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" name="Id">
                    </div>
                </div>
                <div class="columns">
                    <div class="column is-half">
                        <div class="field">
                            <label class="label">DNI<span class="has-text-danger"> *</span></label>
                            <div class="control">
                                <input class="input" type="text" id="dni" name="DNI" placeholder="Ingrese DNI" minlength="8" maxlength="11" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required>
                            </div>
                        </div>
                    </div>
                    <div class="column is-half">
                        <div class="field">
                            <div class="control">
                                <label class="label">&nbsp;</label>
                                <button class="button is-secondary" id="api_sunat" type="button">
                                    <i class="mdi mdi-account-search"></i> Consultar Api Sunat
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Nombres<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" id="nombres" name="nombres" placeholder="Ingrese Nombre" maxlength="50" oninput="this.value = this.value.replace(/[^a-zA-Z]/g, '')" required>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Apellidos<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" id="apellidos" name="apellidos" placeholder="Ingrese Apellidos" maxlength="50" oninput="this.value = this.value.replace(/[^a-zA-Z]/g, '')" required>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Dirección<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" id="direccion" type="text" name="direccion" placeholder="Ingrese Dirección" maxlength="100" required>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Telefono<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" name="telefono" placeholder="Ingrese Telefono" maxlength="10" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Celular<span class="has-text-danger"> *</span></label>
                    <div class="control">
                        <input class="input" type="text" name="movil" placeholder="Ingrese Celular" minlength="9" maxlength="9" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required>
                    </div>
                </div>
                <div class="control">
                    <button class="button is-primary" type="submit">
                        <i class="mdi mdi-content-save"></i> Guardar
                    </button>
                    <a href="${pageContext.request.contextPath}/ControllerCliente?Op=Listar" class="button is-danger">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('api_sunat').addEventListener('click', async function (evt) {
                    evt.preventDefault();
                    const numeroDocumento = document.getElementById('dni').value;
                    console.log(numeroDocumento);

                    if (!numeroDocumento) {
                        alert('Ingrese un número de documento válido.');
                        return;
                    }

                    try {
                        const response = await fetch('ControllerCliente?Op=ConsultarAPI&numero='+numeroDocumento, {
                            method: 'GET',
                        });

                        if (!response.ok) {
                            const errorData = await response.json();
                            alert(`Error: ${errorData.error}`);
                            return;
                        }

                        const data = await response.json();
                        console.log('Datos recibidos:', data);
                        
                        if (numeroDocumento.length === 8) {
                            document.getElementById('nombres').value = data.nombres;
                            document.getElementById('apellidos').value = data.apellidoPaterno + " " + data.apellidoMaterno;
                        } else if (numeroDocumento.length === 11) {
                            document.getElementById('nombres').value = data.razonSocial;
                            document.getElementById('apellidos').value = data.ubigeo;
                            document.getElementById('direccion').value = data.direccion;
                        } else {
                            alert('No se pueden rellenar campos');
                        }
                        
                    } catch (error) {
                        console.error('Error:', error.message);
                    }
                });
            });
        </script>
    </body>
</html>


