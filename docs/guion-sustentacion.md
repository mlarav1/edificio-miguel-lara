# Guion de sustentación (primera persona, para leer en cámara)

Tiempos aproximados sobre un total de 8 a 10 minutos.

## 1. Presentación del ejercicio (0:00 - 0:45)

"Hola, soy Miguel Lara, código 7502510046, estudiante de cuarto semestre de Ingeniería de Software en la Universidad de Cartagena. Esta es la sustentación de la actividad de Servlets y JSP, el ejercicio 13, Edificio. Voy a mostrar la arquitectura, el flujo de una petición completa, el login con sesión, el CRUD de las dos entidades, los cuatro reportes, la recuperación de clave y la aplicación desplegada."

## 2. Arquitectura y patrones (0:45 - 2:15)

"El proyecto sigue una arquitectura por capas: en el paquete `domain.model` están mis dos entidades, Usuario y Edificio. En `infrastructure.database` está la clase `ConexionBD`, que centraliza la conexión JDBC. En `infrastructure.persistence` están los DAO, `UsuarioDAO` y `EdificioDAO`, que usan `PreparedStatement` para todas las consultas. En `business.services` está la lógica de negocio y las validaciones, por ejemplo `EdificioService` y `UsuarioService`. Y en `business.exceptions` están mis excepciones propias.

Para la capa web usé el patrón de la guía: un controlador JSP por entidad, `EdificioController.jsp` y `UsuarioController.jsp`, que reciben un parámetro `action` y usan un `switch` para decidir qué operación ejecutar: crear, listar, actualizar, eliminar o editar."

## 3. Recorrido de una operación completa (2:15 - 3:30)

"Voy a crear un edificio nuevo. [mostrar formulario y guardar] El navegador envía el formulario por POST al controlador `EdificioController.jsp` con `action=crear`. El controlador lee los datos con el método privado `leerFormulario`, construye el objeto Edificio y se lo pasa a `EdificioService.crear`, que valida los datos, por ejemplo que los metros cuadrados sean mayores a cero. Si todo está bien, llama a `EdificioDAO.crear`, que ejecuta un INSERT con PreparedStatement y me devuelve el id generado. Finalmente el controlador redirige al listado, que vuelve a consultar la base de datos y muestra el edificio nuevo."

## 4. Login y sesión (3:30 - 4:30)

"[mostrar login] Cuando inicio sesión, `LoginController.jsp` llama a `UsuarioService.iniciarSesion`, que busca el usuario por su correo y compara la clave con el hash guardado usando BCrypt. Si coincide, guardo el correo y el rol en la `HttpSession`. Todas las páginas internas están protegidas por un filtro, `SesionFilter`, que revisa si hay sesión activa; si no la hay, redirige al login. Ese mismo filtro revisa el rol: solo un administrador puede entrar a la gestión de usuarios."

## 5. CRUD de las dos entidades (4:30 - 6:00)

"[mostrar listar, editar, eliminar de Edificio y de Usuario] Aquí está el listado de edificios con las acciones de editar y eliminar. Y aquí la gestión de usuarios, que solo ve el administrador."

## 6. Reportes (6:00 - 7:00)

"Tengo cuatro reportes parametrizados. Dos de Edificio: por ciudad y rango de número de pisos, y por rango de valor de administración con filtro de ascensor y zona social. Y dos de Usuario: por rol, y por texto contenido en el nombre o el correo. [mostrar cada uno con resultados]"

## 7. Recuperación de clave (7:00 - 7:45)

"[mostrar formulario de recuperación] Cuando el usuario ingresa su correo, `UsuarioService.recuperarClave` genera una clave temporal aleatoria, la guarda con hash BCrypt y la envía por correo. Elegí BCrypt porque agrega la sal automáticamente y permite ajustar el costo del hash, algo que un hash simple no ofrece."

## 8. Aplicación desplegada (7:45 - 8:30)

"[mostrar la URL pública] Aquí está la aplicación funcionando en internet, en la misma base de datos MySQL que usé en local."

## 9. Revisión del historial de commits (8:30 - 9:00)

"[mostrar git log] Y aquí está el historial de commits, que muestra la evolución del proyecto desde la configuración inicial hasta el despliegue."
