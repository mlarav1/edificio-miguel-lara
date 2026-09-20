package com.miguellara.edificio.web;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Protege todas las paginas internas: sin sesion activa, redirige al login.
 * Ademas restringe la gestion de usuarios (carpeta /usuarios/*) solo al rol
 * ADMINISTRADOR, tal como pide el requisito de control por rol.
 */
@WebFilter(urlPatterns = {"/edificios/*", "/usuarios/*", "/reportes/*", "/controllers/*"})
public class SesionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String contexto = request.getContextPath();
        String rutaSolicitada = request.getRequestURI();

        if (rutaSolicitada.endsWith("/controllers/LoginController.jsp")
                || rutaSolicitada.endsWith("/controllers/RecuperarClaveController.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession sesion = request.getSession(false);
        boolean haySesion = sesion != null && sesion.getAttribute("usuario") != null;

        if (!haySesion) {
            response.sendRedirect(contexto + "/login.jsp?motivo=sesion");
            return;
        }

        String rutaPedida = request.getRequestURI();
        boolean esGestionUsuarios = rutaPedida.contains("/usuarios/") || rutaPedida.contains("UsuarioController");
        String rol = (String) sesion.getAttribute("rol");
        if (esGestionUsuarios && !"ADMINISTRADOR".equalsIgnoreCase(rol)) {
            response.sendRedirect(contexto + "/common/sinPermiso.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
