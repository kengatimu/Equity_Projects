#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vpcttumupl.com
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description     :
#  Date            : 07-11-2022
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             07-11-2022      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

usId=${stuserId}
bankId=${bankId}
EventType=${EventType}
dfilpth=${dfilpth}
dfilname=${dfilname}
echo ${EventType} >>MTTRUN.txt
if [ "$EventType" = "MTTRUN" ]; then
nohup exebatch babx4061 $B2K_SESSION_ID cttum_dbInsert.scr ${dfilpth}  ${dfilname} ${stuserId} @s
echo ${stuserId}  ${bankId} ${EventType} ${dfilname} ${dfilpth} >> exemM.log
fi
