grep -li urhk_dbCursorOpen *.scr | while read line ; do
echo "Processing $line"
var_a=$(grep -ci "urhk_dbCursorClose" $line)
var_e=$(grep -ci "urhk_dbCursorOpen" $line)
var_b=$(grep -i "urhk_dbCursorClose" $line | grep -sc "#")
var_f=$(grep -i "urhk_dbCursorOpen" $line | grep -sc "#")
var_c=$(($var_a-$var_b))
    var_g=$(($var_e-$var_f))
    if [ "$var_c" -lt "$var_g" ]
    then
    echo "Processing $line">> "unclosedcursor.txt"
    fi
    done
