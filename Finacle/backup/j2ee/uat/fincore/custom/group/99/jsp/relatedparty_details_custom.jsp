
<script language="javascript" src="../Renderer/custom/javascripts/relatedparty_details_cust.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script type="text/javascript">
function relatedparty_details_post_ONLOAD(obj)
        {
        document.getElementById('custTelexNum').parentNode.previousSibling.innerHTML =  document.getElementById('custTelexNum').parentNode.previousSibling.innerHTML.replace("Telex No.","Per
centage of Ownership");

        document.getElementById('custFaxNum').parentNode.previousSibling.innerHTML =  document.getElementById('custFaxNum').parentNode.previousSibling.innerHTML.replace("Fax No.","Voting Ri
ghts");
        document.getElementById('remarks').parentNode.previousSibling.innerHTML =  document.getElementById('remarks').parentNode.previousSibling.innerHTML.replace("Notes","Controlling Inter
est");

        document.forms[0].custFaxNum.enabled=true;
        document.forms[0].custTelexNum.enabled=true;
        }

function custom_ONBLUR(obj)
{
        //alert("am in");



if ((profileId=='54'))
        {

        if (obj.id=="cifId")
        {
        document.forms[0].custFaxNum.enabled=true;
                document.forms[0].custTelexNum.enabled=true;

        }
        if(isNaN(document.forms[0].custTelexNum.value))
                {
            alert("Enter Valid Percentage of Ownership");
            document.forms[0].custTelexNum.focus();
                return false;
            }
        if(isNaN(document.forms[0].custFaxNum.value))
                {
            alert("Enter Valid Voting Rights");
            document.forms[0].custFaxNum.focus();
                return false;
            }
}
}
function relatedparty_details_pre_ONCLICK(obj)
{
        if (document.forms[0].custTelexNum.value=="")
        {
         alert("Enter Valid Percentage of Ownership");
                    document.forms[0].custTelexNum.focus();
                        return false;
        }

        if(document.forms[0].custFaxNum.value=="")
           {
                    alert("Enter Valid Voting Rights");
                    document.forms[0].custFaxNum.focus();
                        return false;
          }

        if((document.forms[0].remarks.value=="")|| (document.forms[0].remarks.value!='N') && (document.forms[0].remarks.value!='Y'))
          {
               alert("Enter Valid Voting Rights");
               document.forms[0].remarks.focus();
               return false;
            }
}



</script>
