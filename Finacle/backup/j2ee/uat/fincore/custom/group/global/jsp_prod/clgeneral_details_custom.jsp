<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : clgeneral_details_custom.jsp
<!--Description         : Setting A/c Statement field to default value and A/c manager field as mandatory
<!--Date                : 09-07-2013
<!--Author              : Priyanka T02
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HOAACCL
<!--Modification History:
<!--    Version No.          Date                Author             Description
<!--    ---------          ----------           ---------          -----------------
<!--     0.1               09-07-2013          Priyanka T02    Original version
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/clgeneraldetails/clgeneral_details_glink.js"></script>
<script type ="text/javascript">

function clgeneral_details_post_ONLOAD(){
objForm=document.forms[0];
        if(objForm.pbPsFlg.value == "")
        {
                objForm.pbPsFlg.selectedIndex = 2;
        }
return true;
}

function clgeneral_details_pre_TAB_SWITCH(){
var retVal = ""
        if ((retVal =  checkMandatoryFields()) == false) {
              return false;
        }
return true;
}

function clgeneral_details_pre_ONCLICK(obj){
if(obj.id == "Submit" || obj.id == "Validate")
{
        var retVal = ""
        if ((retVal =  checkMandatoryFields()) == false) {
              return false;
        }
}
return true;
}
/**************************************************************************************
Function Name   :   fnCheckMandatoryFields()
Description     :   This function is called to check mandatory fields
**************************************************************************************/
function checkMandatoryFields()
{
        var ObjForm = document.forms[0];
        if(fnIsNull(ObjForm.acctMgrAtAcct.value))
        {
                alert("Enter the A/c. Manager ID");
                ObjForm.acctMgrAtAcct.focus();
                return false;
        }
return true;
}


</script>


