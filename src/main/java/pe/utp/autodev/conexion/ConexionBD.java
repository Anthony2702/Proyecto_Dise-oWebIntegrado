package pe.utp.autodev.conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    private static final String URL =
        "jdbc:mysql://localhost:3306/autodev_db?useSSL=false&serverTimezone=America/Lima";
    private static final String USUARIO = "root";
    private static final String CLAVE = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static Connection obtener() throws SQLException {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException ex) {
            throw new SQLException("No se encontro el driver MySQL Connector/J", ex);
        }
        return DriverManager.getConnection(URL, USUARIO, CLAVE);
    }

    public static void cerrar(Connection cn) {
        if (cn != null) {
            try {
                cn.close();
            } catch (SQLException ex) {
                System.err.println("[AUTODEV] Error al cerrar la conexion: " + ex.getMessage());
            }
        }
    }
}
