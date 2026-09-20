# Pendientes

Este archivo se actualiza a medida que avanza el proyecto. Lista lo que falta conectar o decidir con datos reales del estudiante.

## Datos que faltan (sección 0 del prompt)

- [ ] **URL del repositorio en GitHub**: pendiente de que Miguel lo cree y lo pase.
- [x] **Correo institucional del autor de los commits**: `mlarav1@unicartagena.edu.co` (confirmado por Miguel el 2026-09-19).

## Accesos que pidió Claude Code al inicio (sección 1 del prompt)

- [ ] **GitHub**: autenticación de `git`/`gh` con la cuenta institucional (token o `gh auth login`).
- [ ] **Hosting** (Render u otro con plan gratuito para Tomcat): acceso a la cuenta/token.
- [ ] **SMTP real** para el envío de la clave temporal (p. ej. contraseña de aplicación de Gmail). Mientras no llegue, `CorreoService` cae a un modo de prueba que solo escribe el correo en el log del servidor (ver `src/main/java/.../business/services/CorreoService.java`).
- [ ] **Guía del profesor en PDF**: los dos enlaces de Drive pidieron permiso de acceso y no se pudieron descargar (devolvieron una página HTML de aviso, no el PDF). Se usó el **plan de respaldo** descrito en la sección 3 del prompt (controladores JSP con `switch` sobre `action`, capas Domain.Model / Infrastructure.Database / Infrastructure.Persistence / Business.Exceptions / Business.Services). Si Miguel consigue el contenido real de la guía, avisar para ajustar la arquitectura si difiere.

## Estado del desarrollo

- [x] Estructura Maven + Servlet/JSP creada.
- [x] Entidades `Usuario` y `Edificio` (`domain.model`).
- [x] Acceso a datos JDBC con `PreparedStatement` (`infrastructure.persistence`).
- [x] Servicios de negocio con validaciones (`business.services`), hash de clave con BCrypt (`business.services.HashService`).
- [x] CRUD completo de Usuario y Edificio (controladores JSP + vistas).
- [x] Los 4 reportes parametrizados (2 de Edificio, 2 de Usuario).
- [x] Login, sesión, filtro de protección de páginas internas y control por rol (`web.SesionFilter`).
- [x] Recuperación de clave por correo (con modo de prueba local mientras no haya SMTP real).
- [x] Scripts `db/schema.sql` y `db/data.sql` con 3 usuarios y 10 edificios de ciudades colombianas.
- [x] El proyecto compila y empaqueta (`mvn package`) generando `target/edificio.war` sin errores.
- [x] **Pruebas de punta a punta en Tomcat 10 real contra MariaDB real**: verificado en el navegador (login, CRUD de las dos entidades, los 4 reportes, recuperación de clave con clave temporal real, cierre de sesión, protección de páginas sin sesión y control de acceso por rol). Ver "Entorno de pruebas local" más abajo.
- [x] Capturas de la aplicación funcionando (`docs/capturas/`): 14 imágenes (login, listado y CRUD de edificios, listado de usuarios, los 4 reportes con resultados, recuperación de clave, login con clave temporal, bloqueo por rol, bloqueo por sesión).
- [x] Capturas de código resaltado (`docs/capturas-codigo/`): 8 imágenes (entidad Usuario, entidad Edificio, EdificioDAO, EdificioController, listar.jsp de edificios, SesionFilter, ReporteController, recuperación de clave en UsuarioService).
- [ ] Despliegue en Render (o similar) con base de datos accesible desde Internet.
- [ ] Documento Word (.docx) de evidencias.
- [ ] PDF de entrega (ficha) con hipervínculos.
- [ ] Guion de sustentación en primera persona.
- [ ] `docs/guia-sustentacion.md` (preguntas y respuestas de estudio).
- [ ] Historial de commits real (20 a 30 commits) una vez se cree el repositorio.
- [ ] Verificación final de contribuidores (que solo aparezca Miguel Lara).

## Bugs reales encontrados y corregidos durante las pruebas

Probar de punta a punta contra un Tomcat y una base de datos reales (no solo compilar) sacó a la luz 3 errores que una simple compilación no detecta. Quedan corregidos en el código actual:

1. **`LoginController.jsp` no compilaba**: un comentario mencionaba literalmente `<%! %>`, y el `%>` dentro del comentario cerraba la etiqueta de declaración JSP antes de tiempo, dejando el campo `usuarioService` fuera de la clase generada. Se reescribió el comentario sin usar esos caracteres.
2. **Los listados de Edificio y Usuario aparecían vacíos** después del login o al usar el menú: varios enlaces y redirecciones apuntaban directo a `edificios/listar.jsp` / `usuarios/listar.jsp` (la vista) en vez de pasar por `EdificioController.jsp?action=listar` / `UsuarioController.jsp?action=listar` (el controlador que carga los datos), así que la vista nunca recibía la lista. Se corrigieron todos los enlaces y redirecciones para pasar siempre por el controlador.
3. **El reporte "usuarios por rol" mostraba "No se encontraron usuarios" incluso sin enviar el formulario**: el atributo de request `rol` usado por el reporte tenía el mismo nombre que el atributo de sesión `rol` (el rol del usuario logueado), y en EL (`${rol}`) la búsqueda cae a session scope cuando no hay valor en request scope, generando un falso positivo. Se renombró el atributo del reporte a `rolReporte`.

## Entorno de pruebas local (no es parte del entregable, es solo para desarrollo)

Como no había Java/Maven/Tomcat/base de datos instalados en esta máquina, ni fue posible instalar Docker Desktop sin una confirmación manual de UAC, se armó un entorno portátil sin instaladores de sistema:

- Apache Maven 3.9.9 descargado y extraído en `~/tools/apache-maven-3.9.9`.
- Apache Tomcat 10.1.31 descargado y extraído en `~/tools/apache-tomcat-10.1.31` (Tomcat 7 no sirve porque el proyecto usa `jakarta.*`, no `javax.*`).
- MariaDB 11.4.5 portátil (ZIP, sin instalador ni servicio de Windows) en `~/tools/mariadb-11.4.5-winx64`, corriendo en el puerto 3307 con los scripts `db/schema.sql` y `db/data.sql` ya cargados.
- Variables `DB_URL` (apuntando al puerto 3307), `DB_USUARIO` y `DB_CLAVE` configuradas en `~/tools/apache-tomcat-10.1.31/bin/setenv.bat`.

Nada de esto se sube al repositorio ni es necesario para el despliegue final (que usará el hosting real con su propia base de datos).

## Decisiones técnicas tomadas sin consultar (documentadas aquí y en el README)

- Motor de base de datos: **MySQL** (tiene planes gratuitos verificados en varios hosting compatibles con Tomcat, y es el más común en los cursos de la guía).
- Paquetes en minúscula (`domain.model`, `infrastructure.database`, `infrastructure.persistence`, `business.exceptions`, `business.services`) siguiendo la convención de Java, en vez de `Domain.Model` con mayúsculas tal como aparece literalmente en el prompt. La organización de capas es la misma que pide la guía.
- Claves de prueba de los 3 usuarios (documentadas en el README, no se inventaron valores de los datos del estudiante).
