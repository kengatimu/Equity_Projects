CREATE OR REPLACE FUNCTION        CUSTOM.getCparamValue( parameterId   IN VARCHAR2,
                                                   moduleName    IN VARCHAR2,
                                                   contextBankId IN VARCHAR2
                                                 )
                                                    RETURN VARCHAR2
IS

parameterVal      VARCHAR2(100):=null;

BEGIN
    SELECT
            parameter_value
    INTO
            parameterVal
    FROM
            CUSTOM.C_CPVALUE , CUSTOM.C_CPMASTER
    WHERE
            C_CPMASTER.bank_id          = C_CPVALUE.bank_id
            AND C_CPMASTER.module_name  = C_CPVALUE.module_name
            AND C_CPMASTER.parameter_id = C_CPVALUE.parameter_id
            AND C_CPMASTER.bank_id      = contextBankId
            AND C_CPMASTER.module_name  = moduleName
            AND C_CPVALUE.parameter_id  = parameterId;

    RETURN parameterVal;

END getCparamValue; 
