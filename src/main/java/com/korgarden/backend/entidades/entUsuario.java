package com.korgarden.backend.entidades;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.*;

//Esto indica que esta clase será una entidad para la BBDD
@Entity

//Aquí le indicamos que queremos usar esa tabla, si no lo ponemos Springboot la creará
@Table(name = "usuario")
public class entUsuario {
    @Column(name = "idUsuario")
    //Este campo será la clave primaria de la tabla.
    @Id
    //Le dice a Java que la base de datos se encargará de generar automáticamente el ID
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idUsuario;
    private String nombre, apellido, user, email, telefono, password;
    
    @Column(name = "idRol")
    private int idRol;
    
    public entUsuario() {
        
    }
    
    public entUsuario(int idUsuario, String nombre, String apellido, String user, String email, String telefono, int idRol, String password) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.apellido = apellido;
        this.user = user;
        this.email = email;
        this.telefono = telefono;
        this.idRol = idRol;
        this.password = password;
    }
    
    
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getApellido() {
        return apellido;
    }
    
    public void setApellido(String apellido) {
        this.apellido = apellido;
    }
    
    public String getUser() {
        return user;
    }
    
    public void setUser(String user) {
        this.user = user;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getTelefono() {
        return telefono;
    }
    
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public int getIdRol() {
        return idRol;
    }
    
    public void setIdRol(int idRol) {
        this.idRol = idRol;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
}