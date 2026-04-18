
	Drop table &1;
	Create table  &1 as select * from ssoadm.USER_PROFILE_TBL where REQ_TWO_FACTOR_AUTH ='B' and HOME_ENTITY = '&2';

