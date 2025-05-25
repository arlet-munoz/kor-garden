package com.korgarden.backend.controllers;

import com.korgarden.backend.entidades.entCategoria;
import com.korgarden.backend.repositories.mdCategoria;
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
@RequestMapping("/categorias")
public class svCategoria {

    @Autowired
    private mdCategoria modeloCategoria;

    // Con esto MOSTRAMOS TODAS las categorías
    @GetMapping("/todas")
    public String mostrarCategorias(Model model) {
        List<entCategoria> listaCategorias = modeloCategoria.findAll();
        model.addAttribute("categorias", listaCategorias);
        return "categorias/categorias";
    }

    // Con esto añadimos una NUEVA categoría
    @GetMapping("/nueva")
    public String nuevaCategoria(Model model) {
        return "categorias/categoria";
    }

    // Guardar la categoría en la base de datos
    @PostMapping("/guardar")
    public String guardarCategoria(
            @RequestParam(required = false) Integer idCategoria,
            @RequestParam String nombre,
            Model model) {
        try {
            entCategoria categoria;
    
            if (idCategoria != null) {
                // Buscar la categoría existente
                categoria = modeloCategoria.findById(idCategoria).orElse(new entCategoria());
            } else {
                // Crear una nueva
                categoria = new entCategoria();
            }
    
            categoria.setNombre(nombre);
    
            // Guardar en BBDD
            modeloCategoria.save(categoria);
    
            if (idCategoria != null) {
                model.addAttribute("mensaje", "¡Categoría actualizada exitosamente! ✨");
            } else {
                model.addAttribute("mensaje", "¡Categoría creada exitosamente! 🎉");
            }
        } catch (Exception e) {
            model.addAttribute("mensaje", "¡Error al guardar la categoría! 😢");
        }
        return "categorias/categoria";
    }
    
    // Con esto EDITAMOS la categoría
    @GetMapping("/editar")
    public String editarCategoria(@RequestParam int idCategoria, Model model) {
        entCategoria categoria = modeloCategoria.findById(idCategoria).orElse(null);
        if (categoria != null) {
            model.addAttribute("categoria", categoria);
            return "categorias/categoria";
        } else {
            return "redirect:/categorias/todas";
        }
    }

    // Con esto ELIMINAMOS la categoría
@PostMapping("/eliminar")
public String eliminarCategoria(@RequestParam int idCategoria, RedirectAttributes redirectAttributes) {
    try {
        modeloCategoria.deleteById(idCategoria);
        redirectAttributes.addFlashAttribute("mensajeExito", "Categoría eliminada correctamente");
        
    } catch (Exception e) {
        // Capturar error de clave foránea
        if (e.getMessage().contains("foreign key constraint") || 
            e.getMessage().contains("FOREIGN_KEY_CHECKS") ||
            e.getCause() != null && e.getCause().getMessage().contains("foreign key")) {
            
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "La categoría está asociada con algún platillo y no se puede eliminar");
        } else {
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "Error al eliminar la categoría: " + e.getMessage());
        }
    }
    
    return "redirect:/categorias/todas";
}
}