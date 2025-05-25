package com.korgarden.backend.repositories;

import com.korgarden.backend.entidades.entPedido;
import org.springframework.data.jpa.repository.JpaRepository;

public interface mdPedido extends JpaRepository<entPedido, Integer> {
}