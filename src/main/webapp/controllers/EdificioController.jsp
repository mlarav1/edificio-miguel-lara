<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.miguellara.edificio.business.services.EdificioService" %>
<%@ page import="com.miguellara.edificio.business.exceptions.ValidacionException" %>
<%@ page import="com.miguellara.edificio.business.exceptions.PersistenciaException" %>
<%@ page import="com.miguellara.edificio.domain.model.Edificio" %>
<%@ page import="java.math.BigDecimal" %>
<%!
    // Metodos privados del controlador, como indica la guia "CRUD JSP".
    private EdificioService edificioService = new EdificioService();

    private Edificio leerFormulario(jakarta.servlet.http.HttpServletRequest request) {
        Edificio edificio = new Edificio();
        String idTexto = request.getParameter("id");
        if (idTexto != null && !idTexto.isBlank()) {
            edificio.setId(Integer.parseInt(idTexto));
        }
        edificio.setNombre(request.getParameter("nombre"));
        edificio.setMetrosCuadrados(parseDecimal(request.getParameter("metrosCuadrados")));
        edificio.setAltura(parseDecimal(request.getParameter("altura")));
        edificio.setNumPisos(parseEntero(request.getParameter("numPisos")));
        edificio.setNumApartamentos(parseEntero(request.getParameter("numApartamentos")));
        edificio.setNumOficinas(parseEntero(request.getParameter("numOficinas")));
        edificio.setNombreParqueadero(request.getParameter("nombreParqueadero"));
        edificio.setNumPiscinas(parseEntero(request.getParameter("numPiscinas")));
        edificio.setPais(request.getParameter("pais"));
        edificio.setDepartamento(request.getParameter("departamento"));
        edificio.setCiudad(request.getParameter("ciudad"));
        edificio.setTieneAscensor("on".equals(request.getParameter("tieneAscensor")));
        edificio.setValorAdministracion(parseDecimal(request.getParameter("valorAdministracion")));
        edificio.setTieneZonaSocial("on".equals(request.getParameter("tieneZonaSocial")));
        return edificio;
    }

    private BigDecimal parseDecimal(String valor) {
        return (valor == null || valor.isBlank()) ? BigDecimal.ZERO : new BigDecimal(valor);
    }

    private Integer parseEntero(String valor) {
        return (valor == null || valor.isBlank()) ? 0 : Integer.parseInt(valor);
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
                Edificio nuevo = leerFormulario(request);
                edificioService.crear(nuevo);
                response.sendRedirect(contexto + "/controllers/EdificioController.jsp?action=listar&exito=creado");
                break;
            }
            case "actualizar": {
                Edificio editado = leerFormulario(request);
                edificioService.actualizar(editado);
                response.sendRedirect(contexto + "/controllers/EdificioController.jsp?action=listar&exito=actualizado");
                break;
            }
            case "eliminar": {
                int id = Integer.parseInt(request.getParameter("id"));
                edificioService.eliminar(id);
                response.sendRedirect(contexto + "/controllers/EdificioController.jsp?action=listar&exito=eliminado");
                break;
            }
            case "editar": {
                int id = Integer.parseInt(request.getParameter("id"));
                Edificio edificio = edificioService.buscarPorId(id);
                request.setAttribute("edificio", edificio);
                request.getRequestDispatcher("/edificios/formulario.jsp").forward(request, response);
                break;
            }
            case "listar":
            default: {
                request.setAttribute("edificios", edificioService.listarTodos());
                request.getRequestDispatcher("/edificios/listar.jsp").forward(request, response);
                break;
            }
        }
    } catch (ValidacionException e) {
        request.setAttribute("error", e.getMessage());
        request.setAttribute("edificio", leerFormulario(request));
        request.getRequestDispatcher("/edificios/formulario.jsp").forward(request, response);
    } catch (PersistenciaException e) {
        request.setAttribute("error", "Error de base de datos: " + e.getMessage());
        request.getRequestDispatcher("/common/error.jsp").forward(request, response);
    }
%>
