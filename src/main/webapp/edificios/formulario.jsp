<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Formulario de edificio - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%@ include file="/common/menu.jspf" %>
<main class="contenido">
    <div class="tarjeta">
        <h1>${empty edificio.id ? 'Nuevo edificio' : 'Editar edificio'}</h1>

        <c:if test="${not empty error}"><p class="mensaje-error">${error}</p></c:if>

        <form class="formulario" method="post" action="${pageContext.request.contextPath}/controllers/EdificioController.jsp">
            <input type="hidden" name="action" value="${empty edificio.id ? 'crear' : 'actualizar'}">
            <c:if test="${not empty edificio.id}">
                <input type="hidden" name="id" value="${edificio.id}">
            </c:if>

            <div>
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" name="nombre" value="${edificio.nombre}" required>
            </div>
            <div>
                <label for="pais">Pais</label>
                <input type="text" id="pais" name="pais" value="${edificio.pais}" required>
            </div>
            <div>
                <label for="departamento">Departamento</label>
                <input type="text" id="departamento" name="departamento" value="${edificio.departamento}" required>
            </div>
            <div>
                <label for="ciudad">Ciudad</label>
                <input type="text" id="ciudad" name="ciudad" value="${edificio.ciudad}" required>
            </div>
            <div>
                <label for="metrosCuadrados">Metros cuadrados</label>
                <input type="number" step="0.01" id="metrosCuadrados" name="metrosCuadrados" value="${edificio.metrosCuadrados}" required>
            </div>
            <div>
                <label for="altura">Altura (m)</label>
                <input type="number" step="0.01" id="altura" name="altura" value="${edificio.altura}" required>
            </div>
            <div>
                <label for="numPisos">Numero de pisos</label>
                <input type="number" id="numPisos" name="numPisos" value="${edificio.numPisos}" required>
            </div>
            <div>
                <label for="numApartamentos">Numero de apartamentos</label>
                <input type="number" id="numApartamentos" name="numApartamentos" value="${edificio.numApartamentos}" required>
            </div>
            <div>
                <label for="numOficinas">Numero de oficinas</label>
                <input type="number" id="numOficinas" name="numOficinas" value="${edificio.numOficinas}" required>
            </div>
            <div>
                <label for="nombreParqueadero">Nombre del parqueadero</label>
                <input type="text" id="nombreParqueadero" name="nombreParqueadero" value="${edificio.nombreParqueadero}">
            </div>
            <div>
                <label for="numPiscinas">Numero de piscinas</label>
                <input type="number" id="numPiscinas" name="numPiscinas" value="${edificio.numPiscinas}" required>
            </div>
            <div>
                <label for="valorAdministracion">Valor de administracion</label>
                <input type="number" step="0.01" id="valorAdministracion" name="valorAdministracion" value="${edificio.valorAdministracion}" required>
            </div>
            <div>
                <label for="tieneAscensor">Tiene ascensor</label>
                <input type="checkbox" id="tieneAscensor" name="tieneAscensor" style="width:auto;" ${edificio.tieneAscensor ? 'checked' : ''}>
            </div>
            <div>
                <label for="tieneZonaSocial">Tiene zona social</label>
                <input type="checkbox" id="tieneZonaSocial" name="tieneZonaSocial" style="width:auto;" ${edificio.tieneZonaSocial ? 'checked' : ''}>
            </div>

            <div class="campo-completo">
                <button class="boton" type="submit">Guardar</button>
                <a class="boton" style="background:#6c757d;" href="${pageContext.request.contextPath}/controllers/EdificioController.jsp?action=listar">Cancelar</a>
            </div>
        </form>
    </div>
</main>
</body>
</html>
