#+++++++++++++++++++++++++++++++++
#FileName : ebGoalIntR.com
#Author : Vino Palani
#Date   : 13/03/2019
#Desc   : Please do Not Change
#+++++++++++++++++++++++++++++++++
echo "set head off;">ebGoalsIntR.sql
echo "set trims on;">>ebGoalsIntR.sql
echo "set pages 0;">>ebGoalsIntR.sql
echo "set feedback off;">>ebGoalsIntR.sql
echo "set termout off;">>ebGoalsIntR.sql
echo "spool ebGoalsIntR.lst;">>ebGoalsIntR.sql
echo "select gam.foracid||'VV'||gam.sol_id from tbaadm.gam ,tbaadm.tam where tam.acid = gam.acid and gam.bank_id= '54' and gam.schm_code='TU400' ">>ebGoalsIntR.sql
echo "and gam.acct_cls_flg='N' and gam.del_flg='N' and gam.entity_cre_flg='Y' and gam.acct_cls_date is null ">>ebGoalsIntR.sql
echo "and tam.maturity_date <= (select db_stat_date from tbaadm.gct where bank_id ='54' ) ">>ebGoalsIntR.sql
echo "order by gam.sol_id,gam.foracid; ">>ebGoalsIntR.sql
echo "spool off;">>ebGoalsIntR.sql

exebatch bauu9151 ebGoalsIntR.sql

rm -f ebGoalsIntR.sql

for fil in `cat ebGoalsIntR.lst`
do
echo ${fil} | awk -F "VV" '{print $2}' >>${fil}.DAT
echo "" >>${fil}.DAT
echo ${fil} | awk -F "VV" '{print $1}' >>${fil}.DAT
echo ${fil} | awk -F "VV" '{print $1}' >>${fil}.DAT
echo "" >>${fil}.DAT
echo "" >>${fil}.DAT
echo "TU400" >>${fil}.DAT
echo "TU400" >>${fil}.DAT
echo "" >>${fil}.DAT
echo "" >>${fil}.DAT
echo "TUA" >>${fil}.DAT
echo "" >>${fil}.DAT
echo "0" >>${fil}.DAT
echo "0" >>${fil}.DAT
echo ${fil} | awk -F "VV" '{print $1}' >>${fil}.DAT
echo "Y" >>${fil}.DAT
echo "N" >>${fil}.DAT
echo "CIDEEEII N" >>${fil}.DAT
echo "INTRUN" >>${fil}.DAT
echo "" >>${fil}.DAT
echo "" >>${fil}.DAT
echo "N" >>${fil}.DAT
done
#++++++++++++++++++++++++++++
for runbok in `ls -lrt *.DAT`
do
exebatch icbx4008 $B2K_SESSION_ID < ./$runbok
rm -f ${runbok}
done
rm -f  ebGoalsIntR.lst
exit 0
