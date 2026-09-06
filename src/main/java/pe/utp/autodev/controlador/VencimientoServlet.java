package pe.utp.autodev.controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.utp.autodev.conexion.ConexionBD;
import pe.utp.autodev.modelo.Licencia;

@WebServlet("/VencimientoServlet")
public class VencimientoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int dias = 30;
        String parametro = request.getParameter("txtDias");
        if (parametro != null && !parametro.isEmpty()) {
            try {
                dias = Integer.parseInt(parametro);
            } catch (NumberFormatException ex) {
                dias = 30;
            }
        }

        ArrayList<Licencia> lista = new ArrayList<>();
        String sql = "SELECT l.id_licencia, c.ruc, c.razon_social, c.contacto, p.nombre, "
                   + "l.fecha_fin, l.monto_contrato, l.estado, "
                   + "DATEDIFF(l.fecha_fin, CURDATE()) AS dias_restantes "
                   + "FROM licencia l "
                   + "INNER JOIN cliente c  ON c.id_cliente  = l.id_cliente "
                   + "INNER JOIN producto p ON p.id_producto = l.id_producto "
                   + "WHERE l.estado <> 'ANULADA' AND DATEDIFF(l.fecha_fin, CURDATE()) <= ? "
                   + "ORDER BY l.fecha_fin";

        try (Connection cn = ConexionBD.obtener();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, dias);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Licencia l = new Licencia();
                    l.setIdLicencia(rs.getInt("id_licencia"));
                    l.setRuc(rs.getString("ruc"));
                    l.setRazonSocial(rs.getString("razon_social"));
                    l.setContacto(rs.getString("contacto"));
                    l.setProducto(rs.getString("nombre"));
                    l.setFechaFin(rs.getString("fecha_fin"));
                    l.setMontoContrato(rs.getDouble("monto_contrato"));
                    l.setEstado(rs.getString("estado"));
                    l.setDiasRestantes(rs.getInt("dias_restantes"));
                    lista.add(l);
                }
            }

        } catch (Exception ex) {
            throw new ServletException(ex);
        }

        request.setAttribute("listaVencimientos", lista);
        request.setAttribute("diasFiltro", dias);
        request.getRequestDispatcher("vencimientos.jsp").forward(request, response);
    }
}
