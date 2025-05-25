package com.korgarden.backend.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/configuracion")
public class svConfiguracion {

    // Panel de configuración para admin y encargado
    @GetMapping("")
    public String panelConfiguracion(HttpSession session) {
        String rolUsuario = (String) session.getAttribute("rolUsuario");
        
        // Verificar si el usuario tiene permiso para acceder a la configuración
        if (rolUsuario == null || (!rolUsuario.equals("admin") && !rolUsuario.equals("encargado"))) {
            return "redirect:/inicio";
        }
        
        return "configuracion/panel";
    }
}