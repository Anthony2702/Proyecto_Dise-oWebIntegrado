package pe.utp.autodev.controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.utp.autodev.conexion.ConexionBD;
import pe.utp.autodev.modelo.Cliente;
import pe.utp.autodev.modelo.Licencia;
import pe.utp.autodev.modelo.Producto;

@WebServlet("/LicenciaServlet")
public class LicenciaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        listar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idCliente = request.getParameter("cboCliente");
        String idProducto = request.getParameter("cboProducto");
        String fechaInicio = request.getParameter("txtFechaInicio");

        if (idCliente == null || idProducto == null || fechaInicio == null || fechaInicio.isBlank()) {
            request.setAttribute("mensaje", "Seleccione cliente, producto y fecha de inicio.");
            request.setAttribute("tipoMensaje", "error");
            listar(request, response);
            return;
        }

        String sql = "INSERT INTO licencia (id_cliente, id_producto, fecha_inicio, fecha_fin, monto_contrato, estado) "
                   + "SELECT ?, id_producto, ?, ?, precio_anual, 'VIGENTE' FROM producto WHERE id_producto = ?";

        try (Connection cn = ConexionBD.obtener();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            LocalDate inicio = LocalDate.parse(fechaInicio);
            LocalDate fin = inicio.plusYears(1);

            ps.setInt(1, Integer.parseInt(idCliente));
            ps.setDate(2, Date.valueOf(inicio));
            ps.setDate(3, Date.valueOf(fin));
            ps.setInt(4, Integer.parseInt(idProducto));
            ps.executeUpdate();

            request.setAttribute("mensaje", "Licencia registrada con vigencia hasta el " + fin + ".");
            request.setAttribute("tipoMensaje", "ok");

        } catch (Exception ex) {
            request.setAttribute("mensaje", "No se pudo registrar la licencia.");
            request.setAttribute("tipoMensaje", "error");
        }

        listar(request, response);
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Cliente> clientes = new ArrayList<>();
        ArrayList<Producto> productos = new ArrayList<>();
        ArrayList<Licencia> licencias = new ArrayList<>();

        String sqlClientes = "SELECT id_cliente, ruc, razon_social FROM cliente "
                           + "WHERE estado = 'A' ORDER BY razon_social";

        String sqlProductos = "SELECT id_producto, codigo, nombre, precio_anual FROM producto "
                            + "WHERE estado = 'A' ORDER BY nombre";

        String sqlLicencias = "SELECT l.id_licencia, c.ruc, c.razon_social, p.nombre, "
                            + "l.fecha_inicio, l.fecha_fin, l.monto_contrato, l.estado "
                            + "FROM licencia l "
                            + "INNER JOIN cliente c  ON c.id_cliente  = l.id_cliente "
                            + "INNER JOIN producto p ON p.id_producto = l.id_producto "
                            + "ORDER BY l.id_licencia";

        try (Connection cn = ConexionBD.obtener()) {

            try (PreparedStatement ps = cn.prepareStatement(sqlClientes);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cliente c = new Cliente();
                    c.setIdCliente(rs.getInt("id_cliente"));
                    c.setRuc(rs.getString("ruc"));
                    c.setRazonSocial(rs.getString("razon_social"));
                    clientes.add(c);
                }
            }

            try (PreparedStatement ps = cn.prepareStatement(sqlProductos);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Producto p = new Producto();
                    p.setIdProducto(rs.getInt("id_producto"));
                    p.setCodigo(rs.getString("codigo"));
                    p.setNombre(rs.getString("nombre"));
                    p.setPrecioAnual(rs.getDouble("precio_anual"));
                    productos.add(p);
                }
            }

            try (PreparedStatement ps = cn.prepareStatement(sqlLicencias);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Licencia l = new Licencia();
                    l.setIdLicencia(rs.getInt("id_licencia"));
                    l.setRuc(rs.getString("ruc"));
                    l.setRazonSocial(rs.getString("razon_social"));
                    l.setProducto(rs.getString("nombre"));
                    l.setFechaInicio(rs.getString("fecha_inicio"));
                    l.setFechaFin(rs.getString("fecha_fin"));
                    l.setMontoContrato(rs.getDouble("monto_contrato"));
                    l.setEstado(rs.getString("estado"));
                    licencias.add(l);
                }
            }

        } catch (Exception ex) {
            throw new ServletException(ex);
        }

        request.setAttribute("listaClientes", clientes);
        request.setAttribute("listaProductos", productos);
        request.setAttribute("listaLicencias", licencias);
        request.getRequestDispatcher("licencias.jsp").forward(request, response);
    }
}
