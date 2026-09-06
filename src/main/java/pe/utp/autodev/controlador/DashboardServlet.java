package pe.utp.autodev.controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import pe.utp.autodev.conexion.ConexionBD;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int totalClientes = 0;
        int totalVigentes = 0;
        int totalPorVencer = 0;
        double totalRecaudado = 0;

        try (Connection cn = ConexionBD.obtener()) {

            String sql1 = "SELECT COUNT(*) FROM cliente WHERE estado = 'A'";
            try (PreparedStatement ps = cn.prepareStatement(sql1);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalClientes = rs.getInt(1);
                }
            }

            String sql2 = "SELECT COUNT(*) FROM licencia WHERE estado = 'VIGENTE'";
            try (PreparedStatement ps = cn.prepareStatement(sql2);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalVigentes = rs.getInt(1);
                }
            }

            String sql3 = "SELECT COUNT(*) FROM licencia WHERE estado = 'VIGENTE' "
                        + "AND fecha_fin BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)";
            try (PreparedStatement ps = cn.prepareStatement(sql3);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalPorVencer = rs.getInt(1);
                }
            }

            String sql4 = "SELECT SUM(monto) FROM pago WHERE YEAR(fecha_pago) = YEAR(CURDATE())";
            try (PreparedStatement ps = cn.prepareStatement(sql4);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalRecaudado = rs.getDouble(1);
                }
            }

        } catch (Exception ex) {
            throw new ServletException(ex);
        }

        request.setAttribute("totalClientes", totalClientes);
        request.setAttribute("totalVigentes", totalVigentes);
        request.setAttribute("totalPorVencer", totalPorVencer);
        request.setAttribute("totalRecaudado", totalRecaudado);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
