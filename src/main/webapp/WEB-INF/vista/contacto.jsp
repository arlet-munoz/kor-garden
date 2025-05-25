<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-contacto.css">
    <title>Contacto</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>Contáctanos</h1>
                <p>Para reservas, pedidos o cualquier consulta</p>
            </div>
        </div>
    </header>

    <section class="contacto-box">
        <div class="contact-box">
            <h2>Envíanos un mensaje</h2>
            <form class="contact-form" action="/contacto" method="post">
                <label class="nombre" for="nombre">Nombre:</label>
                <input class="c1" type="text" id="nombre" name="nombre" required>
                
                <label class="email" for="email">Email:</label>
                <input class="c2" type="email" id="email" name="email" required>
                
                <label class="mensaje" for="mensaje">Mensaje:</label>
                <textarea class="c5" id="mensaje" name="mensaje" required></textarea>
                
                <button class="boton" type="submit"><i class="fa-solid fa-paper-plane"></i>
                     Enviar</button>
            </form>
        </div>

        <div class="contacto-newsletter">
            <h2>Información de Contacto</h2>
            <p><strong>Dirección:</strong> Calle Principal, 123</p>
            <p><strong>Teléfono:</strong> 123-456-789</p>
            <p><strong>Email:</strong> info@korgarden.com</p>
            <p><strong>Horario:</strong> Lunes a Domingo, 12:00 - 23:00</p>
        </div>

        <div class="contacto-info">
            <div class="info-box">
                <i class="fa-solid fa-phone"></i>
                <p>(+876) 765 665</p>
            </div>
            <div class="info-box">
                <i class="fa-solid fa-envelope"></i>
                <p>mail@korgarden.com</p>
            </div>
            <div class="info-box">
                <i class="fa-solid fa-location-dot"></i>
                <p>Ubicación: Tokio, Japón</p>
            </div>
        </div>

        <div class="contacto-mapa">
            <iframe class="mapa"
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3151.8354345093747!2d139.69170621531557!3d35.68948798019186!2m3!1f0!2f0!3f0!2m3!1i1024!2i768!4f13.1!3m3!1m2!1s0x60188c0e51f96fd7%3A0x7c2b227b6e67941!2sTokio%2C%20Jap%C3%B3n!5e0!3m2!1ses!2ses!4v1645751234567!5m2!1ses!2ses"
                allowfullscreen="" loading="lazy"></iframe>
        </div>
    </section>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>
</html>