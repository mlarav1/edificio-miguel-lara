<%@ page contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("usuario") != null) {
        response.sendRedirect(request.getContextPath() + "/controllers/EdificioController.jsp?action=listar");
    } else {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>
