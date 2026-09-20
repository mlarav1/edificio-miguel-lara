<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reporte: usuarios por rol - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%@ include file="/common/menu.jspf" %>
<main class="contenido">
    <div class="tarjeta">
        <h1>Reporte: usuarios por rol</h1>
        <form class="formulario" method="get" action="${pageContext.request.contextPath}/controllers/ReporteController.jsp">
            <input type="hidden" name="action" value="usuarioPorRol">
            <div>
                <label for="rol">Rol</label>
                <select id="rol" name="rol" required>
                    <option value="ADMINISTRADOR" ${rolReporte == 'ADMINISTRADOR' ? 'selected' : ''}>ADMINISTRADOR</option>
                    <option value="USUARIO" ${rolReporte == 'USUARIO' ? 'selected' : ''}>USUARIO</option>
                </select>
            </div>
            <div class="campo-completo">
                <button class="boton" type="submit">Generar reporte</button>
            </div>
        </form>

        <c:if test="${not empty resultado}">
            <h2>Resultados</h2>
            <table>
                <thead><tr><th>Correo (id)</th><th>Nombre</th><th>Rol</th></tr></thead>
                <tbody>
                <c:forEach var="u" items="${resultado}">
                    <tr><td>${u.id}</td><td>${u.nombre}</td><td>${u.rol}</td></tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty resultado and not empty rolReporte}">
            <p>No se encontraron usuarios con ese rol.</p>
        </c:if>
    </div>
</main>
</body>
</html>
