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

@WebServlet("/ClienteServlet")
public class ClienteServlet extends HttpServlet {

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

        String ruc = request.getParameter("txtRuc");
        String razonSocial = request.getParameter("txtRazonSocial");
        String contacto = request.getParameter("txtContacto");
        String correo = request.getParameter("txtCorreo");
        String telefono = request.getParameter("txtTelefono");

        if (ruc == null || ruc.length() != 11 || razonSocial == null || razonSocial.isBlank()) {
            request.setAttribute("mensaje", "El RUC debe tener 11 digitos y la razon social es obligatoria.");
            request.setAttribute("tipoMensaje", "error");
            listar(request, response);
            return;
        }

        String sql = "INSERT INTO cliente (ruc, razon_social, contacto, correo, telefono, fecha_registro, estado) "
                   + "VALUES (?, ?, ?, ?, ?, ?, 'A')";

        try (Connection cn = ConexionBD.obtener();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, ruc);
            ps.setString(2, razonSocial);
            ps.setString(3, contacto);
            ps.setString(4, correo);
            ps.setString(5, telefono);
            ps.setDate(6, Date.valueOf(LocalDate.now()));
            ps.executeUpdate();

            request.setAttribute("mensaje", "Cliente registrado correctamente.");
            request.setAttribute("tipoMensaje", "ok");

        } catch (Exception ex) {
            request.setAttribute("mensaje", "No se pudo registrar. Verifique que el RUC no este duplicado.");
            request.setAttribute("tipoMensaje", "error");
        }

        listar(request, response);
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Cliente> lista = new ArrayList<>();
        String sql = "SELECT id_cliente, ruc, razon_social, contacto, correo, telefono, fecha_registro, estado "
                   + "FROM cliente ORDER BY id_cliente DESC";

        try (Connection cn = ConexionBD.obtener();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setIdCliente(rs.getInt("id_cliente"));
                c.setRuc(rs.getString("ruc"));
                c.setRazonSocial(rs.getString("razon_social"));
                c.setContacto(rs.getString("contacto"));
                c.setCorreo(rs.getString("correo"));
                c.setTelefono(rs.getString("telefono"));
                c.setFechaRegistro(rs.getString("fecha_registro"));
                c.setEstado(rs.getString("estado"));
                lista.add(c);
            }

        } catch (Exception ex) {
            throw new ServletException(ex);
        }

        request.setAttribute("listaClientes", lista);
        request.getRequestDispatcher("clientes.jsp").forward(request, response);
    }
}
