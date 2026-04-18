#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vpMerchantMaster.com
#  Description     :
#  Date            : 24-08-2021
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             24-08-2021      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Please do not change without CR and businsess change
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo $FIN_BANK_ID
ubankid=`echo $FIN_BANK_ID`
upldir="/finreports/MERCHANT_TRAN_IN/${ubankid}"
datadir="/finreports/MERCHANT_TRAN_IN/${ubankid}/DATA"
logdir="/finreports/MERCHANT_TRAN_IN/${ubankid}/LOG"
bkpdir="/finreports/MERCHANT_TRAN_IN/${ubankid}/DATA/BKP"
cd $upldir
utrFile="MERCHANT_TRAN_USD_"`date +%d%m%Y`".csv"
if [ "$ubankid" == "43" ]
then
#{
ktrFile="MERCHANT_TRAN_CDF_"`date +%d%m%Y`".csv"
#}
fi
if [ "$ubankid" == "54" ]
then
#{
ktrFile="MERCHANT_TRAN_KES_"`date +%d%m%Y`".csv"
#}
fi
rtgsFile="MERCHANT_RTGS_"`date +%d%m%Y`".csv"
eftFile="MERCHANT_EFT_"`date +%d%m%Y`".csv"
ctlPth=`echo $CTL_PATH`

if [ "$ubankid" == "54" ]
then
#{
usr="CDCI54"
#}
fi
if [ "$ubankid" == "43" ]
then
#{
usr="CDCI43"
#}
fi
ubankid=`echo $FIN_BANK_ID`
test -d ${datadir}
if [ $? -ne 0 ]
then
    echo "merchant data directory not exists"
fi
test -d ${bkpdir}
if [ $? -ne 0 ]
then
    echo "merchant data backup directory not exists"
fi
for fil in `ls | egrep -e ".csv"`
do
echo ${fil}
echo ${trFile}
if [ -f "$fil" ]; then
#{
        echo "$fil exists."
        if [[ ! -s $fil ]] ; then
        #{
                  echo $fil is empty
        #}
        else
        #{
                if [ "$ktrFile" == "$fil" ]
                then
                #{
                        if [ "$ubankid" == "54" ]
                        then
                        #{
                                echo "kes tran yes"
                                batchId="TRAN_KES"`date +%m%d%Y%H%M%S`
                                mv ${fil} ${datadir}/${fil}
                                logfile=${logdir}/${batchId}"_F.log"
                                badfile=${logdir}/${batchId}"_F.bad"
                                sed s/upluser/${usr}/g ${ctlPth}vpMerchantTran.ctl > vpMerTran1.ctl
                                sed s/uplbankid/${ubankid}/g vpMerTran1.ctl > vpMerTran2.ctl
                                sed s/uplbaid/${batchId}/g vpMerTran2.ctl > vpMerTran3.ctl
                                sed s/uplfilname/${fil}/g vpMerTran3.ctl > vpMerTran.ctl
                                filPth=${datadir}/${fil}
                                perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
                                $ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpMerTran.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
                                echo $? >> vp.log
                                test -f ${badfile}
                                if [ $? -eq 0 ]
                                then
                                        echo "in bad rpt " >>vp.log
                                fi
                                test -f ${logfile}
                                if [ $? -eq 0 ]
                                then
                                        echo "in log rpt " >>vp.log
                                fi
                                rm -f vpMerTran1.ctl vpMerTran2.ctl vpMerTran3.ctl vp.log vpMerTran.ctl
                                mv ${datadir}/${fil} ${bkpdir}/${fil}
                                `execom vpMerchantTran.com ${batchId}`
                        #}
                        fi
                        if [ "$ubankid" == "43" ]
                        then
                        #{
                                echo "cdf tran yes"
                                batchId="TRAN_CDF"`date +%m%d%Y%H%M%S`
                                mv ${fil} ${datadir}/${fil}
                                logfile=${logdir}/${batchId}"_F.log"
                                badfile=${logdir}/${batchId}"_F.bad"
                                sed s/upluser/${usr}/g ${ctlPth}vpMerchantTran43.ctl > vpMerTran41.ctl
                                sed s/uplbankid/${ubankid}/g vpMerTran41.ctl > vpMerTran42.ctl
                                sed s/uplbaid/${batchId}/g vpMerTran42.ctl > vpMerTran43.ctl
                                sed s/uplfilname/${fil}/g vpMerTran43.ctl > vpMerTran34.ctl
                                filPth=${datadir}/${fil}
                                perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
                                $ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpMerTran34.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
                                echo $? >> vp.log
                                test -f ${badfile}
                                if [ $? -eq 0 ]
                                then
                                        echo "in bad rpt " >>vp.log
                                fi
                                test -f ${logfile}
                                if [ $? -eq 0 ]
                                then
                                        echo "in log rpt " >>vp.log
                                fi
                                rm -f vpMerTran41.ctl vpMerTran42.ctl vpMerTran43.ctl vp.log vpMerTran34.ctl
                                mv ${datadir}/${fil} ${bkpdir}/${fil}
                                `execom vpMerchantTran.com ${batchId}`
                        #}
                        fi
                #}
                elif [ "$utrFile" == "$fil" ]
                then
                #{
                        if [ "$ubankid" == "54" ]
                        then
                        #{
                                echo "usd tran yes"
                                batchId="TRAN_USD"`date +%m%d%Y%H%M%S`
                                mv ${fil} ${datadir}/${fil}
                                logfile=${logdir}/${batchId}"_F.log"
                                badfile=${logdir}/${batchId}"_F.bad"
                                sed s/upluser/${usr}/g ${ctlPth}vpMerchantTran.ctl > vpMerTran1.ctl
                                sed s/uplbankid/${ubankid}/g vpMerTran1.ctl > vpMerTran2.ctl
                                sed s/uplbaid/${batchId}/g vpMerTran2.ctl > vpMerTran3.ctl
                                sed s/uplfilname/${fil}/g vpMerTran3.ctl > vpMerTran.ctl
                                filPth=${datadir}/${fil}
                                perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
                                $ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpMerTran.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
                                echo $? >> vp.log
                                test -f ${badfile}
                                if [ $? -eq 0 ]
                                then
                                        echo "in bad rpt " >>vp.log
                                fi
                                test -f ${logfile}
                                if [ $? -eq 0 ]
                                then
                                        echo "in log rpt " >>vp.log
                                fi
                                rm -f vpMerTran1.ctl vpMerTran2.ctl vpMerTran3.ctl vp.log vpMerTran.ctl
                                mv ${datadir}/${fil} ${bkpdir}/${fil}
                                `execom vpMerchantTran.com ${batchId}`
                        #}
                        fi
                        if [ "$ubankid" == "43" ]
                        then
                        #{
                                echo "usd tran yes"
                                batchId="TRAN_USD"`date +%m%d%Y%H%M%S`
                                mv ${fil} ${datadir}/${fil}
                                logfile=${logdir}/${batchId}"_F.log"
                                badfile=${logdir}/${batchId}"_F.bad"
                                sed s/upluser/${usr}/g ${ctlPth}vpMerchantTran43.ctl > vpMerTran41.ctl
                                sed s/uplbankid/${ubankid}/g vpMerTran41.ctl > vpMerTran42.ctl
                                sed s/uplbaid/${batchId}/g vpMerTran42.ctl > vpMerTran43.ctl
                                sed s/uplfilname/${fil}/g vpMerTran43.ctl > vpMerTran34.ctl
                                filPth=${datadir}/${fil}
                                perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
                                $ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpMerTran34.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
                                echo $? >> vp.log
                                test -f ${badfile}
                                if [ $? -eq 0 ]
                                then
                                        echo "in bad rpt " >>vp.log
                                fi
                                test -f ${logfile}
                                if [ $? -eq 0 ]
                                then
                                        echo "in log rpt " >>vp.log
                                fi
                                rm -f vpMerTran41.ctl vpMerTran42.ctl vpMerTran43.ctl vp.log vpMerTran34.ctl
                                mv ${datadir}/${fil} ${bkpdir}/${fil}
                                `execom vpMerchantTran.com ${batchId}`
                        #}
                        fi
                #}
                elif [ "$rtgsFile" == "$fil" ]
                then
                #{
                        echo "rtgs yes"
                        batchId="PO_"`date +%m%d%Y%H%M%S`
                        mv ${fil} ${datadir}/${fil}
                        logfile=${logdir}/${batchId}"_F.log"
                        badfile=${logdir}/${batchId}"_F.bad"
                        sed s/upluser/${usr}/g ${ctlPth}vpMerchantPo.ctl > vpMerPo1.ctl
                        sed s/uplbankid/${ubankid}/g vpMerPo1.ctl > vpMerPo2.ctl
                        sed s/uplbaid/${batchId}/g vpMerPo2.ctl > vpMerPo3.ctl
                        sed s/uplfilname/${fil}/g vpMerPo3.ctl > vpMerPo.ctl
                        filPth=${datadir}/${fil}
                        perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
                        $ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpMerPo.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
                        echo $? >> vp.log
                        test -f ${badfile}
                        if [ $? -eq 0 ]
                        then
                                echo "in bad rpt " >>vp.log
                        fi
                        test -f ${logfile}
                        if [ $? -eq 0 ]
                        then
                                echo "in log rpt " >>vp.log
                        fi
                        rm -f vpMerPo1.ctl vpMerPo2.ctl vpMerPo3.ctl vp.log vpMerPo.ctl
                        mv ${datadir}/${fil} ${bkpdir}/${fil}
                        `execom vpMerchantPo.com ${batchId}`
                #}
                elif [ "$eftFile" == "$fil" ]
                then
                #{
                        echo "eft yes"
                        batchId="EFT_"`date +%m%d%Y%H%M%S`
                        mv ${fil} ${datadir}/${fil}
                        logfile=${logdir}/${batchId}"_F.log"
                        badfile=${logdir}/${batchId}"_F.bad"
                        sed s/upluser/${usr}/g ${ctlPth}vpMerchantEft.ctl > vpMerEft1.ctl
                        sed s/uplbankid/${ubankid}/g vpMerEft1.ctl > vpMerEft2.ctl
                        sed s/uplbaid/${batchId}/g vpMerEft2.ctl > vpMerEft3.ctl
                        sed s/uplfilname/${fil}/g vpMerEft3.ctl > vpMerEft.ctl
                        filPth=${datadir}/${fil}
                        perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
                        $ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpMerEft.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
                        echo $? >> vp.log
                        test -f ${badfile}
                        if [ $? -eq 0 ]
                        then
                                echo "in bad rpt " >>vp.log
                        fi
                        test -f ${logfile}
                        if [ $? -eq 0 ]
                        then
                                echo "in log rpt " >>vp.log
                        fi
                        rm -f vpMerEft1.ctl vpMerEft2.ctl vpMerEft3.ctl vp.log vpMerEft.ctl
                        mv ${datadir}/${fil} ${bkpdir}/${fil}
                        `execom vpMerchantEft.com ${batchId}`
                #}
                else
                #{
                        echo "no"
                #}
                fi
        #}
        fi
else
    echo "$fil does not exist."
#}
fi
done
exit 0
