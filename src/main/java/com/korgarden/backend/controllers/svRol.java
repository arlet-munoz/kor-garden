package com.korgarden.backend.controllers;

import com.korgarden.backend.entidades.entRol;
import com.korgarden.backend.repositories.mdRol;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/roles")
public class svRol {

    @Autowired
    private mdRol modeloRol;

    // Con esto MOSTRAMOS TODOS los roles
    @GetMapping("/todos")
    public String mostrarRoles(Model model) {
        List<entRol> listaRoles = modeloRol.findAll();
        model.addAttribute("roles", listaRoles);
        return "roles/roles";
    }

    // Con esto añadimos un NUEVO rol
    @GetMapping("/nuevo")
    public String nuevoRol(Model model) {
        return "roles/rol";
    }

    // Guardar el rol en la base de datos
    @PostMapping("/guardar")
    public String guardarRol(
            @RequestParam(required = false) Integer idRol,
            @RequestParam String tipo,
            Model model) {
        try {
            entRol rol;
    
            if (idRol != null) {
                // Buscar el rol existente
                rol = modeloRol.findById(idRol).orElse(new entRol());
            } else {
                // Crear uno nuevo
                rol = new entRol();
            }
    
            rol.setTipo(tipo);
    
            // Guardar en BBDD
            modeloRol.save(rol);
    
            if (idRol != null) {
                model.addAttribute("mensaje", "¡Rol actualizado exitosamente! ✨");
            } else {
                model.addAttribute("mensaje", "¡Rol creado exitosamente! 🎉");
            }
        } catch (Exception e) {
            model.addAttribute("mensaje", "¡Error al guardar el rol! 😢");
        }
        return "roles/rol";
    }
    
    // Con esto EDITAMOS el rol
    @GetMapping("/editar")
    public String editarRol(@RequestParam int idRol, Model model) {
        entRol rol = modeloRol.findById(idRol).orElse(null);
        if (rol != null) {
            model.addAttribute("rol", rol);
            return "roles/rol";
        } else {
            return "redirect:/roles/todos";
        }
    }

    // Con esto ELIMINAMOS el rol
@PostMapping("/eliminar")
public String eliminarRol(@RequestParam int idRol, RedirectAttributes redirectAttributes) {
    try {
        modeloRol.deleteById(idRol);
        redirectAttributes.addFlashAttribute("mensajeExito", "Rol eliminado correctamente");
        
    } catch (Exception e) {
        // Capturar error de clave foránea
        if (e.getMessage().contains("foreign key constraint") || 
            e.getMessage().contains("FOREIGN_KEY_CHECKS") ||
            e.getCause() != null && e.getCause().getMessage().contains("foreign key")) {
            
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "El rol está asociado con algún usuario y no se puede eliminar");
        } else {
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "Error al eliminar el rol: " + e.getMessage());
        }
    }
    
    return "redirect:/roles/todos";
}
}