<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : aclslres_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 29-07-2013
<!--Author              : George
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HACLHM
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                29-07-2013             George              Original version          
<!--     0.2                25-10-2013             Bharath              Remarks field defaultly populated
<!---------------------------------------------------------------------------------------------------------------->
<script>
function aclslres_post_ONLOAD(obj)
{
	if (mopId=="HACLHM")
	{
		if(vFuncCode != "I")
		{
			//alert("isha kuwa");
			//document.forms[0].limLvlIntFlg.value="Y";
		alert("Kindly check Normal Int Percent for LIMIT LEVEL INT");
		}
		var remksLenght = (document.forms[0].notes.value).length;
		var custData = (document.forms[0].customData.value).length;

		if ( (vFuncCode == "M") && (remksLenght==0) && (custData==0))
		{	
			document.forms[0].notes.value="CHARGES";
			document.forms[0].customData.value="~aclslres|";
		}
	}
}
function aclslres_pre_ONCLICK(obj)
                {
                        if (obj.id == "Submit") 
						{
                                if (document.forms[0].limLvlIntFlg.value=="Y")
                                {
                                      alert(document.forms[0].nrmlIntRate.value);

								 if (document.forms[0].nrmlIntRate.value == "")
                                        {
                                        alert("PLEASE ENTER NORMAL INTEREST RATE");
                                        document.forms[0].nrmlIntRate.focus();
                                        return false;
                                        }
                                }
                        }
                }
               
</script>
