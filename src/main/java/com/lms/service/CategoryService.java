package com.lms.service;

import com.lms.dto.category.CategoryResponse;
import com.lms.dto.category.CreateCategoryRequest;
import com.lms.dto.category.UpdateCategoryRequest;
import com.lms.entity.Category;
import com.lms.repository.CategoryRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepository categoryRepository;

    /** Returns up to 8 active categories for the home page. */
    @Transactional(readOnly = true)
    public List<CategoryResponse> getCategoriesForHomePage() {
        Pageable top8 = PageRequest.of(0, 8);
        return categoryRepository.findTop8ForHomePage(top8)
                .stream()
                .map(CategoryResponse::fromEntity)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<CategoryResponse> listAll() {
        return categoryRepository.findAll()
                .stream()
                .map(CategoryResponse::fromEntity)
                .toList();
    }

    @Transactional(readOnly = true)
    public Page<CategoryResponse> listPaginated(String search, Pageable pageable) {
        return categoryRepository.findAllPaginated(search, pageable)
                .map(CategoryResponse::fromEntity);
    }

    @Transactional(readOnly = true)
    public CategoryResponse getById(Long id) {
        return categoryRepository.findById(id)
                .map(CategoryResponse::fromEntity)
                .orElseThrow(() -> new EntityNotFoundException("Category not found: " + id));
    }

    @Transactional
    public CategoryResponse create(CreateCategoryRequest request) {
        Category category = Category.builder()
                .categoryName(request.getCategoryName())
                .description(request.getDescription())
                .avatar(request.getAvatar())
                .build();
        return CategoryResponse.fromEntity(categoryRepository.save(category));
    }

    @Transactional
    public CategoryResponse update(Long id, UpdateCategoryRequest request) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Category not found: " + id));
        if (request.getCategoryName() != null) category.setCategoryName(request.getCategoryName());
        if (request.getDescription() != null) category.setDescription(request.getDescription());
        if (request.getAvatar() != null) category.setAvatar(request.getAvatar());
        return CategoryResponse.fromEntity(categoryRepository.save(category));
    }

    @Transactional
    public void delete(Long id) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Category not found: " + id));
        category.setDeletedDate(java.time.LocalDateTime.now());
        categoryRepository.save(category);
    }
}
