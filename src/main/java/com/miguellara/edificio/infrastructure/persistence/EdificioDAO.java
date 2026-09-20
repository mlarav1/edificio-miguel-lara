package com.miguellara.edificio.infrastructure.persistence;

import com.miguellara.edificio.business.exceptions.PersistenciaException;
import com.miguellara.edificio.domain.model.Edificio;
import com.miguellara.edificio.infrastructure.database.ConexionBD;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Acceso a datos de Edificio. Todas las consultas usan PreparedStatement
 * y cierran sus recursos con try-with-resources.
 */
public class EdificioDAO {

    private static final String COLUMNAS = "id, nombre, metros_cuadrados, altura, num_pisos, num_apartamentos, "
            + "num_oficinas, nombre_parqueadero, num_piscinas, pais, departamento, ciudad, tiene_ascensor, "
            + "valor_administracion, tiene_zona_social";

    public void crear(Edificio edificio) throws PersistenciaException {
        String sql = "INSERT INTO edificio (nombre, metros_cuadrados, altura, num_pisos, num_apartamentos, "
                + "num_oficinas, nombre_parqueadero, num_piscinas, pais, departamento, ciudad, tiene_ascensor, "
                + "valor_administracion, tiene_zona_social) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            asignarParametros(ps, edificio);
            ps.executeUpdate();
            try (ResultSet claves = ps.getGeneratedKeys()) {
                if (claves.next()) {
                    edificio.setId(claves.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo crear el edificio: " + e.getMessage(), e);
        }
    }

    public Edificio buscarPorId(int id) throws PersistenciaException {
        String sql = "SELECT " + COLUMNAS + " FROM edificio WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
                return null;
            }
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo buscar el edificio: " + e.getMessage(), e);
        }
    }

    public List<Edificio> listarTodos() throws PersistenciaException {
        String sql = "SELECT " + COLUMNAS + " FROM edificio ORDER BY nombre";
        List<Edificio> resultado = new ArrayList<>();
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                resultado.add(mapear(rs));
            }
            return resultado;
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo listar los edificios: " + e.getMessage(), e);
        }
    }

    public void actualizar(Edificio edificio) throws PersistenciaException {
        String sql = "UPDATE edificio SET nombre = ?, metros_cuadrados = ?, altura = ?, num_pisos = ?, "
                + "num_apartamentos = ?, num_oficinas = ?, nombre_parqueadero = ?, num_piscinas = ?, pais = ?, "
                + "departamento = ?, ciudad = ?, tiene_ascensor = ?, valor_administracion = ?, tiene_zona_social = ? "
                + "WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            asignarParametros(ps, edificio);
            ps.setInt(15, edificio.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo actualizar el edificio: " + e.getMessage(), e);
        }
    }

    public void eliminar(int id) throws PersistenciaException {
        String sql = "DELETE FROM edificio WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo eliminar el edificio: " + e.getMessage(), e);
        }
    }

    /** Reporte 1: edificios de una ciudad con numero de pisos dentro de un rango. */
    public List<Edificio> reportePorCiudadYPisos(String ciudad, int pisosMin, int pisosMax) throws PersistenciaException {
        String sql = "SELECT " + COLUMNAS + " FROM edificio WHERE ciudad = ? AND num_pisos BETWEEN ? AND ? ORDER BY num_pisos";
        List<Edificio> resultado = new ArrayList<>();
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, ciudad);
            ps.setInt(2, pisosMin);
            ps.setInt(3, pisosMax);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    resultado.add(mapear(rs));
                }
            }
            return resultado;
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo generar el reporte por ciudad y pisos: " + e.getMessage(), e);
        }
    }

    /** Reporte 2: edificios por rango de valor de administracion, con filtro opcional de ascensor y zona social. */
    public List<Edificio> reportePorAdministracion(BigDecimal valorMin, BigDecimal valorMax,
                                                     Boolean conAscensor, Boolean conZonaSocial) throws PersistenciaException {
        StringBuilder sql = new StringBuilder("SELECT " + COLUMNAS
                + " FROM edificio WHERE valor_administracion BETWEEN ? AND ?");
        if (conAscensor != null) {
            sql.append(" AND tiene_ascensor = ?");
        }
        if (conZonaSocial != null) {
            sql.append(" AND tiene_zona_social = ?");
        }
        sql.append(" ORDER BY valor_administracion");

        List<Edificio> resultado = new ArrayList<>();
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int indice = 1;
            ps.setBigDecimal(indice++, valorMin);
            ps.setBigDecimal(indice++, valorMax);
            if (conAscensor != null) {
                ps.setBoolean(indice++, conAscensor);
            }
            if (conZonaSocial != null) {
                ps.setBoolean(indice++, conZonaSocial);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    resultado.add(mapear(rs));
                }
            }
            return resultado;
        } catch (SQLException e) {
            throw new PersistenciaException("No se pudo generar el reporte por administracion: " + e.getMessage(), e);
        }
    }

    private void asignarParametros(PreparedStatement ps, Edificio edificio) throws SQLException {
        ps.setString(1, edificio.getNombre());
        ps.setBigDecimal(2, edificio.getMetrosCuadrados());
        ps.setBigDecimal(3, edificio.getAltura());
        ps.setInt(4, edificio.getNumPisos());
        ps.setInt(5, edificio.getNumApartamentos());
        ps.setInt(6, edificio.getNumOficinas());
        ps.setString(7, edificio.getNombreParqueadero());
        ps.setInt(8, edificio.getNumPiscinas());
        ps.setString(9, edificio.getPais());
        ps.setString(10, edificio.getDepartamento());
        ps.setString(11, edificio.getCiudad());
        ps.setBoolean(12, edificio.isTieneAscensor());
        ps.setBigDecimal(13, edificio.getValorAdministracion());
        ps.setBoolean(14, edificio.isTieneZonaSocial());
    }

    private Edificio mapear(ResultSet rs) throws SQLException {
        Edificio edificio = new Edificio();
        edificio.setId(rs.getInt("id"));
        edificio.setNombre(rs.getString("nombre"));
        edificio.setMetrosCuadrados(rs.getBigDecimal("metros_cuadrados"));
        edificio.setAltura(rs.getBigDecimal("altura"));
        edificio.setNumPisos(rs.getInt("num_pisos"));
        edificio.setNumApartamentos(rs.getInt("num_apartamentos"));
        edificio.setNumOficinas(rs.getInt("num_oficinas"));
        edificio.setNombreParqueadero(rs.getString("nombre_parqueadero"));
        edificio.setNumPiscinas(rs.getInt("num_piscinas"));
        edificio.setPais(rs.getString("pais"));
        edificio.setDepartamento(rs.getString("departamento"));
        edificio.setCiudad(rs.getString("ciudad"));
        edificio.setTieneAscensor(rs.getBoolean("tiene_ascensor"));
        edificio.setValorAdministracion(rs.getBigDecimal("valor_administracion"));
        edificio.setTieneZonaSocial(rs.getBoolean("tiene_zona_social"));
        return edificio;
    }
}
