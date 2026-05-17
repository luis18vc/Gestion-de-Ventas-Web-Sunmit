<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">
        <style>
            body {
                position: relative;
                margin: 0;
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
            }
            body::before {
                content: "";
                position: fixed;
                top: 0;
                left: 0;
                width: 50%;
                height: 100%;
                background-image: url('Componentes/img/logoSD.JPG');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                border-radius: 50%;
                z-index: -1;
                transition: width 0.3s ease;
            }
            .formcontacto {
                position: relative;
                background-color: rgba(255, 255, 255, 0.2);
                backdrop-filter: blur(6px);
                padding: 2rem;
                background-color: rgba(0, 0, 0, 0.8);
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
                width: 400px;
                left: 25%;
            }
            .table{
                width: 100%;
                border-radius: 5px;
            }
            @media screen and (max-width: 768px) {
                body::before {
                    width: 100%;
                    height: 100vh;
                    border-radius: 0;
                }
                .formcontacto {
                    width: 90%;
                    left: 0;
                    top: 60%;
                }
            }
        </style>
    </head>
    <body>
        <form action="ControllerLogin" method="post" class="formcontacto">   
            <h2 class="title is-3 has-text-centered">Iniciar sesión</h2>
            <table class="table">
                <tr>
                    <td>Usuario</td>
                    <td><input class="input is-primary" type="text" name="txtUsuario" required></td>
                </tr>
                <tr>
                    <td>Clave</td>
                    <td><input class="input is-primary" type="password" name="txtClave" required></td>
                </tr> 
            </table>  
            <!--Modificar -->
            <!--<c:if test="${not empty errorMessage}">
                <div class="notification is-danger has-text-centered">
                    ${errorMessage}
                </div>
            </c:if>-->
            <input class="button is-link" style="width: 100%" type="submit" name="validar" value="Ingresar"> 
            <br>
            <a href="registro.jsp">Registrar</a>
        </form>
    </body>
</html>
