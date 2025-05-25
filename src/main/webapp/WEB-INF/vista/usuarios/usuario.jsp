<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-usuario.css">
    <title>${empty usuario ? 'Agregar Nuevo Usuario' : 'Editar Usuario'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>${empty usuario ? 'Agregar Nuevo Usuario' : 'Editar Usuario'}</h1>
                <p>Gestiona la información del usuario</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="formulario-contenedor">
            <h2 class="cajita-titulo">${empty usuario ? 'Nuevo Usuario' : 'Editar Usuario'}</h2>

            <%-- Mostrar mensaje si hay uno --%>
                <c:if test="${not empty mensaje}">
                    <div class="mensaje-estado">${mensaje}</div>
                </c:if>

                <form action="/usuarios/guardar" method="post" class="formulario-usuario">
                    <%-- Campo oculto para idUsuario si existe (para editar) --%>
                        <c:if test="${not empty usuario}">
                            <input type="hidden" name="idUsuario" value="${usuario.idUsuario}">
                        </c:if>

                        <div class="campo-grupo">
                            <label for="nombre">Nombre:</label>
                            <input type="text" id="nombre" name="nombre" value="${usuario.nombre}" required>
                        </div>

                        <div class="campo-grupo">
                            <label for="apellido">Apellido:</label>
                            <input type="text" id="apellido" name="apellido" value="${usuario.apellido}" required>
                        </div>

                        <div class="campo-grupo">
                            <label for="user">Usuario:</label>
                            <input type="text" id="user" name="user" value="${usuario.user}" required>
                        </div>

                        <div class="campo-grupo">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" value="${usuario.email}" required>
                        </div>

                        <div class="campo-grupo">
                            <label for="telefono">Teléfono:</label>
                            <input type="text" id="telefono" name="telefono" value="${usuario.telefono}" required>
                        </div>

                        <div class="campo-grupo">
                            <label for="password">Contraseña:</label>
                            <input type="password" id="password" name="password" value="${usuario.password}" required>
                        </div>

                        <div class="campo-grupo">
                            <label for="idRol">Rol:</label>
                            <select id="idRol" name="idRol" required>
                                <c:forEach var="rol" items="${roles}">
                                    <option value="${rol.idRol}"
                                        ${usuario.idRol==rol.idRol ? 'selected' : '' }>
                                        ${rol.tipo}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                            <button type="submit" class="boton boton-guardar"><i class="fa-solid fa-floppy-disk"></i>
                                 Guardar Usuario</button>
                            <a href="/usuarios/todos" type="button" class="boton boton-cancelar"><i class="fa-solid fa-xmark"></i>
                                 Cancelar</a>
                </form>

                <div class="enlaces-navegacion">
                    <a href="/usuarios/todos" class="boton"><i class="fa-solid fa-arrow-left"></i>
                         Ver todos los Usuarios</a>
                    <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
                </div>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>

</html>