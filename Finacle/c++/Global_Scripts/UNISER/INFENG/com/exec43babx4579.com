#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : exec43babx4579.com 
#  Description     :
#  Date            : 22-08-2022
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             22-08-2022      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#+++++++++++++++++++++++++++++++++++++++++++++++++++
#Fraud Management Check Channel Transactions Routine
#+++++++++++++++++++++++++++++++++++++++++++++++++++
###exebatch babx4061 $B2K_SESSION_ID ebChnlLienChkExtRtn.scr &
#+++++++++++++++++++++++++++++++++++++++++++++++++++
#Merchant & Card Transaction Maintenance
#++++++++++++++++++++++++++++++++++++++++++++++++
. `execom vpMerchantMaster.com` &
#++++++++++++++++++++++++++++++++++++++++++++++++
#Agent Commission Transaction Processing
#++++++++++++++++++++++++++++++++++++++++++++++++
. `execom vpAgentCommMaster.com` &
#++++++++++++++++++++++++++++++
#Post Treasury Deals 01-03-2022
#++++++++++++++++++++++++++++++
thr=`date +%H`
tmi=`date +%M`
tday=`date +%a`
exprc=`ps -aef | grep  "exebatch -i RTD-" | wc -l`
echo ${thr}
echo ${tmi}
echo ${tday}
echo ${exprc}
if [ "${exprc}" -le "1" ]
then
if [ "${thr}" -le "17" ]
then
        if [ "${tday}" !=  "Sun" ]
        then
        . `execom vptmRTDpost.com` &
        else
                echo "no RTD sunday"
        fi
else
        echo "no RTD time"
fi
else
        echo "no RTD exebatch"
fi
exit 0


