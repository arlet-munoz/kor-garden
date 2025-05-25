<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<nav class="navegador">
    <label for="menu">☰</label><input type="checkbox" name="menu" id="menu">
    <ul class="lista-box">
        <div class="lista-box-caja1">
            <li><a href="/"><img class="logo" src="/img/logo2.png" alt="logo de kor garden"></a></li>
        </div>
        <div class="lista-box-caja2">
            <li><a href="/platillos/menu">Menu</a></li>
            <li><a href="/sobre-nosotros">Nosotros</a></li>
            <li><a href="/contacto">Contacto</a></li>
            
            <!-- Si es cliente, mostrar "Mis Pedidos" -->
            <c:if test="${not empty sessionScope.rolUsuario and sessionScope.rolUsuario eq 'cliente'}">
                <li><a href="/pedidos/misPedidos">Mis Pedidos</a></li>
            </c:if>
            
            <!-- Si es admin o encargado, mostrar enlace a configuración -->
            <c:if test="${not empty sessionScope.rolUsuario and (sessionScope.rolUsuario eq 'admin' || sessionScope.rolUsuario eq 'encargado')}">
                <li><a href="/configuracion">Configuración</a></li>
            </c:if>
        </div>
        <div class="lista-box-caja3">
            <!-- Si hay sesión activa con usuario, mostrar perfil; si no, mostrar iniciar sesión -->
            <c:choose>
                <c:when test="${not empty sessionScope.userUsuario}">
                    <li><a href="/perfil">${sessionScope.userUsuario}</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="/login">Iniciar Sesión</a></li>
                </c:otherwise>
            </c:choose>
        </div>
    </ul>
</nav>

<script src="/js/menu.js"></script>