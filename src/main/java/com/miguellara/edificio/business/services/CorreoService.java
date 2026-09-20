package com.miguellara.edificio.business.services;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Envio de correo para la recuperacion de clave. Lee la configuracion SMTP
 * de variables de entorno (ver .env.example). Si no hay host configurado,
 * cae a un modo local de prueba que solo escribe el correo en el log de la
 * aplicacion, para poder seguir desarrollando sin credenciales SMTP reales.
 */
public class CorreoService {

    private static final Logger LOG = Logger.getLogger(CorreoService.class.getName());

    private final String host = System.getenv("SMTP_HOST");
    private final String puerto = valorEnv("SMTP_PORT", "587");
    private final String usuario = System.getenv("SMTP_USUARIO");
    private final String clave = System.getenv("SMTP_CLAVE");
    private final String remitente = valorEnv("SMTP_REMITENTE", "no-responder@edificio-app.local");

    public void enviarClaveTemporal(String destinatario, String nombre, String claveTemporal) {
        String asunto = "Recuperacion de clave - Edificio App";
        String cuerpo = "Hola " + nombre + ",\n\n"
                + "Tu nueva clave temporal es: " + claveTemporal + "\n\n"
                + "Ingresa con esta clave y cambiala desde tu perfil apenas puedas.\n\n"
                + "Si no solicitaste este cambio, contacta al administrador.";

        if (host == null || host.isBlank()) {
            LOG.log(Level.INFO, "[SMTP DE PRUEBA - no hay SMTP_HOST configurado] Para: {0} | Asunto: {1} | Cuerpo: {2}",
                    new Object[]{destinatario, asunto, cuerpo});
            return;
        }

        Properties propiedades = new Properties();
        propiedades.put("mail.smtp.auth", "true");
        propiedades.put("mail.smtp.starttls.enable", "true");
        propiedades.put("mail.smtp.host", host);
        propiedades.put("mail.smtp.port", puerto);

        Session sesion = Session.getInstance(propiedades, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(usuario, clave);
            }
        });

        try {
            Message mensaje = new MimeMessage(sesion);
            mensaje.setFrom(new InternetAddress(remitente));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject(asunto);
            mensaje.setText(cuerpo);
            Transport.send(mensaje);
        } catch (MessagingException e) {
            LOG.log(Level.SEVERE, "No se pudo enviar el correo de recuperacion de clave a " + destinatario, e);
        }
    }

    private static String valorEnv(String nombre, String porDefecto) {
        String valor = System.getenv(nombre);
        return (valor == null || valor.isBlank()) ? porDefecto : valor;
    }
}
