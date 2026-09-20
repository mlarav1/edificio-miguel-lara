<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edificios - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%@ include file="/common/menu.jspf" %>
<main class="contenido">
    <div class="tarjeta">
        <h1>Edificios</h1>

        <c:if test="${param.exito == 'creado'}"><p class="mensaje-exito">Edificio creado correctamente.</p></c:if>
        <c:if test="${param.exito == 'actualizado'}"><p class="mensaje-exito">Edificio actualizado correctamente.</p></c:if>
        <c:if test="${param.exito == 'eliminado'}"><p class="mensaje-exito">Edificio eliminado correctamente.</p></c:if>

        <a class="boton" href="${pageContext.request.contextPath}/edificios/formulario.jsp">Nuevo edificio</a>

        <table>
            <thead>
            <tr>
                <th>Nombre</th>
                <th>Ciudad</th>
                <th>Pisos</th>
                <th>Aptos</th>
                <th>Oficinas</th>
                <th>Ascensor</th>
                <th>Zona social</th>
                <th>Valor admin.</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="e" items="${edificios}">
                <tr>
                    <td>${e.nombre}</td>
                    <td>${e.ciudad}</td>
                    <td>${e.numPisos}</td>
                    <td>${e.numApartamentos}</td>
                    <td>${e.numOficinas}</td>
                    <td>${e.tieneAscensor ? 'Si' : 'No'}</td>
                    <td>${e.tieneZonaSocial ? 'Si' : 'No'}</td>
                    <td><fmt:formatNumber value="${e.valorAdministracion}" type="currency" currencySymbol="$"/></td>
                    <td class="acciones-tabla">
                        <a href="${pageContext.request.contextPath}/controllers/EdificioController.jsp?action=editar&id=${e.id}">Editar</a>
                        <a href="${pageContext.request.contextPath}/controllers/EdificioController.jsp?action=eliminar&id=${e.id}"
                           onclick="return confirm('Deseas eliminar este edificio?');">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty edificios}">
                <tr><td colspan="9">No hay edificios registrados.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
