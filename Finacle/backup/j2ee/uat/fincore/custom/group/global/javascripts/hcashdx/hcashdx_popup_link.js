<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}




<!-- This function is added for formatting a particular MRH Row -->

function formatRowValue(Obj, colNumber) {

      return Obj;

       }


function fnSubmitButtonClick()
{
        var d=currncy+"|"+sysCalAmt+"|"+usrEntAmt+"|"+chrgPart;
        if("Microsoft Internet Explorer"==browser_name){
                window.returnValue=d;
        }

        window.close();
}
