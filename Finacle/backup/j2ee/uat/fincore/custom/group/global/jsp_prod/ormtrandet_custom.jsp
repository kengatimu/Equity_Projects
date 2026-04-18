<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : ormtrandet_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 13-03-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HORM/HIRM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            13-03-2013           Shilpa           Original version
<!--     0.2            19-06-2013           Shilpa           split value modified in HORM mop id
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="ormtran" isEntryPoint="false" />
<script type ="text/javascript">
function post_ONLOAD(obj){
	var inputNameValues    = "";
	var outputNames        = "val1";
	var scrName            = "rmvalmn001.scr";
	var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");
	var acctType= ret[1];

		if(mopId == "HIRM"){
		if((funcCode == 'G')||(funcCode == 'M')){
			var custData = document.forms[0].customData.value;
            var custSplit = custData.split('|');
			var length = custSplit.length;
			var myString = custData;
			var name= myString.search("~irmgendtl");
			var addr1= myString.search("~irmgendtl");
			var newname = myString.substring(name,myString.length);
			var newaddr1 = myString.substring(addr1,myString.length);
			var custPayDataSplit1 = newname.split('|');
			name= custPayDataSplit1[1];
			var custPayDataSplit2 = newaddr1.split('|');
			addr1 = custPayDataSplit2[2];
                     
			if(sacType == acctType){
             			if(drCrFlg == "C" ){          
					document.forms[0].tranPartcls.value ="FrgnRmt"+" "+refCcy+ " " +refAmt + " " +name;
					return false;
				}
				else{
					document.forms[0].tranPartcls.value = "COMM ON FOREIGN REMITTANCE";
					return false;
				}    
			}
		}
	}
		if(mopId == "HORM"){
		if((funcCode == 'J')||(funcCode == 'M')){
		
			var custData = document.forms[0].customData.value;
			var custSplit = custData.split('|');
			var length = custSplit.length;
			var myString = custData;
			var oprAcct = myString.search("~ormgendtl");
			var newoprAcct = myString.substring(oprAcct,myString.length);
			var custPayDataSplit = newoprAcct.split('|');
			oprAcct= custPayDataSplit[1];
			var Name= myString.search("~ormpartydtl");
			var addrBB1= myString.search("~ormpartydtl");
			var remitTypeLen = myString.search("~ormcrit");
			var newremitType = myString.substring(remitTypeLen ,myString.length);
			var newName = myString.substring(Name,myString.length);
			var newaddrBB1 = myString.substring(addrBB1,myString.length);
			var custPayDataSplit = newremitType.split('|');
			remitType = custPayDataSplit[1].toUpperCase();
			var custPayDataSplit2 = newName.split('|');
			Name = custPayDataSplit2[2];
			var custPayDataSplit3 = newaddrBB1.split('|');
			addrBB1= custPayDataSplit3[3];

			if(drCrFlg == "D" && sacType == acctType) {
				document.forms[0].tranPartcls.value ="FrgnRmt"+" "+refCcy+ " " +refAmt + " " +Name;
				return true;
			}
			else{
				alert("Visit the customer credit part tran only...");
			}	
		}	
	}
}
</script>


