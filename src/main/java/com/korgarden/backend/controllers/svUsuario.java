package com.korgarden.backend.controllers;

import com.korgarden.backend.entidades.entUsuario;
import com.korgarden.backend.repositories.mdUsuario;
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
@RequestMapping("/usuarios")
public class svUsuario {

    @Autowired
    private mdUsuario modeloUsuario;
    @Autowired
    private mdRol modeloRol;

    // Con esto MOSTRAMOS TODOS los usuarios
    @GetMapping("/todos")
    public String mostrarUsuarios(Model model) {
        List<entUsuario> listaUsuarios = modeloUsuario.findAll();
        model.addAttribute("usuarios", listaUsuarios);
        model.addAttribute("roles", modeloRol.findAll());
        return "usuarios/usuarios";
    }

    // Con esto añadimos un NUEVO usuario
    @GetMapping("/nuevo")
    public String nuevoUsuario(Model model) {
        model.addAttribute("roles", modeloRol.findAll());
        return "usuarios/usuario";
    }

    // Guardar el usuario en la base de datos
    @PostMapping("/guardar")
    public String guardarUsuario(
            @RequestParam(required = false) Integer idUsuario, 
            @RequestParam String nombre,
            @RequestParam String apellido,
            @RequestParam String user,
            @RequestParam String email,
            @RequestParam String telefono,
            @RequestParam int idRol,
            @RequestParam String password,
            Model model) {
        try {
            entUsuario usuario;
    
            if (idUsuario != null) {
                // Buscar el usuario existente
                usuario = modeloUsuario.findById(idUsuario).orElse(new entUsuario());
            } else {
                // Crear uno nuevo
                usuario = new entUsuario();
            }
    
            usuario.setNombre(nombre);
            usuario.setApellido(apellido);
            usuario.setUser(user);
            usuario.setEmail(email);
            usuario.setTelefono(telefono);
            usuario.setIdRol(idRol);
            usuario.setPassword(password); 
    
            // Guardar en BBDD
            modeloUsuario.save(usuario);
    
            if (idUsuario != null) {
                model.addAttribute("mensaje", "¡Usuario actualizado exitosamente! ✨");
            } else {
                model.addAttribute("mensaje", "¡Usuario creado exitosamente! 🎉");
            }
        } catch (Exception e) {
            model.addAttribute("mensaje", "¡Error al guardar el usuario! 😢");
        }
        model.addAttribute("roles", modeloRol.findAll());
        return "usuarios/usuario";
    }
    
    // Con esto EDITAMOS el usuario
    @GetMapping("/editar")
    public String editarUsuario(@RequestParam int idUsuario, Model model) {
        entUsuario usuario = modeloUsuario.findById(idUsuario).orElse(null);
        model.addAttribute("roles", modeloRol.findAll());
        if (usuario != null) {
            model.addAttribute("usuario", usuario);
            return "usuarios/usuario";
        } else {
            return "redirect:/usuarios/todos";
        }
    }

    // Con esto ELIMINAMOS el usuario
@PostMapping("/eliminar")
public String eliminarUsuario(@RequestParam int idUsuario, RedirectAttributes redirectAttributes) {
    try {
        modeloUsuario.deleteById(idUsuario);
        redirectAttributes.addFlashAttribute("mensajeExito", "Usuario eliminado correctamente");
        
    } catch (Exception e) {
        // Capturar error de clave foránea
        if (e.getMessage().contains("foreign key constraint") || 
            e.getMessage().contains("FOREIGN_KEY_CHECKS") ||
            e.getCause() != null && e.getCause().getMessage().contains("foreign key")) {
            
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "El usuario está asociado con algún pedido o platillo y no se puede eliminar");
        } else {
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "Error al eliminar el usuario: " + e.getMessage());
        }
    }
    
    return "redirect:/usuarios/todos";
}
}