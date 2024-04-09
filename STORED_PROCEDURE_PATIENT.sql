SET SERVEROUTPUT ON;

/**
*
*@info: insert 
*@params:
*       -> name
*       -> lastname
*       -> dni
*       -> birthdate
*       -> gender
*       -> address
*       -> telephone
*       -> email
*       -> others_details
*/
CREATE OR REPLACE PROCEDURE insert_Patient(name IN VARCHAR2,
                                            lastname IN VARCHAR2,
                                            dni IN INTEGER,
                                            birthdate IN DATE,
                                            gender IN VARCHAR2,
                                            address IN VARCHAR2,
                                            telephone IN INTEGER,
                                            email IN VARCHAR2,
                                            OTHER_DETAILS IN CLOB
                                            )
    IS
        reg_patient PATIENT%ROWTYPE;
        uniqueDNI PATIENT.dni%TYPE;
    BEGIN
        
        /*
        *insert the last id plus 1
        **/
        SELECT COALESCE(MAX(id),0)+1 INTO reg_patient.id FROM PATIENT;
        
        
        /**
        * INSERT OTHERS ATTRIBUTE
        */
        reg_patient.name:=name;
        reg_patient.lastname:=lastname;
        reg_patient.dni:=dni;
        reg_patient.birthdate:=birthdate;
        reg_patient.gender:=gender;
        reg_patient.address:=address;
        reg_patient.telephone:=telephone;
        reg_patient.email:=email;
        reg_patient.other_details:=other_details;
        
        
        
        INSERT INTO PATIENT (id,name,lastname,dni,birthdate,gender,address,telephone,email,other_details) values(
                                        reg_patient.id,
                                        reg_patient.name,
                                        reg_patient.lastname,
                                        reg_patient.dni,
                                        reg_patient.birthdate,
                                        reg_patient.gender,
                                        reg_patient.address,
                                        reg_patient.telephone,
                                        reg_patient.email,
                                        reg_patient.other_details
        );
                               
        COMMIT;        
        DBMS_OUTPUT.PUT_LINE('Guardado exitoso !!');
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('PATIENT NOT FOUND');
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error: Violación de restricción de clave duplicada.');
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('VALUE ERROR');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR IN PATIENT STORED PROCEDURE');

END;


/**
*
*@info: insert by patient object
*@params:
*       -> patient row type
*/
CREATE OR REPLACE PROCEDURE insert_Patient_by_Object(reg_patient IN PATIENT%ROWTYPE)
    IS
        last_id Integer;
        uniqueDNI PATIENT.dni%TYPE;
    BEGIN
        
        /*
        *insert the last id plus 1
        **/
        SELECT COALESCE(MAX(id),0)+1 INTO last_id FROM PATIENT;
                
        
        INSERT INTO PATIENT (id,name,lastname,dni,birthdate,gender,address,telephone,email,other_details) values(
                                        last_id,
                                        reg_patient.name,
                                        reg_patient.lastname,
                                        reg_patient.dni,
                                        reg_patient.birthdate,
                                        reg_patient.gender,
                                        reg_patient.address,
                                        reg_patient.telephone,
                                        reg_patient.email,
                                        reg_patient.other_details
        );
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Guardado exitoso !!');
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('PATIENT NOT FOUND');
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error: Violación de restricción de clave duplicada.');
        WHEN VALUE_ERROR THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('VALUE ERROR');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR IN PATIENT STORED PROCEDURE');

END;

/**
*
*@info: update
*@params:
*       -> name
*       -> lastname
*       -> dni
*       -> birthdate
*       -> gender
*       -> address
*       -> telephone
*       -> email
*       -> others_details
*/

CREATE OR REPLACE PROCEDURE update_patient(reg_patient IN PATIENT%ROWTYPE)
IS

    sentences VARCHAR2(200):='UPDATE PATIENT SET ';
BEGIN
 
    
    /*name*/
    IF(length(reg_patient.name)!=0) THEN
        sentences:= sentences || ' name = '''||reg_patient.name||''' ,';
    END IF;
    
    
    IF(length(reg_patient.lastname)!=0) THEN
        sentences:= sentences || ' lastname = '''||reg_patient.lastname||''' ,';
    END IF;
    
   
    IF(length(reg_patient.birthdate)!=0) THEN
        sentences:= sentences || ' birthdate = '''||reg_patient.birthdate||''' ,';
    END IF;
    
   
    IF(length(reg_patient.address)!=0) THEN
       sentences:= sentences || ' address = '''||reg_patient.address||''' ,';
    END IF;
    
    IF(length(reg_patient.telephone)!=0) THEN
        sentences:= sentences || ' telephone = '||to_char(reg_patient.telephone)||' ,';
    END IF;
    
    IF(length(reg_patient.email)!=0) THEN
        sentences:= sentences || ' email = '''||reg_patient.email||''' ,';
    END IF;
    
    
    IF(length(reg_patient.other_details)!=0) THEN
        sentences:= sentences || ' other_details = '''||reg_patient.other_details||''' ,';
    END IF;
    
    /**BORRAMOS ULTIMA ','/*/
    sentences:=SUBSTR(sentences,1,LENGTH(sentences)-1);
    
    sentences:=sentences || ' WHERE id = ' || TO_CHAR(reg_patient.id);
    
    dBMS_OUTPUT.PUT_LINE(sentences);
    EXECUTE IMMEDIATE sentences;
    COMMIT;
    
    dBMS_OUTPUT.PUT_LINE('Actualizacion completada');

END;


/**
*
*@info: delete
*@params:
*       -> id
*       
*/
CREATE OR REPLACE PROCEDURE DELETE_PATIENT(a_ID IN PATIENT.ID%TYPE)IS
    BOOL INTEGER :=0;
BEGIN
    SELECT 1 INTO BOOL FROM PATIENT p WHERE p.ID = a_ID;
    
    IF BOOL = 1 THEN 
        DELETE FROM PATIENT WHERE ID = a_ID;
        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('PACIENTE INEXISTENTE !!');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('DATO INEXISTENTE');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR');
END;


/**
*
*@info: get patient info
*/
CREATE OR REPLACE PROCEDURE GetPatientInfo(a_ID PATIENT.ID%TYPE)IS                                        
    reg_patient PATIENT%ROWTYPE;
    
    CURSOR C_PATIENT IS SELECT * FROM PATIENT WHERE ID = a_ID;
    
BEGIN
    OPEN C_PATIENT;
    
    FETCH C_PATIENT INTO reg_patient.id,reg_patient.name,reg_patient.lastname,reg_patient.dni,reg_patient.birthdate,reg_patient.gender,reg_patient.address,reg_patient.telephone,reg_patient.email,reg_patient.other_details;
    
    CLOSE C_PATIENT;
    
    dBMS_OUTPUT.PUT_LINE('ID                :' || reg_patient.id);
    dBMS_OUTPUT.PUT_LINE('NAME              :' || reg_patient.name);
    dBMS_OUTPUT.PUT_LINE('LASTNAME          :' || reg_patient.lastname);
    dBMS_OUTPUT.PUT_LINE('DNI               :' || reg_patient.dni);
    dBMS_OUTPUT.PUT_LINE('BIRTHDATE         :' || reg_patient.birthdate);
    dBMS_OUTPUT.PUT_LINE('GENDER            :' || reg_patient.gender);
    dBMS_OUTPUT.PUT_LINE('ADDRESS           :' || reg_patient.address);
    dBMS_OUTPUT.PUT_LINE('TELEPHONE         :' || reg_patient.telephone);
    dBMS_OUTPUT.PUT_LINE('EMAIL             :' || reg_patient.email);
    dBMS_OUTPUT.PUT_LINE('OTHERS DETAILS    :' || reg_patient.other_details);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR');
END;


/**
*
*@info: get patient info with cursor
*/
CREATE OR REPLACE PROCEDURE getCursorInfoPatient(a_ID IN PATIENT.ID%TYPE, p_Cursor OUT SYS_REFCURSOR) IS

BEGIN
    OPEN p_Cursor FOR SELECT * FROM PATIENT WHERE PATIENT.ID = a_ID;

END;

/**
*
*@info: get all patient info with cursor
*/
CREATE OR REPLACE PROCEDURE getCursorAllInfoPatient(p_Cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM PATIENT;
END;


/*===============================================================*/




DECLARE
    reg_patient PATIENT%ROWTYPE;
    p_Cursor sys_refcursor;
    
BEGIN
    
    getCursorAllInfoPatient(p_Cursor);
    
   LOOP
    
        FETCH p_Cursor INTO reg_patient.id,reg_patient.name,reg_patient.lastname,reg_patient.dni,reg_patient.birthdate,reg_patient.gender,reg_patient.address,reg_patient.telephone,reg_patient.email,reg_patient.other_details;
        dBMS_OUTPUT.PUT_LINE('ID                :' || reg_patient.id);
        dBMS_OUTPUT.PUT_LINE('NAME              :' || reg_patient.name);
        dBMS_OUTPUT.PUT_LINE('LASTNAME          :' || reg_patient.lastname);
        dBMS_OUTPUT.PUT_LINE('DNI               :' || reg_patient.dni);
        dBMS_OUTPUT.PUT_LINE('BIRTHDATE         :' || reg_patient.birthdate);
        dBMS_OUTPUT.PUT_LINE('GENDER            :' || reg_patient.gender);
        dBMS_OUTPUT.PUT_LINE('ADDRESS           :' || reg_patient.address);
        dBMS_OUTPUT.PUT_LINE('TELEPHONE         :' || reg_patient.telephone);
        dBMS_OUTPUT.PUT_LINE('EMAIL             :' || reg_patient.email);
        dBMS_OUTPUT.PUT_LINE('OTHERS DETAILS    :' || reg_patient.other_details);
        DBMS_OUTPUT.PUT_LINE('====================================================');
        
        EXIT WHEN p_Cursor%notfound; 
        
        
        
    
   END LOOP;
   
END;




UPDATE PATIENT SET email='asdasd@hh.com',lastname='asdasd' WHERE ID = 8;
            
 
                           