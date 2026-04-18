LoanAcctId=${LoanAcctId}
OperAcctNum=${OperAcctNum}
RecoverAmt=${RecoverAmt}
FunctionC=${FunctionC}
usId=${stuserId}
bankId=${bankId}
EventType=${EventType}
BatId="AgentLoanPayment"`date +%d%m%Y`
if [ "$EventType" = "ONSPAY" ]; then
echo "in Ons pay" >> ${BatId}_run.txt
nohup exebatch babx4061 $B2K_SESSION_ID vpcodlpayAgentFloatTran.scr ${LoanAcctId} ${OperAcctNum} ${RecoverAmt} ${FunctionC} ${usId} @s
##nohup exebatch babx4061 $B2K_SESSION_ID vpcodlpayIntChk.scr ${LoanAcctId} ${OperAcctNum} ${RecoverAmt} ${FunctionC} ${usId} @s
fi
