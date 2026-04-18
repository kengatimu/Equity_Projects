#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : cttum_validate.com
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description     :
#  Date            : 30-08-2023
#  Author          : Harrison Ruiru
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             30-08-2023      Harrison Ruiru          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

usId=${stuserId}
bankId=${bankId}
EventType=${EventType}
dfilpth=${dfilpth}
dfilname=${dfilname}
if [ "$EventType" = "MTTRUN" ]; then
nohup exebatch babx4061 $B2K_SESSION_ID cttum_validate.scr ${dfilpth}  ${dfilname}  @s
echo ${stuserId}  ${bankId} ${EventType} ${dfilname} ${dfilpth} >> hktrack.log
fi
