package com.lms.dto.admin;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class ChangePasswordRequest {

    /**
     * Mật khẩu hiện tại — bắt buộc để xác minh danh tính.
     */
    @NotBlank(message = "Current password is required")
    private String currentPassword;

    /**
     * Mật khẩu mới — tối thiểu 8 ký tự.
     */
    @NotBlank(message = "New password is required")
    @Size(min = 8, message = "New password must be at least 8 characters")
    private String newPassword;

    /**
     * Xác nhận mật khẩu mới — phải khớp với newPassword (kiểm tra ở service).
     */
    @NotBlank(message = "Confirm password is required")
    private String confirmPassword;
}
