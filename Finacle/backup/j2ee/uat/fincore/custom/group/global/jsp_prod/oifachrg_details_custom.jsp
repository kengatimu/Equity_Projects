<!------------------------------------------------------------------------------------------------>
<!--    Name            :       oifachrg_details_custom.jsp                                       
<!--    Menu            :       OIFA                                                  
<!--    Author          :       Priya K                                               
<!--    Description     :       Fee tab is disabled .        
<!--    Modification History                                                                    
<!--    <Serial No>  <Date>          <Author>        <Description>                               
<!--    1            15-Jul-2013     Priya K            Original Version                           
<!------------------------------------------------------------------------------------------------>
<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="com.infy.finbranch.groups.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*"%>
<%@ include file="../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>

<script language="javascript" src="../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="javascript">


function post_ONLOAD(obj)
{
	if( (mopId == "OIFA") || (mopId == "MIFA") || (mopId == "MIFAT"))
	{ 
		ObjForm = document.forms[0];
		ObjForm.totChrgCollected.disabled= true ;
		ObjForm.totChrgAssessed.disabled= true ;
		ObjForm.totChrgWaived.disabled= true ;
		ObjForm.eventId.disabled= true ;
		ObjForm.chargeType.disabled= true ;
		ObjForm.maxNoOfAssessmnts.disabled= true ;
		ObjForm.assessFreqType.disabled= true ;
		ObjForm.assessFreqWeek.disabled= true ;
		ObjForm.assessFreqDay.disabled= true ;
		ObjForm.assessStartDate.disabled= true ;
		ObjForm.hldyStatus.disabled= true ;
		ObjForm.assessFreqCalBase.disabled= true ;
		disableFields("nextAssessDate");
		ObjForm.feeTenor.disabled= true ;
		ObjForm.chkdeductible_flg.disabled= true ;
		ObjForm.chkdelFlg.disabled= true ;
		hideImage("sLnk1");
		hideImage("sLnk2");
		hideImage("sLnk3");
		hideImage("sLnk4");
		ObjForm.chargeFreqDetail_AddNew.disabled= true ;
		ObjForm.chargeFreqDetail_LowLimit.disabled= true ;
	}
}

</script>
