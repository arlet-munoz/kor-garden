package com.korgarden.backend.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(name = "pedido")
public class entPedido {
    @Column(name = "idPedido")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idPedido;
    private String direccion;
    private Timestamp fechaPedido;
    private BigDecimal total;
    
    @Column(name = "idUsuario")
    private int idUsuario;
    
    @Column(name = "idEstado")
    private int idEstado;
    
    public entPedido() {
        
    }
    
    public entPedido(int idPedido, String direccion, Timestamp fechaPedido, int idUsuario, int idEstado, BigDecimal total) {
        this.idPedido = idPedido;
        this.direccion = direccion;
        this.fechaPedido = fechaPedido;
        this.idUsuario = idUsuario;
        this.idEstado = idEstado;
        this.total = total;
    }
    
    public int getIdPedido() {
        return idPedido;
    }
    
    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }
    
    public String getDireccion() {
        return direccion;
    }
    
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    public Timestamp getFechaPedido() {
        return fechaPedido;
    }
    
    public void setFechaPedido(Timestamp fechaPedido) {
        this.fechaPedido = fechaPedido;
    }
    
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public int getIdEstado() {
        return idEstado;
    }
    
    public void setIdEstado(int idEstado) {
        this.idEstado = idEstado;
    }
    
    public BigDecimal getTotal() {
        return total;
    }
    
    public void setTotal(BigDecimal total) {
        this.total = total;
    }
}