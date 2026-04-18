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
<%@include file="../../jsp/formatAcct.jsp" %>
<%
	String acctLabel = "A/c. ID";
	String acctIdStr = "acctId";
	String solIdStr = "";
%>
<%@ include file="../../jsp/custsvswindow.jsp" %>
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

//Edwin.Z DRC start
function almcrit_pre_ONCLICK(obj)
{
	
	if ((obj.id=="Accept") &&(profileId=="43"))
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

				/*if ((funcCode=="A")||(funcCode=="M"))
				{
					if ((a=="240")||(a=="084")||(a=="051")||(a=="060")||(a=="070")||(a=="110")||(a=="150")||(a=="200")||(a=="260")||(a=="310"))
					{

					}
					else
					{
						alert("Lien Maintenance not allowed!!! only Workclass 051,060,070,084,110,150,200,240,260,310 allowed")
						return false;
					}
				}*/
				//restrict users to modify / delete lien with wrk cls <999
				if (funcCode=="M")
				{
					var modType=document.forms[0].modType.value;
					
					if (modType!="ULIEN")
					{
						if ((a!="150")&&(a!="145"))
						{								
							alert("You are not authorized to Modify this lien type");
							//alert("Users with Workclass '150' are only allowed to modify this lien");
							return false;
						}
					}
					
				}
				

				if (funcCode=="V")
				{
					if ((a=="060")||(a=="070"))
					{
						alert("Verification not allowed by work class 070 and 060")
						return false;

				
						/*if ((a=="150")||(a=="200"))
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
									alert("Verification not allowed on Modified Lien.Workclass 146,290,310")
									return false;
							}
						}
						else
						{
						alert("Verification not allowed.Workclass 146,290,310")
						return false;
						}
						*/									
					}

				}
		}
	}
	
	
}
//Edwin.Z DRC end
</script>
<html>
<script>
{
        document.write('<html>');
        
        document.write('<table class ="ctable" id="tbaleId" border="0" cellpadding="0" cellspacing="0" width="100%">');
        document.write('<tr>');
        document.write('<td valign="top">');
        document.write('<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
        document.write('<tr>');
        document.write('<td>');
        document.write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        document.write('<tr>');
        document.write('<td>');
        document.write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
        document.write('<tr>');
        document.write('<td>');
        document.write('</td>');
        document.write('</tr>');
        document.write('<tr class="innertabletop1">');
        document.write('<td colspan="5" align="right">');
        document.write('<table border="0" cellspacing="0" cellpadding="0">');
        document.write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
        document.write('<tr>');
      
	document.write('<td class="textlabel" size="500">IBAN Number </td>');


	 document.write('<td class="textfield" size="200">');
       	        document.write('<input type="text" name="ibanNo" style="width: 200px" class="textfieldfont" id="ibanNo" OnChange="javascript:fnIbanVal()">');
 
        document.write('</td>');
		document.write('<td>&nbsp</td>');
        document.write('<td>&nbsp</td>');
        document.write('<td>&nbsp</td>');
        document.write('<td>&nbsp</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('<tr class="rowspacing">');
        document.write('<td colspan="2"><spacer type="block" height="1" width="1"></spacer></td>');
        document.write('</tr>');
        document.write('</table>');
		 document.write('<tr class="rowspacing">');
        document.write('<td colspan="2"><spacer type="block" height="1" width="1"></spacer></td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</html>');
}
</script>
<script language="Javascript">
function fnIbanVal()
{
document.forms[0].acctId.value ='';
document.forms[0].acctSolId.value='';
document.forms[0].acctCrncyCode.value='';
document.forms[0].acctShortName.value='';
var ibanNo = document.forms[0].ibanNo.value;
 var inputNameValues    = "ibanNo|"+ibanNo;
                         var outputNames        = "errorFlg|errorMsg|acctNum|acctName|solId|crncyCode";
                         var scrName            = "ibanToForacid.scr";
                         var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var result      = retVal.split("|");
        var errorFlg = result[1];
        var errorMsg = result[3];
        var acctNum = result[5];
        var solId = result[9];
        var crncyCode = result[11];
        var acctName = result[7];
         if (errorFlg == "Y") {
                alert(errorMsg);
                document.forms[0].acctId.value ='';
                        document.forms[0].ibanNo.value = '';
                return false;
            } else {
                    document.forms[0].acctId.value =acctNum;
                        document.forms[0].acctSolId.value = solId;
        document.forms[0].acctCrncyCode.value=crncyCode;
                document.forms[0].acctShortName.value = acctName;
        setFieldFocus(document.forms[0].acctId);
                }
return true;
}
</script>

</html>
