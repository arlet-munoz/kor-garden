package com.korgarden.backend.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.math.RoundingMode;

@Entity
@Table(name = "platillo")
public class entPlatillo {
    @Column(name = "idPlatillo")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idPlatillo;
    private String nombre;
    private String descripcion;
    private String imagen;
    @Column(name = "precio", precision = 10, scale = 2)
    private BigDecimal precio;

    @Column(name = "idCategoria")
    private int idCategoria;

    @Column(name = "idCreador")
    private Integer idCreador;

    public entPlatillo() {

    }

    public entPlatillo(int idPlatillo, String nombre, String descripcion, String imagen, BigDecimal precio,
            int idCategoria, Integer idCreador) {
        this.idPlatillo = idPlatillo;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.precio = precio;
        this.idCategoria = idCategoria;
        this.idCreador = idCreador;
    }

    public int getIdPlatillo() {
        return idPlatillo;
    }

    public void setIdPlatillo(int idPlatillo) {
        this.idPlatillo = idPlatillo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public BigDecimal getPrecio() {
        if (precio != null) {
            return precio.setScale(2, RoundingMode.HALF_UP);
        }
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public Integer getIdCreador() {
        return idCreador;
    }

    public void setIdCreador(Integer idCreador) {
        this.idCreador = idCreador;
    }
}