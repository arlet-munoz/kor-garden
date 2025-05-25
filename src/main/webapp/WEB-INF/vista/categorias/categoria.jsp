<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-categoria.css">
    <title>${empty categoria ? 'Agregar Nueva Categoría' : 'Editar Categoría'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>${empty categoria ? 'Agregar Nueva Categoría' : 'Editar Categoría'}</h1>
                <p>Gestiona la información de la categoría</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="formulario-contenedor">
            <h2 class="cajita-titulo">${empty categoria ? 'Nueva Categoría' : 'Editar Categoría'}</h2>

            <%-- Mostrar mensaje si hay uno --%>
                <c:if test="${not empty mensaje}">
                    <div class="mensaje-estado">${mensaje}</div>
                </c:if>

                <form action="/categorias/guardar" method="post" class="formulario-categoria">
                    <%-- Campo oculto para idCategoria si existe (para editar) --%>
                        <c:if test="${not empty categoria}">
                            <input type="hidden" name="idCategoria" value="${categoria.idCategoria}">
                        </c:if>

                        <div class="campo-grupo">
                            <label for="nombre">Nombre:</label>
                            <input type="text" id="nombre" name="nombre" value="${categoria.nombre}" required>
                        </div>

                            <button type="submit" class="boton boton-guardar"><i class="fa-solid fa-floppy-disk"></i>
                                 Guardar Categoría</button>
                            <a href="/categorias/todas" type="button" class="boton boton-cancelar"><i class="fa-solid fa-xmark"></i>
                                 Cancelar</a>
                </form>

                <div class="enlaces-navegacion">
                    <a href="/categorias/todas" class="boton"><i class="fa-solid fa-arrow-left"></i>
                         Ver todas las Categorías</a>
                    <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
                </div>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>

</html>