package com.lms.service;

import com.lms.dto.level.LevelResponse;
import com.lms.exception.ResourceNotFoundException;
import com.lms.repository.CategoryRepository;
import com.lms.repository.LevelRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LevelService {

    private final LevelRepository   levelRepository;
    private final CategoryRepository categoryRepository;

    @Transactional(readOnly = true)
    public List<LevelResponse> listByCategory(Long categoryId) {
        // Validate category exists
        categoryRepository.findById(categoryId)
                .orElseThrow(() -> new ResourceNotFoundException("Category", categoryId));

        return levelRepository.findByCategoryId(categoryId)
                .stream()
                .map(LevelResponse::fromEntity)
                .toList();
    }
}
