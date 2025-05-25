<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Kor Garden</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />
    
    <header>
        <div class="bienvenido-box">
            <div class="bienvenido-box-caja1">
                <div class="caja1">
                    <h1>¡Tu primer pedido con 15% de descuento!</h1>
                    <p>Ven y prueba la auténtica gastronomía japonesa con un 15% de descuento en tu primer pedido. Déjate sorprender por nuestros sabores tradicionales y disfruta de una experiencia única. ¡No te lo pierdas! 🍣🍜</p>
                    <div class="bienvenido-botones">
                        <button class="boton"><a href="/registro"><i class="fa-solid fa-calendar-check"></i>
                             Reservar</a></button>
                        <button class="boton"><a href="/platillos/menu"><i class="fa-solid fa-book-open"></i>
                             Ver Menu</a></button>
                    </div>
                </div>
                <div class="caja2">
                    <h2>Ofrecemos</h2>
                    <img src="img/ofrecemos1.jpg" alt="sushi sobre una hojita">
                    <img src="img/ofrecemos2.jpg" alt="un plato de ramen">
                    <img src="img/ofrecemos3.jpg" alt="un plato de huevo y arroz">
                </div>
            </div>
            <div class="bienvenido-box-caja2"></div>
        </div>
    </header>
    <article>
        <section class="quienes-somos-box">
            <div class="quienes-somos-box-caja1">
                <div class="foto1">
                    <img src="img/fondo-ola.jpg" alt="la gran ola de Kanagawa​">
                </div>
                <div class="foto2">
                    <img src="img/fondo-luces.jpg" alt="restaurante de comida japonesa antigua">
                </div>
                <div class="foto3">
                    <img src="img/fondo-banderas.jpg" alt="banderas de Japón">
                </div>
            </div>
            <div class="quienes-somos-box-caja2">
                <h1>Sobre Nosotros</h1>
                <p>¿Listo para probar Japón sin salir de la ciudad? En <strong>Kor Garden</strong>, combinamos lo mejor de la cocina tradicional con un toque innovador. Ingredientes frescos, técnicas auténticas y una experiencia gastronómica que va más allá del plato. Ven y descubre un rincón donde cada comida es un arte y cada bocado cuenta una historia. 🏯🥢</p>
                <div class="caja-botones">
                    <button class="boton"><a href="/sobre-nosotros"><i class="fa-solid fa-plus"></i>
                         Info</a></button>
                </div>
            </div>
        </section>
        <section class="menu-box">
            <h1>Nuestros menus</h1>
            <div class="menu-box-cajas">
                <div class="menu-box-caja1">
                    <h2>Comidas</h2>
                    <img src="img/comida.jpg" alt="plato de sushi de arroz, mariscos y salmón">
                    <button class="boton"><a href="/platillos/menu"><i class="fa-solid fa-utensils"></i> Ver más</a></button>
                </div>
                <div class="menu-box-caja2">
                    <h2>Bebidas</h2>
                    <img src="img/bebidas.jpg" alt="bebidas alcohólicas de Japón">
                    <button class="boton"><a href="/platillos/menu"><i class="fa-solid fa-martini-glass"></i>
                         Ver más</a></button>
                </div>
                <div class="menu-box-caja3">
                    <h2>Postres</h2>
                    <img src="img/postres.jpg" alt="taiyaki japonés">
                    <button class="boton"><a href="/platillos/menu"><i class="fa-solid fa-cake-candles"></i> <!-- tortas o pasteles -->
                         Ver más</a></button>
                </div>
            </div>
        </section>

        <section class="contacto-box">
            <div class="contacto-box-caja1">
                <h1>Contáctanos</h1>
                <p>¿Tienes preguntas, sugerencias o simplemente quieres saludarnos? En <strong>Kor Garden</strong>, valoramos cada mensaje. Contáctanos para reservas, pedidos o cualquier consulta. ¡Estamos aquí para ti! 📞🍣</p>
                <div class="caja-botones">
                    <button class="boton"><a href="/contacto"><i class="fa-solid fa-plus"></i>
                         Info</a></button>
                </div>
            </div>
            <div class="contacto-box-caja2">
                <img src="img/contactanos.png" alt="entrada roja a templo japonés ">
            </div>
        </section>
    </article>
    <!-- Incluir el footer -->
<jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

</body>

</html>