package com.lms.dto.admin;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UpdateUserInfoRequest {

    @Size(min = 2, max = 255, message = "Họ tên phải từ 2 đến 255 ký tự")
    private String fullName;

    @Pattern(regexp = "^(\\+?[0-9]{7,15})?$", message = "Số điện thoại không hợp lệ")
    private String phone;

    /**
     * URL đường dẫn tới ảnh đại diện (do Frontend cung cấp sau khi upload ảnh lên server).
     * Nếu null → giữ nguyên avatar cũ.
     * Nếu chuỗi rỗng "" → xóa avatar.
     */
    private String avatarUrl;
}
