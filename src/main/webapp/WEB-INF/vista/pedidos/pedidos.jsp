<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-pedidos.css">
    <title>Administración de Pedidos</title>
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
                <h1>Administración de Pedidos</h1>
                <p>Gestiona todos los pedidos del restaurante</p>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="acciones-superiores">
            <a href="/configuracion" class="boton"><i class="fa-solid fa-gear"></i> Volver a Configuración</a>
        </div>
        
        <div class="tabla-contenedor">
            <table class="tabla-pedidos">
                <thead>
                    <tr>
                        <th>Cliente</th>
                        <th>Dirección</th>
                        <th>Fecha</th>
                        <th>Estado</th>
                        <th>Total</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pedido" items="${pedidos}">
                        <tr>
                            <td class="cliente-pedido">
                                <c:forEach var="usuario" items="${usuarios}">
                                    <c:if test="${pedido.idUsuario == usuario.idUsuario}">
                                        ${usuario.nombre} ${usuario.apellido}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td class="direccion-pedido">${pedido.direccion}</td>
                            <td class="fecha-pedido">${pedido.fechaPedido}</td>
                            <td class="estado-pedido">
                                <c:forEach var="estado" items="${estados}">
                                    <c:if test="${pedido.idEstado == estado.idEstado}">
                                        <span class="badge-estado estado-${estado.idEstado}">
                                            ${estado.tipo}
                                        </span>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td class="total-pedido">€${pedido.total}</td>
                            <td class="acciones-celda">
                                <a href="/pedidos/detalle?idPedido=${pedido.idPedido}" class="boton boton-detalle">
                                    <i class="fa-solid fa-eye"></i> Ver Detalles
                                </a>
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