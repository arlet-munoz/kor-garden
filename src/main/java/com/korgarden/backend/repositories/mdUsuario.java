package com.korgarden.backend.repositories;

import com.korgarden.backend.entidades.entUsuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface mdUsuario extends JpaRepository<entUsuario, Integer> {
}