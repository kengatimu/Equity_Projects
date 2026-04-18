#------------------------------------------------------------------------------------------------
#  Name            : c2breBatch.com
#  Description     : C2BRE menu upload pushing to backgrounf processing
#  Date            : 04-11-2022
#  Author          : Sundar
#  Menu Option     : C2BRE
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             04-11-2022      Sundar          Original Version
#-----------------------------------------------------------------------------------------------
echo $1
echo $2
echo $3
echo $4
./etc/b2k/EQDR/FINCORE/com/commonenv.com
exectrusteduser.com babx4061 $B2K_SESSION_ID c2bre_dbInsert.scr $1 $2 $3 $4 &
