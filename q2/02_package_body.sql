-- HR Employee Management System Package Body
CREATE OR REPLACE PACKAGE BODY hr_employee_mgmt AS
    
    -- Function to calculate RSSB tax (3% of gross salary)
    FUNCTION calculate_rssb_tax(p_gross_salary NUMBER) RETURN NUMBER IS
        v_rssb_rate CONSTANT NUMBER := 0.03; -- 3% RSSB tax rate
    BEGIN
        -- USER vs CURRENT_USER demonstration:
        -- USER: Returns the name of the user who logged into the session
        -- CURRENT_USER: Returns the name of the user whose privileges are currently active
        DBMS_OUTPUT.PUT_LINE('Tax calculated by USER: ' || USER);
        DBMS_OUTPUT.PUT_LINE('Tax calculated by CURRENT_USER: ' || SYS_CONTEXT('USERENV', 'CURRENT_USER'));
        
        RETURN p_gross_salary * v_rssb_rate;
    END calculate_rssb_tax;
    
    -- Function to calculate net salary after RSSB deduction
    FUNCTION calculate_net_salary(p_employee_id NUMBER) RETURN NUMBER IS
        v_gross_salary NUMBER;
        v_rssb_tax NUMBER;
        v_net_salary NUMBER;
    BEGIN
        SELECT salary INTO v_gross_salary
        FROM employees
        WHERE employee_id = p_employee_id;
        
        v_rssb_tax := calculate_rssb_tax(v_gross_salary);
        v_net_salary := v_gross_salary - v_rssb_tax;
        
        RETURN v_net_salary;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END calculate_net_salary;
    
    -- Dynamic procedure for various employee operations using dynamic SQL
    PROCEDURE dynamic_employee_operation(
        p_operation VARCHAR2,
        p_employee_id NUMBER DEFAULT NULL,
        p_salary NUMBER DEFAULT NULL
    ) IS
        v_sql VARCHAR2(4000);
        v_count NUMBER;
    BEGIN
        -- Security Context Demonstration:
        -- USER: Session user who logged in (remains constant)
        -- CURRENT_USER: User whose privileges are active (changes with DEFINER/INVOKER)
        -- This package uses DEFINER rights by default
        DBMS_OUTPUT.PUT_LINE('Operation by USER: ' || USER);
        DBMS_OUTPUT.PUT_LINE('Operation by CURRENT_USER: ' || SYS_CONTEXT('USERENV', 'CURRENT_USER'));
        
        CASE UPPER(p_operation)
            WHEN 'UPDATE_SALARY' THEN
                v_sql := 'UPDATE employees SET salary = :1 WHERE employee_id = :2';
                EXECUTE IMMEDIATE v_sql USING p_salary, p_employee_id;
                DBMS_OUTPUT.PUT_LINE('Salary updated using dynamic SQL');
                
            WHEN 'INSERT_RECORD' THEN
                v_sql := 'INSERT INTO employees (employee_id, first_name, last_name, salary, department_id) VALUES (:1, :2, :3, :4, :5)';
                EXECUTE IMMEDIATE v_sql USING p_employee_id, 'New', 'Employee', p_salary, 10;
                DBMS_OUTPUT.PUT_LINE('Record inserted using dynamic SQL');
                
            WHEN 'GENERATE_REPORT' THEN
                v_sql := 'SELECT COUNT(*) FROM employees WHERE salary > :1';
                EXECUTE IMMEDIATE v_sql INTO v_count USING NVL(p_salary, 50000);
                DBMS_OUTPUT.PUT_LINE('Report: ' || v_count || ' employees with salary > ' || NVL(p_salary, 50000));
        END CASE;
        
        COMMIT;
    END dynamic_employee_operation;
    
    -- Bulk processing procedure using cursor (Optional Challenge)
    PROCEDURE process_bulk_employees(p_department_id NUMBER) IS
        CURSOR emp_cursor IS
            SELECT employee_id, salary
            FROM employees
            WHERE department_id = p_department_id;
        
        v_net_salary NUMBER;
        v_processed_count NUMBER := 0;
    BEGIN
        -- Process multiple employees using cursor loop
        FOR emp_rec IN emp_cursor LOOP
            v_net_salary := calculate_net_salary(emp_rec.employee_id);
            v_processed_count := v_processed_count + 1;
            DBMS_OUTPUT.PUT_LINE('Employee ' || emp_rec.employee_id || ' Net: ' || v_net_salary);
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('Total processed: ' || v_processed_count);
    END process_bulk_employees;
    
END hr_employee_mgmt;
/