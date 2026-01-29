USE school_fee_management;



INSERT INTO roles (role_name) VALUES ('Admin'), ('Accountant');

INSERT INTO users (username, password, role_id) VALUES
('admin', 'admin123', 1),
('accountant', 'acc123', 2);

INSERT INTO classes (class_name) VALUES
('Play Group'), ('Nursery'), ('One'), ('Two'), ('Three'),
('Four'), ('Five'), ('Six'), ('Seven'), ('Eight'),
('Nine'), ('Ten');

INSERT INTO sections (section_name) VALUES
('A'), ('B'), ('C'), ('D');

INSERT INTO academic_year (year_name) VALUES
('2024-2025'), ('2025-2026');

INSERT INTO fee_types (fee_type_name) VALUES
('Tuition Fee'),
('Exam Fee'),
('Transport Fee'),
('Lab Fee');

INSERT INTO fee_structure (fee_type_id, amount) VALUES
(1, 5000),
(2, 1500),
(3, 2000),
(4, 1000);


DELIMITER $$

CREATE PROCEDURE Generate1200Students()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1200 DO
        INSERT INTO students
        (name, roll_no, class_id, section_id, status)
        VALUES
        (
            CONCAT('Student_', i),
            CONCAT('ROLL-', LPAD(i, 5, '0')),
            (i MOD 12) + 1,
            (i MOD 4) + 1,
            'ACTIVE'
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL Generate1200Students();
DROP PROCEDURE Generate1200Students;


DELIMITER $$

CREATE PROCEDURE GenerateMonthlyFees()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1200 DO
        INSERT INTO monthly_fee
        (student_id, fee_id, month, year_id, due_date, status)
        VALUES
        (
            i,
            1,
            'January',
            1,
            '2025-01-10',
            IF(i MOD 3 = 0, 'PAID', 'UNPAID')
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL GenerateMonthlyFees();
DROP PROCEDURE GenerateMonthlyFees;



DELIMITER $$

CREATE PROCEDURE GeneratePayments()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1200 DO
        IF i MOD 3 = 0 THEN
            INSERT INTO payments
            (monthly_fee_id, amount_paid, payment_date, user_id)
            VALUES
            (i, 5000, CURDATE(), 2);
        END IF;

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL GeneratePayments();
DROP PROCEDURE GeneratePayments;



DELIMITER $$

CREATE PROCEDURE GenerateFines()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1200 DO
        IF i MOD 5 = 0 THEN
            INSERT INTO fines
            (monthly_fee_id, fine_amount)
            VALUES
            (i, 500);
        END IF;

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL GenerateFines();
DROP PROCEDURE GenerateFines;

-- GENERATE DISCOUNTS (≈ 170)

DELIMITER $$

CREATE PROCEDURE GenerateDiscounts()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1200 DO
        IF i MOD 7 = 0 THEN
            INSERT INTO discounts
            (monthly_fee_id, discount_amount)
            VALUES
            (i, 300);
        END IF;

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL GenerateDiscounts();
DROP PROCEDURE GenerateDiscounts;

-- FINAL SYSTEM LOG

INSERT INTO system_logs (log_type, message)
VALUES
('INFO', '1200+ student records and financial data generated successfully');
