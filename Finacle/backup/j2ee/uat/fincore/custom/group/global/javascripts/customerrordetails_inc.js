<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ page import="fabclasses.*, applcommon.*, java.util.ArrayList, com.infy.bbu.jsputil.ResourceManager"%>
<arjsp:init groupName="Customize" isEntryPoint="false" />
<%
final String STR_BLANK = "";
final String COMM_ERR_GROUP = "Common Group";  //error that do not belong to any group come here

String sGroupName = ARJspCurr.getCurrentGroup();
String sSubGroupName = (String)ARJspCurr.getInput("subGroupName","");
StringBuffer sbErrBuffer = new StringBuffer();
String sTemplateStatus = (String)ARJspCurr.getInputWithGroup("templateStatus",null);
fabclasses.FinErrException fex = (fabclasses.FinErrException)ARJspCurr.getInput(sGroupName+".fex",null);


String mandatoryTabChecked=(String)ARJspCurr.getInput(sSubGroupName+".MandatoryTabVisited","");

com.infy.COTP.LinkList displayErrLL= null;
if(fex != null) displayErrLL= fex.getErrLL();

String sTabHeadingPrefix = (String)ARJspCurr.getInputWithGroup("TabHeadingPrefix",null);
FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");

ArrayList alTabDetails= (ArrayList)(ARJspCurr.getInput(sSubGroupName+".TabDetails",""));

int iSize=alTabDetails.size();
int iIndex=iSize/6;

String sTabDetails[][] = new String[iIndex][6];


int j=0;

for(int i=0;i<iSize;i++)
{
	if(i!=0 && i%6==0)
		j++;
	sTabDetails[j][i%6]=(String)alTabDetails.get(i);
	
}


FABInquiry.Err errObj = null;

int iCount = 0;
int ancCount = 0;


if ( displayErrLL != null ) {

	int iNewCtr = 0;	//used to identify if the error just found is new error for the group
	for(int i = 0; i < sTabDetails.length; i++){
		iNewCtr = i;
		for(iCount = 0; iCount < displayErrLL.size() ; iCount++){
			errObj = (FABInquiry.Err)displayErrLL.elementAt(iCount);
			String []sErrSource = CommonFunctions.parseError(errObj);
	        if( (errObj.type !='B')
			  &&(errObj.type !='\0')
			  &&(errObj.type != CommonFunctions.FRONT_END_ERR_TYPE))
		    {
		    	continue;
		    }
			//filter for those errors that belong to the current group
			if( sErrSource[CommonFunctions.ERR_GROUP].equals(sTabDetails[i][TabResource.TAB_NAME]) ){
                //needs to be looked into
                if(iNewCtr++ ==  i){
                    ancCount++;
                    sbErrBuffer.append("<tr class=\"alert\"><td width='8%'>&nbsp;"+errObj.errCode+"</td><td width='15%'>&nbsp;<a id='anc" + ancCount + "' onMouseOver='displayHand(this)' onClick=onErrClick('"+sErrSource[CommonFunctions.ERR_GROUP]+"')>"+sTabDetails[i][TabResource.TAB_DESC]+"</a></td><td>&nbsp;");                    

                    //modified by ratish for mandatory tab check
                    
                    if((errObj.errCode).startsWith("FER")||(mandatoryTabChecked.equals("N")))                    
                        sbErrBuffer.append(errObj.errDesc);
                    else
                        sbErrBuffer.append(ResourceManager.getString(pageContext,"finbranch","FER000298"));

                    sbErrBuffer.append("</td></tr>");
				}
				else continue;
			}
		}
	}
	//filter for those errors that do not belong to any groups
	for(iCount = 0; iCount < displayErrLL.size() ; iCount++){
		errObj = (FABInquiry.Err)displayErrLL.elementAt(iCount);
		String []sErrSource = CommonFunctions.parseError(errObj);
		if( (errObj.type !='B')
		  &&(errObj.type !='\0')
		  &&(errObj.type != CommonFunctions.FRONT_END_ERR_TYPE))
		{
			continue;
		}
		//filter for those errors that belong to the current group
		if( sErrSource[CommonFunctions.ERR_GROUP].equals(STR_BLANK) ){
			sbErrBuffer.append("<tr class=\"alert\"><td width='8%' >&nbsp;"+errObj.errCode+"</td><td width='15%'>&nbsp;"+COMM_ERR_GROUP+"</td><td>&nbsp;"+errObj.errDesc+"</td></tr>");
		}
	}
}


%>

<%
	String sSubGrpName = (String)ARJspCurr.getInput("subGroupName","");
	String sGrpName = ARJspCurr.getCurrentGroup();
	String sPopUpExceptionWindow = (String)ARJspCurr.getInput(sGrpName+".PopUpExceptionWindow" ,"false");
	String sReferralMode = (String)ARJspCurr.getInput("refSubMode" ,"");
	ARJspCurr.setInput(sGrpName+".PopUpExceptionWindow","false");
%>

<script>
var sTabHeadingPrefix = "<%=ParseValue.checkString(sTabHeadingPrefix)%>";
var ancCount = <%=ParseValue.checkString(ancCount)%>;
var sMode ='<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("mode",""))%>';
var sbErrBuffer = '<%=ParseValue.checkString(sbErrBuffer)%>';

var sPopUpExceptionWindow = '<%=sPopUpExceptionWindow%>';
var sReferralMode = '<%=sReferralMode%>' ;

var funcCode = '<%=ParseValue.checkString(ARJspCurr.getInput(sSubGrpName+".funcCode",""))%>';	
	
</script>


<script language="JavaScript">
	printBlock();
</script>



