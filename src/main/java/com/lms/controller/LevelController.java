package com.lms.controller;

import com.lms.dto.level.LevelResponse;
import com.lms.service.LevelService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/levels")
@RequiredArgsConstructor
public class LevelController {

    private final LevelService levelService;

    /**
     * Public — returns levels filtered by categoryId.
     * Example: GET /levels?categoryId=1
     */
    @GetMapping
    public ResponseEntity<List<LevelResponse>> listByCategory(
            @RequestParam Long categoryId
    ) {
        return ResponseEntity.ok(levelService.listByCategory(categoryId));
    }
}
