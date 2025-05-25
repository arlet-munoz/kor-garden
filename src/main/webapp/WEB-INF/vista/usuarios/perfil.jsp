<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-perfil.css">
    <title>Mi Perfil</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>Mi Perfil</h1>
                <p>Gestiona tu información personal y configuración de cuenta</p>
            </div>
        </div>
    </header>

    <%-- Mostrar mensaje si hay uno --%>
    <c:if test="${not empty mensaje}">
        <div class="mensaje-alerta" style="background-color: #4CAF50; color: white; padding: 10px; margin: 10px auto; max-width: 80%; text-align: center; border-radius: 5px;">
            ${mensaje}
        </div>
    </c:if>

    <div class="container">
        <div class="perfil-box">
            <div class="datos-perfil">
                <h2 class="cajita-titulo">Mis Datos</h2>
                <div class="datos-grid">
                    <div class="dato-item">
                        <span class="dato-etiqueta">Nombre:</span>
                        <span class="dato-valor">${usuario.nombre}</span>
                    </div>
                    <div class="dato-item">
                        <span class="dato-etiqueta">Apellido:</span>
                        <span class="dato-valor">${usuario.apellido}</span>
                    </div>
                    <div class="dato-item">
                        <span class="dato-etiqueta">Usuario:</span>
                        <span class="dato-valor">${usuario.user}</span>
                    </div>
                    <div class="dato-item">
                        <span class="dato-etiqueta">Email:</span>
                        <span class="dato-valor">${usuario.email}</span>
                    </div>
                    <div class="dato-item">
                        <span class="dato-etiqueta">Teléfono:</span>
                        <span class="dato-valor">${usuario.telefono}</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="acciones-box">
            <h2 class="cajita-titulo">Acciones</h2>
            <div class="botones-acciones">
                <a href="/cambiarDatos">
                    <button class="boton boton-editar">
                        <i class="fa-solid fa-edit"></i> Cambiar Datos
                    </button>
                </a>
                <a href="/logout">
                    <button class="boton boton-salir">
                        <i class="fa-solid fa-door-open"></i> Cerrar Sesión
                    </button>
                </a>
            </div>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>
</html>