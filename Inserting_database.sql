SET SERVEROUTPUT ON;

/*
PLSQL SCRIPT THAT INSERT ALL FICTITIUS DATA INTO THE DATA BASE CLINICA

*/


DECLARE

 /*INSTANCE FOR THE TABLE PATIENT LAST ID*/
 LastId INTEGER;
 
 /*CREATE A SIMULATION TABLE, USING  ARRAYS OF ORDER 5 */
 TYPE M_PATIENT IS VARRAY(8) OF VARCHAR2(30);
 TYPE L_PATIENT IS VARRAY(10) OF M_PATIENT;
 lPatient L_PATIENT;
 
 
BEGIN

    /*COMPLETE THE ARRAY LIST WITH PERSON DATA*/

    lpatient := L_PATIENT(
        M_PATIENT('María', 'López', '1990-03-25', 'Avenida Principal', '987654321', 'maria@example.com', 'Detalles del paciente 2', 'Femenino'),
        M_PATIENT('Ana', 'Martínez', '1995-09-20', 'Calle 456', '111222333', 'ana@example.com', 'Detalles del paciente 3', 'Femenino'),
        M_PATIENT('Pedro', 'Gómez', '1980-04-12', 'Avenida Central', '444555666', 'pedro@example.com', 'Detalles del paciente 4', 'Masculino'),
        M_PATIENT('Luisa', 'Rodríguez', '2000-12-05', 'Plaza Principal', '777888999', 'luisa@example.com', 'Detalles del paciente 5', 'Femenino'),
        M_PATIENT('Javier', 'Hernández', '1975-11-08', 'Carretera 123', '123456789', 'javier@example.com', 'Detalles del paciente 6', 'Masculino'),
        M_PATIENT('Sofía', 'García', '1993-08-15', 'Avenida 123', '555666777', 'sofia@example.com', 'Detalles del paciente 7', 'Femenino'),
        M_PATIENT('Daniel', 'Pérez', '1988-06-30', 'Calle 789', '999888777', 'daniel@example.com', 'Detalles del paciente 8', 'Masculino'),
        M_PATIENT('Laura', 'Díaz', '1977-05-20', 'Calle 456', '333444555', 'laura@example.com', 'Detalles del paciente 9', 'Femenino'),
        M_PATIENT('Carlos', 'Gutiérrez', '1999-02-10', 'Avenida 789', '222333444', 'carlos@example.com', 'Detalles del paciente 10', 'Masculino'),
        M_PATIENT('Martina', 'Ruiz', '1985-11-18', 'Calle 567', '666777888', 'martina@example.com', 'Detalles del paciente 11', 'Femenino')
    );

    /*INSERT INTO LastId VARIABLE WITH THE LAST ID, USING SENTENCES OF SELECTION*/
    SELECT COALESCE(MAX(ID),0) INTO LastId FROM PATIENT;
    
    /*CREATE INCONDITIONAL BUCLE, WITH THE OBJETIVE OF PRINT THE ARRAY VALUES IN THE INSERT SENCENTES*/
    FOR I IN 1..lPatient.COUNT LOOP
        BEGIN
            INSERT INTO PATIENT (
                    ID,
                    NAME,
                    LASTNAME,
                    BIRTHDATE,
                    ADDRESS,
                    TELEPHONE,
                    EMAIL,
                    OTHER_DETAILS,
                    GENDER)
            VALUES
                (LastId+I,
                lPatient(I)(1),
                lPatient(I)(2),
                lPatient(I)(3), 
                lPatient(I)(4),
                lPatient(I)(5), 
                lPatient(I)(6),
                lPatient(I)(7), 
                lPatient(I)(8)
            );   
        COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
                ROLLBACK;
                RAISE;
                EXIT;
        END;
        
    END LOOP;
         
END;

DELETE FROM PATIENT;
SELECT COALESCE(MAX(ID),0)FROM PATIENT;
SELECT * FROM PATIENT;
 