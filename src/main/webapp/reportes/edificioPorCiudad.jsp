<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reporte: edificios por ciudad y pisos - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%@ include file="/common/menu.jspf" %>
<main class="contenido">
    <div class="tarjeta">
        <h1>Reporte: edificios por ciudad y rango de pisos</h1>
        <form class="formulario" method="get" action="${pageContext.request.contextPath}/controllers/ReporteController.jsp">
            <input type="hidden" name="action" value="edificioPorCiudad">
            <div>
                <label for="ciudad">Ciudad</label>
                <input type="text" id="ciudad" name="ciudad" value="${ciudad}" required>
            </div>
            <div>
                <label for="pisosMin">Pisos minimo</label>
                <input type="number" id="pisosMin" name="pisosMin" value="${pisosMin}" required>
            </div>
            <div>
                <label for="pisosMax">Pisos maximo</label>
                <input type="number" id="pisosMax" name="pisosMax" value="${pisosMax}" required>
            </div>
            <div class="campo-completo">
                <button class="boton" type="submit">Generar reporte</button>
            </div>
        </form>

        <c:if test="${not empty resultado}">
            <h2>Resultados</h2>
            <table>
                <thead>
                <tr><th>Nombre</th><th>Ciudad</th><th>Pisos</th><th>Aptos</th><th>Oficinas</th><th>Valor admin.</th></tr>
                </thead>
                <tbody>
                <c:forEach var="e" items="${resultado}">
                    <tr>
                        <td>${e.nombre}</td>
                        <td>${e.ciudad}</td>
                        <td>${e.numPisos}</td>
                        <td>${e.numApartamentos}</td>
                        <td>${e.numOficinas}</td>
                        <td>${e.valorAdministracion}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty resultado and not empty ciudad}">
            <p>No se encontraron edificios con esos parametros.</p>
        </c:if>
    </div>
</main>
</body>
</html>
