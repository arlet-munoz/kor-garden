package com.korgarden.backend.repositories;

import com.korgarden.backend.entidades.entPlatillo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface mdPlatillo extends JpaRepository<entPlatillo, Integer> {
}