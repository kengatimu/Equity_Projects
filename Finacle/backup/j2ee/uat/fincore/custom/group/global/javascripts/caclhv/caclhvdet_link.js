<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() 
{
	return true;	
}

function fnOnPrevPageCall(obj)
{

	if(fnValidateData())
		{

			doSubmit(obj.id);
		}

}