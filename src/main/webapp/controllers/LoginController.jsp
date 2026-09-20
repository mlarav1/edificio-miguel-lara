<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.miguellara.edificio.business.services.UsuarioService" %>
<%@ page import="com.miguellara.edificio.business.exceptions.AutenticacionException" %>
<%@ page import="com.miguellara.edificio.domain.model.Usuario" %>
<%!
    // Metodos y atributos privados del controlador, segun la guia CRUD JSP.
    private UsuarioService usuarioService = new UsuarioService();
%>
<%
    String contexto = request.getContextPath();
    String action = request.getParameter("action");
    if (action == null) {
        action = "iniciarSesion";
    }

    switch (action) {
        case "iniciarSesion": {
            String correo = request.getParameter("correo");
            String clave = request.getParameter("clave");
            try {
                Usuario usuario = usuarioService.iniciarSesion(correo, clave);
                session.setAttribute("usuario", usuario.getId());
                session.setAttribute("nombreUsuario", usuario.getNombre());
                session.setAttribute("rol", usuario.getRol());
                response.sendRedirect(contexto + "/controllers/EdificioController.jsp?action=listar");
            } catch (AutenticacionException e) {
                request.setAttribute("error", e.getMessage());
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
            break;
        }
        case "cerrarSesion": {
            session.invalidate();
            response.sendRedirect(contexto + "/login.jsp");
            break;
        }
        default:
            response.sendRedirect(contexto + "/login.jsp");
    }
%>
