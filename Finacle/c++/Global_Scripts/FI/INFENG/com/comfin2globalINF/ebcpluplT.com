#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : ebcpluplT.com 
#  Description     : 
#  Date            : 04-04-2020
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             04-04-2020      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
uuid=${2}
filp=${3}
tranYN=${4}
batchId=${5}
nopj="1"
echo "set head off;">${batchId}_T.sql
echo "set trimspool on;">>${batchId}_T.sql
echo "set trimout on;">>${batchId}_T.sql
echo "set pages 0;">>${batchId}_T.sql
echo "set feedback off;">>${batchId}_T.sql
echo "set linesize 32767;">>${batchId}_T.sql
echo "set echo off;">>${batchId}_T.sql
echo "set long 90000;">>${batchId}_T.sql
echo "spool ${batchId}.DAT;">>${batchId}_T.sql
echo "select rpad(NVL(DR_ACCT_NUM,' '),16,' ')||rpad('KES',3,' ')||rpad(NVL((select sol_id from tbaadm.gam where bank_id='54' and foracid=DR_ACCT_NUM),' '),8,' ')||rpad(NVL('D',' '),1,' ')||lpad(NVL(abs((TRAN_AMT)),0),17,' ')||rpad(NVL(TRAN_REMARKS,' '),30,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),20,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),6,' ')||rpad(NVL(' ',' '),16,' ')||rpad(NVL(' ',' '),1,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),3,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL('',' '),15,' ')||rpad(to_char(sysdate,'DD-MM-YYYY'),10,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),6,' ')||rpad(NVL(' ',' '),6,' ')||rpad(NVL(' ',' '),2,' ')||rpad(NVL(' ',' '),1,' ')||rpad(NVL(' ',' '),12,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),20,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),30,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(BENEF_ACCOUNT_NUM,' '),30,' ')||rpad(NVL(' ',' '),16,' ')||rpad(NVL(' ',' '),12,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),9,' ')||rpad(NVL(' ',' '),4,' ')||rpad(NVL(' ',' '),256,' ')||rpad(NVL(' ',' '),16,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),50,' ')from custom.plmt where bank_id='54' and CORE_TRAN_ID is null and CORE_TRAN_DATE is null and RCRE_USER_ID='${uuid}' and UPL_REF_NUM='${batchId}' " >> ${batchId}_T.sql 
echo "union all " >> ${batchId}_T.sql 
echo "select rpad(NVL('0001400306093',' '),16,' ') ||rpad('KES',3,' ') ||rpad(NVL((select sol_id from tbaadm.gam where bank_id='54' and foracid=CR_ACCT_NUM),' '),8,' ') ||rpad(NVL('C',' '),1,' ') ||lpad(NVL(abs((TRAN_AMT)),0),17,' ')||rpad(NVL(TRAN_REMARKS,' '),30,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),20,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),6,' ') ||rpad(NVL(' ',' '),16,' ') ||rpad(NVL(' ',' '),1,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),3,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL('',' '),15,' ') ||rpad(to_char(sysdate,'DD-MM-YYYY'),10,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),6,' ') ||rpad(NVL(' ',' '),6,' ') ||rpad(NVL(' ',' '),2,' ') ||rpad(NVL(' ',' '),1,' ') ||rpad(NVL(' ',' '),12,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),20,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),30,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(BENEF_ACCOUNT_NUM,' '),30,' ') ||rpad(NVL(' ',' '),16,' ') ||rpad(NVL(' ',' '),12,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),9,' ') ||rpad(NVL(' ',' '),4,' ') ||rpad(NVL(' ',' '),256,' ') ||rpad(NVL(' ',' '),16,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),50,' ') from custom.plmt where bank_id='54' and CORE_TRAN_ID is null and CORE_TRAN_DATE is null and RCRE_USER_ID='${uuid}' and UPL_REF_NUM='${batchId}' " >> ${batchId}_T.sql
echo "union all " >> ${batchId}_T.sql 
echo "select rpad(NVL(DR_ACCT_NUM,' '),16,' ')||rpad('KES',3,' ')||rpad(NVL((select sol_id from tbaadm.gam where bank_id='54' and foracid=DR_ACCT_NUM),' '),8,' ')||rpad(NVL('D',' '),1,' ')||lpad(NVL(abs((FREE_TEXT4)),0),17,' ')||rpad(NVL('Transaction Processing Charge',' '),30,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),20,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),6,' ')||rpad(NVL(' ',' '),16,' ')||rpad(NVL(' ',' '),1,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),3,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL('',' '),15,' ')||rpad(to_char(sysdate,'DD-MM-YYYY'),10,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),6,' ')||rpad(NVL(' ',' '),6,' ')||rpad(NVL(' ',' '),2,' ')||rpad(NVL(' ',' '),1,' ')||rpad(NVL(' ',' '),12,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),20,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),30,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),40,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),17,' ')||rpad(NVL(' ',' '),17,' ')||rpad(nvl('PesaLink Comm Dr:'||benef_account_num,' '),30,' ')||rpad(NVL(' ',' '),16,' ')||rpad(NVL(' ',' '),12,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),9,' ')||rpad(NVL(' ',' '),4,' ')||rpad(NVL(' ',' '),256,' ')||rpad(NVL(' ',' '),16,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),50,' ')from custom.plmt where bank_id='54' and CORE_TRAN_ID is null and CORE_TRAN_DATE is null and FREE_TEXT4 is not null and RCRE_USER_ID='${uuid}' and UPL_REF_NUM='${batchId}' " >> ${batchId}_T.sql 
echo "union all " >> ${batchId}_T.sql 
echo "select rpad(NVL('0006500604443',' '),16,' ') ||rpad('KES',3,' ') ||rpad(NVL((select sol_id from tbaadm.gam where bank_id='54' and foracid=CR_ACCT_NUM),' '),8,' ') ||rpad(NVL('C',' '),1,' ') ||lpad(NVL(abs((FREE_TEXT4)),0),17,' ')||rpad(NVL('Transaction Processing Charge',' '),30,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),20,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),6,' ') ||rpad(NVL(' ',' '),16,' ') ||rpad(NVL(' ',' '),1,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),3,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL('',' '),15,' ') ||rpad(to_char(sysdate,'DD-MM-YYYY'),10,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),6,' ') ||rpad(NVL(' ',' '),6,' ') ||rpad(NVL(' ',' '),2,' ') ||rpad(NVL(' ',' '),1,' ') ||rpad(NVL(' ',' '),12,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),20,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),30,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),40,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(NVL(' ',' '),17,' ') ||rpad(nvl('PesaLink Comm Cr:'||benef_account_num,' '),30,' ')||rpad(NVL(' ',' '),16,' ') ||rpad(NVL(' ',' '),12,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),10,' ') ||rpad(NVL(' ',' '),9,' ') ||rpad(NVL(' ',' '),4,' ') ||rpad(NVL(' ',' '),256,' ') ||rpad(NVL(' ',' '),16,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),5,' ') ||rpad(NVL(' ',' '),50,' ') from custom.plmt where bank_id='54' and CORE_TRAN_ID is null and CORE_TRAN_DATE is null and RCRE_USER_ID='${uuid}' and FREE_TEXT4 is not null and UPL_REF_NUM='${batchId}'; " >> ${batchId}_T.sql
echo "spool off;">>${batchId}_T.sql
sleep 5
exebatch bauu9151 ${batchId}_T.sql 
if [ $? -ne 0 ]
then
        echo "SQL execution failed !" > log.txt 
        exit 1
fi
cp -f ${batchId}.DAT /finreports/FILE_UPLOAD/${uuid}/
sleep 3
if [ ${tranYN} = "Y" ]
then
        drmsg="P"
fi
if [ ${tranYN} = "N" ]
then
        drmsg="P"
fi
echo "${batchId}.DAT $drmsg Y 
MANAGER CI ${batchId}.DAT ${drmsg} ${batchId} Y Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > ${batchId}_INP.DAT 
mcbx4024 $B2K_SESSION_ID < ${batchId}_INP.DAT 
echo `head -1 TRAN_INFO.dat` >> PesaLinkBatch.txt 
tid=`head -1 TRAN_INFO.dat`
echo "a is " $tid > log.txt
if [ -z "$tid" ]
then
rm -f ${batchId}_T.sql ${batchId}.DAT ${batchId}_INP.DAT PesaLinkBatch.txt ${batchId}_status.sql 
else
echo "update custom.plmt set CORE_TRAN_ID='${tid}',CORE_TRAN_DATE=sysdate,PROCESS_MSG='TRAN',FREE_TEXT2='0001400306093' where bank_id='54' and UPL_REF_NUM='${batchId}' and rcre_user_id='${uuid}';" >>${batchId}_status.sql
echo "commit;">>${batchId}_status.sql
exebatch bauu9151 ${batchId}_status.sql 
sleep 2
rm -f ${batchId}_T.sql ${batchId}.DAT ${batchId}_INP.DAT PesaLinkBatch.txt ${batchId}_status.sql 
##echo ${tid}"|"${batchId}>>${batchId}gag.lst
echo "set head off;">${batchId}g.sql
echo "set trimspool on;">>${batchId}g.sql
echo "set trimout on;">>${batchId}g.sql
echo "set pages 0;">>${batchId}g.sql
echo "set feedback off;">>${batchId}g.sql
echo "set linesize 32767;">>${batchId}g.sql
echo "set echo off;">>${batchId}g.sql
echo "set long 90000;">>${batchId}g.sql
echo "spool ${batchId}G.DAT;">>${batchId}g.sql
echo "select dtd.tran_id||'|'||dtd.acid||'|'||dtd.tran_amt||'|'||dtd.tran_particular||'|'||dtd.tran_rmks||'|'||dtd.tran_crncy_code||'|'||'${batchId}'||'|'||plmt.benef_bank_code||'|'||plmt.benef_branch_code||'|'||plmt.dr_acct_num " >> ${batchId}g.sql
echo "from tbaadm.dtd,custom.plmt ">> ${batchId}g.sql
echo "where dtd.bank_id='54' " >> ${batchId}g.sql
echo "and dtd.bank_id=plmt.bank_id " >> ${batchId}g.sql
echo "and plmt.upl_ref_num ='${batchId}' " >> ${batchId}g.sql 
echo "and dtd.tran_id = plmt.core_tran_id " >> ${batchId}g.sql
echo "and dtd.tran_rmks = plmt.benef_account_num " >> ${batchId}g.sql
echo "and dtd.tran_date=(select db_stat_date from tbaadm.gct where bank_id='54') " >> ${batchId}g.sql
echo "and dtd.tran_id = lpad('${tid}',9,' ') " >> ${batchId}g.sql  
echo "and dtd.pstd_flg='Y' and dtd.del_flg='N' and dtd.part_tran_type='C' " >> ${batchId}g.sql 
echo "and exists(select 1 from tbaadm.dth where dth.bank_id='54' and dth.tran_date=dtd.tran_date " >> ${batchId}g.sql
echo "and dth.tran_id = lpad('${tid}',9,' ') ">> ${batchId}g.sql
echo "and dth.tran_id=dtd.tran_id and dth.remarks='${batchId}');" >> ${batchId}g.sql
echo "spool off;">>${batchId}g.sql
exebatch bauu9151 ${batchId}g.sql 
rm -f ${batchId}g.sql
sleep 2
exebatch -i ${batchId}G.DAT -n ${nopj} babx4061 $B2K_SESSION_ID ebcpluplGag.scr @s
rm -f ${batchId}G.DAT
fi
exit 0
