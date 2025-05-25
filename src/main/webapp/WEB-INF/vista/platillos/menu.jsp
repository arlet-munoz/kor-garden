<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-menu.css">
    <title>Menú de Platillos</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>Nuestro Menú</h1>
                <p>Desde lo tradicional hasta lo innovador, tenemos el platillo perfecto para ti</p>
            </div>
        </div>
    </header>

    <%-- Mostrar mensaje si hay uno --%>
    <c:if test="${not empty mensaje}">
        <div class="mensaje-alerta" style="background-color: rgba(76, 175, 80, 0.1);
        border: 1px solid #4CAF50;
        color: #4CAF50;
        padding: 10px;
        border-radius: 5px;
        margin: 0 10%;
        margin-top: 10px;
        text-align: center;">
            ${mensaje}
        </div>
    </c:if>

    <article class="row bootstrap-only">
        <!-- SECCIÓN DE COMIDAS -->
        <section class="col-12">
            <h1 class="cajita-titulo">Comidas</h1>
            <div class="row justify-content-center">
                <c:forEach var="platillo" items="${platillos}">
                    <c:if test="${platillo.idCategoria == 1}">
                        <div class="cajita-menu col-12 col-lg-3 col-sm-6 border">
                            <div class="cajita-menu-seccion card">
                                <h2 class="card-title">${platillo.nombre}</h2>
                                <div class="card-body">
                                    <c:if test="${not empty platillo.imagen}">
                                        <img src="/imagenes/${platillo.imagen}" alt="${platillo.nombre}">
                                    </c:if>
                                    <p class="card-text">${platillo.descripcion}</p>
                                    <p class="precio">${platillo.precio} €</p>
                                    
                                    <c:choose>
                                        <c:when test="${empty sessionScope.rolUsuario}">
                                            <!-- Usuario no logueado -->
                                            <button class="boton" onclick="alert('Para pedir necesitas iniciar sesión'); window.location.href='/login';">
                                                <i class="fa-solid fa-cart-shopping"></i>
 Pedir
                                            </button>
                                        </c:when>
                                        <c:when test="${sessionScope.rolUsuario eq 'cliente'}">
                                            <!-- Usuario cliente -->
                                            <form action="/pedidos/anadirCarrito" method="post">
                                                <input type="hidden" name="idPlatillo" value="${platillo.idPlatillo}">
                                                <button class="boton" type="submit"><i class="fa-solid fa-cart-shopping"></i>
                                                     Pedir</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Admin o encargado: no muestra botón de pedir -->
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </section>

        <!-- SECCIÓN DE BEBIDAS -->
        <section class="col-12 seccion-bebidas">
            <h1 class="cajita-titulo">Bebidas</h1>
            <div class="row justify-content-center">
                <c:forEach var="platillo" items="${platillos}">
                    <c:if test="${platillo.idCategoria == 2}">
                        <div class="cajita-menu col-12 col-lg-3 col-sm-6 border">
                            <div class="cajita-menu-seccion card">
                                <h2 class="card-title">${platillo.nombre}</h2>
                                <div class="card-body">
                                    <c:if test="${not empty platillo.imagen}">
                                        <img src="/imagenes/${platillo.imagen}" alt="${platillo.nombre}">
                                    </c:if>
                                    <p class="card-text">${platillo.descripcion}</p>
                                    <p class="precio">${platillo.precio} €</p>
                                    
                                    <c:choose>
                                        <c:when test="${empty sessionScope.rolUsuario}">
                                            <!-- Usuario no logueado -->
                                            <button class="boton" onclick="alert('Para pedir necesitas iniciar sesión'); window.location.href='/login';">
                                                <i class="fa-solid fa-cart-shopping"></i>
 Pedir
                                            </button>
                                        </c:when>
                                        <c:when test="${sessionScope.rolUsuario eq 'cliente'}">
                                            <!-- Usuario cliente -->
                                            <form action="/pedidos/anadirCarrito" method="post">
                                                <input type="hidden" name="idPlatillo" value="${platillo.idPlatillo}">
                                                <button class="boton" type="submit"><i class="fa-solid fa-cart-shopping"></i>
                                                     Pedir</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Admin o encargado: no muestra botón de pedir -->
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </section>

        <!-- SECCIÓN DE POSTRES -->
        <section class="col-12">
            <h1 class="cajita-titulo">Postres</h1>
            <div class="row justify-content-center">
                <c:forEach var="platillo" items="${platillos}">
                    <c:if test="${platillo.idCategoria == 3}">
                        <div class="cajita-menu col-12 col-lg-3 col-sm-6 border">
                            <div class="cajita-menu-seccion card">
                                <h2 class="card-title">${platillo.nombre}</h2>
                                <div class="card-body">
                                    <c:if test="${not empty platillo.imagen}">
                                        <img src="/imagenes/${platillo.imagen}" alt="${platillo.nombre}">
                                    </c:if>
                                    <p class="card-text">${platillo.descripcion}</p>
                                    <p class="precio">${platillo.precio} €</p>
                                    
                                    <c:choose>
                                        <c:when test="${empty sessionScope.rolUsuario}">
                                            <!-- Usuario no logueado -->
                                            <button class="boton" onclick="alert('Para pedir necesitas iniciar sesión'); window.location.href='/login';">
                                                <i class="fa-solid fa-cart-shopping"></i>
 Pedir
                                            </button>
                                        </c:when>
                                        <c:when test="${sessionScope.rolUsuario eq 'cliente'}">
                                            <!-- Usuario cliente -->
                                            <form action="/pedidos/anadirCarrito" method="post">
                                                <input type="hidden" name="idPlatillo" value="${platillo.idPlatillo}">
                                                <button class="boton" type="submit"><i class="fa-solid fa-cart-shopping"></i>
                                                     Pedir</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Admin o encargado: no muestra botón de pedir -->
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </section>
    </article>

    <!-- Incluir el footer -->
<jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

</body>
</html>