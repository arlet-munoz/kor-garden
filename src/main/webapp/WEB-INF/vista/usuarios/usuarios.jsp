<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-usuarios.css">
    <title>Administración de Usuarios</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
    <script>
        window.onload = function() {
            <c:if test="${not empty mensajeAlerta}">
                alert("${mensajeAlerta}");
            </c:if>
        }
    </script>
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>Administración de Usuarios</h1>
                <p>Gestiona el catálogo completo de usuarios del sistema</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="acciones-superiores">
            <a href="/usuarios/nuevo" class="boton"><i class="fa-solid fa-plus"></i> Agregar Nuevo Usuario</a>
            <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
        </div>
        
        <div class="tabla-contenedor">
            <table class="tabla-usuarios">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Usuario</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Rol</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="usuario" items="${usuarios}">
                        <tr>
                            <td class="nombre-usuario">${usuario.nombre}</td>
                            <td class="nombre-usuario">${usuario.apellido}</td>
                            <td class="nombre-usuario">${usuario.user}</td>
                            <td class="email-usuario">${usuario.email}</td>
                            <td>${usuario.telefono}</td>
                            <td class="rol-usuario">
                                <c:forEach var="rol" items="${roles}">
                                    <c:if test="${usuario.idRol == rol.idRol}">
                                        ${rol.tipo}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td class="acciones-celda">
                                <a href="/usuarios/editar?idUsuario=${usuario.idUsuario}" class="boton"><i class="fa-solid fa-edit"></i> Editar</a>
                                <form action="/usuarios/eliminar" method="post" class="formulario-eliminar">
                                    <input type="hidden" name="idUsuario" value="${usuario.idUsuario}">
                                    <button type="submit" class="boton" onclick="return confirm('¿Estás seguro de eliminar este usuario?')"><i class="fa-solid fa-trash"></i> Eliminar</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>
</html>