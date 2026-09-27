-- ===============================================================
-- BƯỚC 1: TẠO CSDL VÀ BẢNG EMPLOYEES
-- ===============================================================
CREATE DATABASE IF NOT EXISTS company;
USE company;

-- Xóa bảng cũ nếu có để tránh lỗi trùng lặp khi chạy lại file nhiều lần
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);


-- ===============================================================
-- BƯỚC 2: TẠO TRIGGER TỰ ĐỘNG CẬP NHẬT PHÒNG BAN THEO LƯƠNG
-- ===============================================================
DELIMITER //

DROP TRIGGER IF EXISTS update_department //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;


-- ===============================================================
-- BƯỚC 3: DEMO SỬ DỤNG TRIGGER (CHÈN DỮ LIỆU KIỂM TRA)
-- ===============================================================
INSERT INTO employees (name, department, salary)
VALUES 
    ('John Doe', 'A', 3500),
    ('Jane Smith', 'A', 2000),
    ('David Johnson', 'A', 6000);

-- Kiểm tra kết quả sau khi Trigger tự động xử lý đổi giá trị cột 'department'
SELECT * FROM employees;
