<%
    IDetailProperties dtlProp = null;

    screenProperties = (ICriteriaProperties)ARJspCurr.getInput(CommonConstants.KEY_CRITERIA_PROPERTIES,null);
    
	//flag to specify whether validate button should be hidden or displayed
    String isValReq    = null;
    boolean bEnableVal = false;

	if(screenProperties instanceof IDetailProperties)   {

        dtlProp         = (IDetailProperties)screenProperties;
        uiProperties = dtlProp.getDetailUIProperties();
        attributes      = uiProperties.getCriteriaAttributes();
        separators      = uiProperties.getSeparatorAttributes();
        columnPattern   = uiProperties.getColumnPattern();

    }
    if(attributes != null)  {
            fldCount = attributes.length;
    }

    if(separators!=null)           {
            sepCount            =          separators.length;
    }

    String sFnCode = (String)ARJspCurr.getInput(sScreenName+"."+"funcCode","");

    String sId = sScreenName;    
    sScreenName = sScreenName + FrwkViewConstants.KEY_SUFFIX_DTL;

        /**Audit changes starts from here*/
        //Calling a validateAndProcessRequestForFramework method of FinAFIRequestor
        finbranchUtil.FinAFIRequestor.validateAndProcessRequestForFramework(pageContext,ARJspCurr,sId);
        /**Audit changes Ends here*/
	
	//get the value of showValidateButton attribute set in context
    isValReq = (String)ARJspCurr.getInput(CommonConstants.KEY_SHOW_VAL_BUTTON,"");
    if(isValReq.equals("TRUE")){
        bEnableVal = true;
    }
%>

<script>

var fnCode      = "<%=ParseValue.checkString(sFnCode)%>";
var fldCnt      = "<%=ParseValue.checkString(fldCount)%>";
var firstFldName= "<%=ParseValue.checkString(attributes[0].getFieldName())%>";

screenName = "<%=ParseValue.checkString(sScreenName)%>";

</script>
