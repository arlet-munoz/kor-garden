document.addEventListener('DOMContentLoaded', function() {
    // Variables globales
    let carritoLocal = {};
    let platillosInfo = {};
    
    // Verificar que contextPath esté definido
    if (typeof contextPath === 'undefined') {
        window.contextPath = '';
    }
    
    // Inicializar carrito desde datos del servidor
    inicializarCarrito();
    
    // Calcular total inicial
    calcularTotal();
    
    // Event listeners
    configurarEventListeners();
    
    // Función para inicializar el carrito con datos del servidor
    function inicializarCarrito() {
        // Obtener datos de platillos desde la tabla
        const filasPlatillos = document.querySelectorAll('.fila-platillo');
        filasPlatillos.forEach(function(fila) {
            const idPlatillo = parseInt(fila.getAttribute('data-id'));
            const cantidadInput = fila.querySelector('.cantidad-input');
            const precio = parseFloat(cantidadInput.getAttribute('data-precio'));
            const nombre = fila.querySelector('.nombre-producto').textContent;
            
            // Guardar info del platillo
            platillosInfo[idPlatillo] = {
                nombre: nombre,
                precio: precio
            };
            
            // Guardar cantidad actual en carrito local
            carritoLocal[idPlatillo] = parseInt(cantidadInput.value) || 0;
        });
        
        console.log('Carrito inicializado:', carritoLocal);
        console.log('Platillos info:', platillosInfo);
    }
    
    // Configurar todos los event listeners
    function configurarEventListeners() {
        // Inputs de cantidad
        const cantidadInputs = document.querySelectorAll('.cantidad-input');
        cantidadInputs.forEach(function(input) {
            input.addEventListener('input', function() {
                actualizarCantidadLocal(this);
            });
            input.addEventListener('change', function() {
                validarCantidad(this);
                actualizarCantidadLocal(this);
            });
        });
        
        // Botones de eliminar
        const botonesEliminar = document.querySelectorAll('.btn-eliminar');
        botonesEliminar.forEach(function(boton) {
            boton.addEventListener('click', function(e) {
                e.preventDefault();
                const idPlatillo = parseInt(this.getAttribute('data-id'));
                const nombrePlatillo = this.getAttribute('data-nombre') || 'este producto';
                
                if (confirm(`¿Estás seguro de eliminar ${nombrePlatillo} del carrito?`)) {
                    eliminarDelCarritoLocal(idPlatillo);
                }
            });
        });
        
        // Formulario de pedido
        const formularioPedido = document.getElementById('formularioPedido');
        if (formularioPedido) {
            formularioPedido.addEventListener('submit', function(e) {
                e.preventDefault();
                procesarPedidoCompleto();
            });
        }
        
        // Botón procesar pedido
        const btnProcesarPedido = document.getElementById('btn-procesar-pedido');
        if (btnProcesarPedido) {
            btnProcesarPedido.addEventListener('click', function(e) {
                e.preventDefault();
                procesarPedidoCompleto();
            });
        }
    }
    
    // Validar cantidad (entre 1 y 20)
    function validarCantidad(input) {
        let cantidad = parseInt(input.value);
        if (isNaN(cantidad) || cantidad < 1) {
            cantidad = 1;
            input.value = 1;
        } else if (cantidad > 20) {
            cantidad = 20;
            input.value = 20;
            mostrarMensaje('La cantidad máxima por producto es 20 unidades', 'warning');
        }
        return cantidad;
    }
    
    // Actualizar cantidad en carrito local (sin comunicación con servidor)
    function actualizarCantidadLocal(input) {
        try {
            const idPlatillo = parseInt(input.getAttribute('data-id-platillo'));
            const cantidad = validarCantidad(input);
            const precio = parseFloat(input.getAttribute('data-precio'));
            
            if (isNaN(precio) || isNaN(cantidad) || isNaN(idPlatillo)) {
                console.error('Error en datos: precio=' + precio + ', cantidad=' + cantidad + ', id=' + idPlatillo);
                return;
            }
            
            // Actualizar carrito local
            carritoLocal[idPlatillo] = cantidad;
            
            // Calcular y mostrar subtotal (con 2 decimales exactos)
            const subtotal = (precio * cantidad);
            const subtotalFormatted = Math.round(subtotal * 100) / 100; // Evitar errores de punto flotante
            const subtotalElement = document.getElementById('subtotal-' + idPlatillo);
            if (subtotalElement) {
                subtotalElement.textContent = '€' + subtotalFormatted.toFixed(2);
            }
            
            // Recalcular total
            calcularTotal();
            
            console.log('Cantidad actualizada localmente - ID:', idPlatillo, 'Cantidad:', cantidad);
        } catch (error) {
            console.error('Error actualizando cantidad local:', error);
        }
    }
    
    // Eliminar producto del carrito (solo frontend)
    function eliminarDelCarritoLocal(idPlatillo) {
        try {
            // Buscar la fila del producto
            const fila = document.querySelector(`[data-id="${idPlatillo}"]`);
            if (fila) {
                // Eliminar del carrito local
                delete carritoLocal[idPlatillo];
                
                // Eliminar visualmente la fila
                fila.remove();
                
                // Recalcular total
                calcularTotal();
                
                // Verificar si el carrito está vacío
                verificarCarritoVacio();
                
                const nombrePlatillo = platillosInfo[idPlatillo]?.nombre || 'Producto';
                mostrarMensaje(nombrePlatillo + ' eliminado del carrito', 'success');
                
                console.log('Producto eliminado localmente:', idPlatillo);
            }
        } catch (error) {
            console.error('Error eliminando producto:', error);
        }
    }
    
    // Calcular total del carrito
    function calcularTotal() {
        try {
            let total = 0;
            
            // Calcular desde carrito local
            for (let idPlatillo in carritoLocal) {
                const cantidad = carritoLocal[idPlatillo];
                const precio = platillosInfo[idPlatillo]?.precio || 0;
                
                if (cantidad > 0 && precio > 0) {
                    const subtotal = precio * cantidad;
                    total += subtotal;
                }
            }
            
            // Evitar errores de punto flotante
            total = Math.round(total * 100) / 100;
            
            // Actualizar total en la página (con 2 decimales)
            const totalElement = document.getElementById('total');
            if (totalElement) {
                totalElement.textContent = total.toFixed(2);
            }
            
            // Actualizar total en el botón
            const totalDisplay = document.querySelector('.total-display');
            if (totalDisplay) {
                totalDisplay.textContent = total.toFixed(2);
            }
            
            // Actualizar input hidden
            const totalHidden = document.getElementById('total-hidden');
            if (totalHidden) {
                totalHidden.value = total.toFixed(2);
            }
            
            // Habilitar/deshabilitar botón de procesar
            const btnProcesar = document.getElementById('btn-procesar-pedido');
            if (btnProcesar) {
                btnProcesar.disabled = total <= 0;
                btnProcesar.style.opacity = total <= 0 ? '0.5' : '1';
            }
            
            console.log('Total calculado:', total.toFixed(2));
            return total;
            
        } catch (error) {
            console.error('Error calculando total:', error);
            return 0;
        }
    }
    
    // Verificar si el carrito está vacío y mostrar mensaje
    function verificarCarritoVacio() {
        const filasProductos = document.querySelectorAll('.fila-platillo');
        const tablaCarrito = document.querySelector('.tabla-carrito');
        const formularioContainer = document.querySelector('.formulario-contenedor');
        
        if (filasProductos.length === 0) {
            // Carrito vacío - mostrar mensaje
            if (formularioContainer) {
                formularioContainer.innerHTML = `
                    <div class="carrito-vacio">
                        <i class="fa-solid fa-shopping-cart"></i>
                        <p>No hay platillos en el carrito.</p>
                        <a href="${window.contextPath}/platillos/menu" class="boton">
                            <i class="fa-solid fa-utensils"></i> Ver Menú
                        </a>
                    </div>
                `;
            }
        }
    }
    
    // Procesar pedido completo (enviar todo al servidor de una vez)
    function procesarPedidoCompleto() {
        try {
            // Validar dirección
            const direccionInput = document.getElementById('direccion');
            
            // Validar que hay productos
            const productosValidos = Object.keys(carritoLocal).filter(id => carritoLocal[id] > 0);
            if (productosValidos.length === 0) {
                mostrarMensaje('El carrito está vacío', 'error');
                return false;
            }
            
            // Calcular total final
            const totalFinal = calcularTotal();
            if (totalFinal <= 0) {
                mostrarMensaje('El total del pedido no es válido', 'error');
                return false;
            }
            
            // Confirmar pedido (con 2 decimales)
            if (!confirm(`¿Confirmar pedido por €${totalFinal.toFixed(2)}?`)) {
                return false;
            }
            
            // Preparar datos para enviar
            const datosPedido = {
                direccion: direccionInput.value.trim(),
                productos: carritoLocal,
                total: totalFinal
            };
            
            console.log('Enviando pedido:', datosPedido);
            
            // Enviar al servidor
            enviarPedidoAlServidor(datosPedido);
            
        } catch (error) {
            console.error('Error procesando pedido:', error);
            mostrarMensaje('Error al procesar el pedido', 'error');
        }
    }
    
    // Enviar pedido al servidor
    function enviarPedidoAlServidor(datosPedido) {
        // Mostrar loading
        const btnProcesar = document.getElementById('btn-procesar-pedido');
        const textoOriginal = btnProcesar ? btnProcesar.innerHTML : '';
        if (btnProcesar) {
            btnProcesar.disabled = true;
            btnProcesar.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Procesando...';
        }
        
        // Crear formulario para envío
        const form = document.createElement('form');
        form.method = 'post';
        form.action = `${window.location.origin}${window.contextPath}/pedidos/procesarPedidoCompleto`;
        form.style.display = 'none';
        
        // Dirección
        const inputDireccion = document.createElement('input');
        inputDireccion.type = 'hidden';
        inputDireccion.name = 'direccion';
        inputDireccion.value = datosPedido.direccion;
        form.appendChild(inputDireccion);
        
        // Total
        const inputTotal = document.createElement('input');
        inputTotal.type = 'hidden';
        inputTotal.name = 'total';
        inputTotal.value = datosPedido.total.toFixed(2); // Enviar con 2 decimales exactos
        form.appendChild(inputTotal);
        
        // Productos (como JSON)
        const inputProductos = document.createElement('input');
        inputProductos.type = 'hidden';
        inputProductos.name = 'productosJson';
        inputProductos.value = JSON.stringify(datosPedido.productos);
        form.appendChild(inputProductos);
        
        // Enviar
        document.body.appendChild(form);
        form.submit();
    }
    
    // Mostrar mensajes al usuario
    function mostrarMensaje(mensaje, tipo = 'info') {
        // Crear elemento de mensaje si no existe
        let mensajeElement = document.querySelector('.mensaje-temporal');
        if (!mensajeElement) {
            mensajeElement = document.createElement('div');
            mensajeElement.className = 'mensaje-temporal';
            document.querySelector('.container').prepend(mensajeElement);
        }
        
        // Configurar clase según tipo
        mensajeElement.className = `mensaje-temporal mensaje-${tipo}`;
        mensajeElement.textContent = mensaje;
        mensajeElement.style.display = 'block';
        
        // Ocultar después de 3 segundos
        setTimeout(() => {
            if (mensajeElement) {
                mensajeElement.style.display = 'none';
            }
        }, 3000);
    }
    
    // Funciones públicas para uso externo
    window.calcularTotal = calcularTotal;
    window.carritoLocal = carritoLocal;
    window.platillosInfo = platillosInfo;
});

// Función para formatear precio (exactamente 2 decimales)
function formatearPrecio(precio) {
    const precioNum = parseFloat(precio);
    const precioRedondeado = Math.round(precioNum * 100) / 100;
    return '€' + precioRedondeado.toFixed(2);
}