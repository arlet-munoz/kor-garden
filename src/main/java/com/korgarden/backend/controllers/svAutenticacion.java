package com.korgarden.backend.controllers;

import com.korgarden.backend.entidades.entUsuario;
import com.korgarden.backend.entidades.entRol;
import com.korgarden.backend.repositories.mdUsuario;
import com.korgarden.backend.repositories.mdRol;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class svAutenticacion {

    @Autowired
    private mdUsuario modeloUsuario;

    @Autowired
    private mdRol modeloRol;

    // Página de inicio
    @GetMapping("/")
    public String inicio() {
        return "index";
    }

    @GetMapping("/inicio")
    public String paginaInicio() {
        return "index";
    }

    // Sobre nosotros
    @GetMapping("/sobre-nosotros")
    public String sobreNosotros() {
        return "sobre-nosotros";
    }

    // Contacto
    @GetMapping("/contacto")
    public String contacto() {
        return "contacto";
    }

    // Login
    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String procesarLogin(
            @RequestParam String user,
            @RequestParam String password,
            HttpSession session,
            HttpServletResponse response,
            Model model) {

        // Buscar el usuario por username
        List<entUsuario> usuarios = modeloUsuario.findAll();
        entUsuario usuarioEncontrado = null;

        for (entUsuario u : usuarios) {
            if (u.getUser().equals(user) && u.getPassword().equals(password)) {
                usuarioEncontrado = u;
                break;
            }
        }

        if (usuarioEncontrado != null) {
            // Obtener el rol
            entRol rol = modeloRol.findById(usuarioEncontrado.getIdRol()).orElse(null);
            String tipoRol = (rol != null) ? rol.getTipo() : "";

            // Guardar en sesión
            session.setAttribute("idUsuario", usuarioEncontrado.getIdUsuario());
            session.setAttribute("nombreUsuario", usuarioEncontrado.getNombre());
            session.setAttribute("apellidoUsuario", usuarioEncontrado.getApellido());
            session.setAttribute("userUsuario", usuarioEncontrado.getUser());
            session.setAttribute("emailUsuario", usuarioEncontrado.getEmail());
            session.setAttribute("telefonoUsuario", usuarioEncontrado.getTelefono());
            session.setAttribute("rolUsuario", tipoRol);

            // Crear cookie
            Cookie cookieUsuario = new Cookie("userId", String.valueOf(usuarioEncontrado.getIdUsuario()));
            cookieUsuario.setMaxAge(3600); // 1 hora
            cookieUsuario.setPath("/");
            response.addCookie(cookieUsuario);

            return "redirect:/";
        } else {
            model.addAttribute("mensaje", "Usuario o contraseña incorrectos");
            return "login";
        }
    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {
        // Invalidar sesión
        if (session != null) {
            // Eliminar todos los atributos uno por uno
            session.removeAttribute("idUsuario");
            session.removeAttribute("nombreUsuario");
            session.removeAttribute("apellidoUsuario");
            session.removeAttribute("userUsuario");
            session.removeAttribute("emailUsuario");
            session.removeAttribute("telefonoUsuario");
            session.removeAttribute("rolUsuario");

            // Luego invalidar la sesión
            session.invalidate();
        }

        // Eliminar cookie userId específicamente
        Cookie cookie = new Cookie("userId", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);

        // Redireccionar a la página de inicio de sesión
        return "redirect:/login";
    }

    // Registro
    @GetMapping("/registro")
    public String registroForm() {
        return "registro";
    }

    @PostMapping("/registro")
    public String procesarRegistro(
            @RequestParam String nombre,
            @RequestParam String apellido,
            @RequestParam String email,
            @RequestParam String telefono,
            @RequestParam String user,
            @RequestParam String password,
            Model model) {

        try {
            // Verificar si el usuario ya existe
            List<entUsuario> usuarios = modeloUsuario.findAll();

            for (entUsuario u : usuarios) {
                if (u.getUser().equals(user)) {
                    model.addAttribute("mensaje", "El nombre de usuario ya existe, por favor elija otro");
                    return "registro";
                }

                if (u.getEmail().equals(email)) {
                    model.addAttribute("mensaje", "El email ya está registrado");
                    return "registro";
                }
            }

            // Crear nuevo usuario
            entUsuario nuevoUsuario = new entUsuario();
            nuevoUsuario.setNombre(nombre);
            nuevoUsuario.setApellido(apellido);
            nuevoUsuario.setEmail(email);
            nuevoUsuario.setTelefono(telefono);
            nuevoUsuario.setUser(user);
            nuevoUsuario.setPassword(password);
            nuevoUsuario.setIdRol(2); // Rol "cliente" por defecto

            // Guardar en BBDD
            modeloUsuario.save(nuevoUsuario);

            model.addAttribute("mensaje", "Registro exitoso");
            return "login";
        } catch (Exception e) {
            model.addAttribute("mensaje", "Error durante el registro: " + e.getMessage());
            return "registro";
        }
    }

    // Perfil de usuario
    @GetMapping("/perfil")
    public String verPerfil(HttpSession session, Model model) {
        Integer idUsuario = (Integer) session.getAttribute("idUsuario");

        if (idUsuario == null) {
            return "redirect:/login";
        }

        entUsuario usuario = modeloUsuario.findById(idUsuario).orElse(null);

        if (usuario == null) {
            return "redirect:/";
        }

        model.addAttribute("usuario", usuario);
        return "usuarios/perfil";
    }

    // Cambiar datos de usuario
    @GetMapping("/cambiarDatos")
    public String cambiarDatosForm(HttpSession session, Model model) {
        Integer idUsuario = (Integer) session.getAttribute("idUsuario");

        if (idUsuario == null) {
            return "redirect:/login";
        }

        entUsuario usuario = modeloUsuario.findById(idUsuario).orElse(null);

        if (usuario == null) {
            return "redirect:/";
        }

        model.addAttribute("usuario", usuario);
        return "usuarios/cambiarDatos";
    }

    @PostMapping("/guardarDatos")
    public String guardarDatos(
            @RequestParam String nombre,
            @RequestParam String apellido,
            @RequestParam String email,
            @RequestParam String telefono,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        Integer idUsuario = (Integer) session.getAttribute("idUsuario");

        if (idUsuario == null) {
            return "redirect:/login";
        }

        entUsuario usuario = modeloUsuario.findById(idUsuario).orElse(null);

        if (usuario == null) {
            return "redirect:/";
        }

        try {
            usuario.setNombre(nombre);
            usuario.setApellido(apellido);
            usuario.setEmail(email);
            usuario.setTelefono(telefono);

            // Solo actualizar la contraseña si se ha ingresado una nueva
            if (password != null && !password.isEmpty()) {
                usuario.setPassword(password);
            }

            // Guardar en BBDD
            modeloUsuario.save(usuario);

            // Actualizar datos en sesión
            session.setAttribute("nombreUsuario", usuario.getNombre());
            session.setAttribute("apellidoUsuario", usuario.getApellido());
            session.setAttribute("emailUsuario", usuario.getEmail());
            session.setAttribute("telefonoUsuario", usuario.getTelefono());

            model.addAttribute("mensaje", "Datos actualizados correctamente");
            model.addAttribute("usuario", usuario);
            return "usuarios/perfil";
        } catch (Exception e) {
            model.addAttribute("mensaje", "Error al actualizar datos: " + e.getMessage());
            model.addAttribute("usuario", usuario);
            return "usuarios/cambiarDatos";
        }
    }
}