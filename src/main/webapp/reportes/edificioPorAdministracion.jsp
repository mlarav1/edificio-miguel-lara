<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reporte: edificios por valor de administracion - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%@ include file="/common/menu.jspf" %>
<main class="contenido">
    <div class="tarjeta">
        <h1>Reporte: edificios por rango de valor de administracion</h1>
        <form class="formulario" method="get" action="${pageContext.request.contextPath}/controllers/ReporteController.jsp">
            <input type="hidden" name="action" value="edificioPorAdministracion">
            <div>
                <label for="valorMin">Valor minimo</label>
                <input type="number" step="0.01" id="valorMin" name="valorMin" value="${valorMin}" required>
            </div>
            <div>
                <label for="valorMax">Valor maximo</label>
                <input type="number" step="0.01" id="valorMax" name="valorMax" value="${valorMax}" required>
            </div>
            <div>
                <label for="conAscensor">Con ascensor</label>
                <select id="conAscensor" name="conAscensor">
                    <option value="">Cualquiera</option>
                    <option value="true" ${conAscensor == true ? 'selected' : ''}>Si</option>
                    <option value="false" ${conAscensor == false ? 'selected' : ''}>No</option>
                </select>
            </div>
            <div>
                <label for="conZonaSocial">Con zona social</label>
                <select id="conZonaSocial" name="conZonaSocial">
                    <option value="">Cualquiera</option>
                    <option value="true" ${conZonaSocial == true ? 'selected' : ''}>Si</option>
                    <option value="false" ${conZonaSocial == false ? 'selected' : ''}>No</option>
                </select>
            </div>
            <div class="campo-completo">
                <button class="boton" type="submit">Generar reporte</button>
            </div>
        </form>

        <c:if test="${not empty resultado}">
            <h2>Resultados</h2>
            <table>
                <thead>
                <tr><th>Nombre</th><th>Ciudad</th><th>Ascensor</th><th>Zona social</th><th>Valor admin.</th></tr>
                </thead>
                <tbody>
                <c:forEach var="e" items="${resultado}">
                    <tr>
                        <td>${e.nombre}</td>
                        <td>${e.ciudad}</td>
                        <td>${e.tieneAscensor ? 'Si' : 'No'}</td>
                        <td>${e.tieneZonaSocial ? 'Si' : 'No'}</td>
                        <td>${e.valorAdministracion}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty resultado and not empty valorMin}">
            <p>No se encontraron edificios con esos parametros.</p>
        </c:if>
    </div>
</main>
</body>
</html>
