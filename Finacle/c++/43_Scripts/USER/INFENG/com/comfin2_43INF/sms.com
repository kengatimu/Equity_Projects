echo "Executing Commonenv.com..." >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/INFENG/com/cron.log
. /etc/b2k/EQDR/FINCORE/43/com/commonenv.com
echo $FIN_BANK_ID >> /finacle/EQPPROD/Fin10218/APP/Finacle/FC/app/cust/INFENG/com/cron.log


SERVERMODE=YES
export SERVERMODE
echo $SERVERMODE >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/INFENG/com/cron.log
exebatch babx4044
B2K_SESSION_ID=`cat tty.mn3`
echo $B2K_SESSION_ID >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/INFENG/com/cron.log
NOETOS=`cat anskey.mn1`
echo $NOETOS >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/INFENG/com/cron.log
export B2K_SESSION_ID
export NOETOS

echo $B2K_SESSION_ID >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/INFENG/com/cron.log
echo $NOETOS >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/INFENG/com/cron.log

SCRIPT=/finacle/EQPPROD/Fin10218/APP/Finacle/FC/app/cust/43/INFENG/scripts/smsmerge.scr
export SCRIPT

echo $SCRIPT >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/INFENG/com/cron.log

exebatch babx4061 $B2K_SESSION_ID $SCRIPT

echo "after" >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/INFENG/com/cron.log

     rm -f anskey.mn1
     rm -f tty.mn3
