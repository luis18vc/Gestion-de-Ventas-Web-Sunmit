<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">
         <style>
             body {
                 position: relative;
                 margin: 0;
                 padding: 0;
             }
             body::before {
                 content: "";
                 position: fixed;
                 top: 0px;
                 left: 50%;
                 width: 50%;
                 height: 100%;
                 background-image: url('Componentes/img/logoSD.JPG');
                 background-size: cover;
                 background-position: center;
                 background-repeat: no-repeat;
                 border-radius: 50%;
                 z-index: -1;
             }
            .formcontacto{
                position: absolute;
                top: 300px;
                left: 25%;
                transform: translate(-50%, -50%);
                padding: 2rem;
                background-color: rgba(255, 255, 255, 0.8);
                border-radius: 8px; 
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3); 
                width: 400px;
            }
        </style>
    </head>
    <body>
        <form action="ControllerRegister" method="post" class="formcontacto">   
            <h2 class="title is-3 has-text-centered">Registrarse</h2>
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
            <input class="button is-link" style="width: 100%" type="submit" name="validar" value="Registrar"> 
            <br>
            <a href="login.jsp">Loguin</a>
        </form>
    </body>
</html>
