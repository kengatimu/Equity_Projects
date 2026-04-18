<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : saccrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 20-05-2013
<!--Author            : charles
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HSAC
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		20-05-2013	charles		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
//pre_ONLOAD4(obj,acctId)
function haccdet_pre_ONCLICK(obj)
{
if ( obj.id == "Accept")
{
//alert("xxxx");
var acctId1= document.forms[0].acctId.value;
//var acctId1= document.forms[0].acctId.value;

var inputNameValues = "acctId1|"+acctId1;
//alert(acctId1);


var outputNameValues = "";
            var scriptName = "accdet.scr";
            var ret = appFnExecuteScript(inputNameValues,outputNameValues,scriptName,false);
            var token = ret.split("|");
}
}
//post_ONLOAD(obj)
</script>
