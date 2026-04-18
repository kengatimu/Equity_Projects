#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : ebSwifRtgsMsgSep.com 
#  Description     :
#  Date            : 17-12-2020
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             17-12-2020      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/etc/b2k/EQDR/FINCORE/43/com/commonenv.com
echo $FIN_BANK_ID
wd="/finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/PAYSYS43/LOG/"
mkp="/finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/PAYSYS43/LOG/BCDCLOG/"
reout="/finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/PAYSYS43/LOG/BCDC/"
cd ${wd}
nacct="RTO15"
ott="OTT15"
eazybiz=":20:OTTBZN"
tfyz="20:OLCF"
isstmt="{2:I940"
isstbcdc="{1:F01BCDCCDKIAXXX0000000000"
logfil=`date +%m%d%Y%H%M%S`".log"
##for fil in `find /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/PAYSYS43/LOG  -name "*.MSG" -print`
##for fil in `find . -type f -name "*.MSG"`
for fil in `ls | egrep -e ".MSG"`
do
echo ${fil}
#######if [ grep -q $nacct ${fil} ] OR [ grep -q $ott ${fil} ] OR [ grep -q $eazybiz ${fil} ] OR [ grep -q $tfyz ${fil} ]; then
if grep -q $nacct ${fil};
then
	echo "in BCDC loop"
	isrtgs=":33B:CDF"
	if grep -q $isrtgs ${fil};
	then
		perl -pi -e 's/\n/\r\n/g' ${fil}
		uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
		uidd=`echo "${uuidd}" | tr -d -`
		uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
		uidi=`echo ${uidi:0:6}`
		uidi=`date +%S%N | cut -c 6-`
		senum=`date +%N  | cut -c 2-`
		yymmdd=`date +%Y%m%d`
		hhmm=`date +%H%M`
		##datr="RTGS""${uidi}"".SWF"
		datr="RTGS""${senum}""${yymmdd}""${hhmm}"".SWF"
		cp -p ${fil} ${reout}${datr}
		mv ${fil} ${mkp} 
		echo $?
	else
		isrtgs="CDF"
		if grep -q $isrtgs ${fil};
		then
			perl -pi -e 's/\n/\r\n/g' ${fil}
			uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
			uidd=`echo "${uuidd}" | tr -d -`
			uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
			uidi=`echo ${uidi:0:6}`
		senum=`date +%N  | cut -c 2-`
		yymmdd=`date +%Y%m%d`
		hhmm=`date +%H%M`
			##datr="RTGS""${uidi}"".SWF"
		datr="RTGS""${senum}""${yymmdd}""${hhmm}"".SWF"
			cp -p ${fil} ${reout}${datr}
			mv ${fil} ${mkp}
			echo $?
		else
			perl -pi -e 's/\n/\r\n/g' ${fil}
			uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
			uidd=`echo "${uuidd}" | tr -d -`
			uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
			uidi=`echo ${uidi:0:6}`
			senum=`date +%N  | cut -c 2-`
			yymmdd=`date +%Y%m%d`
			hhmm=`date +%H%M`
			##datr="SWFD""${uidi}"".SWF"
			#++++++++++++
			fscnt=`wc -c ${fil} |  awk '{print $1}'`
			var1=512
			if [ $fscnt -eq "512" ]
		 	then	
				echo "system generated file is already 512 bytes...................."
				datr="SWFD""${senum}""${yymmdd}""${hhmm}"".SWF"
				cp -p ${fil} ${reout}${datr}
				mv ${fil} ${mkp}
				echo $?
			else
				echo "system generated file is NOT 512 bytes...................."
				datr="SWFD""${senum}""${yymmdd}""${hhmm}"".SWF"
				echo ${var1}
				echo ${fscnt}
				appendCnt=`expr ${var1} - ${fscnt}`
				echo ${appendCnt}
				fappendCnt=`expr ${appendCnt} + 2`
				echo ${fappendCnt}
				tail -1 ${fil} | awk '{printf "%-'$fappendCnt's\n", $0}' >> "TAIL_"${uidi}".SWF" 
				sed  '$ d'  ${fil} > "HEAD_"${uidi}".SWF" 
				cat "HEAD_"${uidi}".SWF" "TAIL_"${uidi}".SWF" > ${datr} 
				cp -p  ${datr} ${reout}${datr} 
				mv ${datr} ${mkp}
				rm -f "HEAD_"${uidi}".SWF" "TAIL_"${uidi}".SWF"
				echo $?
			fi
			#++++++++++++++++
		fi
	fi
elif grep -q $ott ${fil};
	then
		echo "in BCDC loop"
		isrtgs=":33B:CDF"
		if grep -q $isrtgs ${fil};
		then
			perl -pi -e 's/\n/\r\n/g' ${fil}
			uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
			uidd=`echo "${uuidd}" | tr -d -`
			uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
			uidi=`echo ${uidi:0:6}`
		senum=`date +%N  | cut -c 2-`
		yymmdd=`date +%Y%m%d`
		hhmm=`date +%H%M`
			##datr="RTGS""${uidi}"".SWF"
		datr="RTGS""${senum}""${yymmdd}""${hhmm}"".SWF"
			cp -p ${fil} ${reout}${datr}
			mv ${fil} ${mkp}
			echo $?
		else
			isrtgs="CDF"
			if grep -q $isrtgs ${fil};
			then
				perl -pi -e 's/\n/\r\n/g' ${fil}
				uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
				uidd=`echo "${uuidd}" | tr -d -`
				uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
				uidi=`echo ${uidi:0:6}`
		senum=`date +%N  | cut -c 2-`
		yymmdd=`date +%Y%m%d`
		hhmm=`date +%H%M`
				##datr="RTGS""${uidi}"".SWF"
		datr="RTGS""${senum}""${yymmdd}""${hhmm}"".SWF"
				cp -p ${fil} ${reout}${datr}
				mv ${fil} ${mkp}
				echo $?
			else
				perl -pi -e 's/\n/\r\n/g' ${fil}
				uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
				uidd=`echo "${uuidd}" | tr -d -`
				uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
				uidi=`echo ${uidi:0:6}`
		senum=`date +%N  | cut -c 2-`
		yymmdd=`date +%Y%m%d`
		hhmm=`date +%H%M`
				##datr="SWFD""${uidi}"".SWF"
                        #++++++++++++
                        fscnt=`wc -c ${fil} |  awk '{print $1}'`
                        var1=512
                        if [ $fscnt -eq "512" ]
                        then
                                echo "system generated file is already 512 bytes...................."
                                datr="SWFD""${senum}""${yymmdd}""${hhmm}"".SWF"
                                cp -p ${fil} ${reout}${datr}
                                mv ${fil} ${mkp}
                                echo $?
                        else
                                echo "system generated file is NOT 512 bytes...................."
                                datr="SWFD""${senum}""${yymmdd}""${hhmm}"".SWF"
                                echo ${var1}
                                echo ${fscnt}
                                appendCnt=`expr ${var1} - ${fscnt}`
                                echo ${appendCnt}
                                fappendCnt=`expr ${appendCnt} + 2`
                                echo ${fappendCnt}
				tail -1 ${fil} | awk '{printf "%-'$fappendCnt's\n", $0}' >> "TAIL_"${uidi}".SWF"
                                sed  '$ d'  ${fil} > "HEAD_"${uidi}".SWF"
                                cat "HEAD_"${uidi}".SWF" "TAIL_"${uidi}".SWF" > ${datr}
                                cp -p  ${datr} ${reout}${datr}
                                mv ${datr} ${mkp}
				rm -f "HEAD_"${uidi}".SWF" "TAIL_"${uidi}".SWF"
                                echo $?
                        fi

                        #++++++++++++++++

			fi
		fi
elif grep -q $eazybiz ${fil};
then
                echo "in BCDC loop"
                isrtgs=":33B:CDF"
                if grep -q $isrtgs ${fil};
                then
                        perl -pi -e 's/\n/\r\n/g' ${fil}
                        uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
                        uidd=`echo "${uuidd}" | tr -d -`
                        uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
                        uidi=`echo ${uidi:0:6}`
                senum=`date +%N  | cut -c 2-`
                yymmdd=`date +%Y%m%d`
                hhmm=`date +%H%M`
                        ##datr="RTGS""${uidi}"".SWF"
                datr="RTGS""${senum}""${yymmdd}""${hhmm}"".SWF"
                        cp -p ${fil} ${reout}${datr}
                        mv ${fil} ${mkp}
                        echo $?
                else
                        isrtgs="CDF"
                        if grep -q $isrtgs ${fil};
                        then
                                perl -pi -e 's/\n/\r\n/g' ${fil}
                                uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
                                uidd=`echo "${uuidd}" | tr -d -`
                                uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
                                uidi=`echo ${uidi:0:6}`
                senum=`date +%N  | cut -c 2-`
                yymmdd=`date +%Y%m%d`
                hhmm=`date +%H%M`
                                ##datr="RTGS""${uidi}"".SWF"
                datr="RTGS""${senum}""${yymmdd}""${hhmm}"".SWF"
                                cp -p ${fil} ${reout}${datr}
                                mv ${fil} ${mkp}
                                echo $?
                        else
                                perl -pi -e 's/\n/\r\n/g' ${fil}
                                uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
                                uidd=`echo "${uuidd}" | tr -d -`
                                uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
                                uidi=`echo ${uidi:0:6}`
                senum=`date +%N  | cut -c 2-`
                yymmdd=`date +%Y%m%d`
                hhmm=`date +%H%M`
                                ##datr="SWFD""${uidi}"".SWF"
                        #++++++++++++
                        fscnt=`wc -c ${fil} |  awk '{print $1}'`
                        var1=512
                        if [ $fscnt -eq "512" ]
                        then
                                echo "system generated file is already 512 bytes...................."
                                datr="SWFD""${senum}""${yymmdd}""${hhmm}"".SWF"
                                cp -p ${fil} ${reout}${datr}
                                mv ${fil} ${mkp}
                                echo $?
                        else
                                echo "system generated file is NOT 512 bytes...................."
                                datr="SWFD""${senum}""${yymmdd}""${hhmm}"".SWF"
                                echo ${var1}
                                echo ${fscnt}
                                appendCnt=`expr ${var1} - ${fscnt}`
                                echo ${appendCnt}
                                fappendCnt=`expr ${appendCnt} + 2`
                                echo ${fappendCnt}
				tail -1 ${fil} | awk '{printf "%-'$fappendCnt's\n", $0}' >> "TAIL_"${uidi}".SWF"
                                sed  '$ d'  ${fil} > "HEAD_"${uidi}".SWF"
                                cat "HEAD_"${uidi}".SWF" "TAIL_"${uidi}".SWF" > ${datr}
                                cp -p  ${datr} ${reout}${datr}
                                mv ${datr} ${mkp}
				rm -f "HEAD_"${uidi}".SWF" "TAIL_"${uidi}".SWF"
                                echo $?
                        fi

                        #++++++++++++++++

                        fi
                fi
elif grep -q $tfyz ${fil};
then
                echo "in BCDC loop"
                isrtgs=":33B:CDF"
                if grep -q $isrtgs ${fil};
                then
                        perl -pi -e 's/\n/\r\n/g' ${fil}
                        uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
                        uidd=`echo "${uuidd}" | tr -d -`
                        uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
                        uidi=`echo ${uidi:0:6}`
                senum=`date +%N  | cut -c 2-`
                yymmdd=`date +%Y%m%d`
                hhmm=`date +%H%M`
                        ##datr="RTGS""${uidi}"".SWF"
                datr="RTGS""${senum}""${yymmdd}""${hhmm}"".SWF"
                        cp -p ${fil} ${reout}${datr}
                        mv ${fil} ${mkp}
                        echo $?
                else
                        isrtgs="CDF"
                        if grep -q $isrtgs ${fil};
                        then
                                perl -pi -e 's/\n/\r\n/g' ${fil}
                                uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
                                uidd=`echo "${uuidd}" | tr -d -`
                                uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
                                uidi=`echo ${uidi:0:6}`
                senum=`date +%N  | cut -c 2-`
                yymmdd=`date +%Y%m%d`
                hhmm=`date +%H%M`
                                ##datr="RTGS""${uidi}"".SWF"
                datr="RTGS""${senum}""${yymmdd}""${hhmm}"".SWF"
                                cp -p ${fil} ${reout}${datr}
                                mv ${fil} ${mkp}
                                echo $?
                        else
                                perl -pi -e 's/\n/\r\n/g' ${fil}
                                uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
                                uidd=`echo "${uuidd}" | tr -d -`
                                uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
                                uidi=`echo ${uidi:0:6}`
                senum=`date +%N  | cut -c 2-`
                yymmdd=`date +%Y%m%d`
                hhmm=`date +%H%M`
                                ##datr="SWFD""${uidi}"".SWF"
                        #++++++++++++
                        fscnt=`wc -c ${fil} |  awk '{print $1}'`
                        var1=512
                        if [ $fscnt -eq "512" ]
                        then
                                echo "system generated file is already 512 bytes...................."
                                datr="SWFD""${senum}""${yymmdd}""${hhmm}"".SWF"
                                cp -p ${fil} ${reout}${datr}
                                mv ${fil} ${mkp}
                                echo $?
                        else
                                echo "system generated file is NOT 512 bytes...................."
                                datr="SWFD""${senum}""${yymmdd}""${hhmm}"".SWF"
                                echo ${var1}
                                echo ${fscnt}
                                appendCnt=`expr ${var1} - ${fscnt}`
                                echo ${appendCnt}
                                fappendCnt=`expr ${appendCnt} + 2`
                                echo ${fappendCnt}
				tail -1 ${fil} | awk '{printf "%-'$fappendCnt's\n", $0}' >> "TAIL_"${uidi}".SWF"
                                sed  '$ d'  ${fil} > "HEAD_"${uidi}".SWF"
                                cat "HEAD_"${uidi}".SWF" "TAIL_"${uidi}".SWF" > ${datr}
                                cp -p  ${datr} ${reout}${datr}
                                mv ${datr} ${mkp}
				rm -f "HEAD_"${uidi}".SWF" "TAIL_"${uidi}".SWF"
                                echo $?
                        fi

                        #++++++++++++++++

                        fi
                fi
else
        if grep -q $isstmt ${fil};
        then
		if grep -q $isstbcdc ${fil};
		then
			perl -pi -e 's/\n/\r\n/g' ${fil}
			uuidd=`/usr/bin/python /finacle/EQDR/Fin10218/APP/Finacle/FC/app/cust/54/INFENG/com/ebV4UUID.py`
			uidd=`echo "${uuidd}" | tr -d -`
			uidi=`echo "${uidd}" | tr '[a-z]' '[A-Z]'`
			uidi=`echo ${uidi:0:6}`
			senum=`date +%N  | cut -c 2-`
			yymmdd=`date +%Y%m%d`
			hhmm=`date +%H%M`
			datr="MT940""${senum}""${yymmdd}""${hhmm}"".SWF"
			cp -p ${fil} ${reout}${datr}
			mv ${fil} ${mkp}
			echo $?
		else
			echo "no +++++++++++++++++++++++++"
		fi
        else
                echo "no +++++++++++++++++++++++++"
        fi
fi
done
exit 0
