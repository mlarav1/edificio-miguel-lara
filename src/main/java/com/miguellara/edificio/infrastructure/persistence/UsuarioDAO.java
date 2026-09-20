package com.miguellara.edificio.infrastructure.persistence;

import com.miguellara.edificio.business.exceptions.PersistenciaException;
import com.miguellara.edificio.domain.model.Usuario;
import com.miguellara.edificio.infrastructure.database.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Acceso a datos de Usuario. Todas las consultas usan PreparedStatement
 * (nunca se concatena SQL con datos de entrada) y cierran sus recursos
 * con try-with-resources.
 */
public class UsuarioDAO {

    public void crear(Usuario usuario) throws PersistenciaException {
        String sql = "INSERT INTO usuario (id, clave, nombre, rol) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, usuario.getId());
            ps.setString(2, usuario.getClave());
            ps.setString(3, usuario.getNombre());
            ps.setString(4, usuario.getRol());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo crear el usuario: " + e.getMessage(), e);
        }
    }

    public Usuario buscarPorId(String id) throws PersistenciaException {
        String sql = "SELECT id, clave, nombre, rol FROM usuario WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
                return null;
            }
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo buscar el usuario: " + e.getMessage(), e);
        }
    }

    public List<Usuario> listarTodos() throws PersistenciaException {
        String sql = "SELECT id, clave, nombre, rol FROM usuario ORDER BY nombre";
        List<Usuario> resultado = new ArrayList<>();
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                resultado.add(mapear(rs));
            }
            return resultado;
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo listar los usuarios: " + e.getMessage(), e);
        }
    }

    public void actualizar(Usuario usuario) throws PersistenciaException {
        String sql = "UPDATE usuario SET clave = ?, nombre = ?, rol = ? WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, usuario.getClave());
            ps.setString(2, usuario.getNombre());
            ps.setString(3, usuario.getRol());
            ps.setString(4, usuario.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo actualizar el usuario: " + e.getMessage(), e);
        }
    }

    public void actualizarClave(String id, String claveConHash) throws PersistenciaException {
        String sql = "UPDATE usuario SET clave = ? WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, claveConHash);
            ps.setString(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo actualizar la clave: " + e.getMessage(), e);
        }
    }

    public void eliminar(String id) throws PersistenciaException {
        String sql = "DELETE FROM usuario WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo eliminar el usuario: " + e.getMessage(), e);
        }
    }

    /** Reporte 1: usuarios filtrados por rol exacto. */
    public List<Usuario> reportePorRol(String rol) throws PersistenciaException {
        String sql = "SELECT id, clave, nombre, rol FROM usuario WHERE rol = ? ORDER BY nombre";
        List<Usuario> resultado = new ArrayList<>();
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, rol);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    resultado.add(mapear(rs));
                }
            }
            return resultado;
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo generar el reporte por rol: " + e.getMessage(), e);
        }
    }

    /** Reporte 2: usuarios cuyo nombre o correo (id) contiene el texto dado. */
    public List<Usuario> reportePorTexto(String texto) throws PersistenciaException {
        String sql = "SELECT id, clave, nombre, rol FROM usuario WHERE nombre LIKE ? OR id LIKE ? ORDER BY nombre";
        List<Usuario> resultado = new ArrayList<>();
        String patron = "%" + texto + "%";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, patron);
            ps.setString(2, patron);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    resultado.add(mapear(rs));
                }
            }
            return resultado;
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo generar el reporte por texto: " + e.getMessage(), e);
        }
    }

    private Usuario mapear(ResultSet rs) throws SQLException {
        Usuario usuario = new Usuario();
        usuario.setId(rs.getString("id"));
        usuario.setClave(rs.getString("clave"));
        usuario.setNombre(rs.getString("nombre"));
        usuario.setRol(rs.getString("rol"));
        return usuario;
    }
}
