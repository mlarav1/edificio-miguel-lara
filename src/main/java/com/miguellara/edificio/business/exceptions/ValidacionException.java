package com.miguellara.edificio.business.exceptions;

/** Se lanza cuando los datos de entrada no cumplen las reglas de negocio. */
public class ValidacionException extends Exception {

    public ValidacionException(String mensaje) {
        super(mensaje);
    }
}
