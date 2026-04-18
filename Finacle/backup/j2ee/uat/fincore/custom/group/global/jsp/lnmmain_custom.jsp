<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : lnmmain_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 07-01-2013
<!--Author            : cate
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HLNM
<!--Modification History:
<!--    Version No.     Date            Author          Description
<!--    -----------     ------          ----------      ---------------------------
<!--    0.1             07-01-2013      CATE            Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function lnmmain_pre_ONCLICK(obj)
{
        if(mopId == "HLNM")
        {

			//patch for call ID - 392912	
		if (obj.id == "globalLimitFlg")
		{
			var tmpVar =  getRadioValue(document.forms[0].globalLimitFlg);
			if(tmpVar == "Y")
			{
				alert("Limit is set as Global Limit,this cannot be modified later.");		
			}	
		}
		//patch ends here

        if(obj.id=="Submit")
                {
                if(document.forms[0].limExpDate.value=="")
					{
					alert("Enter limit expiry date");
					return false;
					}
                if(document.forms[0].limitEffDate.value=="")
					{
					alert("Enter limit effective date");
					return false;
					 }
			    if(document.forms[0].limitType.value=="")
					{
					alert("Enter limit Type");
					document.forms[0].limitType.focus();
					return false;
					 }
				if(document.forms[0].cifID.value=="")
					{
					alert("Enter limit Limit Type ID");
					document.forms[0].cifID.focus();

					return false;

					 }
                    {
				var radioButtons = document.getElementsByName('condPrecedentFlg');
				radioButtons[0].checked = true;
				radioButtons[1].checked = false;
		           }       

                }
        }
}

</script>



