#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vpfaswphist.com
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description     :
#  Date            : 28-09-2022
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             28-09-2022      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo $FIN_BANK_ID
ubankid=`echo $FIN_BANK_ID`
nohup exebatch bauu9151 vpfaswphist.sql ${ubankid} @s &
if [ $? -ne 0 ]
then
        echo "sql execution failed !"
        exit 1
fi
nohup exebatch bauu9151 vpagddt_cdci_bod3hist.sql ${ubankid} @s &
if [ $? -ne 0 ]
then
        echo "sql execution failed !"
        exit 1
fi
nohup exebatch bauu9151 vpagddthist_all_delflgY.sql ${ubankid} @s &
if [ $? -ne 0 ]
then
        echo "sql execution failed !"
        exit 1
fi
####Please note not enable this line below 
###############nohup exebatch bauu9151 vpagddthist_nosweep_onetime.sql ${ubankid} @s &
########if [ $? -ne 0 ]
#####then
######        echo "sql execution failed !"
######        exit 1
####fi
