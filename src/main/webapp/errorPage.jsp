<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Incidencia - AUTODEV</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

<main class="contenedor contenedor-error">
    <h1>Incidencia operativa</h1>
    <p>El sistema detecto una condicion no prevista al procesar la solicitud.</p>

    <div class="ticket">
        <strong>Codigo de seguimiento:</strong> INC-<%= System.currentTimeMillis() %><br>
        <strong>Estado:</strong> registrado en la bitacora del servidor de aplicaciones.
    </div>

    <p class="texto-apoyo">
        Por politica de seguridad, el detalle tecnico de la excepcion no se muestra al usuario.
    </p>

    <%
        System.err.println("[AUTODEV] Excepcion capturada: " + exception.getMessage());
    %>

    <a href="DashboardServlet" class="boton boton-principal">Volver al panel</a>
</main>

</body>
</html>
