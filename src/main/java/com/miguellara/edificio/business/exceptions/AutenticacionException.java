package com.miguellara.edificio.business.exceptions;

/** Se lanza cuando el login falla o el usuario no tiene permiso para la accion. */
public class AutenticacionException extends Exception {

    public AutenticacionException(String mensaje) {
        super(mensaje);
    }
}
