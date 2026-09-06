<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="errorPage.jsp" %>
<%@ page import="java.util.ArrayList, pe.utp.autodev.modelo.Licencia, pe.utp.autodev.modelo.Usuario" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ArrayList<Licencia> lista = (ArrayList<Licencia>) request.getAttribute("listaVencimientos");
    Integer dias = (Integer) request.getAttribute("diasFiltro");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vencimientos - AUTODEV</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

<jsp:include page="partials/header.jsp">
    <jsp:param name="txtModulo" value="Control de Vencimientos" />
    <jsp:param name="txtRol" value="Administrador" />
</jsp:include>

<main class="contenedor">
    <h1>Vencimientos</h1>

    <section class="bloque">
        <form action="VencimientoServlet" method="get" class="formulario formulario-filtro">
            <div class="campo">
                <label for="txtDias">Licencias que vencen dentro de</label>
                <input type="number" id="txtDias" name="txtDias" min="1" max="365" value="<%= dias %>" required>
            </div>
            <div class="campo campo-boton">
                <button type="submit" class="boton boton-principal">Consultar</button>
            </div>
        </form>
    </section>

    <section class="bloque">
        <h2>Resultado: <%= lista.size() %> licencia(s) vencidas o por vencer en <%= dias %> dias</h2>

        <% if (lista.isEmpty()) { %>
            <p class="aviso aviso-ok">No hay licencias vencidas ni por vencer en el rango consultado.</p>
        <% } else { %>
        <div class="tabla-scroll">
            <table class="tabla tabla-datos">
                <thead>
                    <tr>
                        <th>RUC</th>
                        <th>Cliente</th>
                        <th>Contacto</th>
                        <th>Producto</th>
                        <th>Vence</th>
                        <th>Dias</th>
                        <th>Estado</th>
                        <th>Monto renovacion</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (Licencia l : lista) {
                        String clase = l.getDiasRestantes() < 0 ? "rojo"
                                     : l.getDiasRestantes() <= 15 ? "alerta" : "ok";
                %>
                    <tr>
                        <td><%= l.getRuc() %></td>
                        <td><%= l.getRazonSocial() %></td>
                        <td><%= l.getContacto() %></td>
                        <td><%= l.getProducto() %></td>
                        <td><%= l.getFechaFin() %></td>
                        <td><span class="etiqueta etiqueta-<%= clase %>"><%= l.getDiasRestantes() %></span></td>
                        <td><span class="etiqueta etiqueta-<%= "VIGENTE".equals(l.getEstado()) ? "ok" : "rojo" %>"><%= l.getEstado() %></span></td>
                        <td>S/ <%= String.format("%,.2f", l.getMontoContrato()) %></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
        <% } %>
    </section>
</main>

<jsp:include page="partials/footer.jsp" />

</body>
</html>
