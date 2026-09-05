<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="errorPage.jsp" %>
<%@ page import="pe.utp.autodev.modelo.Usuario" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Integer totalClientes  = (Integer) request.getAttribute("totalClientes");
    Integer totalVigentes  = (Integer) request.getAttribute("totalVigentes");
    Integer totalPorVencer = (Integer) request.getAttribute("totalPorVencer");
    Double  totalRecaudado = (Double)  request.getAttribute("totalRecaudado");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Control - AUTODEV</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

<jsp:include page="partials/header.jsp">
    <jsp:param name="txtModulo" value="Panel de Control" />
    <jsp:param name="txtRol" value="Administrador" />
</jsp:include>

<main class="contenedor">
    <h1>Bienvenido, <%= usuario.getNombres() %></h1>
    <p class="texto-apoyo">Resumen operativo de la cartera de clientes y licencias.</p>

    <section class="tarjetas">
        <article class="tarjeta">
            <span class="tarjeta-valor"><%= totalClientes %></span>
            <span class="tarjeta-rotulo">Clientes activos</span>
        </article>
        <article class="tarjeta">
            <span class="tarjeta-valor"><%= totalVigentes %></span>
            <span class="tarjeta-rotulo">Licencias vigentes</span>
        </article>
        <article class="tarjeta tarjeta-alerta">
            <span class="tarjeta-valor"><%= totalPorVencer %></span>
            <span class="tarjeta-rotulo">Vencen en 30 dias</span>
        </article>
        <article class="tarjeta">
            <span class="tarjeta-valor">S/ <%= String.format("%,.2f", totalRecaudado) %></span>
            <span class="tarjeta-rotulo">Recaudado <%= java.time.Year.now() %></span>
        </article>
    </section>

    <section class="accesos">
        <h2>Accesos directos</h2>
        <a href="ClienteServlet" class="boton">Registrar cliente</a>
        <a href="LicenciaServlet" class="boton">Asignar licencia</a>
        <a href="VencimientoServlet" class="boton">Ver vencimientos</a>
    </section>
</main>

<jsp:include page="partials/footer.jsp" />

</body>
</html>
