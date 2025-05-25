<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-platillos.css">
    <title>Administración de Platillos</title>
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
                <h1>Administración de Platillos</h1>
                <p>Gestiona el catálogo completo de platillos del restaurante</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="acciones-superiores">
            <a href="/platillos/nuevo" class="boton"><i class="fa-solid fa-plus"></i> Agregar Nuevo Platillo</a>
            <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
        </div>
        
        <div class="tabla-contenedor">
            <table class="tabla-platillos">
                <thead>
                    <tr>
                        <th>Imagen</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Categoría</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="platillo" items="${platillos}">
                        <tr>
                            <td class="celda-imagen">
                                <c:if test="${not empty platillo.imagen}">
                                    <img src="/imagenes/${platillo.imagen}" alt="${platillo.nombre}" class="imagen-platillo">
                                </c:if>
                                <c:if test="${empty platillo.imagen}">
                                    <div class="sin-imagen">Sin imagen</div>
                                </c:if>
                            </td>
                            <td class="nombre-platillo">${platillo.nombre}</td>
                            <td class="descripcion-platillo">${platillo.descripcion}</td>
                            <td class="precio-platillo">$${platillo.precio}</td>
                            <td>
                                <c:forEach var="categoria" items="${categorias}">
                                    <c:if test="${platillo.idCategoria == categoria.idCategoria}">
                                        ${categoria.nombre}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td class="acciones-celda">
                                <a href="/platillos/editar?idPlatillo=${platillo.idPlatillo}" class="boton"><i class="fa-solid fa-edit"></i> Editar</a></button>
                                <form action="/platillos/eliminar" method="post" class="formulario-eliminar">
                                    <input type="hidden" name="idPlatillo" value="${platillo.idPlatillo}">
                                    <button type="submit" class="boton" onclick="return confirm('¿Estás seguro de eliminar este platillo?')"><i class="fa-solid fa-trash"></i> Eliminar</button>
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