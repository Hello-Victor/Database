SET SERVEROUTPUT ON;
DECLARE
already_exists exception;
pragma exception_init (already_exists, -955);
begin
--------------------------------------------------------
--  File created - Friday-December-10-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence CUSTOMER_ID_SEQ
--------------------------------------------------------
execute immediate
   'CREATE SEQUENCE  "ADMIN"."CUSTOMER_ID_SEQ"  MINVALUE 2100 MAXVALUE 5000 INCREMENT BY 1 START WITH 2120 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL';
--------------------------------------------------------
--  DDL for Sequence DELIVERYORDER_ID_SEQ
--------------------------------------------------------
execute immediate
   'CREATE SEQUENCE  "ADMIN"."DELIVERYORDER_ID_SEQ"  MINVALUE 521 MAXVALUE 10000 INCREMENT BY 1 START WITH 541 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL';
--------------------------------------------------------
--  DDL for Sequence DINEINORDER_ID_SEQ
--------------------------------------------------------
execute immediate
   'CREATE SEQUENCE  "ADMIN"."DINEINORDER_ID_SEQ"  MINVALUE 100 MAXVALUE 10000 INCREMENT BY 1 START WITH 120 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL' ;
--------------------------------------------------------
--  DDL for Sequence MEMBER_ID_SEQ
--------------------------------------------------------
execute immediate
   'CREATE SEQUENCE  "ADMIN"."MEMBER_ID_SEQ"  MINVALUE 1050 MAXVALUE 5000 INCREMENT BY 1 START WITH 1070 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL' ;
--------------------------------------------------------
--  DDL for Table CUSTOMER
--------------------------------------------------------
dbms_output.put_line('Sequence Created');
  exception
  when already_exists then
  dbms_output.put_line('Sequence already Exists');
  null;
  end;