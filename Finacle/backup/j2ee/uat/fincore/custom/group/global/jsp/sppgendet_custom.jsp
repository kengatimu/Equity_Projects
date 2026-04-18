<!------------------------------------------------------------------------------------------------>
<!--    Name            :       sppgendet_custom.jsp                                        
<!--    Menu            :       HSPPAU                                                    
<!--    Author          :       Pankaj Gaur                                              
<!--    Description     :       begin cheq Number,no of leaves and acctId values is being set to get it in details page        
<!--    Modification History                                                                    
<!--    <Serial No>  <Date>          <Author>        <Description>                               
<!--    1            12-Aug-2013     Pankaj Gaur            Original Version                           
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

function fnOnButtonClick(btn)
{
		//alert("button id"+btn.id);
		var objForm = document.forms[0];
		if(Const.ACTION_SUBMIT == btn.id)
		{
				if(fnValidateForm())	{
				
				if(mode==Const.PRINT_MODE || mode==Const.REPRINT_MODE)	{
					//alert("inside print mode");
					doSubmit(Const.ACTION_PRINTGETDATA);
					return true;
				}	else	{
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
								doSubmit(Const.ACTION_SUBMIT);
								return true;
							}
						}
						else
						{
							doSubmit(Const.ACTION_SUBMIT);
							return true;
						}
					}
					else
					{
						doSubmit(Const.ACTION_SUBMIT);
						return true;
					}
				}
			}
		
		} else if(Const.ACTION_VALIDATE==btn.id)	{
		
			if(fnValidateForm())	{
				doSubmit(Const.ACTION_VALIDATE);
				return true;
			}	
		
		} else if(Const.ACTION_CANCEL==btn.id || Const.ACTION_BACK==btn.id)	{
			doSubmit(btn.id);
			return true;
		}
		return false;
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
