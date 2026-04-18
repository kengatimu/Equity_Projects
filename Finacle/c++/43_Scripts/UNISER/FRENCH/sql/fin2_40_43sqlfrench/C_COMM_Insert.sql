--====================================================================================================                    
-- Table Name             : CUSTOM.C_COMM
-- Date                   : 12-JUL-2018                    
-- Description            : This script is for inserting the Commission Codes.     
-- Author                 : Shiva Krishna D       
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================
REM INSERTING into CUSTOM.C_COMM
SET DEFINE OFF;
Insert into CUSTOM.C_COMM (COMM_CODE,COMM_DESC,CRNCY_CODE,VAT_RATE,RCRE_USER_ID,RCRE_TIME,LCHG_USER_ID,LCHG_TIME,BANK_ID,DEL_FLG,MIN_COMM,COMM_PCNT) values ('BG001','BANK GUARANTEE CDF','CDF',16,'SYSTEM',sysdate,'SYSTEM',sysdate,'43','N',0,0.5);
Insert into CUSTOM.C_COMM (COMM_CODE,COMM_DESC,CRNCY_CODE,VAT_RATE,RCRE_USER_ID,RCRE_TIME,LCHG_USER_ID,LCHG_TIME,BANK_ID,DEL_FLG,MIN_COMM,COMM_PCNT) values ('BG002','BANK GUARANTEE USD','USD',16,'SYSTEM',sysdate,'SYSTEM',sysdate,'43','N',30,0.5);
Insert into CUSTOM.C_COMM (COMM_CODE,COMM_DESC,CRNCY_CODE,VAT_RATE,RCRE_USER_ID,RCRE_TIME,LCHG_USER_ID,LCHG_TIME,BANK_ID,DEL_FLG,MIN_COMM,COMM_PCNT) values ('BG003','BANK GUARANTEE EUR','EUR',16,'SYSTEM',sysdate,'SYSTEM',sysdate,'43','N',30,0.5);
Insert into CUSTOM.C_COMM (COMM_CODE,COMM_DESC,CRNCY_CODE,VAT_RATE,RCRE_USER_ID,RCRE_TIME,LCHG_USER_ID,LCHG_TIME,BANK_ID,DEL_FLG,MIN_COMM,COMM_PCNT) values ('LC001','LETTER OF CREDIT CDF','CDF',16,'SYSTEM',sysdate,'SYSTEM',sysdate,'43','N',0,0.5);
Insert into CUSTOM.C_COMM (COMM_CODE,COMM_DESC,CRNCY_CODE,VAT_RATE,RCRE_USER_ID,RCRE_TIME,LCHG_USER_ID,LCHG_TIME,BANK_ID,DEL_FLG,MIN_COMM,COMM_PCNT) values ('LC002','LETTER OF CREDIT USD','USD',16,'SYSTEM',sysdate,'SYSTEM',sysdate,'43','N',50,0.5);
Insert into CUSTOM.C_COMM (COMM_CODE,COMM_DESC,CRNCY_CODE,VAT_RATE,RCRE_USER_ID,RCRE_TIME,LCHG_USER_ID,LCHG_TIME,BANK_ID,DEL_FLG,MIN_COMM,COMM_PCNT) values ('LC003','LETTER OF CREDIT EUR','EUR',16,'SYSTEM',sysdate,'SYSTEM',sysdate,'43','N',50,0.5);
COMMIT;