package com.korgarden.backend.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "pedido_platillo")
public class entPedidoPlatillo {
    @Column(name = "idPedidoPlatillo")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idPedidoPlatillo;
    private BigDecimal cantidad;
    
    @Column(name = "idPedido")
    private int idPedido;
    
    @Column(name = "idPlatillo")
    private int idPlatillo;
    
    public entPedidoPlatillo() {
        
    }
    
    public entPedidoPlatillo(int idPedidoPlatillo, BigDecimal cantidad, int idPedido, int idPlatillo) {
        this.idPedidoPlatillo = idPedidoPlatillo;
        this.cantidad = cantidad;
        this.idPedido = idPedido;
        this.idPlatillo = idPlatillo;
    }
    
    public int getIdPedidoPlatillo() {
        return idPedidoPlatillo;
    }
    
    public void setIdPedidoPlatillo(int idPedidoPlatillo) {
        this.idPedidoPlatillo = idPedidoPlatillo;
    }
    
    public BigDecimal getCantidad() {
        return cantidad;
    }
    
    public void setCantidad(BigDecimal cantidad) {
        this.cantidad = cantidad;
    }
    
    public int getIdPedido() {
        return idPedido;
    }
    
    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }
    
    public int getIdPlatillo() {
        return idPlatillo;
    }
    
    public void setIdPlatillo(int idPlatillo) {
        this.idPlatillo = idPlatillo;
    }
}