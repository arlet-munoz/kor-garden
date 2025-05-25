package com.korgarden.backend.repositories;

import com.korgarden.backend.entidades.entEstado;
import org.springframework.data.jpa.repository.JpaRepository;

public interface mdEstado extends JpaRepository<entEstado, Integer> {
}