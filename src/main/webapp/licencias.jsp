<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="errorPage.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pe.utp.autodev.modelo.Cliente, pe.utp.autodev.modelo.Producto" %>
<%@ page import="pe.utp.autodev.modelo.Licencia, pe.utp.autodev.modelo.Usuario" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ArrayList<Cliente>  clientes  = (ArrayList<Cliente>)  request.getAttribute("listaClientes");
    ArrayList<Producto> productos = (ArrayList<Producto>) request.getAttribute("listaProductos");
    ArrayList<Licencia> licencias = (ArrayList<Licencia>) request.getAttribute("listaLicencias");
    String mensaje = (String) request.getAttribute("mensaje");
    String tipoMensaje = (String) request.getAttribute("tipoMensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Licencias - AUTODEV</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

<jsp:include page="partials/header.jsp">
    <jsp:param name="txtModulo" value="Asignacion de Licencias" />
    <jsp:param name="txtRol" value="Administrador" />
</jsp:include>

<main class="contenedor">
    <h1>Licencias</h1>

    <% if (mensaje != null) { %>
        <p class="aviso <%= "ok".equals(tipoMensaje) ? "aviso-ok" : "aviso-error" %>"><%= mensaje %></p>
    <% } %>

    <section class="bloque">
        <h2>Asignar licencia anual</h2>
        <form action="LicenciaServlet" method="post" class="formulario">
            <div class="campo campo-ancho">
                <label for="cboCliente">Cliente</label>
                <select id="cboCliente" name="cboCliente" required>
                    <option value="">-- Seleccione --</option>
                    <% for (Cliente c : clientes) { %>
                        <option value="<%= c.getIdCliente() %>"><%= c.getRuc() %> - <%= c.getRazonSocial() %></option>
                    <% } %>
                </select>
            </div>
            <div class="campo">
                <label for="cboProducto">Producto</label>
                <select id="cboProducto" name="cboProducto" required>
                    <option value="">-- Seleccione --</option>
                    <% for (Producto p : productos) { %>
                        <option value="<%= p.getIdProducto() %>">
                            <%= p.getNombre() %> (S/ <%= String.format("%,.2f", p.getPrecioAnual()) %>)
                        </option>
                    <% } %>
                </select>
            </div>
            <div class="campo">
                <label for="txtFechaInicio">Fecha de inicio</label>
                <input type="date" id="txtFechaInicio" name="txtFechaInicio" required>
            </div>
            <div class="campo campo-boton">
                <button type="submit" class="boton boton-principal">Asignar</button>
            </div>
        </form>
        <p class="texto-apoyo">La vigencia se calcula a un ano desde la fecha de inicio y el monto se toma del catalogo.</p>
    </section>

    <section class="bloque">
        <h2>Licencias emitidas (<%= licencias.size() %>)</h2>
        <div class="tabla-scroll">
            <table class="tabla tabla-datos">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>RUC</th>
                        <th>Cliente</th>
                        <th>Producto</th>
                        <th>Inicio</th>
                        <th>Fin</th>
                        <th>Monto</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Licencia l : licencias) { %>
                    <tr>
                        <td><%= l.getIdLicencia() %></td>
                        <td><%= l.getRuc() %></td>
                        <td><%= l.getRazonSocial() %></td>
                        <td><%= l.getProducto() %></td>
                        <td><%= l.getFechaInicio() %></td>
                        <td><%= l.getFechaFin() %></td>
                        <td>S/ <%= String.format("%,.2f", l.getMontoContrato()) %></td>
                        <td><span class="etiqueta etiqueta-<%= "VIGENTE".equals(l.getEstado()) ? "ok" : "rojo" %>">
                            <%= l.getEstado() %></span></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>
</main>

<jsp:include page="partials/footer.jsp" />

</body>
</html>
