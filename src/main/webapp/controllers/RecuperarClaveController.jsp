<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.miguellara.edificio.business.services.UsuarioService" %>
<%!
    private UsuarioService usuarioService = new UsuarioService();
%>
<%
    String correo = request.getParameter("correo");
    usuarioService.recuperarClave(correo);
    response.sendRedirect(request.getContextPath() + "/login.jsp?recuperado=1");
%>
