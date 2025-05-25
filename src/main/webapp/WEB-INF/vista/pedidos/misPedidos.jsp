<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-misPedidos.css">
    <title>Mis Pedidos - Kor Garden</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
    
    <!-- Definir contextPath para JavaScript -->
    <script>
        window.contextPath = '${pageContext.request.contextPath}';
    </script>
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>Mis Pedidos</h1>
                <p>Gestiona tu carrito y revisa tus pedidos</p>
            </div>
        </div>
    </header>

    <div class="container">
        <!-- Mensaje de notificación si existe -->
        <c:if test="${not empty mensaje}">
            <div class="mensaje-estado">${mensaje}</div>
        </c:if>

        <!-- Carrito actual -->
        <div class="seccion-carrito">
            <h2 class="seccion-titulo"><i class="fa-solid fa-shopping-cart"></i> Carrito Actual</h2>

            <c:if test="${empty carrito || carrito.size() == 0}">
                <div class="carrito-vacio">
                    <i class="fa-solid fa-shopping-cart"></i>
                    <p>No hay platillos en el carrito.</p>
                    <a href="${pageContext.request.contextPath}/platillos/menu" class="boton">
                        <i class="fa-solid fa-utensils"></i> Ver Menú
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty carrito && carrito.size() > 0}">
                <div class="formulario-contenedor">
                    <!-- NOTA: No usamos action, todo se maneja en JavaScript -->
                    <form id="formularioPedido">
                        
                        <div class="tabla-contenedor">
                            <table class="tabla-carrito">
                                <thead>
                                    <tr>
                                        <th>Imagen</th>
                                        <th>Nombre</th>
                                        <th>Cantidad</th>
                                        <th>Precio</th>
                                        <th>Subtotal</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="carritoBody">
                                    <c:forEach items="${productosCarrito}" var="producto">
                                        <tr class="fila-platillo" data-id="${producto.platillo.idPlatillo}">
                                            <td class="celda-imagen">
                                                <c:if test="${not empty producto.platillo.imagen}">
                                                    <img src="/imagenes/${producto.platillo.imagen}" 
                                                         alt="${producto.platillo.nombre}" 
                                                         class="imagen-producto">
                                                </c:if>
                                                <c:if test="${empty producto.platillo.imagen}">
                                                    <div class="sin-imagen">Sin imagen</div>
                                                </c:if>
                                            </td>
                                            <td class="nombre-producto">${producto.platillo.nombre}</td>
                                            <td class="celda-cantidad">
                                                <div class="cantidad-container">
                                                    <!-- INPUT PRINCIPAL: aquí se editan las cantidades -->
                                                    <input type="number" 
                                                           class="cantidad-input" 
                                                           min="1" max="20"
                                                           value="${producto.cantidad}"
                                                           data-id-platillo="${producto.platillo.idPlatillo}"
                                                           data-precio="${producto.platillo.precio}">
                                                </div>
                                            </td>
                                            <td class="precio-producto">€${producto.platillo.precio}</td>
                                            <td class="subtotal-celda">
                                                <span class="subtotal" id="subtotal-${producto.platillo.idPlatillo}">
                                                    €${producto.subtotal}
                                                </span>
                                            </td>
                                            <td class="acciones-celda">
                                                <!-- BOTÓN ELIMINAR: solo JavaScript, sin formulario -->
                                                <button type="button" 
                                                        class="boton btn-eliminar" 
                                                        data-id="${producto.platillo.idPlatillo}"
                                                        data-nombre="${producto.platillo.nombre}">
                                                    <i class="fa-solid fa-trash"></i> Eliminar
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr class="fila-total">
                                        <td colspan="4"><strong>Total:</strong></td>
                                        <td><strong>€<span id="total">${totalCarrito}</span></strong></td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <!-- Datos del cliente -->
                        <div class="seccion-cliente">
                            <h3 class="subseccion-titulo"><i class="fa-solid fa-user"></i> Datos de entrega</h3>
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
                            </div>
                            <div class="enlace-cambiar">
                                <a href="${pageContext.request.contextPath}/cambiarDatos" class="boton boton-secundario">
                                    <i class="fa-solid fa-edit"></i> Cambiar datos
                                </a>
                            </div>
                        </div>

                        <!-- Dirección de entrega -->
                        <div class="seccion-direccion">
                            <h3 class="subseccion-titulo"><i class="fa-solid fa-map-marker-alt"></i> Dirección de entrega</h3>
                            <div class="campo-grupo">
                                <label for="direccion">Dirección completa:</label>
                                <!-- INPUT DIRECCIÓN: requerido para el pedido -->
                                <input type="text" 
                                       id="direccion" 
                                       name="direccion" 
                                       required 
                                       maxlength="20"
                                       placeholder="Ej: Calle Mayor 123, 2º A, Madrid, 28001">
                            </div>
                        </div>

                        <!-- Botón procesar pedido -->
                        <div class="acciones-pedido">
                            <!-- BOTÓN PRINCIPAL: manejado completamente por JavaScript -->
                            <button type="button" id="btn-procesar-pedido" class="boton boton-principal">
                                <i class="fa-solid fa-shopping-bag"></i> 
                                Procesar Pedido - Total: €<span class="total-display">${totalCarrito}</span>
                            </button>
                        </div>
                    </form>
                </div>
            </c:if>
        </div>

        <!-- Historial de pedidos -->
        <div class="seccion-historial">
            <h2 class="seccion-titulo"><i class="fa-solid fa-history"></i> Historial de Pedidos</h2>

            <c:if test="${empty pedidos}">
                <div class="historial-vacio">
                    <i class="fa-solid fa-clock"></i>
                    <p>No tienes pedidos realizados aún.</p>
                </div>
            </c:if>

            <c:if test="${not empty pedidos}">
                <div class="tabla-contenedor">
                    <table class="tabla-historial">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Fecha</th>
                                <th>Dirección</th>
                                <th>Estado</th>
                                <th>Total</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pedidos}" var="pedido">
                                <tr>
                                    <td class="id-pedido">#${pedido.idPedido}</td>
                                    <td class="fecha-pedido">${pedido.fechaPedido}</td>
                                    <td class="direccion-pedido">${pedido.direccion}</td>
                                    <td class="estado-pedido">
                                        <c:forEach items="${estados}" var="estado">
                                            <c:if test="${estado.idEstado == pedido.idEstado}">
                                                <span class="badge-estado estado-${estado.idEstado}">
                                                    ${estado.tipo}
                                                </span>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td class="total-pedido">€${pedido.total}</td>
                                    <td class="acciones-celda">
                                        <a href="${pageContext.request.contextPath}/pedidos/detalle?idPedido=${pedido.idPedido}" 
                                           class="boton boton-detalle">
                                            <i class="fa-solid fa-eye"></i> Ver Detalles
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>

        <!-- Enlaces de navegación -->
        <div class="enlaces-navegacion">
            <a href="${pageContext.request.contextPath}/platillos/menu" class="boton">
                <i class="fa-solid fa-utensils"></i> Ver Menú
            </a>
            <a href="/" class="boton">
                <i class="fa-solid fa-home"></i> Inicio
            </a>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <!-- JavaScript: IMPORTANTE - cargar después del DOM -->
    <script src="${pageContext.request.contextPath}/js/menu.js"></script>
    <script src="${pageContext.request.contextPath}/js/gestionPedidos.js"></script>
</body>

</html>