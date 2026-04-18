<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : aclicrit_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This is used to pass
<!--                      the values
<!--Date                : 11-07-2013
<!--Author              : Khan
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HACLINQ
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            11-07-2013           Khan           Original version
<!--     0.2			04/09/2013			 Kalvin			modified for TO :371603 
<!--     0.3			08/10/2013			 Bharath			Modified for TOL 
<!---------------------------------------------------------------------------------------------------------------->
<%@include file="formatAcct.jsp" %>

<script language="javascript" src="../Renderer/custom/javascripts/aclicrit_cust.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/session.js"> </script>

<!--Modified for TO :371603------------ -->
<script type ="text/javascript">
function aclicrit_pre_ONCLICK(obj)
{
	var objForm = document.forms[0];
	if(typeof(mopId) != "undefined"){
		if(mopId=='HACLINQ'){
			if(obj.id == 'Accept'){
				if(objForm.acctNum.value != "" ){
					setSValue("catodAcctNum|"+objForm.acctNum.value);

					var acct = objForm.acctNum.value;
					var input      = "acct|"+acct;
					var outputNames    = "output|outVal";
					var scrName     =   "bio_check.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					//alert(a);
					var retBuff = retVal.split("|");
					var output1 = retBuff[2];
					var value1 = retBuff[3];
					var b = value1;
					//alert(b);
					if (a!=1)
					{
						if (b!=4) 
						{
							alert("ENROLL CUSTOMER FOR BIO");
						}
						if (b==4) 
						{
							alert("PLEASE ENROLL CUSTOMER FOR BIO");
							document.forms[0].acctNum.focus();
							return false;
						}
					}

					//equitel start
					var acct = objForm.acctNum.value;
					var inputNameValues =  "acctNum|"+acct;
					var outputNames     = "";
					var scrName         = "b_equitelacct.scr";
					var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					var ret1 = retVal.split("|");
					 if(ret1[0] == "Y" )
						{
							alert("The Equitel line linked to this account is INACTIVE.Kindly advise the customer to replace their SIM card at the Equitel desk,for FREE or to BUY Equitel airtime so as to receive 100% BONUS airtime");
						}

					//equitel end
					if (profileId=="11")
					{
						var acct = objForm.acctNum.value;
						var inputNameValues =  "acctNum|"+acct;
						var outputNames     = "";
						var scrName         = "phone_check.scr";
						var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
						var retBuff = retVal.split("|");
						var output = retBuff[0];
						var value = retBuff[1];
						var a = value;
						 if(a == "N" )
							{
								alert("Kindly Update customers phone at CIF Level");
							}
					}
					else
					{

					//KRA PIN start
						var acct = objForm.acctNum.value;
						var inputNameValues =  "acctNum|"+acct;
						var outputNames     = "";
						var scrName         = "krapin_check.scr";
						var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
						var retBuff = retVal.split("|");
						var output = retBuff[0];
						var value = retBuff[1];
						var a = value;
						 if(a == "N" )
							{
								alert("Kindly Update customers PIN at CIF Level");
							}
					}
					//KRA PIN end
				}
			}
		}
	}

if (obj.id == "Accept")
         {
             var inputNameValues = "foracid|"+document.forms[0].acctNum.value+"|startDate|"+document.forms[0].startDate_ui.value+"|endDate|"+document.forms[0].endDate_ui.value;
             var outputNames = "msg";
             var scrName="acliInsert.scr";
             retVal=appFnExecuteScript(inputNameValues, outputNames, scrName, false);
             return true;
         }
}

function aclicrit_ONCLICK12(b,c)
{
        document.forms[0].acctNum.value="";
	document.forms[0].solId.value="";
        document.forms[0].acctName.value="";
        document.forms[0].crncyCode.value="";
        document.forms[0].addressLn1.value="";
        document.forms[0].addressLn2.value="";
        document.forms[0].addressLn3.value="";
        document.forms[0].city.value="";
        document.forms[0].state.value="";
        document.forms[0].country.value="";
        document.forms[0].pinNo.value="";
        document.forms[0].phoneNo.value="";
        document.forms[0].mobileNo.value="";
        document.forms[0].emailId.value="";
        document.forms[0].custStat.value="";
        document.forms[0].acctStat.value="";
        document.forms[0].acctNum.focus();
        //return false;
}


function aclicrit_post_ONLOAD(obj)
{
             var inputNameValues ="";
             var outputNames = "acctNum|startDate|endDate";
             var scrName="acliSelect.scr";
             retVal=appFnExecuteScript(inputNameValues, outputNames, scrName, false);
             retVal = retVal.split("|");
             var acctNum=retVal[1];
             var startDate=retVal[3];
             var endDate=retVal[5];

            if((startDate!=undefined)&&(startDate!=" ")&&(startDate!=""))
            {
                document.forms[0].startDate_ui.value=startDate;
            }
            if((endDate!=undefined) && (endDate!=" ")&&(endDate!=""))
            {
                document.forms[0].endDate_ui.value=endDate;
            }
           
            if(fnIsNull(document.forms[0].acctNum.value)==true)
            {
                 if(acctNum != document.forms[0].acctNum.value)
		{
                    document.forms[0].acctNum.value = acctNum;
                }
            }
            
            if (profileId=="11")
            {
                // Document Expiration Check --- Anderson
                if (document.forms[0].acctNum.value != "") {
                    var inputNameValues = "foracid|" + document.forms[0].acctNum.value;
                    var outputNames = "msgFlg";
                    var scrName = "checkDocExpDate.scr";
                    retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                    retVal = retVal.split("|");
                    if (retVal[1]) {
                        alert(retVal[1]);
                    }
                }
                // End Document Expiration Check --- Anderson
            }
}




</script>
