function fnNameLength(obj)
{
        var firstName = trim(document.getElementById("AccountBO.Cust_First_Name").value);
        var middleName = trim(document.getElementById("AccountBO.Cust_Middle_Name").value);
        var lastName = trim(document.getElementById("AccountBO.Cust_Last_Name").value);
        var fullName = firstName + middleName + lastName;
       	document.getElementById("AccountBO.Name").value = firstName + " " + middleName + " " + lastName;
        var nameLength = fullName.length;
        if ( nameLength > 100 )
        {
		obj.value = "";
		document.getElementById("AccountBO.Cust_Last_Name").value = "";
                alert("Enter the First, Middle & Last names such that Full Name does not exceed 100 characters");
		obj.focus();
		return false;
        }
}


function fnNameLengthSQDE(obj)
{
        var firstName = trim(document.getElementById("AccountBO.Cust_First_Name").value);
        var middleName = trim(document.getElementById("AccountBO.Cust_Middle_Name").value);
        var lastName = trim(document.getElementById("AccountBO.Cust_Last_Name").value);
        var fullName = "";
        var nameLength = fullName.length;
	
		if (firstName != null && firstName != "") {
		fullName = firstName;
	}
	if (middleName != null && middleName != "") {
		if (fullName != null) {
			fullName = trim(fullName + " " + middleName);
		} else {
			fullName = trim(middleName);
		}
	}
	if (lastName != null && lastName != "") {
		
		if (fullName != null) {
			fullName = trim(fullName + " "+ lastName);
		} else {
			fullName = trim(lastName);
		}
	}
	document.getElementsByName("AccountBO.Name")[0].value = fullName;
        if ( nameLength > 100 )
        {
		obj.value = "";
		document.getElementById("AccountBO.Cust_Last_Name").value = "";
                alert("Enter the First, Middle & Last names such that Full Name does not exceed 100 characters");
		obj.focus();
		return false;
        }
}

function fnloadSQDE()
{
 
 document.getElementsByName(boName+".CustomerNREFlg")[0].value = "N";
 document.getElementsByName(boName+".Cust_Language")[0].value = "UK (English)";
 
 if(!(bcName=='000'||bcName=='1000'||bcName=='2000'||bcName=='3000'||bcName=='4000'))
 {
 document.getElementsByName("AccountBO.Primary_sol_id")[0].disabled=true;
 document.getElementsByName("Cat_AccountBO.Primary_sol_id")[0].disabled=true;
 document.getElementsByName("btnone_AccountBO.Primary_sol_id")[0].disabled = true;
 document.getElementsByName("btntwo_AccountBO.Primary_sol_id")[0].disabled = true;
 }
 
var URL = "";
/*Added for currency issue*/

var accountid="";
var strProcessURL = '../servlet/com.infy.cis.custom.EquityGetCurrency?entityId='+accountid;
fnEquityGetCurrency(strProcessURL);

}

/*Added for currency issue*/
function fnEquityGetCurrency(strProcessURL)
{ 
    try{
        
	var xmlhttp;
	if (window.XMLHttpRequest)
	{
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else if (window.ActiveXObject)
	{
		// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		alert("Your browser does not support XMLHTTP!");
	}
	
        xmlhttp.abort();
	xmlhttp.open("GET",strProcessURL,false);
        xmlhttp.send();
	if(xmlhttp.status == 200)
	  { 
	   Currency = xmlhttp.responseXML.selectSingleNode("XML/Currency").text;
	   
	  }
	  }
      catch(e)
           {
		alert(e.message);
	   }
} 
/*Added for currency issue*/



