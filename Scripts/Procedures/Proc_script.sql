CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMIN"."CUSTOMER_SIGNUP" (
    c_fName customer.firstname%type, 
    c_lName customer.lastname%type, 
    c_phoneNum customer.phonenum%type, 
    c_address customer.address%type, 
    c_zipcode customer.zipcode%type)
is
begin
  insert into customer(id, firstname, lastname, phonenum, address, zipcode)
  values (customer_id_seq.nextval, c_fName, c_lName, c_phoneNum, c_address, c_zipcode);
  commit;
end;

/

CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMIN"."CUSTOMER_UPDATE" (   
    c_id customer.id%type default 'no_proper_input',
    c_fName customer.firstname%type default 'no_proper_input', 
    c_lName customer.lastname%type default 'no_proper_input', 
    c_phoneNum customer.phonenum%type default 'no_proper_input', 
    c_address customer.address%type default 'no_proper_input', 
    c_zipcode customer.zipcode%type default 1111)  
IS  
BEGIN  
    UPDATE CUSTOMER 
    SET firstname = c_fname,
        lastname = c_lname,
        phonenum = c_phonenum,
        address = c_address,
        zipcode = c_zipcode
    WHERE id = c_id;  
COMMIT;  
END;

/

CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMIN"."DELIVERYORDER_SETUP" (  
    c_id customer.id%type,
    do_zipcode deliveryorder.zipcode%type,
    do_deliverid deliveryorder.deliverid%type,
    do_datetime deliveryorder.datetime%type,
    do_address deliveryorder.address%type,
    do_phonenum deliveryorder.phonenumber%type)  
IS  
BEGIN
    insert into deliveryorder(id, customerid, zipcode, deliverid, datetime, address, phonenumber, orderstatus, deliverystatus)
    values(deliveryorder_id_seq.nextval, c_id, do_zipcode, do_deliverid, do_datetime, do_address, do_phonenum, 'preparing', 'accepted');
    COMMIT;  
    exception when no_data_found then DBMS_OUTPUT.PUT_LINE('invalid in input');
END;
/

set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMIN"."DINEINORDER_SETUP" (  
    t_id diningtable.id%type,
    c_id customer.id%type,
    do_status dineinorder.status%type,
    do_datetime dineinorder.datetime%type)  
IS  
BEGIN
    insert into dineinorder(id, tableid, customerid, status, datetime)
    values(dineinorder_id_seq.nextval, t_id, c_id, do_status, do_datetime);
    COMMIT;  
exception when no_data_found then DBMS_OUTPUT.PUT_LINE('invalid in input');
END;

/


CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMIN"."MEMBER_SIGNUP" (   
    c_id customer.id%type,
    m_discount member.discount%type, 
    m_flavor member.flavor%type, 
    m_birthday member.birthday%type, 
    m_balance member.balance%type, 
    m_expirydate member.expirydate%type)  
IS  
    v_tmp number := -1;
BEGIN
    select memberid into v_tmp from customer where id = c_id;
    if v_tmp != -1
    then dbms_output.put_line('this customer is already a memeber!');
    else  
    insert into member
    values (member_id_seq.nextval, m_discount, m_flavor, m_birthday, m_balance, m_expirydate, 'active');
    update customer
    set memberid = member_id_seq.currval
    where id = c_id;
    COMMIT;  
    end if;
END;

/

CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMIN"."MEMBER_UPDATEBYMEMBERID" (   
    m_id member.id%type,
    m_discount member.discount%type,
    m_flavor member.flavor%type, 
    m_birthday member.birthday%type, 
    m_balance member.balance%type, 
    m_expirydate member.expirydate%type)  
IS  
    v_tmp member.id%type := -1;
BEGIN
    select id into v_tmp from member where id = m_id;
    update member
    set
        discount = m_discount,
        flavor = m_flavor,
        birthday = m_birthday,
        balance = m_balance,
        expirydate = m_expirydate
    where id = m_id;
    COMMIT;  
exception when no_data_found then DBMS_OUTPUT.PUT_LINE('invalid in input');
END;

/

CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMIN"."ORDER_FOOD" (  
    order_type varchar2,
    order_id foodlist.dineinorderid%type,
    item_id foodlist.dishid%type,
    item_quant foodlist.quantity%type)  
IS  
BEGIN
    if order_type = 'dinein' then
    insert into foodlist(dineinorderid, dishid, quantity)
    values(order_id, item_id, item_quant);
    COMMIT;
    elsif order_type = 'delivery' then 
    insert into foodlist(deliveryorderid, dishid, quantity)
    values(order_id, item_id, item_quant);
    COMMIT;
    else DBMS_OUTPUT.PUT_LINE('invalid input of order type');
    end if;
exception when no_data_found then DBMS_OUTPUT.PUT_LINE('invalid in input');
END;

/