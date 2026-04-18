<%
    ICriteriaAttribute critAttribute			=	null;
	ICriteriaAttribute[] critAttributes			=	null;
	IUIProperties uiDtlCritProperties						=	null;
	int critFldCount							=	0;
	String fldName								=	null;
	String critColPattern						=	null;
	String fldType								=	null;
	String fldValue								=	null;
	String comboDesc							=	null;
	String[] valArray							=	null;
	String valOption							=	null;
	String[] litArray							=	null;
	int index									=	-1;
	char isCopy	;
	String frmCpyFld							=	null;
	String toCpyFld 							= 	null;
	boolean flg									= 	false;	
	String	tempFldName							= 	null;

    uiDtlCritProperties		= dtlProp.getUIProperties();
    critAttributes =          uiDtlCritProperties.getCriteriaAttributes();
	if(critAttributes != null)  {
	            critFldCount = critAttributes.length;
    }
    critColPattern	=	uiDtlCritProperties.getColumnPattern();
	critColPattern	=	(critColPattern != null) ? critColPattern : "";

%>
<script>

var critDispProperties	=	new DisplayAttributes();

var critColPattern = "<%=critColPattern%>";
var critFldCount = <%=critFldCount%>;
var cntr = 0;

var litCode = new Array(critFldCount);
var dispPosition = new Array(critFldCount);
var critDispRow = new Array(critFldCount);
var dispColspanLit = new Array(critFldCount);
var dispColspanFld = new Array(critFldCount);
var dispColspanDummy = new Array(critFldCount);
var critDispIsJoin = new Array(critFldCount);
var dispSeparator = new Array(critFldCount);
var critFldDataType = new Array(critFldCount);
var critIsCpyFld = new Array(critFldCount);
var fldVal = new Array(critFldCount);

<% for (int i=0;i<critFldCount;i++){
	critAttribute	=	critAttributes[i];
	fldType			=	critAttribute.getDisplayType();
	fldName			=	critAttribute.getFieldName();
	fldValue		=	(String)ARJspCurr.getInput(sMenuName+"."+fldName,"");
	isCopy			=	critAttribute.getIsCopyFld();
	frmCpyFld		=	(String)ARJspCurr.getInput(fldName+"_frmCpyFld","");
%>
<%--
	// **********************************************************************
	// The value of the criteria field is assigned here.
	// For dropdown the value will be the displayed text and for
	// radio value will be the literal corresponding to the actual value.
	// *********************************************************************
--%>
<%
	if ("HD".equals(fldType)  || isCopy == 'Y') {
		continue;
	} 
	else if ("SL".equals(fldType)) {
		// this gets the value for combo description from the
		// request. and sets it to the ARJSPCurr.
		if(frmCpyFld.equals(fldName))
		{
			flg = true;
			toCpyFld = (String)ARJspCurr.getInput(fldName+"_toCpyFld","");
		}

		fldName=	"drp_"+fldName;
		comboDesc= 	fldValue;

		if(!flg)
		{
			comboDesc = fabclasses.CommonFunctions.getParamValFromRequest(request,fldName);
			//if value is not in request param take from context
			if("".equals(comboDesc)){
				comboDesc = (String)ARJspCurr.getInput(fldName,comboDesc);
			}
		}
		else
		{
			tempFldName= "drp_"+ toCpyFld;
			comboDesc = fabclasses.CommonFunctions.getParamValFromRequest(request,tempFldName);
			if("".equals(comboDesc)){
				comboDesc = (String)ARJspCurr.getInput(tempFldName,comboDesc);
			}
		}

		ARJspCurr.setInput(fldName,comboDesc);
			fldValue	=	comboDesc;
		/*
		 * When the details page is fetched from Referral Inbox, the fieldvalue of the criteria 
		 * attributes which are drop-downs cannot be fetched from http request. Hence calling
		 * getFnDesc to fetch the field value for function code in case of Referral.
		 */
		if("drp_funcCode".equals(fldName))
		{
			 String sRefFuncCode = (String)ARJspCurr.getInputWithGroup("funcCode","");
			finbranchUtil.MenuMiscInfo menuMiscInfo = (finbranchUtil.MenuMiscInfo)ARJspCurr.getInput(finbranchUtil.MenuMiscInfo.getObjectName(), null);
			
if(((menuMiscInfo != null && menuMiscInfo.isCalledMenu()) || securityInfo.callMode == finbranchUtil.ReferralInfo.REFERRAL_INQUIRY_MODE ||securityInfo.callMode == finbranchUtil.ReferralInfo.REFERRAL_WITHDRAW_MODIFY_MODE) &&(null != sRefFuncCode) && (!("").equals(sRefFuncCode)))
			{
				fldValue = fabclasses.CommonFunctions.getFnDesc(sRefFuncCode,fabclasses.CommonFunctions.getContextualResourceBundle(ARJspCurr, pageContext,"finbranch"));
			}
		}
	}
	else if ("OP".equals(fldType)) {
		valArray	=	critAttribute.getGroupFldValues();
		litArray	=	critAttribute.getGroupFldLiterals();
		for (int j=0;valArray!=null && j<valArray.length;j++){
			valOption	=	valArray[j];
			if (valOption!=null && valOption.equals(fldValue)){
				index	=	j;
				break;
			}
		}
		if (index != -1){
			fldValue	=	fabclasses.CommonFunctions.getLiteral(ARJspCurr, pageContext,"finbranch",litArray[index]);
		}
	}
%>
litCode[cntr] = "<%=critAttribute.getLiteralCode()%>";
dispPosition[cntr] = "<%=critAttribute.getDisplayPosition()%>";
critDispRow[cntr] = "<%=critAttribute.getDisplayRow()%>";
dispColspanLit[cntr] = "<%=critAttribute.getDisplayColspanLit()%>";
dispColspanFld[cntr] = "<%=critAttribute.getDisplayColspanFld()%>";
dispColspanDummy[cntr] = "<%=critAttribute.getDisplayColspanDummy()%>";
critDispIsJoin[cntr] = "<%=critAttribute.getDisplayIsJoin()%>";
dispSeparator[cntr] = "<%=ParseValue.checkString(critAttribute.getDisplaySeparator())%>";
critFldDataType[cntr] = "<%=critAttribute.getFieldDataType()%>";
critIsCpyFld[cntr] = "<%=critAttribute.getIsCopyFld()%>";
fldVal[cntr] = "<%=ParseValue.checkString(fldValue)%>";
cntr++;
<%
}
%>

processFilemntCriteria();

</script>

