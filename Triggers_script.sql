
/****************************************
                                        *
 TRIGGERS SCRIPT FILE                   *
                                        *
****************************************/


/* PHONE CONTROL */
/* FUNCTION: VERIFY IF THE TELEFONE NUMBER IS A NUMBER TYPE */
create or replace TRIGGER PHONE_CONTROL
BEFORE INSERT OR UPDATE
ON PATIENT
FOR EACH ROW
DECLARE
    TELEPHONE NUMBER;
BEGIN

   TELEPHONE := TO_NUMBER(:NEW.TELEPHONE);

EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ERROR');
       -- RAISE_APPLICATION_ERROR(-20001,'THE TELEPHONE NUMBER IS NOT NUMBER TYPE');
END;

/* EVENT CONTROL */
/* FUNCTION: INSERT INTO CONTROL TABLE, WHEN A EVENT RELATED TO THE PATIENT TABLE IS ACTIVATED*/
CREATE OR REPLACE TRIGGER  EVENT_PATIENT 
BEFORE UPDATE OR DELETE OR INSERT
ON PATIENT
FOR EACH ROW
DECLARE
    LASTID NUMBER;
BEGIN

    SELECT COALESCE(MAX(ID),0) INTO LASTID FROM CONTROL ;
    
    IF inserting THEN
        INSERT INTO CONTROL VALUES(LASTID+1,'INSERT',SYSDATE);
    END IF;
    
    IF updating THEN
        INSERT INTO CONTROL VALUES(LASTID+1,'UPDATE',SYSDATE);
    END IF;
    
EXCEPTION
    WHEN VALUE_ERROR THEN
        RAISE_APPLICATION_ERROR(-20001,'VALUE ERROR');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002,'ERROR IN THE TRIGGER');
    
END;

/*AVOID ID DUPLICAT ERROR*/
/*FUNCTION: THIS TRIGGER, MODIFY THE NEW ID INSERTED WHEN THIS LATTER IS DUPLICATED, THEREFORE INCREMENT ONE MORE VALUE TO THE LAST ID INSERTED */
CREATE OR REPLACE TRIGGER DUPLICATE_ID
BEFORE INSERT
ON PATIENT
FOR EACH ROW
DECLARE
    D_ID INTEGER;
BEGIN
    SELECT ID INTO D_ID FROM patient p WHERE p.id = :NEW.ID;
    
    if(D_ID = :NEW.ID) THEN
        :NEW.ID := :NEW.ID + 1;
    END IF;
END;


