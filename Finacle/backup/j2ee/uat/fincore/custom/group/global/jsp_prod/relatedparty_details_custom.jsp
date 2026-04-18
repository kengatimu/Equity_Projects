
<script language="javascript" src="../Renderer/custom/javascripts/relatedparty_details_cust.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script language="javascript">

var inputNameValues    = "";
var outputNames        = "bankId";
var scrName            = "oclgirptmn003.scr";
var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
var ret = retVal.split("|");
bankId = ret[1];

function relatedparty_details_pre_ONCLICK(btn)
 {
if (bankId == "54")
    {
        if (mopId == "HOAACSB" || mopId == "HOAACCA")
        {
            if ((btn.id == "Submit") || (btn.id == "Validate")) 
            {
                var chkcodes = document.forms[0].chkmiscodes;
                if (!chkcodes.checked) 
                {
                    document.getElementById("miscodes").click();
                            alert("Enter Tertiary RMID in the MISC Codes TAB");
                    return false;
                }
            }
        }
    }
}

function relatedparty_details_pre_TAB_SWITCH(obj)
{		
   if(bankId == "54")
   {
       if (mopId == "HOAACSB" || mopId == "HOAACCA")	
          {  
               var chkcode = document.forms[0].chkmiscodes;
               if (!chkcode.checked) 
                 {
                    document.getElementById("miscodes").click();
                            alert("Enter Tertiary RMID On MIS Codes Tab to Proceed");
                    return true;
		 }
	}  
   }
}
</script>