<script language="javascript" src="../Renderer/custom/javascripts/relatedparty_details_cust.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script language="javascript">

function relatedparty_details_pre_ONLOAD(obj)
{
    if(profileId == "43")
    {
        var labels = document.getElementsByTagName("td");
        for (var i = 0; i < labels.length; i++) {
            var td = labels[i];

            // Only target cells that hold labels (textlabel class)
            if (td.className && td.className.indexOf("textlabel") !== -1) {
                var txt = td.innerText || td.textContent;
				//State label renaming to State/commune
                if (txt && txt.indexOf("Address Line 1") !== -1) {
                    td.innerHTML = td.innerHTML.replace(/Address Line 1/g, "House no/street name");
                }
				//Address Line 1 label renaming to House no/street name
                if (txt && txt.indexOf("State") !== -1) {
                    td.innerHTML = td.innerHTML.replace(/State/g, "State/commune");
                }
            }
        }
    }
}


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