#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : ebodlaResh.com
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description     :
#  Date            : 19-10-2021
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             19-10-2021      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
LoanAcctId=${LoanAcctId}
reshDate=${reshDate}
isreshYN=${isreshYN}
usId=${stuserId}
bankid=${bankid}
schmCode=${schmCode}
BatId="ODLoanShdl"`date +%d%m%Y`
if [ "$schmCode" = "DL002" ]; then
echo "set head off;">${BatId}_T.sql
echo "set trimspool on;">>${BatId}_T.sql
echo "set trimout on;">>${BatId}_T.sql
echo "set pages 0;">>${BatId}_T.sql
echo "set feedback off;">>${BatId}_T.sql
echo "set linesize 32767;">>${BatId}_T.sql
echo "set echo off;">>${BatId}_T.sql
echo "set long 90000;">>${BatId}_T.sql
echo "spool ${BatId}.LST;">>${BatId}_T.sql
echo "select g.bank_id||'|'||g.foracid||'|'||d.shdl_num||'|'||'EIDEM'||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||sum(d.dmd_amt)||'|'||(case when sum(d.tot_adj_amt) > 0 then d.last_adj_date else null end)||'|'||sum(d.tot_adj_amt)||'|'||LISTAGG(d.flow_id, ',') within group (order by d.flow_id) ||'|'|| LISTAGG(d.dmd_amt, ',') within group (order by d.dmd_amt) as flowamt from custom.dlla_dmd_tbl d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.foracid='${LoanAcctId}' and g.acid=d.od_acid and d.del_flg<>'Y' and d.entity_cre_flg='Y' and g.entity_cre_flg='Y' and d.dmd_amt>0 group by g.bank_id,g.foracid,d.od_acid,d.shdl_num,d.dmd_date,d.dmd_ovdu_date,d.last_adj_date order by d.dmd_date; " >> ${BatId}_T.sql
echo "spool off;">>${BatId}_T.sql
exebatch bauu9151 ${BatId}_T.sql
##rm -f ${BatId}_T.sql
nohup mrbx4004 $B2K_SESSION_ID ebodlaReshSuc.mrt ${BatId}.LST ${BatId}
nohup babx4040 $B2K_SESSION_ID ${FIN_REPORTS_DIR}"/"${usId}"/"${BatId}.rpt 'Digital Loan Schedule Report' MANAGER 1 N
exit
fi
if [ "$schmCode" = "ODFDR" ]; then
echo "set head off;">${BatId}_T.sql
echo "set trimspool on;">>${BatId}_T.sql
echo "set trimout on;">>${BatId}_T.sql
echo "set pages 0;">>${BatId}_T.sql
echo "set feedback off;">>${BatId}_T.sql
echo "set linesize 32767;">>${BatId}_T.sql
echo "set echo off;">>${BatId}_T.sql
echo "set long 90000;">>${BatId}_T.sql
echo "spool ${BatId}.LST;">>${BatId}_T.sql
echo "select g.bank_id||'|'||g.foracid||'|'||d.shdl_num||'|'||'EIDEM'||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||sum(d.dmd_amt)||'|'||(case when sum(d.tot_adj_amt) > 0 then d.last_adj_date else null end)||'|'||sum(d.tot_adj_amt)||'|'||LISTAGG(d.flow_id, ',') within group (order by d.flow_id) ||'|'|| LISTAGG(d.dmd_amt, ',') within group (order by d.dmd_amt) as flowamt from custom.odfdr_dmd_tbl d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.foracid='${LoanAcctId}' and g.acid=d.od_acid and d.del_flg<>'Y' and d.entity_cre_flg='Y' and g.entity_cre_flg='Y' and d.dmd_amt>0 group by g.bank_id,g.foracid,d.od_acid,d.shdl_num,d.dmd_date,d.dmd_ovdu_date,d.last_adj_date order by d.dmd_date; " >> ${BatId}_T.sql
echo "spool off;">>${BatId}_T.sql
exebatch bauu9151 ${BatId}_T.sql
nohup mrbx4004 $B2K_SESSION_ID ebodlaReshSuc.mrt ${BatId}.LST ${BatId}
nohup babx4040 $B2K_SESSION_ID ${FIN_REPORTS_DIR}"/"${usId}"/"${BatId}.rpt 'ODFDR Schedule Report' MANAGER 1 N
exit
fi
if [ "$schmCode" = "OD549" ]; then
echo "set head off;">${BatId}_T.sql
echo "set trimspool on;">>${BatId}_T.sql
echo "set trimout on;">>${BatId}_T.sql
echo "set pages 0;">>${BatId}_T.sql
echo "set feedback off;">>${BatId}_T.sql
echo "set linesize 32767;">>${BatId}_T.sql
echo "set echo off;">>${BatId}_T.sql
echo "set long 90000;">>${BatId}_T.sql
echo "spool ${BatId}.LST;">>${BatId}_T.sql
echo "select g.bank_id||'|'||g.foracid||'|'||d.shdl_num||'|'||'EIDEM'||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||sum(d.dmd_amt)||'|'||(case when sum(d.tot_adj_amt) > 0 then d.last_adj_date else null end)||'|'||sum(d.tot_adj_amt)||'|'||LISTAGG(d.flow_id, ',') within group (order by d.flow_id) ||'|'|| LISTAGG(d.dmd_amt, ',') within group (order by d.dmd_amt) as flowamt from custom.ecosystem_dmd_tbl d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.foracid='${LoanAcctId}' and g.acid=d.od_acid and d.del_flg<>'Y' and d.entity_cre_flg='Y' and g.entity_cre_flg='Y' and d.dmd_amt>0 group by g.bank_id,g.foracid,d.od_acid,d.shdl_num,d.dmd_date,d.dmd_ovdu_date,d.last_adj_date order by d.dmd_date; " >> ${BatId}_T.sql
echo "spool off;">>${BatId}_T.sql
exebatch bauu9151 ${BatId}_T.sql
##rm -f ${BatId}_T.sql
nohup mrbx4004 $B2K_SESSION_ID ebodlaReshSuc.mrt ${BatId}.LST ${BatId}
nohup babx4040 $B2K_SESSION_ID ${FIN_REPORTS_DIR}"/"${usId}"/"${BatId}.rpt 'Ecosystem Loan Schedule Report' MANAGER 1 N
exit
fi
if [ "$schmCode" = "OD553" ]; then
echo "set head off;">${BatId}_T.sql
echo "set trimspool on;">>${BatId}_T.sql
echo "set trimout on;">>${BatId}_T.sql
echo "set pages 0;">>${BatId}_T.sql
echo "set feedback off;">>${BatId}_T.sql
echo "set linesize 32767;">>${BatId}_T.sql
echo "set echo off;">>${BatId}_T.sql
echo "set long 90000;">>${BatId}_T.sql
echo "spool ${BatId}.LST;">>${BatId}_T.sql
echo "select g.bank_id||'|'||g.foracid||'|'||'1'||'|'||'EIDEM'||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||sum(d.dmd_amt)||'|'||(case when sum(d.tot_adj_amt) > 0 then d.last_adj_date else null end)||'|'||sum(d.tot_adj_amt)||'|'||'EIDEM'||'|'|| d.dmd_amt as flowamt from custom.odsme_new d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.schm_code='OD553' and g.cif_id=d.FREE_TEXT1 and g.foracid='${LoanAcctId}' and d.del_flg<>'Y' and d.entity_cre_flg='Y' and g.entity_cre_flg='Y' and d.dmd_amt>0 group by g.bank_id,g.foracid,d.dmd_date,d.dmd_ovdu_date,d.last_adj_date,dmd_amt order by d.dmd_date; " >> ${BatId}_T.sql
echo "spool off;">>${BatId}_T.sql
exebatch bauu9151 ${BatId}_T.sql
##rm -f ${BatId}_T.sql
nohup mrbx4004 $B2K_SESSION_ID ebodlaReshSuc.mrt ${BatId}.LST ${BatId}
nohup babx4040 $B2K_SESSION_ID ${FIN_REPORTS_DIR}"/"${usId}"/"${BatId}.rpt 'ODSME Loan Schedule Report' MANAGER 1 N
exit
fi
if [ "$schmCode" = "OD552" ]; then
echo "set head off;">${BatId}_T.sql
echo "set trimspool on;">>${BatId}_T.sql
echo "set trimout on;">>${BatId}_T.sql
echo "set pages 0;">>${BatId}_T.sql
echo "set feedback off;">>${BatId}_T.sql
echo "set linesize 32767;">>${BatId}_T.sql
echo "set echo off;">>${BatId}_T.sql
echo "set long 90000;">>${BatId}_T.sql
echo "spool ${BatId}.LST;">>${BatId}_T.sql
echo "select g.bank_id||'|'||g.foracid||'|'||d.shdl_num||'|'||'EIDEM'||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||sum(d.dmd_amt)||'|'||(case when sum(d.tot_adj_amt) > 0 then d.last_adj_date else null end)||'|'||sum(d.tot_adj_amt)||'|'||LISTAGG(d.flow_id, ',') within group (order by d.flow_id) ||'|'|| LISTAGG(d.dmd_amt, ',') within group (order by d.dmd_amt) as flowamt from custom.dlla_dmd_tbl d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.foracid='${LoanAcctId}' and g.acid=d.od_acid and d.del_flg<>'Y' and d.entity_cre_flg='Y' and g.entity_cre_flg='Y' and d.dmd_amt>0 group by g.bank_id,g.foracid,d.od_acid,d.shdl_num,d.dmd_date,d.dmd_ovdu_date,d.last_adj_date order by d.dmd_date; " >> ${BatId}_T.sql
echo "spool off;">>${BatId}_T.sql
exebatch bauu9151 ${BatId}_T.sql
##rm -f ${BatId}_T.sql
nohup mrbx4004 $B2K_SESSION_ID ebodlaReshSuc.mrt ${BatId}.LST ${BatId}
nohup babx4040 $B2K_SESSION_ID ${FIN_REPORTS_DIR}"/"${usId}"/"${BatId}.rpt 'SME Loan Schedule Report' MANAGER 1 N
exit
fi
if [ "$schmCode" = "OD541" ]; then
echo "set head off;">${BatId}_T.sql
echo "set trimspool on;">>${BatId}_T.sql
echo "set trimout on;">>${BatId}_T.sql
echo "set pages 0;">>${BatId}_T.sql
echo "set feedback off;">>${BatId}_T.sql
echo "set linesize 32767;">>${BatId}_T.sql
echo "set echo off;">>${BatId}_T.sql
echo "set long 90000;">>${BatId}_T.sql
echo "spool ${BatId}.LST;">>${BatId}_T.sql
echo "select g.bank_id||'|'||g.foracid||'|'||'1'||'|'||'EIDEM'||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||sum(d.dmd_amt)||'|'||(case when sum(d.tot_adj_amt) > 0 then d.last_adj_date else null end)||'|'||sum(d.tot_adj_amt)||'|'||'EIDEM' ||'|'|| LISTAGG(d.dmd_amt, ',') within group (order by d.dmd_amt) as flowamt from custom.agddt d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and schm_code='OD541' and DMD_AMT != TOT_ADJ_AMT and free_text1 in(select cif_id from tbaadm.gam where foracid = '${LoanAcctId}' and bank_id = '${bankid}') and g.cif_id=FREE_TEXT1 and d.del_flg<>'Y' and d.entity_cre_flg='Y' and g.entity_cre_flg='Y' and acct_cls_flg='N' and d.dmd_amt>0 group by g.bank_id,g.foracid,d.dmd_date,d.dmd_ovdu_date,d.last_adj_date order by d.dmd_date; " >> ${BatId}_T.sql
echo "spool off;">>${BatId}_T.sql
exebatch bauu9151 ${BatId}_T.sql
##rm -f ${BatId}_T.sql
nohup mrbx4004 $B2K_SESSION_ID ebodlaReshSuc.mrt ${BatId}.LST ${BatId}
nohup babx4040 $B2K_SESSION_ID ${FIN_REPORTS_DIR}"/"${usId}"/"${BatId}.rpt 'Agent Float Loan Schedule Report' MANAGER 1 N
exit
fi
if [ "$schmCode" = "ML001" ]; then
echo "set head off;">${BatId}_T.sql
echo "set trimspool on;">>${BatId}_T.sql
echo "set trimout on;">>${BatId}_T.sql
echo "set pages 0;">>${BatId}_T.sql
echo "set feedback off;">>${BatId}_T.sql
echo "set linesize 32767;">>${BatId}_T.sql
echo "set echo off;">>${BatId}_T.sql
echo "set long 90000;">>${BatId}_T.sql
echo "spool ${BatId}.LST;">>${BatId}_T.sql
echo "select g.bank_id||'|'||g.foracid||'|'||'1'||'|'||'EIDEM'||'|'||d.LIM_EXP_DATE||'|'||d.LIM_PENALTY_DATE||'|'||sum(d.SANCT_LIM)||'|'||(case when sum(d.SANCT_LIM +clr_bal_amt) > 0 then last_tran_date else null end)||'|'||sum(d.SANCT_LIM +clr_bal_amt)||'|'||'EIDEM' ||'|'|| d.SANCT_LIM as flowamt from tbaadm.lht d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.foracid='${LoanAcctId}' and g.acid=d.acid and d.del_flg<>'Y' and SERIAL_NUM in(select max(SERIAL_NUM) from tbaadm.lht where acid=g.acid and bank_id=g.bank_id) and d.entity_cre_flg='Y' and g.entity_cre_flg='Y' and d.SANCT_LIM>0 group by g.bank_id,g.foracid,d.LIM_EXP_DATE,d.LIM_PENALTY_DATE,d.SANCT_LIM,clr_bal_amt,last_tran_date order by d.LIM_EXP_DATE; " >> ${BatId}_T.sql
echo "spool off;">>${BatId}_T.sql
exebatch bauu9151 ${BatId}_T.sql
##rm -f ${BatId}_T.sql
nohup mrbx4004 $B2K_SESSION_ID ebodlaReshSuc.mrt ${BatId}.LST ${BatId}
nohup babx4040 $B2K_SESSION_ID ${FIN_REPORTS_DIR}"/"${usId}"/"${BatId}.rpt 'Merchant Loan Schedule Report' MANAGER 1 N
exit
fi
if [ "$isreshYN" = "N" ]; then
echo "set head off;">${BatId}_T.sql
echo "set trimspool on;">>${BatId}_T.sql
echo "set trimout on;">>${BatId}_T.sql
echo "set pages 0;">>${BatId}_T.sql
echo "set feedback off;">>${BatId}_T.sql
echo "set linesize 32767;">>${BatId}_T.sql
echo "set echo off;">>${BatId}_T.sql
echo "set long 90000;">>${BatId}_T.sql
echo "spool ${BatId}.LST;">>${BatId}_T.sql
##echo "select g.bank_id||'|'||g.foracid||'|'||d.shdl_num||'|'||d.flow_id||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||d.dmd_amt||'|'||d.last_adj_date||'|'||d.tot_adj_amt from custom.odla_dmd_tbl d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.foracid='${LoanAcctId}' and g.acid=d.od_acid and d.del_flg='N' and d.entity_cre_flg='Y' and g.del_flg='N' and g.entity_cre_flg='Y' and d.dmd_amt is not null order by d.dmd_date; " >> ${BatId}_T.sql
echo "select g.bank_id||'|'||g.foracid||'|'||d.shdl_num||'|'||'EIDEM'||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||sum(d.dmd_amt)||'|'||(case when sum(d.tot_adj_amt) > 0 then d.last_adj_date else null end)||'|'||sum(d.tot_adj_amt)||'|'||LISTAGG(d.flow_id, ',') within group (order by d.flow_id) ||'|'|| LISTAGG(d.dmd_amt, ',') within group (order by d.dmd_amt) as flowamt from custom.odla_dmd_tbl d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.foracid='${LoanAcctId}' and g.acid=d.od_acid and d.del_flg<>'Y' and d.entity_cre_flg='Y' and g.entity_cre_flg='Y' and d.dmd_amt>0 group by g.bank_id,g.foracid,d.od_acid,d.shdl_num,d.dmd_date,d.dmd_ovdu_date,d.last_adj_date order by d.dmd_date; " >> ${BatId}_T.sql
echo "spool off;">>${BatId}_T.sql
exebatch bauu9151 ${BatId}_T.sql
rm -f ${BatId}_T.sql
nohup mrbx4004 $B2K_SESSION_ID ebodlaReshSuc.mrt ${BatId}.LST ${BatId}
nohup babx4040 $B2K_SESSION_ID ${FIN_REPORTS_DIR}"/"${usId}"/"${BatId}.rpt 'OD Loan Schedule Report' MANAGER 1 N
exit
fi
if [ "$isreshYN" = "Y" ]; then
nohup exebatch babx4061 $B2K_SESSION_ID ebodlaResh.scr ${LoanAcctId} ${reshDate} @s
if [ $? -ne 0 ]
then
        echo "SQL execution failed !"
        exit 1
else
echo "set head off;">${BatId}_T.sql
echo "set trimspool on;">>${BatId}_T.sql
echo "set trimout on;">>${BatId}_T.sql
echo "set pages 0;">>${BatId}_T.sql
echo "set feedback off;">>${BatId}_T.sql
echo "set linesize 32767;">>${BatId}_T.sql
echo "set echo off;">>${BatId}_T.sql
echo "set long 90000;">>${BatId}_T.sql
echo "spool ${BatId}.LST;">>${BatId}_T.sql
##echo "select g.bank_id||'|'||g.foracid||'|'||d.shdl_num||'|'||d.flow_id||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||d.dmd_amt||'|'||d.last_adj_date||'|'||d.tot_adj_amt from custom.odla_dmd_tbl d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.foracid='${LoanAcctId}' and g.acid=d.od_acid and d.del_flg='N' and d.entity_cre_flg='Y' and g.del_flg='N' and g.entity_cre_flg='Y' and d.dmd_amt is not null order by d.dmd_date; " >> ${BatId}_T.sql
echo "select g.bank_id||'|'||g.foracid||'|'||d.shdl_num||'|'||'EIDEM'||'|'||d.dmd_date||'|'||d.dmd_ovdu_date||'|'||sum(d.dmd_amt)||'|'||(case when sum(d.tot_adj_amt) > 0 then d.last_adj_date else null end)||'|'||sum(d.tot_adj_amt)||'|'||LISTAGG(d.flow_id, ',') within group (order by d.flow_id) ||'|'|| LISTAGG(d.dmd_amt, ',') within group (order by d.dmd_amt) as flowamt from custom.odla_dmd_tbl d,tbaadm.gam g where g.bank_id='${bankid}' and d.bank_id='${bankid}' and g.foracid='${LoanAcctId}' and g.acid=d.od_acid and d.del_flg='N' and d.entity_cre_flg='Y' and g.del_flg='N' and g.entity_cre_flg='Y' and d.dmd_amt>0 group by g.bank_id,g.foracid,d.od_acid,d.shdl_num,d.dmd_date,d.dmd_ovdu_date,d.last_adj_date order by d.dmd_date; " >> ${BatId}_T.sql
echo "spool off;">>${BatId}_T.sql
exebatch bauu9151 ${BatId}_T.sql
rm -f ${BatId}_T.sql
nohup mrbx4004 $B2K_SESSION_ID ebodlaReshSuc.mrt ${BatId}.LST ${BatId}
nohup babx4040 $B2K_SESSION_ID ${FIN_REPORTS_DIR}"/"${usId}"/"${BatId}.rpt 'OD Loan Schedule Report' MANAGER 1 N
fi
fi
