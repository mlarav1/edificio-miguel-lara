# Edificio App - Servlets/JSP (Ejercicio 13)

Aplicación web desarrollada con **Servlet API + JSP + JDBC** (sin frameworks MVC externos) para el ejercicio 13 (Edificio) de la actividad de Servlets/JSP.

## Datos del estudiante

- Nombre: Miguel Lara
- Código: 7502510046
- Semestre: Cuarto (4)
- Universidad: Universidad de Cartagena, Ingeniería de Software
- Asignatura: Desarrollo Web
- Ejercicio asignado: 13 - Edificio

## Guía utilizada

Los dos PDF de la guía del profesor (enlaces de Google Drive) requieren permisos de acceso que no se pudieron obtener automáticamente. Por eso este proyecto sigue el **plan de respaldo** descrito en el encargo: controladores JSP (`UsuarioController.jsp`, `EdificioController.jsp`, `LoginController.jsp`, `ReporteController.jsp`, `RecuperarClaveController.jsp`) que reciben un parámetro `action` y usan un `switch` para despachar cada operación, con métodos privados declarados con `<%! ... %>`. Ver `PENDIENTES.md` si se necesita comparar contra la guía real más adelante.

## Arquitectura y paquetes

```
src/main/java/com/miguellara/edificio/
├── domain/model/            Usuario, Edificio (entidades)
├── infrastructure/database/ ConexionBD (conexión JDBC)
├── infrastructure/persistence/ UsuarioDAO, EdificioDAO (acceso a datos, PreparedStatement)
├── business/exceptions/     PersistenciaException, ValidacionException, AutenticacionException
├── business/services/       UsuarioService, EdificioService, CorreoService, HashService
└── web/                     SesionFilter (protección de páginas y control por rol)

src/main/webapp/
├── controllers/  *.jsp con el switch(action) de cada entidad
├── usuarios/     listar.jsp, formulario.jsp
├── edificios/    listar.jsp, formulario.jsp
├── reportes/     4 reportes parametrizados
├── common/       menú, error y sin-permiso
└── css/          estilos propios
```

Los nombres de paquete se usan en minúscula (`domain.model`, `infrastructure.persistence`, etc.) siguiendo la convención de Java; las capas son exactamente las que describe la guía de respaldo.

## Entidades

**Usuario**: `id` (correo electrónico, también usado como login y como destino de la recuperación de clave), `clave` (hash BCrypt), `nombre`, `rol` (`ADMINISTRADOR` o `USUARIO`). Se usa el correo como `id` para no necesitar una columna adicional y así la recuperación de clave por correo es directa.

**Edificio**: `id` (clave técnica autoincremental, no forma parte de los atributos del ejercicio), `nombre`, `metrosCuadrados`, `altura`, `numPisos`, `numApartamentos`, `numOficinas`, `nombreParqueadero`, `numPiscinas`, `pais`, `departamento`, `ciudad`, `tieneAscensor`, `valorAdministracion`, `tieneZonaSocial`.

## Requisitos funcionales cubiertos

1. Base de datos MySQL (`db/schema.sql`, `db/data.sql`) con 3 usuarios de distintos roles y 10 edificios de ciudades colombianas.
2. CRUD completo de Usuario y Edificio con validaciones.
3. Cuatro reportes parametrizados:
   - Edificio: por ciudad y rango de pisos; por rango de valor de administración con filtro opcional de ascensor y zona social.
   - Usuario: por rol; por texto en nombre o correo.
4. Login contra la tabla `usuario`, `HttpSession`, cierre de sesión, `SesionFilter` que protege `/usuarios/*`, `/edificios/*`, `/reportes/*` y redirige al login sin sesión, y restringe la gestión de usuarios al rol `ADMINISTRADOR`.
5. Recuperación de clave por correo (Jakarta Mail / Angus Mail): genera una clave temporal aleatoria, la guarda con hash BCrypt y la envía. **Por qué BCrypt**: incorpora la sal automáticamente y permite ajustar el costo computacional, algo que un hash simple (MD5/SHA-256 solo) no ofrece.
6. Interfaz propia con CSS responsive básico (`css/estilos.css`), sin frameworks de UI externos.
7. Todas las consultas usan `PreparedStatement` y cierran sus recursos con try-with-resources; hay páginas de error amigables (`common/error.jsp`, `common/sinPermiso.jsp`).
8. Comentarios en los puntos clave: controladores, acceso a datos y verificación de sesión.

## Configuración y variables de entorno

Copia `.env.example` y define las variables en tu entorno o en el panel del hosting:

- `DB_URL`, `DB_USUARIO`, `DB_CLAVE`: conexión JDBC a MySQL.
- `SMTP_HOST`, `SMTP_PORT`, `SMTP_USUARIO`, `SMTP_CLAVE`, `SMTP_REMITENTE`: envío de correo real. **Si `SMTP_HOST` está vacío**, `CorreoService` cae a un modo de prueba que solo escribe el correo (con la clave temporal) en el log del servidor, para poder desarrollar sin credenciales SMTP.

## Ejecución local

Requisitos: JDK 17+, Maven 3.9+, MySQL 8+.

```bash
# 1. Crear la base de datos y cargar los datos de prueba
mysql -u root -p < db/schema.sql
mysql -u root -p < db/data.sql

# 2. Configurar variables de entorno (o exportarlas en la terminal)
cp .env.example .env

# 3. Compilar y empaquetar
mvn clean package

# 4. Ejecutar en Tomcat (usando el plugin embebido)
mvn tomcat7:run
# la app queda en http://localhost:8080/edificio
```

## Usuarios de prueba

| Correo | Clave | Rol |
|---|---|---|
| admin@correo.com | Admin2026* | ADMINISTRADOR |
| supervisor@correo.com | Usuario2026* | USUARIO |
| residente@correo.com | Residente2026* | USUARIO |

## Despliegue

Ver `Dockerfile` (build multi-stage con Maven + Tomcat 10). Detalles de la plataforma elegida, la URL pública y si el plan gratuito duerme el servicio se documentan en `PENDIENTES.md` a medida que se completa el despliegue.

## Documentos de la actividad

- `docs/capturas/`: capturas de la aplicación funcionando.
- `docs/capturas-codigo/`: capturas de código con resaltado de sintaxis.
- `docs/guia-sustentacion.md`: preguntas y respuestas de estudio.
- `PENDIENTES.md`: estado y pendientes del proyecto.
