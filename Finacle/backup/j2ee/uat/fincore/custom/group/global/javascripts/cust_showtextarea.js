/*<!-------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : cust_showtextarea.js
<!--Description         : This is used to enable text editor TO Id- 359942
<!--Date                                                 : 01-08-2013
<!--Author                                        :  Priyansh
<!--Called By                     : None
<!--Calling jsp                          : None
<!--Menu Option         : 
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------              ----------                 -----------        ------------------
<!--     0.1                01-08-2013                   Priyansh          Original version
<!--------------------------------------------------------------------------------------------------------------------------------------------->*/
function cust_showtextarea(inputVal,align,datatype,noofchar,funcCode)
{
	var retVal=inputVal;
	var argsVariable="";
	var url="../custom/jsp/cust_showtextarea.jsp?inputVal=" + inputVal + "&noofchar=" + noofchar + "&funcCode=" + funcCode
	var answer = window.showModalDialog(url,argsVariable, "dialogWidth:600px; dialogHeight:500px;center:yes");
	if(answer != undefined)
	{
		if(answer.txtArea != undefined)
		{
				retVal = answer.txtArea;
		}
	}
	return retVal;
}
