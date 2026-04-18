if test $# -ne 3
then   
 echo "Insufficient number of parameters recieved"
fi
job_id=$1
tmp_file=$2
ip_address=`cat $tmp_file | head -n 1`
file_name=`cat $tmp_file | head -n 2 | tail -n 1`
exe_name=`cat $tmp_file | head -n 3 | tail -n 1`
add_params=`cat $tmp_file | head -n 4 | tail -n 1`
input_file=`cat $tmp_file | head -n 5 | tail -n 1`
upl_path=`cat $tmp_file | head -n 6 | tail -n 1` 
user_id=`cat $tmp_file | head -n 7 | tail -n 1` 
ons_log_dir=`cat $tmp_file | head -n 8 | tail -n 1` 
appl_user_id=`cat $tmp_file | head -n 9 | tail -n 1` 
file_base_name=`basename $file_name` 
uploadclient LIMO://$ip_address//\ $file_name 

# ================================================
#	Exiting in case of Failure in File Transfer.
# ================================================
if [ $? -ne 0  ] || [ ! -f `basename $file_name` ]
then
	exit 1
fi

# ================================================================= 
# move the upload file from working dir to UPLOAD INPUT FILE PATH 
# ================================================================= 
if [ ! -z "$ons_log_dir" ]
then 
	mkdir -p $upl_path/$user_id
	mv $file_base_name $upl_path/$user_id 

	# ====================================================== 
	# create a soft link in <cust option>/<BJMS user> directory 
	# ====================================================== 
	if [ ! -z $appl_user_id ] 
	then 
		ln -fs $upl_path/$user_id/$file_base_name $upl_path/$appl_user_id/$file_base_name 
	fi 
else 
	mv $file_base_name $upl_path 
fi 

if [ $add_params = "(null)" ]
then
        add_params=' '
fi

if test -s $input_file
then
	case $3 in
	'B') 
	exebatch $exe_name $job_id $add_params < $input_file
	break ;;
	'S'|'G')
	exebatch $exe_name $job_id $input_file $add_params
	break ;;
	*)
	echo "Unknown program type. Exiting......."
	break ;;
	esac
else
    echo "The input file $input_file does not exist or it is zero bytes"
fi
rm -f $input_file
