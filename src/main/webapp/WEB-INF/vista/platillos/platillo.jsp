<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-platillo.css">
    <title>${empty platillo ? 'Agregar Nuevo Platillo' : 'Editar Platillo'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>${empty platillo ? 'Agregar Nuevo Platillo' : 'Editar Platillo'}</h1>
                <p>Gestiona la información del platillo</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="formulario-contenedor">
            <h2 class="cajita-titulo">${empty platillo ? 'Nuevo Platillo' : 'Editar Platillo'}</h2>

            <%-- Mostrar mensaje si hay uno --%>
                <c:if test="${not empty mensaje}">
                    <div class="mensaje-estado">${mensaje}</div>
                </c:if>

                <form action="/platillos/guardar" method="post" enctype="multipart/form-data"
                    class="formulario-platillo">
                    <%-- Campo oculto para idPlatillo si existe (para editar) --%>
                        <c:if test="${not empty platillo}">
                            <input type="hidden" name="idPlatillo" value="${platillo.idPlatillo}">
                        </c:if>

                        <div class="campo-grupo">
                            <label for="nombre">Nombre:</label>
                            <input type="text" id="nombre" name="nombre" value="${platillo.nombre}" required>
                        </div>

                        <div class="campo-grupo">
                            <label for="descripcion">Descripción:</label>
                            <input type="text" id="descripcion" name="descripcion"
                                value="${platillo.descripcion}" required>
                        </div>

                        <div class="campo-grupo">
                            <label for="imagen">Imagen:</label>
                            <c:if test="${not empty platillo.imagen}">
                                <div class="imagen-actual-contenedor">
                                    <img src="/imagenes/${platillo.imagen}" alt="${platillo.nombre}">
                                    <input type="hidden" name="imagen" value="${platillo.imagen}">
                                </div>
                            </c:if>
                            <input type="file" id="imagen" name="imagenFile" accept="image/*">
                        </div>

                        <div class="campo-grupo">
                            <label for="precio">Precio:</label>
                            <input type="number" id="precio" name="precio" value="${platillo.precio}"
                                step="0.01" min="0" required>
                        </div>

                        <div class="campo-grupo">
                            <label for="idCategoria">Categoría:</label>
                            <select id="idCategoria" name="idCategoria" required>
                                <c:forEach var="categoria" items="${categorias}">
                                    <option value="${categoria.idCategoria}"
                                        ${platillo.idCategoria==categoria.idCategoria ? 'selected' : '' }>
                                        ${categoria.nombre}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                            <button type="submit" class="boton boton-guardar"><i class="fa-solid fa-floppy-disk"></i>
                                 Guardar Platillo</button>
                            <a href="/platillos/todos" type="button" class="boton boton-cancelar"><i class="fa-solid fa-xmark"></i>
                                 Cancelar</a>
                </form>

                <div class="enlaces-navegacion">
                    <a href="/platillos/todos" class="boton"><i class="fa-solid fa-arrow-left"></i>
                         Ver todos los Platillos</a>
                    <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
                </div>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>

</html>