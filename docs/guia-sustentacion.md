# Guía breve de sustentación

Preguntas probables sobre el proyecto y respuestas apoyadas en el código real.

## Arquitectura y patrones

**¿Qué patrón de capas usaste?**
Un esquema de capas inspirado en la guía "CRUD JSP": `domain.model` para las entidades (`Usuario.java`, `Edificio.java`), `infrastructure.database` para la conexión JDBC (`ConexionBD.java`), `infrastructure.persistence` para el acceso a datos con `PreparedStatement` (`UsuarioDAO.java`, `EdificioDAO.java`), `business.exceptions` para las excepciones propias y `business.services` para la lógica de negocio y validaciones (`UsuarioService.java`, `EdificioService.java`).

**¿Por qué un controlador JSP con `switch` y no un Servlet clásico?**
Porque la guía de respaldo que seguí (sección 3 del encargo) define exactamente ese patrón: un `.jsp` por entidad que recibe `action` como parámetro y despacha con `switch`, con métodos auxiliares privados declarados con `<%! ... %>` dentro del mismo archivo. Está en `controllers/EdificioController.jsp` y `controllers/UsuarioController.jsp`.

**¿Dónde está el patrón DAO?**
En `infrastructure.persistence`. Cada DAO expone métodos `crear`, `buscarPorId`, `listarTodos`, `actualizar`, `eliminar` y los métodos de reporte, todos usando `PreparedStatement` para evitar inyección SQL.

## Flujo de una petición completa

1. El navegador envía un formulario (por ejemplo `edificios/formulario.jsp`) por POST a `controllers/EdificioController.jsp?action=crear`.
2. El controlador JSP lee los parámetros con `leerFormulario(request)`, construye un objeto `Edificio` y llama a `EdificioService.crear(edificio)`.
3. `EdificioService` valida los datos (`validar(...)`) y, si son correctos, llama a `EdificioDAO.crear(edificio)`.
4. `EdificioDAO` abre una conexión con `ConexionBD.obtenerConexion()`, ejecuta el `INSERT` con `PreparedStatement` y cierra los recursos automáticamente (try-with-resources).
5. El controlador redirige a `edificios/listar.jsp`, que vuelve a pedir la lista actualizada.

## Sesión y control de acceso

**¿Cómo se protege una página interna?**
`web/SesionFilter.java` es un `Filter` mapeado a `/edificios/*`, `/usuarios/*`, `/reportes/*` y `/controllers/*` (salvo login y recuperación de clave). Si no hay `HttpSession` con el atributo `usuario`, redirige a `login.jsp`.

**¿Cómo se restringe la gestión de usuarios al administrador?**
El mismo filtro revisa `sessionScope.rol`: si la ruta pedida es de usuarios y el rol no es `ADMINISTRADOR`, redirige a `common/sinPermiso.jsp`. Además, el menú (`common/menu.jspf`) solo muestra los enlaces de usuarios cuando `sessionScope.rol == 'ADMINISTRADOR'`.

## Reportes

Los cuatro reportes están en `ReporteController.jsp`, cada uno con su propio `case` en el `switch`: `edificioPorCiudad`, `edificioPorAdministracion`, `usuarioPorRol`, `usuarioPorTexto`. Todos delegan en el service correspondiente, que arma la consulta parametrizada en el DAO (`EdificioDAO.reportePorCiudadYPisos`, `EdificioDAO.reportePorAdministracion`, `UsuarioDAO.reportePorRol`, `UsuarioDAO.reportePorTexto`).

## Recuperación de clave

`UsuarioService.recuperarClave(correo)` busca el usuario, genera una clave temporal aleatoria (`generarClaveTemporal`), la guarda con hash BCrypt (`HashService.hashear`) y la envía con `CorreoService.enviarClaveTemporal`. Se eligió BCrypt porque agrega sal automáticamente y permite ajustar el costo, a diferencia de un hash simple.

## Commits

`git log` muestra la evolución real del proyecto: configuración inicial, script de base de datos, modelo, acceso a datos, CRUD de cada entidad, login y sesión, control de acceso, reportes, recuperación de clave, ajustes de interfaz, README y despliegue.
