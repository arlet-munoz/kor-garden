package com.korgarden.backend.controllers;

import com.korgarden.backend.entidades.entPlatillo;
import com.korgarden.backend.entidades.entPedido;
import com.korgarden.backend.entidades.entPedidoPlatillo;
import com.korgarden.backend.repositories.mdPedido;
import com.korgarden.backend.repositories.mdPedidoPlatillo;
import com.korgarden.backend.repositories.mdEstado;
import com.korgarden.backend.repositories.mdUsuario;
import com.korgarden.backend.repositories.mdPlatillo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

@Controller
@RequestMapping("/pedidos")
public class svPedido {

    @Autowired
    private mdPedido modeloPedido;

    @Autowired
    private mdPedidoPlatillo modeloPedidoPlatillo;

    @Autowired
    private mdEstado modeloEstado;

    @Autowired
    private mdUsuario modeloUsuario;

    @Autowired
    private mdPlatillo modeloPlatillo;

    // Con esto MOSTRAMOS TODOS los pedidos (admin y encargado)
    @GetMapping("/todos")
    public String mostrarPedidos(Model model) {
        List<entPedido> listaPedidos = modeloPedido.findAll();
        model.addAttribute("pedidos", listaPedidos);
        model.addAttribute("estados", modeloEstado.findAll());
        model.addAttribute("usuarios", modeloUsuario.findAll());
        return "pedidos/pedidos";
    }

    // Mostrar "mis pedidos" para clientes - OPTIMIZADO PARA FRONTEND
    @GetMapping("/misPedidos")
    public String mostrarMisPedidos(Model model, HttpSession session) {
        Integer idUsuario = (Integer) session.getAttribute("idUsuario");

        if (idUsuario == null) {
            return "redirect:/login";
        }

        // Recuperar pedidos del usuario específico
        List<entPedido> listaPedidos = modeloPedido.findAll();
        List<entPedido> misPedidos = new ArrayList<>();

        for (entPedido pedido : listaPedidos) {
            if (pedido.getIdUsuario() == idUsuario) {
                misPedidos.add(pedido);
            }
        }

        model.addAttribute("pedidos", misPedidos);
        model.addAttribute("estados", modeloEstado.findAll());

        // Recuperar carrito actual si existe
        @SuppressWarnings("unchecked")
        Map<Integer, BigDecimal> carrito = (Map<Integer, BigDecimal>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new HashMap<>();
            session.setAttribute("carrito", carrito);
        }

        // Calcular total del carrito actual
        BigDecimal totalCarrito = calcularTotalCarrito(carrito);
        
        // Obtener platillos del carrito con información completa
        List<Map<String, Object>> productosCarrito = new ArrayList<>();
        for (Map.Entry<Integer, BigDecimal> entry : carrito.entrySet()) {
            entPlatillo platillo = modeloPlatillo.findById(entry.getKey()).orElse(null);
            if (platillo != null) {
                Map<String, Object> producto = new HashMap<>();
                producto.put("platillo", platillo);
                producto.put("cantidad", entry.getValue());
                producto.put("subtotal", platillo.getPrecio().multiply(entry.getValue()).setScale(2, RoundingMode.HALF_UP));
                productosCarrito.add(producto);
            }
        }
        
        model.addAttribute("platillos", modeloPlatillo.findAll());
        model.addAttribute("carrito", carrito);
        model.addAttribute("productosCarrito", productosCarrito);
        model.addAttribute("totalCarrito", totalCarrito);
        model.addAttribute("usuario", modeloUsuario.findById(idUsuario).orElse(null));

        return "pedidos/misPedidos";
    }

    // Método auxiliar para calcular el total del carrito
    private BigDecimal calcularTotalCarrito(Map<Integer, BigDecimal> carrito) {
        BigDecimal total = BigDecimal.ZERO;
        
        if (carrito != null && !carrito.isEmpty()) {
            for (Map.Entry<Integer, BigDecimal> entry : carrito.entrySet()) {
                Integer idPlatillo = entry.getKey();
                BigDecimal cantidad = entry.getValue();
                
                // Buscar el platillo para obtener su precio
                entPlatillo platillo = modeloPlatillo.findById(idPlatillo).orElse(null);
                if (platillo != null && cantidad != null) {
                    BigDecimal subtotal = platillo.getPrecio().multiply(cantidad);
                    total = total.add(subtotal);
                }
            }
        }
        
        return total.setScale(2, RoundingMode.HALF_UP);
    }

    // Añadir al carrito - SIMPLE SIN RECARGA
    @PostMapping("/anadirCarrito")
    public String anadirAlCarrito(
            @RequestParam int idPlatillo,
            @RequestParam(defaultValue = "1") BigDecimal cantidad,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // Verificar si hay sesión de usuario
        if (session.getAttribute("idUsuario") == null) {
            redirectAttributes.addFlashAttribute("mensaje", "Para pedir necesitas iniciar sesión");
            return "redirect:/login";
        }

        // Verificar que el platillo existe
        entPlatillo platillo = modeloPlatillo.findById(idPlatillo).orElse(null);
        if (platillo == null) {
            redirectAttributes.addFlashAttribute("mensaje", "El platillo no existe");
            return "redirect:/platillos/menu";
        }

        // Validar cantidad
        if (cantidad == null || cantidad.compareTo(BigDecimal.ZERO) <= 0) {
            cantidad = BigDecimal.ONE;
        } else if (cantidad.compareTo(new BigDecimal("20")) > 0) {
            cantidad = new BigDecimal("20");
        }

        // Recuperar carrito actual o crear uno nuevo
        @SuppressWarnings("unchecked")
        Map<Integer, BigDecimal> carrito = (Map<Integer, BigDecimal>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new HashMap<>();
        }

        // Agregar el platillo al carrito
        BigDecimal cantidadExistente = carrito.getOrDefault(idPlatillo, BigDecimal.ZERO);
        BigDecimal nuevaCantidad = cantidadExistente.add(cantidad);
        
        // Verificar que no exceda el máximo
        if (nuevaCantidad.compareTo(new BigDecimal("20")) > 0) {
            nuevaCantidad = new BigDecimal("20");
            redirectAttributes.addFlashAttribute("mensaje", 
                String.format("%s añadido al carrito (máximo 20 unidades)", platillo.getNombre()));
        } else {
            redirectAttributes.addFlashAttribute("mensaje", 
                String.format("¡%s añadido al carrito! Cantidad: %s", 
                    platillo.getNombre(), nuevaCantidad));
        }
        
        carrito.put(idPlatillo, nuevaCantidad);

        // Actualizar la sesión
        session.setAttribute("carrito", carrito);

        return "redirect:/platillos/menu";
    }

    // NUEVO MÉTODO: Procesar pedido completo desde frontend
    @PostMapping("/procesarPedidoCompleto")
    public String procesarPedidoCompleto(
            @RequestParam String direccion,
            @RequestParam String productosJson,
            @RequestParam String total, // Cambiado a String para mayor control
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        try {
            Integer idUsuario = (Integer) session.getAttribute("idUsuario");

            // Verificar sesión
            if (idUsuario == null) {
                redirectAttributes.addFlashAttribute("mensaje", "No ha iniciado sesión");
                return "redirect:/login";
            }

            // Convertir total de String a BigDecimal con precisión
            BigDecimal totalRecibido;
            try {
                totalRecibido = new BigDecimal(total).setScale(2, RoundingMode.HALF_UP);
                System.out.println("DEBUG - Total recibido del frontend: " + total);
                System.out.println("DEBUG - Total como BigDecimal: " + totalRecibido);
            } catch (NumberFormatException e) {
                redirectAttributes.addFlashAttribute("mensaje", "Error: Total inválido");
                return "redirect:/pedidos/misPedidos";
            }

            // Verificar dirección
            if (direccion == null || direccion.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("mensaje", "La dirección es obligatoria");
                return "redirect:/pedidos/misPedidos";
            }

            // Parsear productos desde JSON
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Integer> productosMap = objectMapper.readValue(productosJson, new TypeReference<Map<String, Integer>>() {});
            
            if (productosMap == null || productosMap.isEmpty()) {
                redirectAttributes.addFlashAttribute("mensaje", "El carrito está vacío");
                return "redirect:/pedidos/misPedidos";
            }

            // Validar y calcular total del lado del servidor
            BigDecimal totalCalculado = BigDecimal.ZERO;
            List<entPedidoPlatillo> detallesParaGuardar = new ArrayList<>();
            
            for (Map.Entry<String, Integer> entry : productosMap.entrySet()) {
                Integer idPlatillo = Integer.parseInt(entry.getKey());
                Integer cantidad = entry.getValue();

                // Validar cantidad
                if (cantidad == null || cantidad <= 0) {
                    continue; // Saltar productos con cantidad inválida
                }

                // Obtener el precio del platillo
                entPlatillo platillo = modeloPlatillo.findById(idPlatillo).orElse(null);
                if (platillo == null) {
                    redirectAttributes.addFlashAttribute("mensaje", 
                        "Error: Uno de los productos ya no está disponible");
                    return "redirect:/pedidos/misPedidos";
                }

                // Calcular subtotal
                BigDecimal cantidadBD = new BigDecimal(cantidad);
                BigDecimal subtotal = platillo.getPrecio().multiply(cantidadBD);
                totalCalculado = totalCalculado.add(subtotal);

                // Preparar detalle para guardar
                entPedidoPlatillo detalle = new entPedidoPlatillo();
                detalle.setIdPlatillo(idPlatillo);
                detalle.setCantidad(cantidadBD);
                detallesParaGuardar.add(detalle);
            }

            // Verificar que hay productos válidos
            if (detallesParaGuardar.isEmpty() || totalCalculado.compareTo(BigDecimal.ZERO) <= 0) {
                redirectAttributes.addFlashAttribute("mensaje", "No hay productos válidos en el carrito");
                return "redirect:/pedidos/misPedidos";
            }

            // Redondear total calculado a 2 decimales
            totalCalculado = totalCalculado.setScale(2, RoundingMode.HALF_UP);
            System.out.println("DEBUG - Total calculado en servidor: " + totalCalculado);
            
            // Verificar que el total coincide (tolerancia de 0.01)
            BigDecimal diferenciaTotal = totalCalculado.subtract(totalRecibido).abs();
            System.out.println("DEBUG - Diferencia entre totales: " + diferenciaTotal);
            
            if (diferenciaTotal.compareTo(new BigDecimal("0.01")) > 0) {
                redirectAttributes.addFlashAttribute("mensaje", 
                    String.format("Error: El total calculado (€%.2f) no coincide con el enviado (€%.2f)", 
                        totalCalculado, totalRecibido));
                return "redirect:/pedidos/misPedidos";
            }

            // Usar el total calculado por el servidor (más confiable)
            BigDecimal totalFinal = totalCalculado;
            System.out.println("DEBUG - Total final a guardar: " + totalFinal);

            // Crear nuevo pedido
            entPedido pedido = new entPedido();
            pedido.setDireccion(direccion.trim());
            pedido.setFechaPedido(new Timestamp(System.currentTimeMillis()));
            pedido.setIdUsuario(idUsuario);
            pedido.setIdEstado(1); // Estado "pendiente"
            pedido.setTotal(totalFinal); // Usar el total calculado por el servidor

            // Guardar pedido
            entPedido pedidoGuardado = modeloPedido.save(pedido);

            // Guardar detalles del pedido
            for (entPedidoPlatillo detalle : detallesParaGuardar) {
                detalle.setIdPedido(pedidoGuardado.getIdPedido());
                modeloPedidoPlatillo.save(detalle);
            }

            // Limpiar carrito de la sesión
            session.setAttribute("carrito", new HashMap<>());

            redirectAttributes.addFlashAttribute("mensaje", 
                String.format("¡Pedido #%d realizado con éxito! Total: €%.2f", 
                    pedidoGuardado.getIdPedido(), totalFinal));
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("mensaje", 
                "Error al procesar el pedido: " + e.getMessage());
            System.err.println("Error en procesarPedidoCompleto: " + e.getMessage());
            e.printStackTrace();
        }

        return "redirect:/pedidos/misPedidos";
    }

    // Detalles de un pedido específico
    @GetMapping("/detalle")
    public String detallePedido(@RequestParam int idPedido, Model model) {
        entPedido pedido = modeloPedido.findById(idPedido).orElse(null);

        if (pedido == null) {
            return "redirect:/pedidos/todos";
        }

        model.addAttribute("pedido", pedido);
        model.addAttribute("usuario", modeloUsuario.findById(pedido.getIdUsuario()).orElse(null));

        // Obtener detalles del pedido
        List<entPedidoPlatillo> detalles = modeloPedidoPlatillo.findAll();
        List<entPedidoPlatillo> detallesPedido = new ArrayList<>();

        for (entPedidoPlatillo detalle : detalles) {
            if (detalle.getIdPedido() == idPedido) {
                detallesPedido.add(detalle);
            }
        }

        // Validar que el total calculado coincide con el guardado
        BigDecimal totalCalculado = BigDecimal.ZERO;
        for (entPedidoPlatillo detalle : detallesPedido) {
            entPlatillo platillo = modeloPlatillo.findById(detalle.getIdPlatillo()).orElse(null);
            if (platillo != null) {
                BigDecimal subtotal = platillo.getPrecio().multiply(detalle.getCantidad());
                totalCalculado = totalCalculado.add(subtotal);
            }
        }
        totalCalculado = totalCalculado.setScale(2, RoundingMode.HALF_UP);

        model.addAttribute("detalles", detallesPedido);
        model.addAttribute("platillos", modeloPlatillo.findAll());
        model.addAttribute("estados", modeloEstado.findAll());
        model.addAttribute("totalCalculado", totalCalculado);

        return "pedidos/pedido";
    }

    // Cambiar estado del pedido
    @PostMapping("/cambiarEstado")
    public String cambiarEstado(
            @RequestParam int idPedido,
            @RequestParam int idEstado,
            RedirectAttributes redirectAttributes) {

        entPedido pedido = modeloPedido.findById(idPedido).orElse(null);

        if (pedido != null) {
            pedido.setIdEstado(idEstado);
            modeloPedido.save(pedido);
            redirectAttributes.addFlashAttribute("mensaje", "Estado del pedido actualizado correctamente");
        } else {
            redirectAttributes.addFlashAttribute("mensaje", "Error: Pedido no encontrado");
        }

        return "redirect:/pedidos/detalle?idPedido=" + idPedido;
    }
}