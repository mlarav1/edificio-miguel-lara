package com.miguellara.edificio.business.services;

import com.miguellara.edificio.business.exceptions.AutenticacionException;
import com.miguellara.edificio.business.exceptions.PersistenciaException;
import com.miguellara.edificio.business.exceptions.ValidacionException;
import com.miguellara.edificio.domain.model.Usuario;
import com.miguellara.edificio.infrastructure.persistence.UsuarioDAO;

import java.security.SecureRandom;
import java.util.List;

/** Reglas de negocio de Usuario: validacion, login y recuperacion de clave. */
public class UsuarioService {

    private static final String CARACTERES_CLAVE_TEMPORAL = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
    private static final SecureRandom ALEATORIO = new SecureRandom();

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();
    private final CorreoService correoService = new CorreoService();

    public void crear(Usuario usuario, String claveEnTexto) throws ValidacionException, PersistenciaException {
        validar(usuario, claveEnTexto);
        if (usuarioDAO.buscarPorId(usuario.getId()) != null) {
            throw new ValidacionException("Ya existe un usuario con ese correo.");
        }
        usuario.setClave(HashService.hashear(claveEnTexto));
        usuarioDAO.crear(usuario);
    }

    public void actualizar(Usuario usuario, String claveNuevaEnTextoOpcional) throws ValidacionException, PersistenciaException {
        if (usuario.getId() == null || usuario.getId().isBlank()) {
            throw new ValidacionException("El correo del usuario es obligatorio.");
        }
        if (usuario.getNombre() == null || usuario.getNombre().isBlank()) {
            throw new ValidacionException("El nombre es obligatorio.");
        }
        if (!"ADMINISTRADOR".equalsIgnoreCase(usuario.getRol()) && !"USUARIO".equalsIgnoreCase(usuario.getRol())) {
            throw new ValidacionException("El rol debe ser ADMINISTRADOR o USUARIO.");
        }
        if (claveNuevaEnTextoOpcional != null && !claveNuevaEnTextoOpcional.isBlank()) {
            if (claveNuevaEnTextoOpcional.length() < 6) {
                throw new ValidacionException("La clave debe tener al menos 6 caracteres.");
            }
            usuario.setClave(HashService.hashear(claveNuevaEnTextoOpcional));
        } else {
            Usuario existente = usuarioDAO.buscarPorId(usuario.getId());
            if (existente == null) {
                throw new ValidacionException("El usuario no existe.");
            }
            usuario.setClave(existente.getClave());
        }
        usuarioDAO.actualizar(usuario);
    }

    public void eliminar(String id) throws PersistenciaException {
        usuarioDAO.eliminar(id);
    }

    public Usuario buscarPorId(String id) throws PersistenciaException {
        return usuarioDAO.buscarPorId(id);
    }

    public List<Usuario> listarTodos() throws PersistenciaException {
        return usuarioDAO.listarTodos();
    }

    public List<Usuario> reportePorRol(String rol) throws PersistenciaException {
        return usuarioDAO.reportePorRol(rol);
    }

    public List<Usuario> reportePorTexto(String texto) throws PersistenciaException {
        return usuarioDAO.reportePorTexto(texto);
    }

    /** Verifica las credenciales contra la tabla usuario usando el hash BCrypt. */
    public Usuario iniciarSesion(String correo, String claveEnTexto) throws AutenticacionException, PersistenciaException {
        Usuario usuario = usuarioDAO.buscarPorId(correo);
        if (usuario == null || !HashService.coincide(claveEnTexto, usuario.getClave())) {
            throw new AutenticacionException("Correo o clave incorrectos.");
        }
        return usuario;
    }

    /**
     * Genera una clave temporal aleatoria, la guarda con hash y la envia por
     * correo al usuario. No revela si el correo existe o no en la respuesta
     * publica, para no filtrar informacion de la base de usuarios.
     */
    public void recuperarClave(String correo) throws PersistenciaException {
        Usuario usuario = usuarioDAO.buscarPorId(correo);
        if (usuario == null) {
            return;
        }
        String claveTemporal = generarClaveTemporal(10);
        usuarioDAO.actualizarClave(correo, HashService.hashear(claveTemporal));
        correoService.enviarClaveTemporal(correo, usuario.getNombre(), claveTemporal);
    }

    private String generarClaveTemporal(int longitud) {
        StringBuilder clave = new StringBuilder(longitud);
        for (int i = 0; i < longitud; i++) {
            clave.append(CARACTERES_CLAVE_TEMPORAL.charAt(ALEATORIO.nextInt(CARACTERES_CLAVE_TEMPORAL.length())));
        }
        return clave.toString();
    }

    private void validar(Usuario usuario, String claveEnTexto) throws ValidacionException {
        if (usuario.getId() == null || !usuario.getId().matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            throw new ValidacionException("El correo electronico no es valido.");
        }
        if (usuario.getNombre() == null || usuario.getNombre().isBlank()) {
            throw new ValidacionException("El nombre es obligatorio.");
        }
        if (!"ADMINISTRADOR".equalsIgnoreCase(usuario.getRol()) && !"USUARIO".equalsIgnoreCase(usuario.getRol())) {
            throw new ValidacionException("El rol debe ser ADMINISTRADOR o USUARIO.");
        }
        if (claveEnTexto == null || claveEnTexto.length() < 6) {
            throw new ValidacionException("La clave debe tener al menos 6 caracteres.");
        }
    }
}
