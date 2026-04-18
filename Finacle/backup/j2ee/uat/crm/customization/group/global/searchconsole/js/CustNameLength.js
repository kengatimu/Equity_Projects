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
        var fullName = firstName + middleName + lastName;
        var nameLength = fullName.length;
        if ( nameLength > 100 )
        {
		obj.value = "";
                alert("Enter the First, Middle & Last names such that Full Name does not exceed 100 characters");
		obj.focus();
		return false;
        }
}

function fnNameLenProspQDE(obj)
{
        var firstName = trim(document.getElementById("SuspectBO.firstName").value);
        var middleName = trim(document.getElementById("SuspectBO.MiddleName").value);
        var lastName = trim(document.getElementById("SuspectBO.lastName").value);
        var fullName = firstName + middleName + lastName;
        var nameLength = fullName.length;
        if ( nameLength > 100 )
        {
		obj.value = "";
                alert("Enter the First, Middle & Last names such that Full Name does not exceed 100 characters");
		obj.focus();
		return false;
        }
}

