# Database Systems Class Activity

## Team Members
1. **Ingabire Esther** - 27202
2. **Nkurunziza Amos** - 26973
3. **uwitonze pacific** - 26983
4. 

## Project Structure

### Q1 - AUCA System Access Policy
**Location**: `q1/`

**Description**: Implementation of database access control system with business hours restrictions and audit logging.

**Business Rules**:
- No access on Sabbath (Saturday/Sunday)
- Access only during business hours (Monday-Friday, 8AM-5PM)
- All violation attempts logged for audit compliance

**Files**:
- `auca_scripts.sql` - Main database setup script
- `combined_trigger.sql` - Final working trigger implementation
- `sample_violations.sql` - Sample violation data for testing
- `test_scenarios.sql` - Test cases and validation queries

**Key Features**:
- Oracle database triggers for access control
- Autonomous transaction logging
- Real-time violation blocking
- Complete audit trail

### Q2 - HR Employee Management System Package
**Location**: `q2/`

**Description**: PL/SQL package for HR Employee Management System with salary calculations and tax deductions.

**Requirements**:
- Functions to calculate RSSB tax and net salary
- Dynamic procedures for employee operations
- Security context with USER/CURRENT_USER and DEFINER/INVOKER rights
- Bulk operations using loops or cursors

**Files**:
- `01_package_spec.sql` - Package specification with function/procedure declarations
- `02_package_body.sql` - Package body with implementation logic
- `03_setup_tables.sql` - Employee tables and sample data setup
- `04_test_calls.sql` - Test cases and sample function/procedure calls

## Usage Instructions

### Q1 - AUCA System Access Policy
1. **Setup Database**: Run `q1/auca_scripts.sql` to create tables and sequences
2. **Deploy Triggers**: Run `q1/combined_trigger.sql` for access control
3. **Test System**: Use `q1/test_scenarios.sql` to validate functionality
4. **Sample Data**: Run `q1/sample_violations.sql` for demo data

### Q2 - HR Employee Management System
1. **Setup Tables**: Run `q2/03_setup_tables.sql` to create employee tables
2. **Create Package**: Run `q2/01_package_spec.sql` then `q2/02_package_body.sql`
3. **Test Functions**: Use `q2/04_test_calls.sql` to test RSSB calculations

## Documentation
- **Screenshots**: Implementation screenshots and test results included
- **Test Results**: Violation logs and system validation outputs
- **Code Examples**: Sample function calls and procedure executions
