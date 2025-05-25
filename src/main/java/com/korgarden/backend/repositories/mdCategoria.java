package com.korgarden.backend.repositories;

import com.korgarden.backend.entidades.entCategoria;
import org.springframework.data.jpa.repository.JpaRepository;

public interface mdCategoria extends JpaRepository<entCategoria, Integer> {
}