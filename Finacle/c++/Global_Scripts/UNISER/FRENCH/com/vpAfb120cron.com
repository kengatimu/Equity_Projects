echo "Executing Commonenv.com..." >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 
. /etc/b2k/EQDR/FINCORE/43/com/commonenv.com
echo $FIN_BANK_ID >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 
SERVERMODE=YES
export SERVERMODE
echo $SERVERMODE >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 
exebatch babx4044
B2K_SESSION_ID=`cat tty.mn3`
echo $B2K_SESSION_ID >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 
NOETOS=`cat anskey.mn1`
echo $NOETOS >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 
export B2K_SESSION_ID
export NOETOS

echo "after export" >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 
echo $B2K_SESSION_ID >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 
echo $NOETOS >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 

SCRIPT=/finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/43/INFENG/scripts/ebafb120.scr
export SCRIPT

echo $SCRIPT >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 

cd /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR

exebatch babx4061 $B2K_SESSION_ID $SCRIPT

echo "after" >> /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/APPLMGR/AFB120.log 

rm -f anskey.mn1
rm -f tty.mn3
exit 0


