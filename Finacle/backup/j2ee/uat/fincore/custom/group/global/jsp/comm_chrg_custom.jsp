<!------------------------------------------------------------------------------------------------>
<!--    Name            :       comm_chrg_custom.jsp                                        
<!--    Menu            :       HSPPAU                                                    
<!--    Author          :       Pankaj Gaur                                              
<!--    Description     :       begin cheq Number,no of leaves and acctId values is being set to get it in details page        
<!--    Modification History                                                                    
<!--    <Serial No>  <Date>          <Author>        <Description>                               
<!--    1            16-Aug-2013     Pankaj Gaur            Original Version                           
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

document.write('<input type="hidden" name="chgAmt" id="chgAmt" >');
document.write('<input type="hidden" name="tranCurr" id="tranCurr" >');
document.write('<input type="hidden" name="effBal" id="effBal" >');

function fnOnButtonClick(objBtn){
    //alert(objBtn.id);
	if (objBtn.id == "Cancel")
	{
		objForm.submitform.value = objBtn.id;
		if(objForm.actionCode)	{
			objForm.actionCode.value=objBtn.id;
		}
		objForm.submit();
		return; 
	}
	var X = document.forms[0];
	if(!fnValidateForm(objBtn.id)) return false;
	objForm.submitform.value = objBtn.id;
	if(objForm.actionCode)	{
		//alert("inside submit button"+objForm.actionCode);
		
		if(mopId == "HSPPAU")
		{
			var frm=document.forms[0];
			getFieldsFromCustomData("acctId","beginChqNum","noOfLvs");
			
			var csdata = document.forms[0].customData.value;
			var csdataTemp =csdata.split("|");
			var acctId =csdataTemp[1];
			var beginChqNum =csdataTemp[2];
			var noOfLvs =csdataTemp[3];
			//alert(csdataTemp);
			//alert("inside submit action");

			//alert("acctId"+acctId);

			//alert("beginChqNum"+beginChqNum);

			//alert("noOfLvs"+noOfLvs);

			var inputNameValues ="acctId|"+acctId+"|beginChqNum|"+beginChqNum+"|noOfLvs|"+noOfLvs;
			//alert(inputNameValues);
			var outputNames = "stat|chgAmt|tranCurr|effBal";
			var scrName = "spptranAmt.scr";
			var retval = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
			var token = retval.split("|");
			//alert("result:-"+token);
			var stat = token[1];
			//alert("stat"+stat);
			frm.chgAmt.value=token[3];
			frm.tranCurr.value=token[5];
			frm.effBal.value=token[7];
			
			if(stat == "Y")
			{
				if (todGrant() == true) 
				{ 
					setFieldsToCustomData("acctId","chgAmt","tranCurr","effBal");
					//alert("after get"+document.forms[0].customData.value);
					objForm.actionCode.value = objBtn.id;
					objForm.actlAmt.disabled = false; 
					fnEnableDescFields(objForm);
					convertToCaps();
					disableButtons();
					objForm.submit();
					//return false;
				}
			}
			else
			{
				objForm.actionCode.value = objBtn.id;
				objForm.actlAmt.disabled = false; 
				fnEnableDescFields(objForm);
				convertToCaps();
				disableButtons();
				objForm.submit();
				//return false;
			}
		}
		else
		{
			objForm.actionCode.value = objBtn.id;
			objForm.actlAmt.disabled = false; 
			fnEnableDescFields(objForm);
			convertToCaps();
			disableButtons();
			objForm.submit();
		}
			//return false;
	}
	//alert("common code");
	//objForm.actlAmt.disabled = false; 
	//fnEnableDescFields(objForm);
	//convertToCaps();
	//disableButtons();
	//objForm.submit();
}

function comm_chrg_post_ONLOAD(objBtn) 
{	
	if (document.forms[0].actlAmt.value != "" )
	{	
		var dco   = document.forms[0].acctNum.value;
		var input      = "dco|"+dco;
		var outputNames    = "output|outVal";
		var outputNames    = "output1|outVal";
		var scrName     =   "b_acctbacid.scr";
		var retVal = appFnExecuteScript(input,outputNames,scrName,false);
		var retBuff = retVal.split("|");
		var output = retBuff[0];
		var value = retBuff[1];
		var output = retBuff[2];
		var value1 = retBuff[3];
		var b = value;
		//alert(b);
		var c = value1;
		//alert(c);

		if ((c==250||c==131||c==134||c==135) && (b=="PNLBC"))
		//if ((c==250||c==131) && (b=="PNLBC"))
		{
			objForm.actlAmt.disabled = false;
		}
		else
		{
			objForm.actlAmt.disabled = true;
		}
	}
}

function todGrant()
{
	if(confirm("Account Balance is less than the charge amount. Would you like to grant TOD and proceed with the Charge Transaction?"))
	{	
		return true;
		
	}
	else
	{
		return false;
	}
}
</script>
