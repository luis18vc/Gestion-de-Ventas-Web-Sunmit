<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
    const productos = {
        <c:forEach var="producto" items="${ListaProducto}">
            "${producto.getId_Producto()}": {nombre: "${producto.getDescripcion()}"},
        </c:forEach>
    };
</script>

<table class="table is-striped is-fullwidth">
    <thead>
        <tr>
            <th>Código Producto</th>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Cantidad</th>
            <th>IGV</th>
            <th>Total</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <% for (int i = 0; i < 10; i++) { %>
        <tr>
            <td>
                <input type="text" name="codigo_<%= i %>" class="input is-small" placeholder="Código" onblur="buscarProducto(this, <%= i %>)" maxlength="7" minlength="7" oninput="this.value = this.value.replace(/[^P0-9]/g, '').replace(/^(?!P|P\d{0,5}$).*/g, '')"/>
            </td>
            <td id="nombre_<%= i %>"></td>
            <td>
                <input type="number" name="precio_<%= i %>" id="precio_<%= i %>" class="input is-small" value="0" min="0" oninput="actualizarTotal(<%= i %>)" oninput="this.value = this.value.replace(/[^0-9.]/g, '')"/>
            </td>
            <td>
                <input type="number" name="cantidad_<%= i %>" class="input is-small" value="1" min="1" oninput="actualizarTotal(<%= i %>)" oninput="this.value = this.value.replace(/[^0-9]/g, '')"/>
            </td>
            <td id="igv_<%= i %>"><span>0</span></td>
            <td>
                <input type="number" name="total_<%= i %>" id="total_<%= i %>" class="input is-small" readonly />
            </td>
            <td>
                <button type="button" class="button is-danger is-small" onclick="eliminarFila(<%= i %>)">Eliminar</button>
            </td>
        </tr>
        <% } %>
    </tbody>
</table>

<script>
    function buscarProducto(codigoInput, filaId) {
        const codigo = codigoInput.value;
        if (productos[codigo]) {
            document.getElementById("nombre_" + filaId).textContent = productos[codigo].nombre;
            actualizarTotal(filaId);
        } else {
            alert("Producto no encontrado.");
        }
    }

    function actualizarTotal(filaId) {
        const precio = parseFloat(document.getElementById("precio_" + filaId).value) || 0;
        const cantidad = parseInt(document.getElementsByName("cantidad_" + filaId)[0].value) || 1;
        const igv = (precio * cantidad) * 0.18;
        const total = (precio * cantidad) + igv;

        document.getElementById("igv_" + filaId).textContent = igv.toFixed(2);
        document.getElementById("total_" + filaId).value = total.toFixed(2);
        actualizarTotales();
    }

    function eliminarFila(filaId) {
        document.getElementsByName("codigo_" + filaId)[0].value = "";
        document.getElementById("nombre_" + filaId).textContent = "";
        document.getElementById("precio_" + filaId).value = 0;
        document.getElementsByName("cantidad_" + filaId)[0].value = 1;
        document.getElementById("igv_" + filaId).textContent = "0";
        document.getElementById("total_" + filaId).textContent = "0";
        actualizarTotales();
    }
</script>
