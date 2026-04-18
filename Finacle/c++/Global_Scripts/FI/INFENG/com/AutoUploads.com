#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : AutoUploads.com 
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description     :
#  Date            : 19-01-2023 
#  Author          : Irungu James
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             19-01-2023      Irungu James          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

fCode=${fCode}
stuserId=${stuserId}
bankId=${bankId}
EventType=${EventType}
dfilpth=${dfilpth}
dfilname=${dfilname}
if [ "$EventType" = "MTTRUN" ]; then
nohup exebatch babx4061 $B2K_SESSION_ID AutoUploads.scr ${dfilpth}  ${dfilname}  ${fCode} ${stuserId} @s
echo ${fCode} ${stuserId}  ${bankId} ${EventType} ${dfilname} ${dfilpth} >> AutoUploads.log
fi
