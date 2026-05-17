<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table is-striped is-fullwidth">
    <thead>
        <tr>
            <th>Código Producto</th>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Cantidad</th>
            <th>IGV</th>
            <th>Total</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="pedidoDetalle" items="${ListaDet}">
            <tr>
                <td>${pedidoDetalle.getId_Prod()}</td>
                <td>${pedidoDetalle.getDescripcion()}</td>
                <td>${pedidoDetalle.getPrecio()}</td>
                <td>${pedidoDetalle.getCantidad()}</td>
                <td>${pedidoDetalle.getIGV()}</td>
                <td>${pedidoDetalle.getTotalDeta()}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
