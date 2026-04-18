<!-------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : tfcdocdet_custom.jsp
<!--Description         : This is used to set currency code as home currency in Document tab of menu MNTFWC TOL - 356930
<!--Date                : 17-07-2013
<!--Author              : Priyansh
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : MNTFWC
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------              ----------                 -----------        ------------------
<!--     0.1                 17-07-2013                   Priyansh          Original version
<!--	 0.2		     24-07-2013			  Priyanka	    Updated to make document tab mandatory CR - 356933
<!--------------------------------------------------------------------------------------------------------------------------------------------->
<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*,finbranchUtil.*"%>

<%
        FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
        if(null == securityInfo)
        {
                securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
        }
	String homeCrncy  = (String)((securityInfo.homeCrncyCode));
%>


<script type="text/javascript">

document.write('<input type="hidden" name="docTabVisitedFlg" id="docTabVisitedFlg" >');

document.forms[0].docTabVisitedFlg.value = "Y";
setFieldsToCustomData("docTabVisitedFlg");

function tfcdocdet_post_ONLOAD() 
{		
	if(typeof(mopId) != "undefined")
	{
        	if(mopId == 'MNTFWC')
		{
			if(document.forms[0].ccy.value == "")
			{
				document.forms[0].ccy.value = "<%=homeCrncy%>";
			}
		}
	}
}


function tfcdocdet_pre_ONCLICK(obj)
{
        if ( funcCode == 'A' || funcCode == 'M' || funcCode == 'C' || funcCode == 'E' || funcCode == 'L')
        {
                if (obj.id == "Submit" || obj.id == "Validate")
                {
                         if (!fnValidateForm(sArg))
                         {
                                 return false;
                         }
                         if(!fnValidateConditionalMandatory(objForm))
                         {

                                         return false;

                         }
                }
        }
}

function tfcdocdet_pre_TAB_SWITCH()
{
         if (!fnValidateForm(sArg))
         {
                    return false;
         }
         if(!fnValidateConditionalMandatory(objForm))
         {

                         return false;

         }
}


</script>

