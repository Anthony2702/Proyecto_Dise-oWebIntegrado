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

        String sql = "SELECT "
                   + "(SELECT COUNT(*) FROM cliente WHERE estado = 'A') AS clientes, "
                   + "(SELECT COUNT(*) FROM licencia WHERE estado = 'VIGENTE') AS vigentes, "
                   + "(SELECT COUNT(*) FROM licencia WHERE estado = 'VIGENTE' "
                   + "   AND fecha_fin BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)) AS porVencer, "
                   + "(SELECT IFNULL(SUM(monto),0) FROM pago WHERE YEAR(fecha_pago) = YEAR(CURDATE())) AS recaudado";

        try (Connection cn = ConexionBD.obtener();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                request.setAttribute("totalClientes", rs.getInt("clientes"));
                request.setAttribute("totalVigentes", rs.getInt("vigentes"));
                request.setAttribute("totalPorVencer", rs.getInt("porVencer"));
                request.setAttribute("totalRecaudado", rs.getDouble("recaudado"));
            }

        } catch (Exception ex) {
            throw new ServletException(ex);
        }

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
