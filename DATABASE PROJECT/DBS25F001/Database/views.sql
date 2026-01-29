USE school_fee_management;

--  DEFUALTER STUDENTS VIEW

CREATE OR REPLACE VIEW DefaulterStudentsView AS
SELECT 
    s.student_id,
    s.name AS student_name,
    s.roll_no,
    c.class_name,
    mf.month,
    ay.year_name,
    mf.due_date,
    mf.status
FROM monthly_fee mf
JOIN students s ON mf.student_id = s.student_id
JOIN classes c ON s.class_id = c.class_id
JOIN academic_year ay ON mf.year_id = ay.year_id
WHERE mf.status = 'UNPAID';

-- PAID STUDENTS VIEW

CREATE OR REPLACE VIEW PaidStudentsView AS
SELECT 
    s.student_id,
    s.name AS student_name,
    s.roll_no,
    c.class_name,
    mf.month,
    ay.year_name,
    p.amount_paid,
    p.payment_date
FROM payments p
JOIN monthly_fee mf ON p.monthly_fee_id = mf.monthly_fee_id
JOIN students s ON mf.student_id = s.student_id
JOIN classes c ON s.class_id = c.class_id
JOIN academic_year ay ON mf.year_id = ay.year_id;

-- MONTHLY REVENUE VIEW

CREATE OR REPLACE VIEW MonthlyRevenueView AS
SELECT 
    mf.month,
    ay.year_name,
    SUM(p.amount_paid) AS total_collection
FROM payments p
JOIN monthly_fee mf ON p.monthly_fee_id = mf.monthly_fee_id
JOIN academic_year ay ON mf.year_id = ay.year_id
GROUP BY mf.month, ay.year_name;

-- STUDENT FEE HISTORY VIEW

CREATE OR REPLACE VIEW StudentFeeHistoryView AS
SELECT 
    s.student_id,
    s.name AS student_name,
    s.roll_no,
    mf.month,
    ay.year_name,
    mf.status,
    IFNULL(p.amount_paid, 0) AS paid_amount
FROM monthly_fee mf
JOIN students s ON mf.student_id = s.student_id
JOIN academic_year ay ON mf.year_id = ay.year_id
LEFT JOIN payments p 
    ON mf.monthly_fee_id = p.monthly_fee_id;

-- CLASS WISE COLLECTION VIEW

CREATE OR REPLACE VIEW ClassWiseCollectionView AS
SELECT 
    c.class_name,
    SUM(p.amount_paid) AS total_collection
FROM payments p
JOIN monthly_fee mf ON p.monthly_fee_id = mf.monthly_fee_id
JOIN students s ON mf.student_id = s.student_id
JOIN classes c ON s.class_id = c.class_id
GROUP BY c.class_name;

-- FINE REPORT VIEW

CREATE OR REPLACE VIEW FineReportView AS
SELECT 
    s.student_id,
    s.name AS student_name,
    s.roll_no,
    mf.month,
    ay.year_name,
    f.fine_amount
FROM fines f
JOIN monthly_fee mf ON f.monthly_fee_id = mf.monthly_fee_id
JOIN students s ON mf.student_id = s.student_id
JOIN academic_year ay ON mf.year_id = ay.year_id;

