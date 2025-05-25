package com.korgarden.backend.filtros;

import com.korgarden.backend.entidades.entUsuario;
import com.korgarden.backend.entidades.entRol;
import com.korgarden.backend.repositories.mdUsuario;
import com.korgarden.backend.repositories.mdRol;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import jakarta.servlet.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@Component
@Order(1)
public class svFiltro implements Filter {

    @Autowired
    private mdUsuario modeloUsuario;

    @Autowired
    private mdRol modeloRol;

    @Override
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    
    HttpServletRequest httpRequest = (HttpServletRequest) request;
    HttpServletResponse httpResponse = (HttpServletResponse) response;
    
    // Verificar si es una solicitud de logout
    String requestURI = httpRequest.getRequestURI();
    
    // Si es logout, permitir que se procese primero
    if (requestURI.contains("/logout")) {
        chain.doFilter(request, response);
        return;
    }
    
    // Obtener la sesión sin crear una nueva
    HttpSession session = httpRequest.getSession(false);
    
    // Si ya hay una sesión con idUsuario, dejamos pasar
    if (session != null && session.getAttribute("idUsuario") != null) {
        chain.doFilter(request, response);
        return;
    }
    
    // En este punto, no hay sesión o hay sesión sin idUsuario
    
    // Verificar si acabamos de cerrar sesión
    String logoutParam = httpRequest.getParameter("logout");
    boolean isAfterLogout = logoutParam != null && !logoutParam.isEmpty();
    
    // Intentar restaurar sesión desde cookie (solo si no estamos tras un logout)
    if (!isAfterLogout) {
        // Revisar cookies
        Cookie[] cookies = httpRequest.getCookies();
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userId".equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
                    try {
                        int idUsuario = Integer.parseInt(cookie.getValue());
                        entUsuario usuario = modeloUsuario.findById(idUsuario).orElse(null);
                        
                        if (usuario != null) {
                            // Restaurar sesión
                            HttpSession newSession = httpRequest.getSession(true);
                            entRol rol = modeloRol.findById(usuario.getIdRol()).orElse(null);
                            String tipoRol = (rol != null) ? rol.getTipo() : "";
                            
                            newSession.setAttribute("idUsuario", usuario.getIdUsuario());
                            newSession.setAttribute("nombreUsuario", usuario.getNombre());
                            newSession.setAttribute("apellidoUsuario", usuario.getApellido());
                            newSession.setAttribute("userUsuario", usuario.getUser());
                            newSession.setAttribute("emailUsuario", usuario.getEmail());
                            newSession.setAttribute("telefonoUsuario", usuario.getTelefono());
                            newSession.setAttribute("rolUsuario", tipoRol);
                        } else {
                            // Usuario no existe, eliminar cookie
                            cookie.setValue("");
                            cookie.setPath("/");
                            cookie.setMaxAge(0);
                            httpResponse.addCookie(cookie);
                        }
                    } catch (Exception e) {
                        // Error al procesar la cookie, eliminarla
                        cookie.setValue("");
                        cookie.setPath("/");
                        cookie.setMaxAge(0);
                        httpResponse.addCookie(cookie);
                    }
                    break;
                }
            }
        }
    }
    
    // Control de acceso para rutas protegidas
    if (requestURI.contains("/configuracion") || requestURI.contains("/usuarios/todos") || 
        requestURI.contains("/roles/todos") || requestURI.contains("/estados/todos") || 
        requestURI.contains("/pedidos/todos")) {
        
        // Verificar sesión actual (que podría haberse creado arriba)
        session = httpRequest.getSession(false);
        
        if (session == null || session.getAttribute("rolUsuario") == null || 
            !(session.getAttribute("rolUsuario").equals("admin") || 
              session.getAttribute("rolUsuario").equals("encargado"))) {
            
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/inicio");
            return;
        }
    }
    
    chain.doFilter(request, response);
}
}