-- HR Employee Management System Package Specification
CREATE OR REPLACE PACKAGE hr_employee_mgmt AS
    -- Function to calculate RSSB tax (3% of gross salary)
    FUNCTION calculate_rssb_tax(p_gross_salary NUMBER) RETURN NUMBER;
    
    -- Function to calculate net salary after RSSB deduction
    FUNCTION calculate_net_salary(p_employee_id NUMBER) RETURN NUMBER;
    
    -- Dynamic procedure for employee operations
    PROCEDURE dynamic_employee_operation(
        p_operation VARCHAR2,
        p_employee_id NUMBER DEFAULT NULL,
        p_salary NUMBER DEFAULT NULL
    );
    
    -- Bulk processing procedure (Optional Challenge)
    PROCEDURE process_bulk_employees(p_department_id NUMBER);
END hr_employee_mgmt;
/