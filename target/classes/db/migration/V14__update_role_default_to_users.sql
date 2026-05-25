-- Cập nhật role của tất cả người dùng đang là TEACHER thành ADMIN
UPDATE users
SET role = 'ADMIN'::user_role
WHERE role = 'TEACHER'::user_role;
