<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Sin permiso - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%@ include file="menu.jspf" %>
<main class="contenido">
    <div class="tarjeta">
        <h1>No tienes permiso para ver esta pagina</h1>
        <p class="mensaje-error">Esta seccion es exclusiva para usuarios con rol ADMINISTRADOR.</p>
        <a class="boton" href="${pageContext.request.contextPath}/controllers/EdificioController.jsp?action=listar">Volver a Edificios</a>
    </div>
</main>
</body>
</html>
