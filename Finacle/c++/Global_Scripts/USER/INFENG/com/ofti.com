#----------------------------------------------------------------------------------------------   
#    Name			 : ofti.com
#    Description     : This file is used to generating the spool file for the excution of the exe file. 
#    Date            : 19-03-2013
#    Author          : Farhan
#    Input           : NA
#    Output			 : NA
#    Called Script	 : NA
#    Calling Script	 : NA
#    Menu Option	 : HTM
#    Srl. No			Date			Author			Description.   
#    ------			----------			-------			---------------			
#    1.0			19-03-2013			Farhan			Original Version
#-------------------------------------------------------------------------------------------------
reportFileName="ofti${$}.rpt"
mrtFileName="ofti_cust.mrt"
lstFileName="$1"
echo "hs" > a.txt
mrbx4001 $mrtFileName  $lstFileName $reportFileName
if [ $? -ne 0 ]
then
    echo "Report Generation Failed !"
    exit 1
else
        echo "Report generated."
        tprint $reportFileName
fi
echo "h1" >> a.txt
if [ "x$TBA_DEBUG" = "x" ]
then
#    rm -f $lstFileName
fi

exit 0
