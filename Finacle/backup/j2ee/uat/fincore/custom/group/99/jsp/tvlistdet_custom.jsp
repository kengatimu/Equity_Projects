<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : tvlistdet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : Mark Nderitu
<!--Author            : Farhan
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HTV
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		0804-2025	Mark Nderitu		Original version
 
<!---------------------------------------------------------------------------------------------------------------->

<script language="javascript" >




function post_ONLOAD() {
	alert(mopId)
}
function tvlistdet_pre_ONCLICK(obj) {
	alert(mopId)
if (mopId == "HTV") {
		alert("HTV menu");
        if (obj.id == "Submit") {
			alert("HTV menu");
	alert(index)

	var newtranIdArr =  tranIdArr ;

	         for (var i=0; i<=index; i++)
	                {
	                    newtranIdArr == newtranIdArr[i] ;
						 //newtranIdArr[i] += newtranIdArr[i] ;
	var input = "newtranIdArr|"+newtranIdArr+"|index|"+i;                
	}
	                alert(newtranIdArr);

            //var dco = headUserId;
            //var input = "tranIdArr|" + tranIdArr[index];
			//var input = "tranIdArr|" + tranIdArr[1];
	//var input = "newtranIdArr|" + newtranIdArr[i];
	//var input = "newtranIdArr" +i+"|" + newtranIdArr + i;
	//var input = "";
            var outputNames = "";
            var scrName = "ttumSalLienRemove.scr";
            var retVal = appFnExecuteScript(input, outputNames, scrName, false);
            var ret = retVal.split("|");
            //if (ret[1] == "PASS") {
            //    return true;
            //}
            //if (ret[1] == "FAIL") {
            //    alert("Role id Not Allowed");
            //    return false;
            //}
			return true;
        }
    }
   }
</script>
