<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : ormgendtl_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This script used to make 
<!--                      the field manadatory in General Detail tab..
<!--Date                : 13-03-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HORM/HIRM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            13-03-2013           Shilpa           Original version
<!---------------------------------------------------------------------------------------------------------------->


<script language="javascript" src= "../../custom/javascripts/custom_functions.js"></script>
<script type="text/javascript">
function ormgendtl_pre_ONCLICK(obj){
	if(((funcCode == 'J')||(funcCode == 'M')) && (obj.id == "Submit" || obj.id == "Validate")){
		var oprAcct = document.forms[0].oprAcct.value;
		var chrgDrAcId = document.forms[0].chrgDrAcId.value;
		var purremit = document.forms[0].purOfRemit.value;

		if(oprAcct == ""){
			alert("Enter Operativa A/c.ID"); 
			document.forms[0].oprAcct.focus(); 
			return false;
		}

		if(chrgDrAcId == ""){
			alert("Enter charge Debit A/c.ID"); 
			document.forms[0].chrgDrAcId.focus(); 
			return false;
		}

		if(purremit == ""){
			alert("Enter Purpose of remittance"); 
			document.forms[0].purOfRemit.focus(); 
			return false;
		}
	}
//	alert("Please Visit Event Details tab");
}
function ormgendtl_ONBLUR(obj){
if((funcCode == 'J')||(funcCode == 'M'))
{
	setFieldsToCustomData("oprAcct");
}
}
</script>



