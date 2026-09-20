<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.miguellara.edificio.business.services.UsuarioService" %>
<%@ page import="com.miguellara.edificio.business.exceptions.ValidacionException" %>
<%@ page import="com.miguellara.edificio.business.exceptions.PersistenciaException" %>
<%@ page import="com.miguellara.edificio.domain.model.Usuario" %>
<%!
    // Metodos privados del controlador, como indica la guia "CRUD JSP".
    private UsuarioService usuarioService = new UsuarioService();

    private Usuario leerFormulario(jakarta.servlet.http.HttpServletRequest request) {
        Usuario usuario = new Usuario();
        usuario.setId(request.getParameter("id"));
        usuario.setNombre(request.getParameter("nombre"));
        usuario.setRol(request.getParameter("rol"));
        return usuario;
    }
%>
<%
    String contexto = request.getContextPath();
    String action = request.getParameter("action");
    if (action == null) {
        action = "listar";
    }

    try {
        switch (action) {
            case "crear": {
                Usuario nuevo = leerFormulario(request);
                String clave = request.getParameter("clave");
                usuarioService.crear(nuevo, clave);
                response.sendRedirect(contexto + "/controllers/UsuarioController.jsp?action=listar&exito=creado");
                break;
            }
            case "actualizar": {
                Usuario editado = leerFormulario(request);
                String claveNueva = request.getParameter("clave");
                usuarioService.actualizar(editado, claveNueva);
                response.sendRedirect(contexto + "/controllers/UsuarioController.jsp?action=listar&exito=actualizado");
                break;
            }
            case "eliminar": {
                String id = request.getParameter("id");
                usuarioService.eliminar(id);
                response.sendRedirect(contexto + "/controllers/UsuarioController.jsp?action=listar&exito=eliminado");
                break;
            }
            case "editar": {
                String id = request.getParameter("id");
                Usuario usuario = usuarioService.buscarPorId(id);
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("/usuarios/formulario.jsp").forward(request, response);
                break;
            }
            case "listar":
            default: {
                request.setAttribute("usuarios", usuarioService.listarTodos());
                request.getRequestDispatcher("/usuarios/listar.jsp").forward(request, response);
                break;
            }
        }
    } catch (ValidacionException e) {
        request.setAttribute("error", e.getMessage());
        request.setAttribute("usuario", leerFormulario(request));
        request.getRequestDispatcher("/usuarios/formulario.jsp").forward(request, response);
    } catch (PersistenciaException e) {
        request.setAttribute("error", "Error de base de datos: " + e.getMessage());
        request.getRequestDispatcher("/common/error.jsp").forward(request, response);
    }
%>
