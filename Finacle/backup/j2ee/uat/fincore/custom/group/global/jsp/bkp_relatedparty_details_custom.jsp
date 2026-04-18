
<script language="javascript" src="../Renderer/custom/javascripts/relatedparty_details_cust.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script type="text/javascript">
function relatedparty_details_post_ONLOAD(obj)
        {
        document.getElementById('amount').parentNode.previousSibling.innerHTML =  document.getElementById('amount').parentNode.previousSibling.innerHTML.replace("Amt.","Percentage of Ownership");
        document.getElementById('prefLangRemarks').parentNode.previousSibling.innerHTML =  document.getElementById('prefLangRemarks').parentNode.previousSibling.innerHTML.replace("Remarks in Preferred Language","Voting Rights");
        document.getElementById('remarks').parentNode.previousSibling.innerHTML =  document.getElementById('remarks').parentNode.previousSibling.innerHTML.replace("Notes","Controlling Interest(Y/N)");

        //document.forms[0].custFaxNum.enabled=true;
        //document.forms[0].custTelexNum.enabled=true;
        }

function custom_ONBLUR(obj)
{
        //alert("am in");



  if ((profileId=='54'))
        {

        if (obj.id=="cifId")
        {
        //document.forms[0].custFaxNum.enabled=true;
               // document.forms[0].custTelexNum.enabled=true;

        }
        if(isNaN(document.forms[0].amount.value))
                {
            alert("Enter Valid Percentage of Ownership");
            document.forms[0].amount.focus();
                return false;
            }
        if(isNaN(document.forms[0].prefLangRemarks.value))
                {
            alert("Enter Valid Voting Rights");
            document.forms[0].prefLangRemarks.focus();
                return false;
            }
      }
}

function relatedparty_details_pre_ONCLICK(obj)
{
	if ((profileId=='54'))
	{
        if (document.forms[0].amount.value=="")
        {
         alert("Enter Valid Percentage of Ownership");
                    document.forms[0].amount.focus();
                        return false;
        }

		if (document.forms[0].amount.value<='0')
        {
         alert("Enter Valid Percentage of Ownership");
                    document.forms[0].amount.focus();
                        return false;
        }

        if(document.forms[0].prefLangRemarks.value=="")
           {
                    alert("Enter Valid Voting Rights");
                    document.forms[0].prefLangRemarks.focus();
                        return false;
          }

		  if(isNaN(document.forms[0].prefLangRemarks.value))
                {
            alert("Enter Valid Voting Rights");
            document.forms[0].prefLangRemarks.focus();
                return false;
            }	

        if((document.forms[0].remarks.value!='N') && (document.forms[0].remarks.value!='Y'))
          {
               alert("Enter Controlling Interest");
               document.forms[0].remarks.focus();
               return false;
            }
	}
}



</script>
