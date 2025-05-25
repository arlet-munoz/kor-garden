package com.korgarden.backend.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.*;

@Entity
@Table(name = "estado")
public class entEstado {
    @Column(name = "idEstado")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idEstado;
    private String tipo;
    
    public entEstado() {
        
    }
    
    public entEstado(int idEstado, String tipo) {
        this.idEstado = idEstado;
        this.tipo = tipo;
    }
    
    public int getIdEstado() {
        return idEstado;
    }
    
    public void setIdEstado(int idEstado) {
        this.idEstado = idEstado;
    }
    
    public String getTipo() {
        return tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}