-- Test Scenarios for AUCA Access Policy

-- 1. View current violations (should show the blocked attempt)
select *
  from access_violations
 order by attempt_time desc;

-- 2. Check current time and day
select to_char(
   sysdate,
   'Day'
) as current_day,
       to_char(
          sysdate,
          'HH24:MI'
       ) as current_time,
       to_char(
          sysdate,
          'D'
       ) as day_number
  from dual;

-- 3. Simulate business hours test (modify time for testing)
-- This would work during Mon-Fri 8AM-5PM
insert into system_data (
   id,
   data_value
) values ( data_seq.nextval,
           'Business hours test' );

insert into system_data (
   id,
   data_value
) values ( data_seq.nextval,
           'Test autonomous transaction' );


-- 4. Test different operations that should be blocked
-- UPDATE system_data SET data_value = 'Updated' WHERE id = 1;
-- DELETE FROM system_data WHERE id = 1;

-- 5. View all violation attempts (table with borders)
SET PAGESIZE 50
SET LINESIZE 100
COLUMN violation_id FORMAT 999 HEADING 'ID'
COLUMN user_name FORMAT A20 HEADING 'User Name'
COLUMN attempted_action FORMAT A10 HEADING 'Action'
COLUMN formatted_time FORMAT A15 HEADING 'Date/Time'
COLUMN violation_type FORMAT A15 HEADING 'Violation Type'

SELECT 
    violation_id,
    SUBSTR(user_name, 1, 20) AS user_name,
    attempted_action,
    TO_CHAR(attempt_time, 'DD-MON HH24:MI') AS formatted_time,
    violation_type
FROM access_violations 
ORDER BY attempt_time DESC;