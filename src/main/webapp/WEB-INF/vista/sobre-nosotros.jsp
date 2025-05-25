<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-nosotros.css">
    <title>Sobre Nosotros</title>
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
                <h1>Sobre Nosotros</h1>
                <p>Fusionamos lo auténtico con lo moderno para ofrecerte una experiencia única de sabor y tradición
                    japonesa</p>
            </div>
        </div>
    </header>

    <article class="pequena-historia">
        <h1 class="cajita-titulo">En 1980</h1>
        <p>Todo comenzó cuando Itsuki Tanaka, un chef japonés apasionado por su cultura, viajó a occidente y notó que
            algo faltaba en los restaurantes de comida japonesa: la armonía entre tradición y modernidad.

            Inspirado por los jardines zen y la calidez de los izakayas de su infancia, decidió crear un espacio donde
            cada platillo contara una historia. Así nació <strong>Kor Garden</strong>, un rincón donde los sabores clásicos se fusionan
            con nuevas experiencias, manteniendo la esencia de Japón en cada bocado.

            Hoy, <strong>Kor Garden</strong> es más que un restaurante: es un lugar donde la comida se convierte en arte y cada cliente
            es parte de su historia. 🏯🥢</p>
    </article>

    <article class="row bootstrap-only">
        <section class="col-12">
            <h1 class="cajita-titulo">Nuestro Personal</h1>
            <div class="row justify-content-center">
                <div class="cajita-menu col-12 col-lg-3 col-sm-6 border">
                    <div class="cajita-menu-seccion card">
                        <h2 class="card-title">Takashi Nakamura – Chef Ejecutivo </h2>
                        <div class="card-body">
                            <img src="/img/chef-ejecutivo.jpg" alt="foto del chef ejecutivo">
                            <p class="card-text">Experto en cocina japonesa con más de 15 años de experiencia en la
                                preparación de sushi y platillos tradicionales.</p>
                        </div>
                    </div>
                </div>
                <div class="cajita-menu col-12 col-lg-3 col-sm-6 border">
                    <div class="cajita-menu-seccion card">
                        <h2 class="card-title">Hana Fujimoto – Sous Chef </h2>
                        <div class="card-body">
                            <img src="/img/sous-chef.jpg" alt="foto de la sous chef">
                            <p class="card-text">Especialista en ramen y okonomiyaki, encargada de mantener la calidad y autenticidad de cada platillo.</p>
                        </div>
                    </div>
                </div>
                <div class="cajita-menu col-12 col-lg-3 col-sm-6 border">
                    <div class="cajita-menu-seccion card">
                        <h2 class="card-title">Kenji Saito – Sommelier de Sake</h2>
                        <div class="card-body">
                            <img src="/img/sommelier.jpg" alt="foto del sommelier de sake">
                            <p class="card-text">Conocedor del maridaje entre sake y gastronomía japonesa, guía a los clientes en la elección de la mejor bebida.</p>
                        </div>
                    </div>
                </div>
                <div class="cajita-menu col-12 col-lg-3 col-sm-6 border">
                    <div class="cajita-menu-seccion card">
                        <h2 class="card-title">Mika Tanaka – Gerente de Servicio</h2>
                        <div class="card-body">
                            <img src="/img/gerente.jpg" alt="foto de la gerente de servicio">
                            <p class="card-text">Supervisa la experiencia del cliente, asegurando un servicio impecable y un ambiente acogedor en Kor Garden.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </article>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>
</html>