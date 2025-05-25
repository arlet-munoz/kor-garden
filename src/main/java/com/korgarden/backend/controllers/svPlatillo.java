package com.korgarden.backend.controllers;

import com.korgarden.backend.entidades.entPlatillo;
import com.korgarden.backend.repositories.mdPlatillo;
import com.korgarden.backend.repositories.mdCategoria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.math.RoundingMode;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/platillos")
public class svPlatillo {

    @Autowired
    private mdPlatillo modeloPlatillo;

    @Autowired
    private mdCategoria modeloCategoria;

    // Con esto MOSTRAMOS TODOS los platillos
    @GetMapping("/todos")
    public String mostrarPlatillos(Model model) {
        List<entPlatillo> listaPlatillos = modeloPlatillo.findAll();
        model.addAttribute("platillos", listaPlatillos);
        model.addAttribute("categorias", modeloCategoria.findAll());
        return "platillos/platillos";
    }

    // Mostrar platillos para el menú público
    @GetMapping("/menu")
    public String mostrarMenu(Model model) {
        List<entPlatillo> listaPlatillos = modeloPlatillo.findAll();
        model.addAttribute("platillos", listaPlatillos);
        model.addAttribute("categorias", modeloCategoria.findAll());
        return "platillos/menu";
    }

    // Con esto añadimos un NUEVO platillo
    @GetMapping("/nuevo")
    public String nuevoPlatillo(Model model) {
        model.addAttribute("categorias", modeloCategoria.findAll());
        return "platillos/platillo";
    }

    // Guardar el platillo en la base de datos
    @PostMapping("/guardar")
    public String guardarPlatillo(
            @RequestParam(required = false) Integer idPlatillo,
            @RequestParam String nombre,
            @RequestParam String descripcion,
            @RequestParam(required = false) String imagen,
            @RequestParam(required = false) MultipartFile imagenFile,
            @RequestParam BigDecimal precio,
            @RequestParam int idCategoria,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {
        try {

            precio = precio.setScale(2, RoundingMode.HALF_UP);

            entPlatillo platillo;

            // Obtener el usuario de la sesión
            Integer idUsuario = (Integer) session.getAttribute("idUsuario");

            if (idPlatillo != null) {
                // Buscar el platillo existente
                platillo = modeloPlatillo.findById(idPlatillo).orElse(new entPlatillo());
                
            } else {
                // Crear uno nuevo
                platillo = new entPlatillo();
            
                // Si es un nuevo platillo, establecer el creador
                if (idUsuario != null) {
                    platillo.setIdCreador(idUsuario);
                }
            }

            platillo.setNombre(nombre);
            platillo.setDescripcion(descripcion);

            // Manejar la imagen subida
            if (imagenFile != null && !imagenFile.isEmpty()) {
                // Generar un nombre único para el archivo
                String nombreArchivo = System.currentTimeMillis() + "_" + imagenFile.getOriginalFilename();

                // Definir la ruta donde se guardará el archivo
                String rutaDirectorio = "src/main/resources/static/imagenes/";
                Path rutaCompleta = Paths.get(rutaDirectorio + nombreArchivo);

                // Guardar el archivo en el sistema de archivos
                Files.copy(imagenFile.getInputStream(), rutaCompleta, StandardCopyOption.REPLACE_EXISTING);

                // Guardar el nombre del archivo en la entidad
                platillo.setImagen(nombreArchivo);
            } else if (imagen != null && !imagen.isEmpty()) {
                // Si no se subió un archivo pero hay un nombre de imagen (en caso de edición)
                platillo.setImagen(imagen);
            }

            platillo.setPrecio(precio);
            platillo.setIdCategoria(idCategoria);

            // Guardar en BBDD
            modeloPlatillo.save(platillo);

            if (idPlatillo != null) {
                model.addAttribute("mensaje", "¡Platillo actualizado exitosamente! ✨");
            } else {
                model.addAttribute("mensaje", "¡Platillo creado exitosamente! 🎉");
            }
        } catch (Exception e) {
            model.addAttribute("mensaje", "¡Error al guardar el platillo! 😢: " + e.getMessage());
        }
        model.addAttribute("categorias", modeloCategoria.findAll());
        return "platillos/platillo";
    }

    // Con esto EDITAMOS el platillo
    @GetMapping("/editar")
    public String editarPlatillo(@RequestParam int idPlatillo, Model model, HttpSession session) {
        entPlatillo platillo = modeloPlatillo.findById(idPlatillo).orElse(null);

        if (platillo != null) {

            model.addAttribute("platillo", platillo);
            model.addAttribute("categorias", modeloCategoria.findAll());
            return "platillos/platillo";
        } else {
            return "redirect:/platillos/todos";
        }
    }

// Con esto ELIMINAMOS el platillo
@PostMapping("/eliminar")
public String eliminarPlatillo(@RequestParam int idPlatillo, HttpSession session, RedirectAttributes redirectAttributes) {
    try {
        // Verificar si el usuario es encargado y si creó el platillo
        if (session.getAttribute("rolUsuario") != null &&
                session.getAttribute("rolUsuario").equals("encargado")) {

            entPlatillo platillo = modeloPlatillo.findById(idPlatillo).orElse(null);

            if (platillo != null &&
                    platillo.getIdCreador() != null &&
                    !platillo.getIdCreador().equals(session.getAttribute("idUsuario"))) {

                redirectAttributes.addFlashAttribute("mensajeAlerta",
                        "No puedes eliminar el platillo porque tú no lo creaste, contacta con el administrador");
                return "redirect:/platillos/todos";
            }
        }

        // Intentar eliminar el platillo
        modeloPlatillo.deleteById(idPlatillo);
        
        redirectAttributes.addFlashAttribute("mensajeExito", "Platillo eliminado correctamente");
        
    } catch (Exception e) {
        // Capturar error de clave foránea
        if (e.getMessage().contains("foreign key constraint") || 
            e.getMessage().contains("FOREIGN_KEY_CHECKS") ||
            e.getCause() != null && e.getCause().getMessage().contains("foreign key")) {
            
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "El platillo está asociado con algún pedido y no se puede eliminar");
        } else {
            redirectAttributes.addFlashAttribute("mensajeAlerta",
                    "Error al eliminar el platillo: " + e.getMessage());
        }
    }
    
    return "redirect:/platillos/todos";
}
}