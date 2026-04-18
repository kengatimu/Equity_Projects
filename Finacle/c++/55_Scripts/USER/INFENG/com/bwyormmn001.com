################################################################################
# Source Name           : bwyormmn001.com
# Date                  : 01-10-2007
# Description           : Extracts the required fields from message coming from 
#			  Ebanking and insert into CREM table
# Author                : Somak De
# Called SQL            : bwyormmn001.com
##################################################################################

SWFfile=$2
echo $SWFfile > cbwyorm1.log
bankId1="$1"

bankId=`echo \'$1\'`





datfiles=`ls -l $SWFfile/*.dat |tr -s " " " " | cut -d " " -f9`
echo $datfiles >> cbwyorm1.log


for d in $datfiles
do
	
	
	chmod 777 $d
	count=`cat $d|wc -l`
	
	i=1
	
	line=`cat $d|head -$i|tail -1`
	
	echo "lineis:" $line >> logs.log
	
	while [ $i -le $count ]
	 do
	
			line=`cat $d|head -$i|tail -1`
			ReqSlrNo=`echo $line|cut -d"|" -f1`
			ReqSlrNo=`echo \'$ReqSlrNo\'`
			BeneFirstName=`echo $line|cut -d"|" -f4`
			BeneSecondName=`echo $line|cut -d"|" -f5`
			BeneLastName=`echo $line|cut -d"|" -f6`
			
			BeneFullName1=`echo $BeneFirstName $BeneSecondName $BeneLastName`
			BeneFullName=`echo \'$BeneFullName1\'`
					
			BeneAddress1_1=`echo $line|cut -d"|" -f7`
			BeneAddress2_1=`echo $line|cut -d"|" -f8`
			BeneAddress3_1=`echo $line|cut -d"|" -f9`
			
			BeneAddress1=`echo \'$BeneAddress1_1\'`
			BeneAddress2=`echo \'$BeneAddress2_1\'`
			BeneAddress3=`echo \'$BeneAddress3_1\'`
			
			BeneCountry=`echo $line|cut -d"|" -f10`
			BeneCountry=`echo \'$BeneCountry\'`
			
			BeneBIC_1=`echo $line|cut -d"|" -f11`
			BeneBIC=`echo \'$BeneBIC_1\'`
			

			BeneAcid_1=`echo $line|cut -d"|" -f12`
			BeneAcid=`echo \'$BeneAcid_1\'`
			
			PayeeAcid_1=`echo $line|cut -d"|" -f13`
			PayeeAcid=`echo \'$PayeeAcid_1\'`
			
			PayeeName_1=`echo $line|cut -d"|" -f14`
			PayeeName=`echo \'$PayeeName_1\'`
			
			PayeeAddr1_1=`echo $line|cut -d"|" -f15`
			PayeeAddr2_1=`echo $line|cut -d"|" -f16`
			PayeeAddr3_1=`echo $line|cut -d"|" -f17`
			
			
			PayeeAddr1=`echo \'$PayeeAddr1_1\'`
			PayeeAddr2=`echo \'$PayeeAddr2_1\'`
			PayeeAddr3=`echo \'$PayeeAddr3_1\'`
			
			PayeeCountry=`echo $line|cut -d"|" -f18`
			PayeeCountry=`echo \'$PayeeCountry\'`
			
			Amount_1=`echo $line|cut -d"|" -f19`
			Amount=`echo \'$Amount_1\'`
			
			Currency=`echo $line|cut -d"|" -f20`
			Currency=`echo \'$Currency\'`

			ValueDate_1=`echo $line|cut -d"|" -f21`
			ValueDate=`echo \'$ValueDate_1\'`
			
			PayeeBIC_1=`echo $line|cut -d"|" -f22`
			PayeeBIC=`echo \'$PayeeBIC_1\'` 

						
			echo "INSERT INTO CUSTOM.CREM(CREM_SEQ,BWAY_SEQUENCENO,REMIT_CCY,REMIT_AMT,OPER_ACCT,OPER_CHRG_ACCT,REM_CUST_ID,REM_CUST_NAME,
			REM_CUST_ADDR1,REM_CUST_ADDR2,REM_CUST_ADDR3,REM_CUST_CNTRY_CODE,BEN_PARTY_ID,BEN_PARTY_NAME,
			BEN_PARTY_ADDR1,BEN_PARTY_ADDR2,BEN_PARTY_ADDR3,BEN_PARTY_CNTRY_CODE,BEN_PARTY_ACID,BENE_BK_BIC,
			BENE_BK_CODE,BENE_BR_CODE,PAYEE_BK_BIC,PAYEE_BK_CODE,PAYEE_BR_CODE,
			VALUE_DATE,PROCESS_FLG,
			LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,FREE_TEXT_1,FREE_TEXT_2,FREE_TEXT_3,BANK_ID)
			VALUES(custom.CREM_SEQ.nextval,$ReqSlrNo,$Currency,$Amount,$PayeeAcid,$PayeeAcid,'',$PayeeName ,
			$PayeeAddr1,$PayeeAddr2,$PayeeAddr3,$PayeeCountry, '',
			$BeneFullName,$BeneAddress1,$BeneAddress2,$BeneAddress3,$BeneCountry,$BeneAcid,$BeneBIC,'','','','','',
			to_date($ValueDate,'DD-MM-YYYY'),'N','BWY',sysdate,'BWY',sysdate,'','','',$bankId);" > CREMInsert.sql

			echo "COMMIT;" >> CREMInsert.sql
			bauu9151 CREMInsert.sql 

			status1=`echo $?`
			 		
			echo "$sqlPath $ReqSlrNo $BeneFullName $BeneAddress1 $BeneAddress2 $BeneAddress3 $BeneCountry $BeneBIC $BeneAcid $PayeeAcid $PayeeName $PayeeCountry $Amount $Currency $ValueDate" >> cbwyorm.log
	i=`expr $i + 1`
	echo $i >> inwhile.log
	done
	echo file $d
rm $d 2> /dev/null
done
#echo file $d
#rm $d 2> /dev/null
