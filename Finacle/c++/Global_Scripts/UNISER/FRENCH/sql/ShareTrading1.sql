-----------------------------------------------------------------------------------    
--	Name			: ShareTrading1.sql
--	Description		: The file is used to upload the Share trading transaction.  
--	Date			: 05-03-2013
--	Author			: GOKULKRISHNA
--	Input			: NA
--	Output			: NA
--	Called Script	: 
--	Calling Scrip	: NA
--	Menu Option		: CSTTM
--	Srl. No			Date			Author			Description.   
--	-------			---------		-------			---------------			
--	1.0				05-03-2013		GOKULKRISHNA	Original Version
------------------------------------------------------------------------------------
delete CUSTOM.TRADING_TABLE where bank_id = '&1'
/
commit
/
delete CUSTOM.TRADING_TRAN_TABLE where bank_id = '&1'
/
commit
/
exit
