<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-pedido.css">
    <title>Detalle de Pedido #${pedido.idPedido}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>Detalle de Pedido #${pedido.idPedido}</h1>
                <p>Información completa del pedido</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="detalle-contenedor">
            <%-- Mostrar mensaje si hay uno --%>
            <c:if test="${not empty mensaje}">
                <div class="mensaje-estado">${mensaje}</div>
            </c:if>

            <!-- Información del Cliente -->
            <div class="seccion-info">
                <h2 class="seccion-titulo"><i class="fa-solid fa-user"></i> Información del Cliente</h2>
                <div class="info-cliente">
                    <div class="campo-info">
                        <span class="label-info">Nombre:</span>
                        <span class="valor-info">${usuario.nombre} ${usuario.apellido}</span>
                    </div>
                    <div class="campo-info">
                        <span class="label-info">Teléfono:</span>
                        <span class="valor-info">${usuario.telefono}</span>
                    </div>
                    <div class="campo-info">
                        <span class="label-info">Email:</span>
                        <span class="valor-info">${usuario.email}</span>
                    </div>
                    <div class="campo-info">
                        <span class="label-info">Dirección de entrega:</span>
                        <span class="valor-info">${pedido.direccion}</span>
                    </div>
                    <div class="campo-info">
                        <span class="label-info">Fecha del pedido:</span>
                        <span class="valor-info">${pedido.fechaPedido}</span>
                    </div>
                </div>
            </div>

            <!-- Estado del Pedido -->
            <div class="seccion-info">
                <h2 class="seccion-titulo"><i class="fa-solid fa-traffic-light"></i> Estado del Pedido</h2>
                <c:if test="${sessionScope.rolUsuario eq 'admin' || sessionScope.rolUsuario eq 'encargado'}">
                    <form action="/pedidos/cambiarEstado" method="post" class="formulario-estado">
                        <input type="hidden" name="idPedido" value="${pedido.idPedido}">
                        <div class="campo-estado">
                            <select name="idEstado" class="select-estado">
                                <c:forEach var="e" items="${estados}">
                                    <option value="${e.idEstado}" ${pedido.idEstado == e.idEstado ? 'selected' : ''}>
                                        ${e.tipo}
                                    </option>
                                </c:forEach>
                            </select>
                            <button type="submit" class="boton boton-estado"><i class="fa-solid fa-refresh"></i> Cambiar Estado</button>
                        </div>
                    </form>
                </c:if>
                <c:if test="${sessionScope.rolUsuario eq 'cliente'}">
                    <div class="estado-actual">
                        <span class="label-info">Estado actual:</span>
                        <span class="valor-estado">
                            <c:forEach var="e" items="${estados}">
                                <c:if test="${pedido.idEstado == e.idEstado}">
                                    ${e.tipo}
                                </c:if>
                            </c:forEach>
                        </span>
                    </div>
                </c:if>
            </div>

            <!-- Detalle de Productos -->
            <div class="seccion-info">
                <h2 class="seccion-titulo"><i class="fa-solid fa-utensils"></i> Detalle de Productos</h2>
                <div class="tabla-contenedor">
                    <table class="tabla-productos">
                        <thead>
                            <tr>
                                <th>Imagen</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Cantidad</th>
                                <th>Precio Unitario</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detalle" items="${detalles}">
                                <c:forEach var="platillo" items="${platillos}">
                                    <c:if test="${detalle.idPlatillo == platillo.idPlatillo}">
                                        <tr>
                                            <td class="celda-imagen">
                                                <c:if test="${not empty platillo.imagen}">
                                                    <img src="/imagenes/${platillo.imagen}" alt="${platillo.nombre}" class="imagen-producto">
                                                </c:if>
                                                <c:if test="${empty platillo.imagen}">
                                                    <div class="sin-imagen">Sin imagen</div>
                                                </c:if>
                                            </td>
                                            <td class="nombre-producto">${platillo.nombre}</td>
                                            <td class="descripcion-producto">${platillo.descripcion}</td>
                                            <td class="cantidad-producto">${detalle.cantidad}</td>
                                            <td class="precio-producto">€${platillo.precio}</td>
                                            <td class="subtotal-producto">€${platillo.precio * detalle.cantidad}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="fila-total">
                                <td colspan="5"><strong>Total:</strong></td>
                                <td><strong>€${pedido.total}</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <!-- Enlaces de Navegación -->
            <div class="enlaces-navegacion">
                <c:choose>
                    <c:when test="${sessionScope.rolUsuario eq 'admin' || sessionScope.rolUsuario eq 'encargado'}">
                        <a href="/pedidos/todos" class="boton"><i class="fa-solid fa-arrow-left"></i> Volver a Pedidos</a>
                        <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/pedidos/misPedidos" class="boton"><i class="fa-solid fa-arrow-left"></i> Volver a Mis Pedidos</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>

</html>