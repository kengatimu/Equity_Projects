. `execom commfunc.com`

trap '' 2 3

input="$1"

sqlplus custom/kdh#bn@ebfin @/finacle/V707/app/cust/sql/EquiloanUpload1.sql 

sqlldr custom/kdh#bn@ebfin control=/finacle/V707/app/cust/scripts/EquiloanUpload.ctl  data=$HOME/$1

sqlplus custom/kdh#bn@ebfin @/finacle/V707/app/cust/sql/EquiloanUpload.sql $1

chmod 777 EquiloanUpload.lst

reportFileName="EquiloanUpload.txt"
lstFileName="EquiloanUpload.lst"
ripFileName="EquiloanUpload${$}.rip"
mrtFileName="EquiloanUpload.mrt"
datFileName="EquiloanUpload${$}.dat"


exebatch mrbx4004 $B2K_SESSION_ID $mrtFileName $lstFileName $reportFileName $ripFileName

fi

exit 0

