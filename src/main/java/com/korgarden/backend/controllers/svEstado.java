package com.korgarden.backend.controllers;

import com.korgarden.backend.entidades.entEstado;
import com.korgarden.backend.repositories.mdEstado;
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
@RequestMapping("/estados")
public class svEstado {

    @Autowired
    private mdEstado modeloEstado;

    // Con esto MOSTRAMOS TODOS los estados
    @GetMapping("/todos")
    public String mostrarEstados(Model model) {
        List<entEstado> listaEstados = modeloEstado.findAll();
        model.addAttribute("estados", listaEstados);
        return "estados/estados";
    }

    // Con esto añadimos un NUEVO estado
    @GetMapping("/nuevo")
    public String nuevoEstado(Model model) {
        return "estados/estado";
    }

    // Guardar el estado en la base de datos
    @PostMapping("/guardar")
    public String guardarEstado(
            @RequestParam(required = false) Integer idEstado,
            @RequestParam String tipo,
            Model model) {
        try {
            entEstado estado;
    
            if (idEstado != null) {
                // Buscar el estado existente
                estado = modeloEstado.findById(idEstado).orElse(new entEstado());
            } else {
                // Crear uno nuevo
                estado = new entEstado();
            }
    
            estado.setTipo(tipo);
    
            // Guardar en BBDD
            modeloEstado.save(estado);
    
            if (idEstado != null) {
                model.addAttribute("mensaje", "¡Estado actualizado exitosamente! ✨");
            } else {
                model.addAttribute("mensaje", "¡Estado creado exitosamente! 🎉");
            }
        } catch (Exception e) {
            model.addAttribute("mensaje", "¡Error al guardar el estado! 😢");
        }
        return "estados/estado";
    }
    
    // Con esto EDITAMOS el estado
    @GetMapping("/editar")
    public String editarEstado(@RequestParam int idEstado, Model model) {
        entEstado estado = modeloEstado.findById(idEstado).orElse(null);
        if (estado != null) {
            model.addAttribute("estado", estado);
            return "estados/estado";
        } else {
            return "redirect:/estados/todos";
        }
    }

    // Con esto ELIMINAMOS el estado
@PostMapping("/eliminar")
public String eliminarEstado(@RequestParam int idEstado, RedirectAttributes redirectAttributes) {
    try {
        modeloEstado.deleteById(idEstado);
        redirectAttributes.addFlashAttribute("mensajeExito", "Estado eliminado correctamente");
        
    } catch (Exception e) {
        // Capturar error de clave foránea
        if (e.getMessage().contains("foreign key constraint") || 
            e.getMessage().contains("FOREIGN_KEY_CHECKS") ||
            e.getCause() != null && e.getCause().getMessage().contains("foreign key")) {
            
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "El estado está asociado con algún pedido y no se puede eliminar");
        } else {
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "Error al eliminar el estado: " + e.getMessage());
        }
    }
    
    return "redirect:/estados/todos";
}
}