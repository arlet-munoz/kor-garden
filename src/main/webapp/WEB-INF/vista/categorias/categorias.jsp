<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-categorias.css">
    <title>Administración de Categorías</title>
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
                <h1>Administración de Categorías</h1>
                <p>Gestiona el catálogo completo de categorías del sistema</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="acciones-superiores">
            <a href="/categorias/nueva" class="boton"><i class="fa-solid fa-plus"></i> Agregar Nueva Categoría</a>
            <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
        </div>
        
        <div class="tabla-contenedor">
            <table class="tabla-categorias">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="categoria" items="${categorias}">
                        <tr>
                            <td class="nombre-categoria">${categoria.nombre}</td>
                            <td class="acciones-celda">
                                <a href="/categorias/editar?idCategoria=${categoria.idCategoria}" class="boton"><i class="fa-solid fa-edit"></i> Editar</a></button>
                                <form action="/categorias/eliminar" method="post" class="formulario-eliminar">
                                    <input type="hidden" name="idCategoria" value="${categoria.idCategoria}">
                                    <button type="submit" class="boton" onclick="return confirm('¿Estás seguro de eliminar esta categoría?')"><i class="fa-solid fa-trash"></i> Eliminar</button>
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