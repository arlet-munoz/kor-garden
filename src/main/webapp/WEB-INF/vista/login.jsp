<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-sesion.css">
    <title>Inicio Sesión</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>Inicio Sesión</h1>
                <p>Bienvenido de nuevo. ¡Tu mesa está lista!</p>
            </div>
        </div>
    </header>

    <%-- Mostrar mensaje si hay uno --%>
    <c:if test="${not empty mensaje}">
        <div style="background-color: rgba(76, 175, 80, 0.1);
        border: 1px solid #8a8a8a;
        color: #8a8a8a;
        padding: 10px;
        border-radius: 5px;
        margin: 0 10%;
        margin-top: 10px;
        text-align: center;">${mensaje}</div>
    </c:if>

    <div class="container">
        <div class="contact-box">
            <form class="contact-form" action="/login" method="post">
                <label class="usuario" for="user">Usuario:</label>
                <input class="c3" type="text" id="user" name="user" required>
                
                <label class="contrasena" for="password">Contraseña:</label>
                <input class="c4" type="password" id="password" name="password" required>
                
                <button class="boton" type="submit"><i class="fa-solid fa-right-to-bracket"></i>
                     Iniciar</button>
            </form>
        </div>
        <div class="info-box">
            <h2 class="cajita-titulo">Iniciar Sesión</h2>
            <p>¿No tienes una cuenta? <strong><a href="/registro">Regístrate aquí</a></strong></p>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>
</html>

