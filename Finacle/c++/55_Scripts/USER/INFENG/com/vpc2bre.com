#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vpc2bre.com
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description     :
#  Date            : 07-11-2022
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             07-11-2022      Vino Palani          Original Version
#  2.0             10-11-2022      Vino Palani          Parallelization
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

usId=${stuserId}
bankId=${bankId}
EventType=${EventType}
dfilpth=${dfilpth}
dRptname=${dRptname}
dfilname=${dfilname}
echo ${EventType} >>MTTRUN.txt
if [ "$EventType" = "MTTRUN" ]; then
echo ${EventType} >> james.txt
nohup exebatch babx4061 $B2K_SESSION_ID c2bre_dbInsert.scr ${dfilpth}  ${dRptname} ${dfilname}  @s
if [ $? -eq 0 ]
then
`execom vpc2brerun.com ${dfilname} ${dRptname} ${dfilpth}`
fi
echo ${stuserId}  ${bankId} ${EventType} ${dfilname} ${dfilpth} ${dRptname} >> exemM.log
fi

