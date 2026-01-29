USE school_fee_management;

-- Automatically add late fine if fee is unpaid


DELIMITER $$

CREATE TRIGGER trg_add_late_fine
AFTER UPDATE ON monthly_fee
FOR EACH ROW
BEGIN
    IF NEW.status = 'UNPAID' 
       AND NEW.due_date < CURDATE() THEN

        INSERT INTO fines (
            monthly_fee_id,
            fine_amount
        )
        VALUES (
            NEW.monthly_fee_id,
            500.00
        );
    END IF;
END$$

DELIMITER ;

-- Update fee status automatically after payment

DELIMITER $$

CREATE TRIGGER trg_update_fee_status
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    UPDATE monthly_fee
    SET status = 'PAID'
    WHERE monthly_fee_id = NEW.monthly_fee_id;
END$$

DELIMITER ;


-- Insert payment log automatically

DELIMITER $$

CREATE TRIGGER trg_payment_log
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    INSERT INTO payment_logs (
        payment_id,
        action,
        log_date
    )
    VALUES (
        NEW.payment_id,
        'Payment received successfully',
        NOW()
    );
END$$

DELIMITER ;

