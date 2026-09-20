package com.miguellara.edificio.business.services;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Se elige BCrypt (via jBCrypt) porque incorpora la sal automaticamente y
 * un costo configurable, a diferencia de un hash simple como SHA-256 solo.
 */
public final class HashService {

    private HashService() {
    }

    public static String hashear(String claveEnTexto) {
        return BCrypt.hashpw(claveEnTexto, BCrypt.gensalt(12));
    }

    public static boolean coincide(String claveEnTexto, String claveConHash) {
        return BCrypt.checkpw(claveEnTexto, claveConHash);
    }
}
