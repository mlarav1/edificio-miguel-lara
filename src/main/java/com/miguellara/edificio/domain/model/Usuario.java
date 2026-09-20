package com.miguellara.edificio.domain.model;

/**
 * Entidad Usuario. El id es el correo electronico del usuario: se usa como
 * identificador de inicio de sesion y como destino de la recuperacion de clave,
 * asi no se necesita una columna adicional de "correo".
 */
public class Usuario {

    private String id; // correo electronico, ej: admin@correo.com
    private String clave; // clave con hash (BCrypt)
    private String nombre;
    private String rol; // ADMINISTRADOR o USUARIO

    public Usuario() {
    }

    public Usuario(String id, String clave, String nombre, String rol) {
        this.id = id;
        this.clave = clave;
        this.nombre = nombre;
        this.rol = rol;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public boolean esAdministrador() {
        return "ADMINISTRADOR".equalsIgnoreCase(rol);
    }
}
