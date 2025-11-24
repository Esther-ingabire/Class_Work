-- Create sample tables and data (skip if already exists)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employees';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    salary NUMBER,
    department_id NUMBER
);

-- Insert sample data
INSERT INTO employees VALUES (101, 'John', 'Doe', 75000, 10);
INSERT INTO employees VALUES (102, 'Jane', 'Smith', 85000, 10);
INSERT INTO employees VALUES (103, 'Bob', 'Johnson', 65000, 20);
COMMIT;