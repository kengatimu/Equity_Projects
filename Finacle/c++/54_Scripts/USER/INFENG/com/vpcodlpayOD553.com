LoanAcctId=${LoanAcctId}
OperAcctNum=${OperAcctNum}
RecoverAmt=${RecoverAmt}
FunctionC=${FunctionC}
usId=${stuserId}
bankId=${bankId}
EventType=${EventType}
sessionid=${sessionid}
BatId="OD553LoanPayment"`date +%d%m%Y`
if [ "$EventType" = "ONSPAY" ]; then
echo "in Ons pay" >> ${BatId}_run.txt
nohup exebatch babx4061 $B2K_SESSION_ID vpcodlpayOD553Tran.scr ${LoanAcctId} ${OperAcctNum} ${RecoverAmt} ${FunctionC} ${usId} ${sessionid} @s
fi
