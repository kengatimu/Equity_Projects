<!-------------------------------------------------------------------------------------------------------------->
<!--Description         : Memo pad.
<!--Date                : 22-05-2013
<!--Author              : Manoj
<!--Called By           : None
<!--Calling  Jsp        : None
<!--Menu Option         : HALM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            22-05-2013           Manoj           Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@include file="formatAcct.jsp" %>
<%
	String acctLabel = "A/c. ID";
	String acctIdStr = "acctId";
	String solIdStr = "";
%>
<%@ include file="custsvswindow.jsp" %>
<script language="javascript">

function fnShowAccountIdList(funcCode){
	objForm = document.forms[0];
	if(funcCode.value  == "V" || funcCode.value  == "X" ){
	var funcCode = funcCode.value;
	showVerfyPendList("ALT",funcCode,"","","","F",objForm.acctId,objForm.modType,objForm.modId);
	fnEnableDisableModId();
    } else{
       showAccountIdList(objForm.acctId, objForm.acctSolId, objForm.acctShortName, 'F', objForm.acctCrncyCode);
    }
memoPad();
}


function memoPad(){
	var acctNumber = document.forms[0].acctId.value ;
	var inputNameValues = "acctNum|"+acctNumber;
	var outputNames     = "";
	var scrName         = "formatacctdp001.scr";
	var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret1 = retVal.split("|");
	if(ret1[0] == "MSG" ){
		alert(ret1[1]);
	}
}

function almcrit_pre_ONCLICK(obj)
{


if (obj.id=="Accept")
{
		var funcCode=document.forms[0].funcCode.value;
  		var modType=document.forms[0].modType.value;
		
	if ((funcCode=="M") && (modType=="LOANS"))
	{
		var dco=userId;
		var input      = "dco|"+dco;
		var outputNames    = "output|outVal";
		var scrName     =   "b_workclass.scr";
		var retVal = appFnExecuteScript(input,outputNames,scrName,false);
		var retBuff = retVal.split("|");
		var output = retBuff[0];
		var value = retBuff[1];
		var a = value;
		alert(a);		
		if (a<"076")
		{
			alert("You are not authorized to Modify this lien type");
			//alert("Users with Workclass '999' are only allowed to modify this lien");
			return false;
		}

    }

		//Audit check start Edwin
		var dco=userId;
		var input      = "dco|"+dco;
		var outputNames    = "output|outVal";
		var scrName     =   "b_workclass.scr";
		var retVal = appFnExecuteScript(input,outputNames,scrName,false);
		var retBuff = retVal.split("|");
		var output = retBuff[0];
		var value = retBuff[1];
		var output1 = retBuff[2];
		var solid = retBuff[3];
		var output2 = retBuff[4];
		var allow = retBuff[5];
		var a = value;
		var b = allow;
		alert(a);
		alert(b);
		//Modification to be allowed as FDR loans need to be modified.		
		if ((a=="210") && (b=="N") && ((funcCode !="I")&&(funcCode !="H")))
		{
			alert("ONLY INQUIRY OPTION IS ALLOWED FOR WC 210!!!");
			//alert("Users with Workclass '999' are only allowed to modify this lien");
			return false;
		}

	//audit check end
}

if ((obj.id=="Accept") &&(profileId=="54"))
{
        var funcCode=document.forms[0].funcCode.value;

        if ((funcCode=="A")||(funcCode=="M")||(funcCode=="V"))
        {
                var dco=userId;
                var input      = "dco|"+dco;
                var outputNames    = "output|outVal";
                var scrName     =   "b_workclass.scr";
                var retVal = appFnExecuteScript(input,outputNames,scrName,false);
                var retBuff = retVal.split("|");
                var output = retBuff[0];
                var value = retBuff[1];
                var a = value;
                //alert(a);
                if ((funcCode=="A")||(funcCode=="M"))
                {
                        if ((a=="074"))
                        {
                                alert("Lien Maintenance not allowed.Workclass 074")
                                return false;
                        }
                        else
                        {

                        }

                }

                if (funcCode=="V")
                {
                        if ((a=="051"))
                        {
                                alert("Lien Maintenance Veriication not allowed  for  Workclass 051")
                                return false;
                        }
                        else
                        {

                        }

                }
        }
}


if ((obj.id=="Accept") &&(profileId=="56"))
	{
		var funcCode=document.forms[0].funcCode.value;

		if ((funcCode=="A")||(funcCode=="M")||(funcCode=="V"))
		{
				var dco=userId;
				var input      = "dco|"+dco;
				var outputNames    = "output|outVal";
				var scrName     =   "b_workclass.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
				//alert(a);
				if ((funcCode=="A")||(funcCode=="M"))
				{
					if ((a=="110")||(a=="130")||(a=="150")||(a=="200")||(a=="260")||(a=="310")||(a=="084")||(a=="144")||(a=="250")||(a=="051"))
					{

					}
					else
					{
						alert("Lien Maintenance not allowed.Workclass 084,110,130,150,200,260,310,051")
						return false;
					}

				}
		
				if (funcCode=="V")
				{
					if ((a=="146")||(a=="290")||(a=="310")||(a=="340")||(a=="051"))
					{

					}
					else
					{
						if ((a=="150")||(a=="200"))
						{
							var	dco=document.forms[0].acctId.value;
							var input      = "dco|"+dco;
							var outputNames    = "output|outVal";
							var outputNames    = "output2|outVal";
							var scrName     =   "almaudch.scr";
							var retVal = appFnExecuteScript(input,outputNames,scrName,false);
							var retBuff = retVal.split("|");
							var output = retBuff[0];
							var value = retBuff[1];
							var k = value;
							//alert(k);
							if (k=="A")
							{

							}
							else
							{
									alert("Verification not allowed on Modified Lien.Workclass 146,290,310,340")
									return false;
							}
						}
						else
						{
						alert("Verification not allowed.Workclass 146,290,310,340")
						return false;
						}
					}

				}
		}
	}
}
</script>

