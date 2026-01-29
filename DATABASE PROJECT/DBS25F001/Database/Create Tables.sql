-- School Fee Management System
	
CREATE DATABASE IF NOT EXISTS school_fee_management;
USE school_fee_management;

-- 1. ROLES TABLE
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- 2. USERS TABLE
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE',

    CONSTRAINT fk_user_role
        FOREIGN KEY (role_id)
        REFERENCES roles(role_id)
);

-- 3. CLASSES TABLE
CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(30) NOT NULL UNIQUE
);

-- 4. SECTIONS TABLE

CREATE TABLE sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    section_name VARCHAR(10) NOT NULL
);

-- 5. ACADEMIC YEAR TABLE
CREATE TABLE academic_year (
    year_id INT AUTO_INCREMENT PRIMARY KEY,
    year_name VARCHAR(20) NOT NULL UNIQUE
);

-- 6. STUDENTS TABLE
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    roll_no VARCHAR(30) NOT NULL UNIQUE,
    class_id INT NOT NULL,
    section_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE',

    CONSTRAINT fk_student_class
        FOREIGN KEY (class_id)
        REFERENCES classes(class_id),

    CONSTRAINT fk_student_section
        FOREIGN KEY (section_id)
        REFERENCES sections(section_id)
);

-- 7. FEE TYPES TABLE

CREATE TABLE fee_types (
    fee_type_id INT AUTO_INCREMENT PRIMARY KEY,
    fee_type_name VARCHAR(50) NOT NULL UNIQUE
);

-- 8. FEE STRUCTURE TABLE
CREATE TABLE fee_structure (
    fee_id INT AUTO_INCREMENT PRIMARY KEY,
    fee_type_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),

    CONSTRAINT fk_fee_type
        FOREIGN KEY (fee_type_id)
        REFERENCES fee_types(fee_type_id)
);

-- 9. MONTHLY FEE TABLE
CREATE TABLE monthly_fee (
    monthly_fee_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    fee_id INT NOT NULL,
    month VARCHAR(20) NOT NULL,
    year_id INT NOT NULL,
    due_date DATE,
    status VARCHAR(20) DEFAULT 'UNPAID',

    CONSTRAINT fk_monthly_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    CONSTRAINT fk_monthly_fee
        FOREIGN KEY (fee_id)
        REFERENCES fee_structure(fee_id),

    CONSTRAINT fk_monthly_year
        FOREIGN KEY (year_id)
        REFERENCES academic_year(year_id)
);

-- 10. PAYMENTS TABLE
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    monthly_fee_id INT NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL CHECK (amount_paid >= 0),
    payment_date DATE NOT NULL,
    user_id INT NOT NULL,

    CONSTRAINT fk_payment_fee
        FOREIGN KEY (monthly_fee_id)
        REFERENCES monthly_fee(monthly_fee_id),

    CONSTRAINT fk_payment_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

-- 11. FINES TABLE
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    monthly_fee_id INT NOT NULL,
    fine_amount DECIMAL(10,2) NOT NULL CHECK (fine_amount >= 0),

    CONSTRAINT fk_fine_fee
        FOREIGN KEY (monthly_fee_id)
        REFERENCES monthly_fee(monthly_fee_id)
);

-- 12. DISCOUNTS TABLE
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    monthly_fee_id INT NOT NULL,
    discount_amount DECIMAL(10,2) NOT NULL CHECK (discount_amount >= 0),

    CONSTRAINT fk_discount_fee
        FOREIGN KEY (monthly_fee_id)
        REFERENCES monthly_fee(monthly_fee_id)
);

-- 13. PAYMENT LOGS TABLE

CREATE TABLE payment_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT NOT NULL,
    action VARCHAR(100),
    log_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_log_payment
        FOREIGN KEY (payment_id)
        REFERENCES payments(payment_id)
);

-- 14. STUDENT STATUS HISTORY
CREATE TABLE student_status_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_status_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
);


-- 15. SYSTEM LOGS TABLE

CREATE TABLE system_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_type VARCHAR(30),
    message TEXT,
    log_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

