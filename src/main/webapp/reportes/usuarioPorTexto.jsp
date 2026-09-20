<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reporte: usuarios por texto - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%@ include file="/common/menu.jspf" %>
<main class="contenido">
    <div class="tarjeta">
        <h1>Reporte: usuarios por texto en nombre o correo</h1>
        <form class="formulario" method="get" action="${pageContext.request.contextPath}/controllers/ReporteController.jsp">
            <input type="hidden" name="action" value="usuarioPorTexto">
            <div class="campo-completo">
                <label for="texto">Texto a buscar (nombre o dominio del correo)</label>
                <input type="text" id="texto" name="texto" value="${texto}" required>
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
        <c:if test="${empty resultado and not empty texto}">
            <p>No se encontraron usuarios con ese texto.</p>
        </c:if>
    </div>
</main>
</body>
</html>
