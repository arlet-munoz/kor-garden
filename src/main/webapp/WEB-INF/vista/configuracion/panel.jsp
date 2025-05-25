<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-panel.css">
    <title>Panel de Configuración</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>Panel de Configuración</h1>
                <p>Administra todos los aspectos de Kor Garden desde un solo lugar</p>
            </div>
        </div>
    </header>

    <div class="container">
        <h2 class="cajita-titulo">Opciones Disponibles</h2>
        
        <div class="opciones-configuracion">
            <div class="opcion-card">
                <div class="icono-opcion">
                    <i class="fa-solid fa-bowl-food"></i>
                </div>
                <h3>Administrar Platillos</h3>
                <p>Gestiona el menú de platillos disponibles en el restaurante.</p>
                <a href="/platillos/todos" class="boton boton-platillos">
                    <i class="fa-solid fa-arrow-right"></i> Ir a Platillos
                </a>
            </div>

            <div class="opcion-card">
                <div class="icono-opcion">
                    <i class="fa-solid fa-box"></i>
                </div>
                <h3>Administrar Pedidos</h3>
                <p>Gestiona los pedidos de los clientes y su seguimiento.</p>
                <a href="/pedidos/todos" class="boton boton-pedidos">
                    <i class="fa-solid fa-arrow-right"></i> Ir a Pedidos
                </a>
            </div>
            
            <c:if test="${sessionScope.rolUsuario eq 'admin'}">
                <div class="opcion-card admin-only">
                    <div class="icono-opcion">
                        <i class="fa-solid fa-users"></i>
                    </div>
                    <h3>Administrar Usuarios</h3>
                    <p>Gestiona los usuarios del sistema y sus permisos.</p>
                    <a href="/usuarios/todos" class="boton boton-usuarios">
                        <i class="fa-solid fa-arrow-right"></i> Ir a Usuarios
                    </a>
                </div>
                
                <div class="opcion-card admin-only">
                    <div class="icono-opcion">
                        <i class="fa-solid fa-crown"></i>
                    </div>
                    <h3>Administrar Roles</h3>
                    <p>Gestiona los roles de usuario del sistema.</p>
                    <a href="/roles/todos" class="boton boton-roles">
                        <i class="fa-solid fa-arrow-right"></i> Ir a Roles
                    </a>
                </div>
                
                <div class="opcion-card admin-only">
                    <div class="icono-opcion">
                        <i class="fa-solid fa-list"></i>
                    </div>
                    <h3>Administrar Categorías</h3>
                    <p>Gestiona las categorías de platillos del menú.</p>
                    <a href="/categorias/todas" class="boton boton-categorias">
                        <i class="fa-solid fa-arrow-right"></i> Ir a Categorías
                    </a>
                </div>
                
                <div class="opcion-card admin-only">
                    <div class="icono-opcion">
                        <i class="fa-solid fa-traffic-light"></i>
                    </div>
                    <h3>Administrar Estados</h3>
                    <p>Gestiona los estados de los pedidos del sistema.</p>
                    <a href="/estados/todos" class="boton boton-estados">
                        <i class="fa-solid fa-arrow-right"></i> Ir a Estados
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>
</html>