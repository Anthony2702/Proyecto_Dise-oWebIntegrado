<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="errorPage.jsp" %>
<%@ page import="java.util.ArrayList, pe.utp.autodev.modelo.Cliente, pe.utp.autodev.modelo.Usuario" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ArrayList<Cliente> lista = (ArrayList<Cliente>) request.getAttribute("listaClientes");
    String mensaje = (String) request.getAttribute("mensaje");
    String tipoMensaje = (String) request.getAttribute("tipoMensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clientes - AUTODEV</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

<jsp:include page="partials/header.jsp">
    <jsp:param name="txtModulo" value="Gestion de Clientes" />
    <jsp:param name="txtRol" value="Administrador" />
</jsp:include>

<main class="contenedor">
    <h1>Clientes</h1>

    <% if (mensaje != null) { %>
        <p class="aviso <%= "ok".equals(tipoMensaje) ? "aviso-ok" : "aviso-error" %>"><%= mensaje %></p>
    <% } %>

    <section class="bloque">
        <h2>Registrar nuevo cliente</h2>
        <form action="ClienteServlet" method="post" class="formulario">
            <div class="campo">
                <label for="txtRuc">RUC</label>
                <input type="text" id="txtRuc" name="txtRuc" maxlength="11" pattern="\d{11}" required>
            </div>
            <div class="campo campo-ancho">
                <label for="txtRazonSocial">Razon social</label>
                <input type="text" id="txtRazonSocial" name="txtRazonSocial" maxlength="150" required>
            </div>
            <div class="campo">
                <label for="txtContacto">Contacto</label>
                <input type="text" id="txtContacto" name="txtContacto" maxlength="80" required>
            </div>
            <div class="campo">
                <label for="txtCorreo">Correo</label>
                <input type="email" id="txtCorreo" name="txtCorreo" maxlength="100" required>
            </div>
            <div class="campo">
                <label for="txtTelefono">Telefono</label>
                <input type="text" id="txtTelefono" name="txtTelefono" maxlength="15">
            </div>
            <div class="campo campo-boton">
                <button type="submit" class="boton boton-principal">Registrar</button>
            </div>
        </form>
    </section>

    <section class="bloque">
        <h2>Cartera registrada (<%= lista.size() %>)</h2>
        <div class="tabla-scroll">
            <table class="tabla tabla-datos">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>RUC</th>
                        <th>Razon social</th>
                        <th>Contacto</th>
                        <th>Correo</th>
                        <th>Telefono</th>
                        <th>Registro</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (Cliente c : lista) {
                %>
                    <tr>
                        <td><%= c.getIdCliente() %></td>
                        <td><%= c.getRuc() %></td>
                        <td><%= c.getRazonSocial() %></td>
                        <td><%= c.getContacto() %></td>
                        <td><%= c.getCorreo() %></td>
                        <td><%= c.getTelefono() %></td>
                        <td><%= c.getFechaRegistro() %></td>
                        <td><span class="etiqueta etiqueta-<%= "A".equals(c.getEstado()) ? "ok" : "gris" %>">
                            <%= "A".equals(c.getEstado()) ? "Activo" : "Inactivo" %></span></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </section>
</main>

<jsp:include page="partials/footer.jsp" />

</body>
</html>
