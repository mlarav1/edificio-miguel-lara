<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Iniciar sesion - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<main class="contenido" style="max-width: 420px;">
    <div class="tarjeta">
        <h1>Edificio App</h1>
        <p>Ingresa con tu correo institucional y tu clave.</p>

        <c:if test="${param.motivo == 'sesion'}">
            <p class="mensaje-error">Tu sesion expiro o no has iniciado sesion. Ingresa de nuevo.</p>
        </c:if>
        <c:if test="${not empty error}">
            <p class="mensaje-error">${error}</p>
        </c:if>
        <c:if test="${param.recuperado == '1'}">
            <p class="mensaje-exito">Si el correo existe, se envio una clave temporal.</p>
        </c:if>

        <form class="formulario" method="post" action="${pageContext.request.contextPath}/controllers/LoginController.jsp">
            <input type="hidden" name="action" value="iniciarSesion">
            <div class="campo-completo">
                <label for="correo">Correo institucional</label>
                <input type="email" id="correo" name="correo" required autofocus>
            </div>
            <div class="campo-completo">
                <label for="clave">Clave</label>
                <input type="password" id="clave" name="clave" required>
            </div>
            <div class="campo-completo">
                <button class="boton" type="submit">Ingresar</button>
            </div>
        </form>
        <p style="margin-top: 1rem;">
            <a href="${pageContext.request.contextPath}/recuperarClave.jsp">Olvide mi clave</a>
        </p>
    </div>
</main>
</body>
</html>
