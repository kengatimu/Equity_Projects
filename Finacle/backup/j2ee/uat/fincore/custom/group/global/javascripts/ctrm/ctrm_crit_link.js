<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}

function fnShowUserIDList()
{
        alert("userIdList");
       	var userName = ""; 
	showUserIdList(document.forms[0].userId,null,'F',userName);
}



<!-- This function is added for formatting a particular MRH Row -->

function formatRowValue(Obj, colNumber) {

      return Obj;

       }
function fnValAndSubmit(btnObj){
	if(document.forms[0].userId.value == "")
        {
		alert("User ID must be entered");
                document.forms[0].userId.focus();
                return false;
        }
	doSubmit(btnObj.id);
}

<!-- This function is added for formatting a particular MRH Row -->

function fnValidateForm(obj){
	objForm = document.forms[0];

	return true;

}
function app_post_ONLOAD()     
{
//	funcCode="A";
 //               alert(funcCode);	
	document.forms[0].funcCode.value = "A";
}
