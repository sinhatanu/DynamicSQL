-- The following code shows when we grant 'create table ' through a role and not direct privilege then 
-- we can create tables using static ddl, through dynamic ddl in an anonymous block,in stored procedure with invoker rights
-- but NOT with definer rights
set serveroutput on;

CREATE TABLE  tab1_with_role (n NUMBER)
/
--table TAB1_WITH_ROLE created (STATIC DDL)

BEGIN
EXECUTE IMMEDIATE 'CREATE TABLE  tab1_anonymous (n NUMBER)';
END;
/
--anonymous block completed
--Not a good approach to create table dynamically here as it can be easily done with simple DDL, it's just for testing purposes.

CREATE OR REPLACE PROCEDURE create_table_proc
AUTHID DEFINER
IS
BEGIN
EXECUTE IMMEDIATE 'CREATE TABLE tab1_definer_rights (n NUMBER)';
EXCEPTION
WHEN OTHERS  THEN 
DBMS_OUTPUT.PUT_LINE('error number '||SQLCODE||' message from oracle  '||SQLERRM);
END;
/
--PROCEDURE CREATE_TABLE_PROC compiled

BEGIN
   create_table_proc ();
END;
/
/*anonymous block completed
error number -1031 message from oracle  ORA-01031: insufficient privileges*/

CREATE OR REPLACE PROCEDURE create_table_proc_cu
AUTHID CURRENT_USER
IS
BEGIN
EXECUTE IMMEDIATE 'CREATE TABLE tab1_current_user (n NUMBER)';
DBMS_OUTPUT.PUT_LINE ('Success');
EXCEPTION
WHEN OTHERS  THEN 
DBMS_OUTPUT.PUT_LINE('error number '||SQLCODE||' message from oracle  '||SQLERRM);
END;
/

BEGIN
   create_table_proc_cu ();
END;
/

/*PROCEDURE CREATE_TABLE_PROC_CU compiled
anonymous block completed
Success
*/







