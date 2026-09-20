<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Usuarios - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%@ include file="/common/menu.jspf" %>
<main class="contenido">
    <div class="tarjeta">
        <h1>Usuarios</h1>

        <c:if test="${param.exito == 'creado'}"><p class="mensaje-exito">Usuario creado correctamente.</p></c:if>
        <c:if test="${param.exito == 'actualizado'}"><p class="mensaje-exito">Usuario actualizado correctamente.</p></c:if>
        <c:if test="${param.exito == 'eliminado'}"><p class="mensaje-exito">Usuario eliminado correctamente.</p></c:if>

        <a class="boton" href="${pageContext.request.contextPath}/usuarios/formulario.jsp">Nuevo usuario</a>

        <table>
            <thead>
            <tr>
                <th>Correo (id)</th>
                <th>Nombre</th>
                <th>Rol</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="u" items="${usuarios}">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.nombre}</td>
                    <td>${u.rol}</td>
                    <td class="acciones-tabla">
                        <a href="${pageContext.request.contextPath}/controllers/UsuarioController.jsp?action=editar&id=${u.id}">Editar</a>
                        <a href="${pageContext.request.contextPath}/controllers/UsuarioController.jsp?action=eliminar&id=${u.id}"
                           onclick="return confirm('Deseas eliminar este usuario?');">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty usuarios}">
                <tr><td colspan="4">No hay usuarios registrados.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
