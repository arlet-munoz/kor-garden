<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-estados.css">
    <title>Administración de Estados</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
    <script>
        window.onload = function() {
            <c:if test="${not empty mensajeAlerta}">
                alert("${mensajeAlerta}");
            </c:if>
        }
    </script>
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
                <h1>Administración de Estados</h1>
                <p>Gestiona el catálogo completo de estados del sistema</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="acciones-superiores">
            <a href="/estados/nuevo" class="boton"><i class="fa-solid fa-plus"></i> Agregar Nuevo Estado</a>
            <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
        </div>
        
        <div class="tabla-contenedor">
            <table class="tabla-estados">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="estado" items="${estados}">
                        <tr>
                            <td class="tipo-estado">${estado.tipo}</td>
                            <td class="acciones-celda">
                                <a href="/estados/editar?idEstado=${estado.idEstado}" class="boton"><i class="fa-solid fa-edit"></i> Editar</a></button>
                                <form action="/estados/eliminar" method="post" class="formulario-eliminar">
                                    <input type="hidden" name="idEstado" value="${estado.idEstado}">
                                    <button type="submit" class="boton" onclick="return confirm('¿Estás seguro de eliminar este estado?')"><i class="fa-solid fa-trash"></i> Eliminar</button>
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