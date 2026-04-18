fileName1=$2"_APPLIED_"$3".SUC"
fileName2=$2"_UNAPPLIED_"$3".SUC"
fileName3=$2"_Charge_"$3".SUC"
datFile="uddsTest${$}.dat"
bauu9151 uddsdirectdebitmn001.sql $1 
if [ $? -ne 0 ]
then
        echo "SQL execution failed !" > uddslog.txt
        exit 1
fi

#modified by Anuya
echo "$fileName1 $4 $5
MANAGER $8 $fileName1 $4 Direct_Debit_Applied $5 Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile Direct_Debit_Applied.dat
mcbx4024 $B2K_SESSION_ID < Direct_Debit_Applied.dat
echo `head -1 TRAN_INFO.dat` >> Direct_Debit_Applied.txt
a=`head -1 TRAN_INFO.dat`
echo "a is " $a > uddslog.test

echo "$fileName2 $4 $5
MANAGER $8 $fileName2 $4 Direct_Debit_Unapplied $5 Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile Direct_Debit_Unapplied.dat
mcbx4024 $B2K_SESSION_ID < Direct_Debit_Unapplied.dat
echo `head -1 TRAN_INFO.dat` >> Direct_Debit_Unapplied.txt
a=`head -1 TRAN_INFO.dat`
echo "b is " $b >> uddslog.test

echo "$fileName3 $4 $5
MANAGER $8 $fileName3 $4 Direct_Debit_Charges $5 Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile Direct_Debit_Charges.dat
mcbx4024 $B2K_SESSION_ID < Direct_Debit_Charges.dat
echo `head -1 TRAN_INFO.dat` >> Direct_Debit_Charges.txt
c=`head -1 TRAN_INFO.dat`
echo "c is " $c >> uddslog.test

if [ $5 == "Y" ]
then
	mv $9 $9.done
fi

if test "$a" != ""
then
echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " > test354352.sql
echo " tran_id = '"$a"|"$b"|"$c"'" >> test354352.sql
echo " WHERE upld_file_name = '"$6"'" >> test354352.sql
echo " AND bank_id = '"$7"'" >> test354352.sql
echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"$6"'" >> test354352.sql
echo " AND bank_id = '"$7"')" >> test354352.sql
echo "/" >> test354352.sql
echo "COMMIT" >> test354352.sql
echo "/" >> test354352.sql
else
echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " > test354352.sql
echo " tran_id = '"$a|"$b"|"$c""'" >> test354352.sql
echo " WHERE upld_file_name = '"$6"'" >> test354352.sql
echo " AND bank_id = '"$7"'" >> test354352.sql
echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"$6"'" >> test354352.sql
echo " AND bank_id = '"$7"')" >> test354352.sql
echo "/" >> test354352.sql
echo "COMMIT" >> test354352.sql
echo "/" >> test354352.sql
fi

bauu9151 test354352.sql

exit 0
