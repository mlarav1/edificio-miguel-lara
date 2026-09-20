# Pendientes

Este archivo se actualiza a medida que avanza el proyecto. Lista lo que falta conectar o decidir.

## Datos de la actividad

- [x] **URL del repositorio en GitHub**: https://github.com/mlarav1/edificio-miguel-lara
- [x] **Correo institucional del autor de los commits**: `mlarav1@unicartagena.edu.co`

## Accesos externos que faltan

- [x] **GitHub**: autenticado con la cuenta institucional (`gh`/`git`), repositorio creado y con push realizado.
- [x] **Hosting**: cuenta de Render creada (login con GitHub), base de datos PostgreSQL gratuita creada (`edificio-db`) y Web Service desplegado desde el repositorio con el `Dockerfile`. Ver sección "Despliegue" más abajo.
- [ ] **SMTP real** para el envío de la clave temporal (p. ej. contraseña de aplicación de Gmail). Mientras no llegue, `CorreoService` cae a un modo de prueba que solo escribe el correo en el log del servidor (ver `src/main/java/.../business/services/CorreoService.java`).
- [ ] **Guía del profesor en PDF**: los dos enlaces de Drive pidieron permiso de acceso y no se pudieron descargar (devolvieron una página HTML de aviso, no el PDF). Se usó el **plan de respaldo** (controladores JSP con `switch` sobre `action`, capas Domain.Model / Infrastructure.Database / Infrastructure.Persistence / Business.Exceptions / Business.Services). Si se consigue el contenido real de la guía, ajustar la arquitectura si difiere.

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
- [x] Historial de commits real en `main` (más de 25 commits, un solo autor: Miguel Lara).
- [x] Verificación de contribuidores: `gh api repos/mlarav1/edificio-miguel-lara/contributors` solo lista a `mlarav1`.
- [x] **Despliegue en Render** con base de datos PostgreSQL accesible desde internet: https://edificio-miguel-lara.onrender.com (verificado con login real, CRUD y datos reales cargados en producción).
- [x] Documento Word (.docx) de evidencias: `docs/evidencias-edificio-miguel-lara.docx`.
- [ ] PDF de entrega (ficha) con hipervínculos.
- [ ] Video de sustentación (grabación personal, tarea exclusiva del estudiante).

## Bugs reales encontrados y corregidos durante las pruebas

Probar de punta a punta contra un Tomcat y una base de datos reales (no solo compilar) sacó a la luz 3 errores que una simple compilación no detecta. Quedan corregidos en el código actual:

1. **`LoginController.jsp` no compilaba**: un comentario mencionaba literalmente `<%! %>`, y el `%>` dentro del comentario cerraba la etiqueta de declaración JSP antes de tiempo, dejando el campo `usuarioService` fuera de la clase generada. Se reescribió el comentario sin usar esos caracteres.
2. **Los listados de Edificio y Usuario aparecían vacíos** después del login o al usar el menú: varios enlaces y redirecciones apuntaban directo a `edificios/listar.jsp` / `usuarios/listar.jsp` (la vista) en vez de pasar por `EdificioController.jsp?action=listar` / `UsuarioController.jsp?action=listar` (el controlador que carga los datos), así que la vista nunca recibía la lista. Se corrigieron todos los enlaces y redirecciones para pasar siempre por el controlador.
3. **El reporte "usuarios por rol" mostraba "No se encontraron usuarios" incluso sin enviar el formulario**: el atributo de request `rol` usado por el reporte tenía el mismo nombre que el atributo de sesión `rol` (el rol del usuario logueado), y en EL (`${rol}`) la búsqueda cae a session scope cuando no hay valor en request scope, generando un falso positivo. Se renombró el atributo del reporte a `rolReporte`.

## Entorno de pruebas local (no es parte del entregable, es solo para desarrollo)

Para probar de punta a punta en esta máquina se usó un entorno portátil sin instaladores de sistema (sin permisos de administrador):

- Apache Maven 3.9.9 y Apache Tomcat 10.1.31 (Tomcat 7 no sirve porque el proyecto usa `jakarta.*`, no `javax.*`).
- MariaDB portátil (ZIP, sin instalador ni servicio de Windows), corriendo en el puerto 3307 con los scripts `db/schema.sql` y `db/data.sql` cargados.
- Git portátil y GitHub CLI portátil para el control de versiones y la creación del repositorio.

Nada de esto se sube al repositorio ni es necesario para el despliegue final (que usa el hosting real con su propia base de datos).

## Despliegue

- **Aplicación**: https://edificio-miguel-lara.onrender.com (Render, Web Service gratuito desplegado desde `Dockerfile`, conectado directo al repositorio público de GitHub sin necesidad de instalar la GitHub App de Render).
- **Base de datos**: PostgreSQL gratuito de Render (`edificio-db`), con `db/schema.sql` y `db/data.sql` ya cargados y verificados.
- **Limitaciones del plan gratuito** (documentadas también en el README): el servicio web se duerme tras inactividad (primera petición puede tardar 50+ segundos), y la base de datos gratuita expira 30 días después de su creación si no se actualiza a un plan pago.
- Verificado en el navegador: login real contra la base de datos de producción, listado de los 10 edificios y 3 usuarios de prueba ya cargados.

## Decisiones técnicas tomadas sin consultar

- Motor de base de datos: **PostgreSQL** (se evaluó MySQL primero, pero al verificar el hosting elegido para el despliegue se confirmó que su plan gratuito solo ofrece PostgreSQL, no MySQL; se migró el proyecto completo antes de desplegar para usar el mismo motor en local y en producción).
- Paquetes en minúscula (`domain.model`, `infrastructure.database`, `infrastructure.persistence`, `business.exceptions`, `business.services`) siguiendo la convención de Java, en vez de `Domain.Model` con mayúsculas. La organización de capas es la misma que pide la guía.
- Claves de prueba de los 3 usuarios (documentadas en el README).
