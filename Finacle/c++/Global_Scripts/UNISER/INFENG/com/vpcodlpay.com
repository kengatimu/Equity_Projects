LoanAcctId=${LoanAcctId}
OperAcctNum=${OperAcctNum}
RecoverAmt=${RecoverAmt}
FunctionC=${FunctionC}
usId=${stuserId}
bankId=${bankId}
EventType=${EventType}
BatId="ODLoanPayment"`date +%d%m%Y`
if [ "$EventType" = "ONSPAY" ]; then
echo "in Ons pay" >> ${BatId}_run.txt
nohup exebatch babx4061 $B2K_SESSION_ID vpcodlpayIntChk.scr ${LoanAcctId} ${OperAcctNum} ${RecoverAmt} ${FunctionC} ${usId} @s
fi
if [ "$EventType" = "APIPAY" ]; then
echo "in API pay" >> ${BatId}_run.txt
nohup exebatch babx4061 $B2K_SESSION_ID ebodlaAclhmMVfy.scr ${LoanAcctId} @s
fi
if [ "$EventType" = "ONSPAYLE" ]; then
echo "in Limit Expiry" >> ${BatId}_run.txt
nohup exebatch babx4061 $B2K_SESSION_ID ebodlaAclhmMVfy.scr ${LoanAcctId} @s
fi

