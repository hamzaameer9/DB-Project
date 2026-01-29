USE school_fee_management;

-- 1. GENERATE MONTHLY FEE
-- Automatically creates monthly fee records

DELIMITER $$

CREATE PROCEDURE GenerateMonthlyFee (
    IN p_month VARCHAR(20),
    IN p_year_id INT,
    IN p_due_date DATE
)
BEGIN
    INSERT INTO monthly_fee (student_id, fee_id, month, year_id, due_date, status)
    SELECT 
        s.student_id,
        fs.fee_id,
        p_month,
        p_year_id,
        p_due_date,
        'UNPAID'
    FROM students s
    CROSS JOIN fee_structure fs
    WHERE s.status = 'ACTIVE';
END$$

DELIMITER ;


-- 2. PAY STUDENT FEE (WITH TRANSACTION)

DELIMITER $$

CREATE PROCEDURE PayStudentFee (
    IN p_monthly_fee_id INT,
    IN p_amount DECIMAL(10,2),
    IN p_user_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO payments (
        monthly_fee_id,
        amount_paid,
        payment_date,
        user_id
    )
    VALUES (
        p_monthly_fee_id,
        p_amount,
        CURDATE(),
        p_user_id
    );

    UPDATE monthly_fee
    SET status = 'PAID'
    WHERE monthly_fee_id = p_monthly_fee_id;

    COMMIT;
END$$

DELIMITER ;

-- 3. GET DEFAULTER STUDENTS

DELIMITER $$

CREATE PROCEDURE GetDefaulterStudents (
    IN p_month VARCHAR(20),
    IN p_year_id INT
)
BEGIN
    SELECT 
        s.student_id,
        s.name,
        s.roll_no,
        c.class_name,
        mf.month,
        ay.year_name,
        mf.status
    FROM monthly_fee mf
    JOIN students s ON mf.student_id = s.student_id
    JOIN classes c ON s.class_id = c.class_id
    JOIN academic_year ay ON mf.year_id = ay.year_id
    WHERE mf.status = 'UNPAID'
      AND mf.month = p_month
      AND mf.year_id = p_year_id;
END$$

DELIMITER ;

-- 4. APPLY DISCOUNT PROCEDURE

DELIMITER $$

CREATE PROCEDURE ApplyDiscount (
    IN p_monthly_fee_id INT,
    IN p_discount_amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO discounts (
        monthly_fee_id,
        discount_amount
    )
    VALUES (
        p_monthly_fee_id,
        p_discount_amount
    );
END$$

DELIMITER ;
