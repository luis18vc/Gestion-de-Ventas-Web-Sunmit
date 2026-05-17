<%-- 
    Document   : index
    Created on : 17/09/2022, 08:38:47 AM
    Author     : javie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  
            if (session.getAttribute("user")==null){
                response.sendRedirect("login.jsp");
            }
%>
<!DOCTYPE html>
<html>
    <head>
      
        <title>Menu</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style> 
            body {
                position: relative;
                margin: 0;
                padding: 0;
            }
            body::before {
                content: "";
                position: fixed;
                top: 20px;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('Componentes/img/logoSD.JPG');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                filter:  grayscale(6%) brightness(1.0) blur(15px);
                
                z-index: -1; 
            }
            .grid {
                display: grid;
                grid-template-columns: repeat(2, 270px); 
                grid-template-rows: repeat(2, 200px); 
                gap: 4rem; 
                justify-content: center;
                align-items: center;  
            }
            .cell {
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 1.5rem;
            }
        </style>
    </head>
    <body>
        <jsp:include page="./Componentes/navMain.jsp" />
        <div class="columns is-centered">
            <div class="column is-narrow">
                <div class="grid ">
                    <a class="cell box has-text-black has-background-warning" href="${pageContext.request.contextPath}/ControllerCliente?Op=Listar"><i class="fa-solid fa-users"></i> Clientes</a>
                    <a class="cell box has-text-black has-background-warning" href="${pageContext.request.contextPath}/ControllerProducto?Op=Listar"><i class="fa-solid fa-shirt"></i> Productos</a>
                    <a class="cell box has-text-black has-background-warning" href="${pageContext.request.contextPath}/ControllerPedido?Op=Listar"><i class="fa-solid fa-cart-shopping"></i> Pedidos</a>
                    <a class="cell box has-text-black has-background-warning mb-5" href="${pageContext.request.contextPath}/ControllerArticulo?Op=Listar"><i class="fa-solid fa-box"></i> Categoria</a>
                </div>
            </div>
        </div>
    </body>
</html>
