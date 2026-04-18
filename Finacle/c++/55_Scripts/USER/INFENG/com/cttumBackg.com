#------------------------------------------------------------------------------------------------
#  Name            : cttumBackg.com
#  Description     : CTTUM menu upload pushing to backgrounf processing
#  Date            : 04-11-2022
#  Author          : Mani Kutti
#  Menu Option     : CTTUM
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             04-11-2022      Mani Kutti          Original Version
#-----------------------------------------------------------------------------------------------
echo $1
echo $2
echo $3
echo $4
echo $5
./etc/b2k/EQDR/FINCORE/com/commonenv.com
exectrusteduser.com babx4061 $B2K_SESSION_ID cttum_dbInsert.scr $1 $2 $3 $4 $5 &
