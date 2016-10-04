-- The following is done to test the 'insufficient privileges error' when trying to execute a DDL inside a stored procedure
-- The user 'hr' is granted 'create table ' via a role 
REVOKE RESOURCE FROM hr;
REVOKE CREATE TABLE FROM hr;
GRANT CREATE PROCEDURE TO hr;

-- Create a new role and grant 'create table ' to that role
CREATE ROLE create_test_table;
GRANT CREATE TABLE TO create_test_table; 
GRANT create_test_table TO hr;
ALTER USER hr QUOTA 10m on USERS;*/

/*Output
REVOKE succeeded.
REVOKE succeeded.
GRANT succeeded.
role CREATE_TEST_TABLE created.
GRANT succeeded.
GRANT succeeded.
user HR altered.
*/