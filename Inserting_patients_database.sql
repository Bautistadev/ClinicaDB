SET SERVEROUTPUT ON;

/*
PLSQL SCRIPT THAT INSERT ALL FICTITIUS DATA INTO THE DATA BASE CLINICA

*/
SELECT * FROM PATIENT;

DECLARE

 /*INSTANCE FOR THE TABLE PATIENT LAST ID*/
 LastId INTEGER;
 
 /*CREATE A SIMULATION TABLE, USING  ARRAYS OF ORDER 5 */
 TYPE M_PATIENT IS VARRAY(9) OF VARCHAR2(30);
 TYPE L_PATIENT IS VARRAY(10) OF M_PATIENT;
 lPatient L_PATIENT;
 
 
BEGIN

    /*COMPLETE THE ARRAY LIST WITH PERSON DATA*/

    lpatient := L_PATIENT(
        M_PATIENT('María', 'López','12345678', '1990-03-25','Femenino', 'Avenida Principal', '987654321', 'maria@example.com', 'Detalles del paciente 2'),
        M_PATIENT('Ana', 'Martínez','98765432', '1995-09-20','Femenino', 'Calle 456', '111222333', 'ana@example.com', 'Detalles del paciente 3'),
        M_PATIENT('Pedro', 'Gómez','56789012', '1980-04-12', 'Masculino', 'Avenida Central', '444555666', 'pedro@example.com', 'Detalles del paciente 4'),
        M_PATIENT('Luisa', 'Rodríguez','34567890', '2000-12-05', 'Femenino', 'Plaza Principal', '777888999', 'luisa@example.com', 'Detalles del paciente 5'),
        M_PATIENT('Javier', 'Hernández','90123456', '1975-11-08', 'Masculino', 'Carretera 123', '123456789', 'javier@example.com', 'Detalles del paciente 6'),
        M_PATIENT('Sofía', 'García','65432109', '1993-08-15', 'Femenino', 'Avenida 123', '555666777', 'sofia@example.com', 'Detalles del paciente 7'),
        M_PATIENT('Daniel', 'Pérez','21098765', '1988-06-30', 'Masculino', 'Calle 789', '999888777', 'daniel@example.com', 'Detalles del paciente 8'),
        M_PATIENT('Laura', 'Díaz','43210987','1977-05-20', 'Femenino', 'Calle 456', '333444555', 'laura@example.com', 'Detalles del paciente 9'),
        M_PATIENT('Carlos', 'Gutiérrez','78901234', '1999-02-10', 'Masculino', 'Avenida 789', '222333444', 'carlos@example.com', 'Detalles del paciente 10'),
        M_PATIENT('Martina', 'Ruiz','87654321','1985-11-18', 'Femenino', 'Calle 567', '666777888', 'martina@example.com', 'Detalles del paciente 11')
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
                    DNI,
                    BIRTHDATE,
                    GENDER,
                    ADDRESS,
                    TELEPHONE,
                    EMAIL,
                    OTHER_DETAILS
                    )
            VALUES
                (LastId+I,
                lPatient(I)(1),
                lPatient(I)(2),
                lPatient(I)(3), 
                to_date(lPatient(I)(4),'YYYY-MM-DD'),
                lPatient(I)(5), 
                lPatient(I)(6),
                lPatient(I)(7), 
                lPatient(I)(8),
                lPatient(I)(9)
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

