# Portal de Gestion de Clientes y Licencias - AUTODEV

Aplicacion web Java EE desarrollada para el curso Desarrollo Web Integrado (UTP).
Permite registrar clientes, asignar licencias anuales de los productos de AUTODEV
y controlar los vencimientos proximos.

- Alumno: Anthony Flores - U24221515
- Curso: Desarrollo Web Integrado (1000005154)
- Evaluacion: Avance de Proyecto Final 1

## Requisitos

| Componente | Version |
|---|---|
| JDK | 21 |
| Apache Maven | 3.9+ |
| Apache Tomcat | 10.1 |
| MySQL | 8.0 o superior |

## Base de datos

Ejecutar los scripts en orden desde la carpeta `basedatos`:

```
mysql -u root -p < basedatos/01_esquema.sql
mysql -u root -p < basedatos/02_datos.sql
```

Esto crea el esquema `autodev_db` con las tablas `usuario`, `cliente`, `producto`,
`licencia` y `pago`, junto con datos de prueba.

## Configuracion de la conexion

Los parametros JDBC estan en `src/main/java/pe/utp/autodev/conexion/ConexionBD.java`.
Ajustar usuario y clave segun la instalacion local de MySQL.

## Compilacion y despliegue

```
mvn clean package
```

Copiar `target/autodev-portal.war` a la carpeta `webapps` de Tomcat y arrancar el servidor.

Aplicacion disponible en: `http://localhost:8080/autodev-portal/`

## Credenciales de acceso

| Correo | Clave | Rol |
|---|---|---|
| admin@autodev.pe | admin123 | Administrador |
| ventas@autodev.pe | ventas123 | Vendedor |

## Pantallas

| Vista | Ruta | Descripcion |
|---|---|---|
| Acceso | `login.jsp` | Autenticacion contra la tabla `usuario` |
| Panel | `DashboardServlet` | Indicadores de clientes, licencias y recaudacion |
| Clientes | `ClienteServlet` | Registro y listado de la cartera |
| Licencias | `LicenciaServlet` | Asignacion de licencias anuales por producto |
| Vencimientos | `VencimientoServlet` | Consulta de licencias proximas a vencer |
| Test JDBC | `testConexion.jsp` | Verificacion de la conexion con MySQL |

## Estructura

```
src/main/java/pe/utp/autodev/
    conexion/      ConexionBD.java
    modelo/        Usuario, Cliente, Producto, Licencia
    controlador/   Login, Logout, Dashboard, Cliente, Licencia, Vencimiento
src/main/webapp/
    partials/      header.jsp, footer.jsp
    css/           estilos.css
    *.jsp          vistas de la aplicacion
basedatos/         scripts SQL
```

## Tecnologias

HTML5, CSS3, JavaServer Pages, Servlets, JDBC con MySQL Connector/J,
empaquetado con Maven sobre Apache Tomcat.
