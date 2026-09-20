package com.miguellara.edificio.business.exceptions;

/** Se lanza cuando falla una operacion de acceso a datos (SQL, conexion, etc). */
public class PersistenciaException extends Exception {

    public PersistenciaException(String mensaje, Throwable causa) {
        super(mensaje, causa);
    }

    public PersistenciaException(String mensaje) {
        super(mensaje);
    }
}
