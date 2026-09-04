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
import jakarta.servlet.http.HttpSession;
import pe.utp.autodev.conexion.ConexionBD;
import pe.utp.autodev.modelo.Usuario;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("txtCorreo");
        String clave = request.getParameter("txtClave");

        String sql = "SELECT id_usuario, nombres, correo, rol FROM usuario "
                   + "WHERE correo = ? AND clave = ? AND estado = 'A'";

        try (Connection cn = ConexionBD.obtener();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, correo);
            ps.setString(2, clave);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setIdUsuario(rs.getInt("id_usuario"));
                    u.setNombres(rs.getString("nombres"));
                    u.setCorreo(rs.getString("correo"));
                    u.setRol(rs.getString("rol"));

                    HttpSession sesion = request.getSession();
                    sesion.setAttribute("usuario", u);
                    response.sendRedirect("DashboardServlet");
                } else {
                    request.setAttribute("mensaje", "Correo o clave incorrectos.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }

        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
