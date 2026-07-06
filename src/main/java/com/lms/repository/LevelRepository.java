package com.lms.repository;

import com.lms.entity.Level;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LevelRepository extends JpaRepository<Level, Long> {

    List<Level> findByCategoryId(Long categoryId);
}
