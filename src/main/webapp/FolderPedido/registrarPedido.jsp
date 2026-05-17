<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
--%>
<%@page import="java.util.List"%>
<%@page import="Entity.Cliente"%>
<%@page import="Entity.Producto"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%
    List<Cliente> ListaCliente = (List<Cliente>) request.getAttribute("ListaCliente");
    List<Producto> ListaProducto = (List<Producto>) request.getAttribute("ListaProducto");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar Pedido</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">   
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css">
        <script>
            const clientes = {
            <c:forEach var="cliente" items="${ListaCliente}">
                "${cliente.getIdCliente()}": {nombre: "${cliente.getApellidos()} ${cliente.getNombres()}", direccion: "${cliente.getDireccion()}"},
            </c:forEach>
                    };
        </script>
    </head>
    <body>
        <jsp:include page="../Componentes/navMain.jsp" />
        <br>
        <div class="container">
            <h2 class="title is-3 has-text-centered">Registrar Pedido</h2>
            <form action="ControllerPedido" method="post">
                <div class="columns">
                    <div class="column is-half">
                        <div class="field">
                            <label class="label">Cod.Cliente<span class="has-text-danger"> *</span></label>
                            <div class="control">
                                <input class="input" type="text" name="idCliente" placeholder="Ingrese Codigo Cliente" maxlength="6" minlength="6" oninput="this.value = this.value.replace(/[^C0-9]/g, '').replace(/^(?!C|C\d{0,5}$).*/g, '')" onblur="buscarCliente(this)" required>
                            </div>
                        </div>
                    </div>
                    <div class="column is-half">
                        <div class="field">
                            <label class="label">Nombres</label>
                            <div class="control">
                                <input disabled class="input" type="text" id="nombres">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column is-full">
                        <div class="field">
                            <label class="label">Dirección</label>
                            <div class="control">
                                <input disabled class="input" type="text" id="direccion">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column is-5">
                        <div class="field">
                            <label class="label">Fecha<span class="has-text-danger"> *</span></label>
                            <div class="control">
                                <input class="input" type="date" name="txtFecha" required>
                            </div>
                        </div>
                    </div>
                    <div class="column is-2">

                    </div>
                    <div class="column is-5">
                        <div class="field">
                            <label class="label">Nro. Pedido</label>
                            <div class="control">
                                <input disabled class="input" type="text" name="numeroPedido" value="${NrPedido}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="columns">
                    <div class="column is-full">
                        <jsp:include page="../FolderPedido/Partials/tablaCarritoRegistrar.jsp" />
                    </div>
                </div>
                <div class="columns">
                    <div class="column is-half">
                        <div class="field is-grouped">
                            <div class="control">
                                <button type="submit" class="button is-primary">
                                    <i class="mdi mdi-content-save"></i>Registrar
                                </button>
                            </div>
                        </div>
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
                                    <input type="text" id="subtotal" name="subtotal" class="input is-small" readonly />
                                </div>
                            </div>

                            <div class="field">
                                <label class="label">IGV (18%):</label>
                                <div class="control">
                                    <input type="text" id="igv_total" name="igv_total" class="input is-small" readonly />
                                </div>
                            </div>

                            <div class="field">
                                <label class="label">Total:</label>
                                <div class="control">
                                    <input type="text" id="totalVenta" name="totalVenta" class="input is-small" readonly />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
    <script>
        function buscarCliente(codigoInput) {
            const codigo = codigoInput.value;
            if (clientes[codigo]) {
                document.getElementById("nombres").value = clientes[codigo].nombre;
                document.getElementById("direccion").value = clientes[codigo].direccion;
            } else {
                alert("Cliente no encontrado.");
            }
        }
        
        // Función para actualizar los totales
        function actualizarTotales() {
            var subtotal = 0;
            var totalVenta = 0;

            for (var i = 0; i < 10; i++) {
                var totalFila = parseFloat(document.getElementById("total_" + i).value) || 0;
                var igvFila = parseFloat(document.getElementById("igv_" + i).innerText) || 0;

                subtotal += totalFila;
                totalVenta += totalFila + igvFila;
            }

            document.getElementById("subtotal").value = subtotal.toFixed(2);
            document.getElementById("igv_total").value = (subtotal * 0.18).toFixed(2);
            document.getElementById("totalVenta").value = totalVenta.toFixed(2);
        }
    </script>
</html>


