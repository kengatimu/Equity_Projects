--#############################################################################################################							
-- Source Name						: BChqReq_Seq									
-- Date								: 12-03-2013									
-- Description						: This  is used to get the sequence 							
-- Input							: None																	
-- Author     						: Gokulkrishna									
-- Bank								: 								
-- Modification History				:				
--		< Version No.> 			<Date>		<Author Name> 		<Description>									
--		 0.1					12-03-2013 	Gokulkrishna 			Original Version									
--############################################################################################################

drop sequence CUSTOM.BChqReq_Seq_54
/

create sequence CUSTOM.BChqReq_Seq_54
minvalue 1
maxValue 99999999
START WITH 1
INCREMENT BY 1
NOCACHE
/
grant select on CUSTOM.BChqReq_Seq_54 to TBAGEN,TBAADM,TBAUTIL
/

drop sequence CUSTOM.BChqReq_Seq_50
/
create sequence CUSTOM.BChqReq_Seq_50
minvalue 1
maxValue 99999999
START WITH 1
INCREMENT BY 1
NOCACHE
/
grant select on CUSTOM.BChqReq_Seq_50 to TBAGEN,TBAADM,TBAUTIL
/

drop sequence CUSTOM.BChqReq_Seq_55
/
create sequence CUSTOM.BChqReq_Seq_55
minvalue 1
maxValue 99999999
START WITH 1
INCREMENT BY 1
NOCACHE
/
grant select on CUSTOM.BChqReq_Seq_55 to TBAGEN,TBAADM,TBAUTIL
/

drop sequence CUSTOM.BChqReq_Seq_56
/
create sequence CUSTOM.BChqReq_Seq_56
minvalue 1
maxValue 99999999
START WITH 1
INCREMENT BY 1
NOCACHE
/
grant select on CUSTOM.BChqReq_Seq_56 to TBAGEN,TBAADM,TBAUTIL
/

drop sequence CUSTOM.BChqReq_Seq_11
/
create sequence CUSTOM.BChqReq_Seq_11
minvalue 1
maxValue 99999999
START WITH 1
INCREMENT BY 1
NOCACHE
/
grant select on CUSTOM.BChqReq_Seq_11 to TBAGEN,TBAADM,TBAUTIL
/
