<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-rol.css">
    <title>${empty rol ? 'Agregar Nuevo Rol' : 'Editar Rol'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>${empty rol ? 'Agregar Nuevo Rol' : 'Editar Rol'}</h1>
                <p>Gestiona la información del rol</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="formulario-contenedor">
            <h2 class="cajita-titulo">${empty rol ? 'Nuevo Rol' : 'Editar Rol'}</h2>

            <%-- Mostrar mensaje si hay uno --%>
                <c:if test="${not empty mensaje}">
                    <div class="mensaje-estado">${mensaje}</div>
                </c:if>

                <form action="/roles/guardar" method="post" class="formulario-rol">
                    <%-- Campo oculto para idRol si existe (para editar) --%>
                        <c:if test="${not empty rol}">
                            <input type="hidden" name="idRol" value="${rol.idRol}">
                        </c:if>

                        <div class="campo-grupo">
                            <label for="tipo">Tipo:</label>
                            <input type="text" id="tipo" name="tipo" value="${rol.tipo}" required>
                        </div>

                            <button type="submit" class="boton boton-guardar"><i class="fa-solid fa-floppy-disk"></i>
                                 Guardar Rol</button>
                            <a href="/roles/todos" type="button" class="boton boton-cancelar"><i class="fa-solid fa-xmark"></i>
                                 Cancelar</a>
                </form>

                <div class="enlaces-navegacion">
                    <a href="/roles/todos" class="boton"><i class="fa-solid fa-arrow-left"></i>
                         Ver todos los Roles</a>
                    <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
                </div>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>

</html>