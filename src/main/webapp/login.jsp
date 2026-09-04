<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso - AUTODEV</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body class="fondo-acceso">

<main class="tarjeta-acceso">
    <h1 class="titulo-acceso">AUTODEV</h1>
    <p class="subtitulo-acceso">Portal de Gestion de Clientes y Licencias</p>

    <%
        String mensaje = (String) request.getAttribute("mensaje");
        if (mensaje != null) {
    %>
        <p class="aviso aviso-error"><%= mensaje %></p>
    <%
        }
    %>

    <form action="LoginServlet" method="post">
        <label for="txtCorreo">Correo electronico</label>
        <input type="email" id="txtCorreo" name="txtCorreo" required autofocus>

        <label for="txtClave">Clave</label>
        <input type="password" id="txtClave" name="txtClave" required>

        <button type="submit" class="boton boton-principal">Ingresar</button>
    </form>
</main>

</body>
</html>
