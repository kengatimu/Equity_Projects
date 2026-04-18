/*
This is a sample source.
*/

/*
SECTION-1: This is a mandatory section. This section contains the declaration of all the com scritps.

syntax of this section is like this:
	var execom_com_scr_names = {
	<unique-identifier1>:"<com-file-name1>|<Text-to-be-diplayed-to-user-in-the-selectbox1>|<Mode-of-execution1>",
	<unique-identifier2>:"<com-file-name2>|<Text-to-be-diplayed-to-user-in-the-selectbox2>|<Mode-of-execution2>",
	.
	.
	<unique-identifierN>:"<com-file-nameN>|<Text-to-be-diplayed-to-user-in-the-selectboxN>|<Mode-of-executionN>"
	};
Note: Mode-of-execution can be either F(Foreground) or B(Background).
*/
var execom_com_scr_names={
							abcd:"abcd.com|Trial Script|F",
							scrName2:"scrName2|2nd Script|B",
							testscript:"test.com|Test Script|F",
							noInput:"abc2.com|Test without any input|F"
						};


/*=================================================================*/

/*
SECTION-2: This section will contain all the field declarations and the validation functions for each com script.

Syntax of this section is like this:
	var <unique-identifier>_params={
				<field1-Id>:"<Literal-for-Field1>|<Max-length-for-field1>",
				<field2-Id>:"<Literal-for-Field2>|<Max-length-for-field2>",
				.
				.
				<fieldN-Id>:"<Literal-for-FieldN>|<Max-length-for-fieldN>"
				};

Below is the example for the abcd.com.
Here the abcd.com would be something like this:
	-----------abcd.com-----------
echo "Please enter your name:"
read name
echo "U entered this:" $name
echo "Please enter your profession:"
read prof
echo "So" $name ", ur profession is:" $prof
	-----------------------

Another eg., for abc2.com (noInput)
Here abc2.com would be something like this:
	----------abc2.com------
bauu9151 < a.sql
	------------------
*/

var abcd_params={
						name:"Name|10",
						prof:"Profession|5"
					};

function abcd_valFunc(){
	alert("In the validation function of scrName1");
}

var testscript_params={
						fld1:"Enter value 1|6",
						fld2:"Enter Value 2|15",
						fld3:"Enter value 3|9"
					};

/*This is the validation function for test.com inputs*/

function testscript_valFunc(){
	var frm = document.forms[0];
	alert("the value of 1st field: " + frm.fld1.value);
	if (frm.fld1.value == null || frm.fld1.value == ""){
		alert("Please enter a proper value in field 1");
		frm.fld1.focus();
		return false;
	}
	if (frm.fld2.value == null || frm.fld2.value == ""){
		alert("Please enter a proper value in field 2");
		frm.fld2.focus();
		return false;
	}
}

var noInput_params={
					dummy:"Dummy Field|1"
				}
