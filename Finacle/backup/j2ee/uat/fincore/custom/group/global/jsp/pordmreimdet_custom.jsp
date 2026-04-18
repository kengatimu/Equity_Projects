<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : pordmmapdet_custom.jsp
<!--Menu Option       : HPORDM address issue
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/session.js"> </script>
<%
        FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
        if(null == securityInfo)
        {
                securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
        }
        String sBODDate = (String)((securityInfo.bodDate).substring(0,10));
        String homeSol  = (String)((securityInfo.homeSolId));
        String workClass  = (String)((securityInfo.userWorkClass));
        String homeCcy  = (String)((securityInfo.homeCrncyCode));
%>

<html>
<script>
        document.write('<input type="hidden" name="remvisitflg"   id="remvisitflg" value=""> ');
</script>
</html>
<script>

function custom_ONBLUR(a,obj){

        
        if(obj.id =="ordPartyAcct"){
                addresspop();
        }
       
}

function pordmreimdet_pre_ONLOAD(obj)
{
	if((profileId == "43") && (mopId == "HPORDM"))
	{
		//Address Line 1 label renaming to House no/street name
		document.forms[0].innerHTML = document.forms[0].innerHTML.replace('Address Line 1','House no/street name');
	}
}

function post_ONLOAD()
{
	addresspop();
	document.forms[0].remvisitflg.value = "Y";
	setCustomFieldValue("remvisitflg"); 
}

function addresspop()
{
if (mopId == "HPORDM")
alert("TTY");
        {
         var acctId = document.forms[0].ordPartyAcct.value;
        if(acctId != "")
        {
                var inputNameValues = "acctNum|"+acctId;
                var outputNames     = "";
                var scrName         = "hpordm_addres_pop.scr";
                var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                var ret1 = retVal.split("|");
				
		 if(ret1[0] == "errorMsg" )
                {
				alert(ret1[1]);
				 return false;
		}
                if(ret1[0] == "addr_1" )
                {
                        var mappedordPartyAddress1drc = ret1[1];
                        var mappedordPartyAddress2drc = ret1[3];
                        var mappedordPartyAddress3drc = ret1[5];
                }

		if((mappedordPartyAddress1drc == mappedordPartyAddress2drc) && (mappedordPartyAddress1drc == mappedordPartyAddress3drc))
                {
                                document.forms[0].ordPartyAddress1.value=mappedordPartyAddress1drc;
                                document.forms[0].ordPartyAddress2.value="";
                                document.forms[0].ordPartyAddress3.value="";

                }
                else
                {
                        if(mappedordPartyAddress1drc == mappedordPartyAddress2drc)
                        {
                                document.forms[0].ordPartyAddress1.value=mappedordPartyAddress1drc;
                                document.forms[0].ordPartyAddress2.value=mappedordPartyAddress3drc;
                                document.forms[0].ordPartyAddress3.value="";


                        }
                        else
                        {
                        if(mappedordPartyAddress2drc == mappedordPartyAddress3drc)
                        {
                                document.forms[0].ordPartyAddress1.value=mappedordPartyAddress1drc;
                                document.forms[0].ordPartyAddress2.value=mappedordPartyAddress3drc;
                                document.forms[0].ordPartyAddress3.value="";


                        }
                        else
                        {
                         if(mappedordPartyAddress1drc == mappedordPartyAddress3drc)
                        {
                                //alert("thiru");
                                document.forms[0].ordPartyAddress1.value=mappedordPartyAddress1drc;
                                document.forms[0].ordPartyAddress2.value=mappedordPartyAddress2drc;
                                document.forms[0].ordPartyAddress3.value="";


                        }
                        }

                        }
                }
                if((mappedordPartyAddress1drc != mappedordPartyAddress2drc) && (mappedordPartyAddress1drc != mappedordPartyAddress3drc))
                {
                                document.forms[0].ordPartyAddress1.value =mappedordPartyAddress1drc;
                                document.forms[0].ordPartyAddress2.value =mappedordPartyAddress2drc;
                                document.forms[0].ordPartyAddress3.value =mappedordPartyAddress3drc;

                }
        }
    }
        return true;
} 


</script>


