<%@ page contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ocurrio un error - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<main class="contenido">
    <div class="tarjeta">
        <h1>Ocurrio un error</h1>
        <p class="mensaje-error">
            No fue posible completar la operacion solicitada. Intenta de nuevo o vuelve al inicio.
        </p>
        <a class="boton" href="${pageContext.request.contextPath}/index.jsp">Volver al inicio</a>
    </div>
</main>
</body>
</html>
