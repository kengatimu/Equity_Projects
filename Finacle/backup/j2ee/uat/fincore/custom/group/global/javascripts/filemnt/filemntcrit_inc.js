<%
	IDetailProperties dtlProperties =   null;
	
	screenProperties = (ICriteriaProperties)ARJspCurr.getInput(CommonConstants.KEY_CRITERIA_PROPERTIES,null);
	
	//flag to specify whether validate button should be hidden or displayed
    String isValReq    = null;
    boolean bEnableVal = false;

	dtlProperties = (IDetailProperties)screenProperties;

	uiProperties = dtlProperties.getUIProperties();
	attributes =          uiProperties.getCriteriaAttributes();

	if(attributes!=null)           {
		fldCount            =          attributes.length;
	}

	separators =		uiProperties.getSeparatorAttributes();

	if(separators!=null)           {
		sepCount            =          separators.length;
	}

	columnPattern	= uiProperties.getColumnPattern();

	String[] reqFuncCodesArray  = dtlProperties.getReqdFunctionCodes();
	
	sScreenName = sScreenName + FrwkViewConstants.KEY_SUFFIX_CRIT;
	
	
	/* changes done as a part of the fix 244134 */
	String toFld 				= 	null;
	ICriteriaAttribute critAttribute	=	null;
	for (int i=0;i<fldCount;i++)
	{
		critAttribute	=	attributes[i];
	
		if(critAttribute.getIsCopyFld() == 'Y')
		{
			toFld=critAttribute.getFieldName();
			break;
		}	
	}
	 
	/* End of changes done for the fix 244134 */	
	
	//get the value of showValidateButton attribute set in context
    isValReq = (String)ARJspCurr.getInput(CommonConstants.KEY_SHOW_VAL_BUTTON,"");
    if(isValReq.equals("TRUE")){
        bEnableVal = true;
    }
%>
<script language="JavaScript">
	var reqdFuncCodes = null;
	var sToFld="<%=ParseValue.checkString(toFld)%>";
	<%
	    if(reqFuncCodesArray!=null) {
		arrCount    =   reqFuncCodesArray.length;
	%>
		reqdFuncCodes   =   new Array(<%=ParseValue.checkString(arrCount)%>);

		<%for(int j=0;j<arrCount;j++)   {%>
			reqdFuncCodes["<%=ParseValue.checkString(j)%>"]="<%=ParseValue.checkString(reqFuncCodesArray[j])%>";
		<%}%>
	<%}%>

	var fnCode = "<%=ParseValue.checkString(ARJspCurr.getInput(sMenuName+".funcCode",""))%>";
	var action="<%=ParseValue.checkString(ARJspCurr.getInput(CommonConstants.KEY_ACTION,null))%>";

	//If the Action Code is "Cancel", the Function Code is reset to empty.
	if(action=="<%=ParseValue.checkString(CommonConstants.ACTION_CANCEL)%>")	{
		fnCode	="";
	}
	var isCopyAction= false;

	//If the Action Code is "Copy", then the 'isActionCopy' variable is made true,
	//thus making the condition that the user will be displayed the second criteria
	//screen which has the 'copy' fields.
	if(action=="<%=ParseValue.checkString(CommonConstants.ACTION_COPY)%>")	{
		isCopyAction=true;
	}
	screenName = "<%=ParseValue.checkString(sScreenName)%>";
</script>
