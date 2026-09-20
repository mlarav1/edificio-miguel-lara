<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Recuperar clave - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<main class="contenido" style="max-width: 420px;">
    <div class="tarjeta">
        <h1>Recuperar clave</h1>
        <p>Ingresa tu correo institucional. Si existe una cuenta, te enviaremos una clave temporal.</p>
        <form class="formulario" method="post" action="${pageContext.request.contextPath}/controllers/RecuperarClaveController.jsp">
            <div class="campo-completo">
                <label for="correo">Correo institucional</label>
                <input type="email" id="correo" name="correo" required autofocus>
            </div>
            <div class="campo-completo">
                <button class="boton" type="submit">Enviar clave temporal</button>
            </div>
        </form>
        <p style="margin-top: 1rem;">
            <a href="${pageContext.request.contextPath}/login.jsp">Volver al login</a>
        </p>
    </div>
</main>
</body>
</html>
