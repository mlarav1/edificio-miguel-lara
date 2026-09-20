<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Formulario de usuario - Edificio App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<%@ include file="/common/menu.jspf" %>
<main class="contenido">
    <div class="tarjeta">
        <h1>${empty usuario.id ? 'Nuevo usuario' : 'Editar usuario'}</h1>

        <c:if test="${not empty error}"><p class="mensaje-error">${error}</p></c:if>

        <form class="formulario" method="post" action="${pageContext.request.contextPath}/controllers/UsuarioController.jsp">
            <input type="hidden" name="action" value="${empty usuario.id ? 'crear' : 'actualizar'}">

            <div class="campo-completo">
                <label for="id">Correo institucional (id)</label>
                <input type="email" id="id" name="id" value="${usuario.id}" ${not empty usuario.id ? 'readonly' : ''} required>
            </div>
            <div class="campo-completo">
                <label for="nombre">Nombre completo</label>
                <input type="text" id="nombre" name="nombre" value="${usuario.nombre}" required>
            </div>
            <div>
                <label for="rol">Rol</label>
                <select id="rol" name="rol" required>
                    <option value="USUARIO" ${usuario.rol == 'USUARIO' ? 'selected' : ''}>USUARIO</option>
                    <option value="ADMINISTRADOR" ${usuario.rol == 'ADMINISTRADOR' ? 'selected' : ''}>ADMINISTRADOR</option>
                </select>
            </div>
            <div>
                <label for="clave">
                    Clave ${empty usuario.id ? '' : '(dejar en blanco para no cambiarla)'}
                </label>
                <input type="password" id="clave" name="clave" ${empty usuario.id ? 'required' : ''}>
            </div>

            <div class="campo-completo">
                <button class="boton" type="submit">Guardar</button>
                <a class="boton" style="background:#6c757d;" href="${pageContext.request.contextPath}/controllers/UsuarioController.jsp?action=listar">Cancelar</a>
            </div>
        </form>
    </div>
</main>
</body>
</html>
