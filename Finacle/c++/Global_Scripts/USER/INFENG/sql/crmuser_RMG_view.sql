CREATE OR REPLACE FORCE VIEW RMG
(
   PERSON_ID,
   BANK_ID,
   LOGIN_ID,
   SALUTATION,
   FIRST_NAME,
   MIDDLE_NAME,
   LAST_NAME,
   GENDER,
   DESIGNATION
)
AS
   SELECT TO_CHAR (USERS.personid) person_id,
          to_char(AGENT_ENTITY_DETAILS.bank_id) bank_id,
         to_char(USERS.loginid) login_id,
          to_char(PERSON.salutation) salutation,
          to_char(PERSON.firstname) first_name,
          to_char(PERSON.middlename) middle_name,
          to_char(PERSON.lastname) last_name,
          to_char(PERSON.gender) gender,
          to_char(AGENT_ENTITY_DETAILS.designation) designation
     FROM crmuser.USERS,
          crmuser.PERSON,
          crmuser.AGENTS,
          crmuser.AGENT_ENTITY_DETAILS
    WHERE     USERS.PERSONID = AGENTS.PERSONID
          AND AGENTS.PERSONID = PERSON.PERSONID
          AND AGENTS.PERSONID = AGENT_ENTITY_DETAILS.PERSONID(+)
          AND USERS.CUSTRELATION = 'Y'
          UNION
    SELECT TO_CHAR(USER_ID) PERSON_ID,
                TO_CHAR(HOME_BANK_ID) BANK_ID,
                TO_CHAR(USER_ID) LOGIN_ID,
                NULL SALUTATION,
                TO_CHAR(EMP_NAME) FIRST_NAME,
               NULL MIDDLE_NAME,
                NULL LAST_NAME,
                NULL GENDER,
                EMP_DESIG DESIGNATION 
FROM TBAADM.GET, 
                TBAADM.UPR 
WHERE USER_EMP_ID=EMP_ID;

