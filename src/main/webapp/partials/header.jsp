<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String modulo = request.getParameter("txtModulo");
    String rolUsuario = request.getParameter("txtRol");
    if (modulo == null) modulo = "Modulo General";
    if (rolUsuario == null) rolUsuario = "Usuario";
%>
<header class="cabecera">
    <div class="cabecera-barra">
        <span class="marca">AUTODEV <span class="marca-sub"><%= modulo %></span></span>
        <span class="cabecera-datos"><%= rolUsuario %> &middot; Portal de Licencias</span>
    </div>
    <nav class="menu">
        <a href="DashboardServlet">Panel</a>
        <a href="ClienteServlet">Clientes</a>
        <a href="LicenciaServlet">Licencias</a>
        <a href="VencimientoServlet">Vencimientos</a>
        <a href="LogoutServlet" class="menu-salir">Cerrar sesion</a>
    </nav>
</header>
