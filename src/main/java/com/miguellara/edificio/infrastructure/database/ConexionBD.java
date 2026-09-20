package com.miguellara.edificio.infrastructure.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Punto unico de acceso a la conexion JDBC. Lee la configuracion de
 * variables de entorno para poder usar la misma clase en local y en
 * produccion sin cambiar codigo (ver .env.example).
 */
public final class ConexionBD {

    private static final String URL = valorEnv("DB_URL", "jdbc:mysql://localhost:3306/edificio_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
    private static final String USUARIO = valorEnv("DB_USUARIO", "root");
    private static final String CLAVE = valorEnv("DB_CLAVE", "");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("No se encontro el driver JDBC de MySQL: " + e.getMessage());
        }
    }

    private ConexionBD() {
    }

    public static Connection obtenerConexion() throws SQLException {
        return DriverManager.getConnection(URL, USUARIO, CLAVE);
    }

    private static String valorEnv(String nombre, String porDefecto) {
        String valor = System.getenv(nombre);
        return (valor == null || valor.isBlank()) ? porDefecto : valor;
    }
}
