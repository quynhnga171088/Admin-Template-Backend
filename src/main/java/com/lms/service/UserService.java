package com.lms.service;

import com.lms.entity.User;
import com.lms.repository.UserRepository;
import jakarta.persistence.criteria.Predicate;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final RefreshTokenService refreshTokenService;

    public User getByIdOrThrow(Long id) {
        return userRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
    }

    public Page<User> listUsers(User.Role role, User.Status status, String search, Pageable pageable) {
        String q = (search == null || search.isBlank()) ? null : search.trim().toLowerCase();
        Specification<User> spec = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            predicates.add(cb.isNull(root.get("deletedAt")));
            if (role != null)
                predicates.add(cb.equal(root.get("role"), role));
            if (status != null)
                predicates.add(cb.equal(root.get("status"), status));
            if (q != null) {
                String pattern = "%" + q + "%";
                predicates.add(cb.or(
                        cb.like(cb.lower(root.get("email")), pattern),
                        cb.like(cb.lower(root.get("fullName")), pattern)));
            }
            return cb.and(predicates.toArray(new Predicate[0]));
        };
        return userRepository.findAll(spec, pageable);
    }

    @Transactional
    public User createTeacher(String email, String password, String fullName, String phone) {
        String normalizedEmail = email.trim().toLowerCase();
        if (userRepository.existsByEmailAndDeletedAtIsNull(normalizedEmail)) {
            throw new IllegalArgumentException("Email already exists");
        }

        User user = User.builder()
                .email(normalizedEmail)
                .passwordHash(passwordEncoder.encode(password))
                .fullName(fullName)
                .phone(phone)
                .role(User.Role.TEACHER)
                .status(User.Status.ACTIVE)
                .build();
        return userRepository.save(user);
    }

    /**
     * Cập nhật thông tin cá nhân của Teacher / Admin.
     * Chỉ các trường khác null mới được cập nhật (partial update).
     *
     * @param id        ID của user cần cập nhật
     * @param fullName  tên đầy đủ mới (null → giữ nguyên)
     * @param phone     số điện thoại mới (null → giữ nguyên, "" → xóa)
     * @param avatarUrl URL avatar mới (null → giữ nguyên, "" → xóa)
     */
    @Transactional
    public User updateUserInfo(Long id, String fullName, String phone, String avatarUrl) {
        User user = getByIdOrThrow(id);

        if (fullName != null && !fullName.isBlank()) {
            user.setFullName(fullName.trim());
        }

        if (phone != null) {
            user.setPhone(phone.isBlank() ? null : phone.trim());
        }

        if (avatarUrl != null) {
            user.setAvatarUrl(avatarUrl.isBlank() ? null : avatarUrl.trim());
        }

        return userRepository.save(user);
    }

    @Transactional
    public User updateRoleStatus(Long id, User.Role role, User.Status status) {
        User user = getByIdOrThrow(id);
        user.setRole(role);
        user.setStatus(status);
        User saved = userRepository.save(user);

        if (status == User.Status.BLOCKED) {
            refreshTokenService.revokeAllUserTokens(saved);
        }

        return saved;
    }

    @Transactional
    public void softDelete(Long id) {
        User user = getByIdOrThrow(id);
        user.setDeletedAt(LocalDateTime.now());
        userRepository.save(user);
        refreshTokenService.revokeAllUserTokens(user);
    }

    /**
     * Cho phép Teacher / Admin tự đổi mật khẩu của mình.
     *
     * Quy trình bảo mật:
     *  1. Xác minh currentPassword khớp với hash trong DB.
     *  2. Kiểm tra confirmPassword == newPassword.
     *  3. Kiểm tra newPassword ≠ currentPassword (tránh đổi sang cùng giá trị).
     *  4. Lưu hash mới vào DB.
     *  5. Revoke toàn bộ refresh token → buộc đăng xuất tất cả thiết bị.
     *
     * @param user            user hiện tại (lấy từ JWT principal)
     * @param currentPassword mật khẩu cũ để xác minh danh tính
     * @param newPassword     mật khẩu mới (đã validate độ dài ở DTO layer)
     * @param confirmPassword phải khớp với newPassword
     */
    @Transactional
    public void changePassword(User user, String currentPassword, String newPassword, String confirmPassword) {
        // 1. Xác minh mật khẩu hiện tại
        if (!passwordEncoder.matches(currentPassword, user.getPasswordHash())) {
            throw new IllegalArgumentException("Current password is incorrect");
        }

        // 2. Xác nhận mật khẩu mới khớp nhau
        if (!newPassword.equals(confirmPassword)) {
            throw new IllegalArgumentException("New password and confirm password do not match");
        }

        // 3. Không cho phép đổi sang cùng mật khẩu cũ
        if (passwordEncoder.matches(newPassword, user.getPasswordHash())) {
            throw new IllegalArgumentException("New password must be different from the current password");
        }

        // 4. Cập nhật hash mới
        user.setPasswordHash(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        // 5. Revoke tất cả refresh tokens → buộc đăng xuất toàn bộ thiết bị
        refreshTokenService.revokeAllUserTokens(user);
    }
}

