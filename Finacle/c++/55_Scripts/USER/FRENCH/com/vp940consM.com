AcctId=${stAcctId}
usId=${stuserId}
cifId=${stCifId}
nohup exebatch babx4061 $B2K_SESSION_ID vp940consMrun.scr ${AcctId} ${usId} ${cifId} @s
if [ $? -ne 0 ]
then
        echo "940 execution failed !"
        exit 1
fi
