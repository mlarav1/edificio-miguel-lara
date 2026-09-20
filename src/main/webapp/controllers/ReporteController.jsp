<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.miguellara.edificio.business.services.EdificioService" %>
<%@ page import="com.miguellara.edificio.business.services.UsuarioService" %>
<%@ page import="com.miguellara.edificio.business.exceptions.ValidacionException" %>
<%@ page import="com.miguellara.edificio.business.exceptions.PersistenciaException" %>
<%@ page import="java.math.BigDecimal" %>
<%!
    // Metodos privados del controlador, como indica la guia "CRUD JSP".
    private EdificioService edificioService = new EdificioService();
    private UsuarioService usuarioService = new UsuarioService();

    private Boolean leerBooleanoOpcional(String valor) {
        if (valor == null || valor.isBlank()) {
            return null;
        }
        return "true".equalsIgnoreCase(valor);
    }
%>
<%
    String action = request.getParameter("action");
    if (action == null) {
        action = "";
    }

    try {
        switch (action) {
            case "edificioPorCiudad": {
                String ciudad = request.getParameter("ciudad");
                int pisosMin = Integer.parseInt(request.getParameter("pisosMin"));
                int pisosMax = Integer.parseInt(request.getParameter("pisosMax"));
                request.setAttribute("resultado", edificioService.reportePorCiudadYPisos(ciudad, pisosMin, pisosMax));
                request.setAttribute("ciudad", ciudad);
                request.setAttribute("pisosMin", pisosMin);
                request.setAttribute("pisosMax", pisosMax);
                request.getRequestDispatcher("/reportes/edificioPorCiudad.jsp").forward(request, response);
                break;
            }
            case "edificioPorAdministracion": {
                BigDecimal valorMin = new BigDecimal(request.getParameter("valorMin"));
                BigDecimal valorMax = new BigDecimal(request.getParameter("valorMax"));
                Boolean conAscensor = leerBooleanoOpcional(request.getParameter("conAscensor"));
                Boolean conZonaSocial = leerBooleanoOpcional(request.getParameter("conZonaSocial"));
                request.setAttribute("resultado",
                        edificioService.reportePorAdministracion(valorMin, valorMax, conAscensor, conZonaSocial));
                request.setAttribute("valorMin", valorMin);
                request.setAttribute("valorMax", valorMax);
                request.setAttribute("conAscensor", conAscensor);
                request.setAttribute("conZonaSocial", conZonaSocial);
                request.getRequestDispatcher("/reportes/edificioPorAdministracion.jsp").forward(request, response);
                break;
            }
            case "usuarioPorRol": {
                String rol = request.getParameter("rol");
                request.setAttribute("resultado", usuarioService.reportePorRol(rol));
                request.setAttribute("rolReporte", rol);
                request.getRequestDispatcher("/reportes/usuarioPorRol.jsp").forward(request, response);
                break;
            }
            case "usuarioPorTexto": {
                String texto = request.getParameter("texto");
                request.setAttribute("resultado", usuarioService.reportePorTexto(texto));
                request.setAttribute("texto", texto);
                request.getRequestDispatcher("/reportes/usuarioPorTexto.jsp").forward(request, response);
                break;
            }
            default:
                response.sendRedirect(request.getContextPath() + "/controllers/EdificioController.jsp?action=listar");
        }
    } catch (ValidacionException e) {
        request.setAttribute("error", e.getMessage());
        request.getRequestDispatcher("/common/error.jsp").forward(request, response);
    } catch (PersistenciaException e) {
        request.setAttribute("error", "Error de base de datos: " + e.getMessage());
        request.getRequestDispatcher("/common/error.jsp").forward(request, response);
    } catch (NumberFormatException e) {
        request.setAttribute("error", "Los parametros numericos del reporte no son validos.");
        request.getRequestDispatcher("/common/error.jsp").forward(request, response);
    }
%>
