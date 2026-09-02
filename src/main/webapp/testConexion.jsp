<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.sql.DatabaseMetaData" %>
<%@ page import="pe.utp.autodev.conexion.ConexionBD" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test de Conexion JDBC - AUTODEV</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>

<main class="contenedor">
    <h1>Prueba de Conexion JDBC</h1>

    <%
        String motor = "";
        String driver = "";
        String catalogo = "";
        int totalClientes = 0;
        int totalProductos = 0;
        int totalLicencias = 0;
        boolean conectado = false;
        String detalleError = "";

        String sql = "SELECT "
                   + "(SELECT COUNT(*) FROM cliente)  AS clientes, "
                   + "(SELECT COUNT(*) FROM producto) AS productos, "
                   + "(SELECT COUNT(*) FROM licencia) AS licencias";

        try (Connection cn = ConexionBD.obtener();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            DatabaseMetaData meta = cn.getMetaData();
            motor    = meta.getDatabaseProductName() + " " + meta.getDatabaseProductVersion();
            driver   = meta.getDriverName() + " " + meta.getDriverVersion();
            catalogo = cn.getCatalog();

            if (rs.next()) {
                totalClientes  = rs.getInt("clientes");
                totalProductos = rs.getInt("productos");
                totalLicencias = rs.getInt("licencias");
            }
            conectado = true;

        } catch (Exception ex) {
            detalleError = ex.getMessage();
            System.err.println("[AUTODEV] Fallo la prueba de conexion: " + ex.getMessage());
        }
    %>

    <% if (conectado) { %>
        <p class="aviso aviso-ok">Conexion establecida correctamente.</p>

        <table class="tabla">
            <tr><th>Motor de base de datos</th><td><%= motor %></td></tr>
            <tr><th>Driver JDBC</th><td><%= driver %></td></tr>
            <tr><th>Esquema conectado</th><td><%= catalogo %></td></tr>
            <tr><th>Clientes registrados</th><td><%= totalClientes %></td></tr>
            <tr><th>Productos en catalogo</th><td><%= totalProductos %></td></tr>
            <tr><th>Licencias emitidas</th><td><%= totalLicencias %></td></tr>
        </table>
    <% } else { %>
        <p class="aviso aviso-error">No se pudo establecer la conexion.</p>
        <p><%= detalleError %></p>
    <% } %>
</main>

</body>
</html>
