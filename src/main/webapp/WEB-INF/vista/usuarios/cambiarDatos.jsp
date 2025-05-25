<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style-cambiarDatos.css">
    <title>Cambiar Datos</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
</head>

<body>
    <!-- Incluir el menú de navegación -->
    <jsp:include page="/WEB-INF/vista/condiciones/menu.jsp" />

    <header>
        <div class="bienvenido-box">
            <div class="caja1">
                <h1>Cambiar Datos</h1>
                <p>Actualiza tu información personal</p>
            </div>
        </div>
    </header>

    <%-- Mostrar mensaje si hay uno --%>
    <c:if test="${not empty mensaje}">
        <div class="mensaje-alerta ${mensaje.contains('Error') ? 'mensaje-error' : ''}">
            ${mensaje}
        </div>
    </c:if>

    <div class="container">
        <div class="form-box">
            <h2 class="cajita-titulo">Editar Información</h2>
            
            <form action="/guardarDatos" method="post">
                <div class="form-grid">
                    <div class="form-item">
                        <label for="nombre" class="form-label">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" value="${usuario.nombre}" 
                               class="form-input" placeholder="Ingresa tu nombre" required>
                    </div>
                    
                    <div class="form-item">
                        <label for="apellido" class="form-label">Apellido:</label>
                        <input type="text" id="apellido" name="apellido" value="${usuario.apellido}" 
                               class="form-input" placeholder="Ingresa tu apellido" required>
                    </div>
                    
                    <div class="form-item">
                        <label for="user" class="form-label">Usuario:</label>
                        <input type="text" id="user" name="user" value="${usuario.user}" 
                               class="form-input" placeholder="Ingresa tu nombre de usuario" required>
                    </div>
                    
                    <div class="form-item">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" id="email" name="email" value="${usuario.email}" 
                               class="form-input" placeholder="Ingresa tu email" required>
                    </div>
                    
                    <div class="form-item">
                        <label for="telefono" class="form-label">Teléfono:</label>
                        <input type="text" id="telefono" name="telefono" value="${usuario.telefono}" 
                               class="form-input" placeholder="Ingresa tu teléfono" required>
                    </div>
                    
                    <div class="form-item">
                        <label for="password" class="form-label">Nueva Contraseña:</label>
                        <input type="password" id="password" name="password" 
                               class="form-input" placeholder="Dejar en blanco para mantener la actual">
                        <small style="color: rgb(201, 200, 200); font-style: italic; margin-top: 5px; display: block;">
                            * Dejar en blanco si no deseas cambiar la contraseña
                        </small>
                    </div>
                </div>
                
                <div class="botones-acciones">
                    <button type="submit" class="boton">
                        <i class="fa-solid fa-save"></i> Guardar Cambios
                    </button>
                    <a href="/perfil" class="boton boton-secundario">
                        <i class="fa-solid fa-times"></i> Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- Incluir el footer -->
    <jsp:include page="/WEB-INF/vista/condiciones/footer.jsp" />

    <script src="/js/menu.js"></script>
</body>
</html>