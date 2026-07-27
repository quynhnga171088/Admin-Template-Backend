package com.lms.controller;

import com.lms.dto.product.PagedResponse;
import com.lms.dto.product.ProductListRequest;
import com.lms.dto.product.ProductResponse;
import com.lms.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    /**
     * Public. Returns a paginated, filtered, and sortable list of products.
     *
     * <pre>
     * ── Basic ──────────────────────────────────────────────────────────────
     * GET /products
     *
     * ── With search ────────────────────────────────────────────────────────
     * GET /products?search=apple
     *
     * ── With sort ──────────────────────────────────────────────────────────
     * GET /products?sortBy=price&sortDir=asc
     * GET /products?sortBy=rating&sortDir=desc
     *
     * ── With pagination ────────────────────────────────────────────────────
     * GET /products?page=1&size=10
     *
     * ── Combined ───────────────────────────────────────────────────────────
     * GET /products?search=laptop&sortBy=price&sortDir=asc&page=0&size=20
     * </pre>
     *
     * @param req all query params bound via {@link ProductListRequest}
     */
    @GetMapping
    public ResponseEntity<PagedResponse<ProductResponse>> list(
            @ModelAttribute ProductListRequest req
    ) {
        log.debug("[products:list] search='{}', page={}, size={}, sortBy={}, sortDir={}, status={}, categoryKey={}",
                req.getSearch(), req.getPage(), req.getSize(), req.getSortBy(), req.getSortDir(), req.getStatus(),  req.getCategoryKey());
        try {
            Sort.Direction direction = Sort.Direction.fromOptionalString(req.getSortDir())
                    .orElse(Sort.Direction.DESC);

            Pageable pageable = PageRequest.of(req.getPage(), req.getSize(),
                    Sort.by(direction, req.getSortBy()));

            Page<ProductResponse> page = productService.listProducts(req.getSearch(), req.getStatus(), req.getCategoryKey(), pageable);

            log.debug("[products:list] returned {} / {} products",
                    page.getNumberOfElements(), page.getTotalElements());

            return ResponseEntity.ok(PagedResponse.of(page));
        } catch (Exception e) {
            log.error("[products:list] Exception — req={}: {} — {}",
                    req, e.getClass().getSimpleName(), e.getMessage(), e);
            throw e;
        }
    }
}
