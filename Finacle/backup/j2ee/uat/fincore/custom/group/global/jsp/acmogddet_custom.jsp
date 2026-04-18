<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : acmogddet_custom.jsp
<!--Description         :
<!--Date                : 30/jan/2020
<!--Author              : Vino Palani
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HACM
<!--Modification History:
<!--    Version No.             Date                     Author         Description
<!--    -------                 ----------              -----------     ------------------
<!---------------------------------------------------------------------------------------------------------------->
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="acmogd" isEntryPoint="false" />
<%
        String glSub   = (String)ARJspCurr.getInputWithGroup("glSubHeadCode", null);
        String schmcode   = (String)ARJspCurr.getInputWithGroup("schmCode", null);
        String cifId   = (String)ARJspCurr.getInputWithGroup("cifId", null);
%>
<script type="text/javascript">
function acmogddet_pre_ONBLUR(obj){
    if (mopId == "HACM") {
         if (profileId == 54){
                SafaricomDealChk();
         }
    }
}
function acmogddet_pre_ONCLICK(){
	
	if(profileId == 50)
	{
		if(document.forms[0].custNumOfDocRecs.value > 0)
		{
			custSetFieldsValues();
			setFieldsToCustomData("custNumOfDocRecs","custDocDetailsRecData","entityType");
		}
		else
		{
			alert("Please enter the Common Reporting standard Details");
			return false();
		}
	}
		
}
function acmogddet_pre_HDR_SWITCH(a,b)
{
       custSetFieldsValues();
}
function acmogddet_pre_TAB_SWITCH()
{
	if(profileId == 50)
	{
		if(document.forms[0].custNumOfDocRecs.value > 0)
		{
		       custSetFieldsValues();
		}
		else
		{
			alert("Please enter the Common Reporting standard Details");
			return false();
		}
	}
}
function acmogddet_pre_ONLOAD(){
	if(profileId == 50)
        {
		var schmCode = "<%=schmcode%>"

		var objForm = document.forms[0];
		document.forms[0].schmCode.value = schmCode;

		if((document.forms[0].schmCode.value == "CA200") || (document.forms[0].schmCode.value == "CA203") || (document.forms[0].schmCode.value == "CA204") || (document.forms[0].schmCode.value == "CA202") || (document.forms[0].schmCode.value == "CA205") || (document.forms[0].schmCode.value == "CA209") || (document.forms[0].schmCode.value == "CA214") || (document.forms[0].schmCode.value == "CA207") || (document.forms[0].schmCode.value == "CA221") || (document.forms[0].schmCode.value == "CA220") || (document.forms[0].schmCode.value == "CA223") || (document.forms[0].schmCode.value == "CA235") || (document.forms[0].schmCode.value == "CA244") || (document.forms[0].schmCode.value == "SB106") || (document.forms[0].schmCode.value == "SB101") || (document.forms[0].schmCode.value == "SB104") || (document.forms[0].schmCode.value == "SB125") || (document.forms[0].schmCode.value == "SB113") || (document.forms[0].schmCode.value == "SB153") || (document.forms[0].schmCode.value == "TD404"))
		{
			document.getElementById('A').style.display = "block";
			document.getElementById('B').style.display = "block";
			document.getElementById('C').style.display = "block";
			document.getElementById('D').style.display = "none";
		}
		else
		{

			if((document.forms[0].schmCode.value == "CA117") || (document.forms[0].schmCode.value == "CA126") || (document.forms[0].schmCode.value == "CA190") || (document.forms[0].schmCode.value == "CA201") || (document.forms[0].schmCode.value == "CA215") || (document.forms[0].schmCode.value == "CA210") || (document.forms[0].schmCode.value == "CA222") || (document.forms[0].schmCode.value == "CA234") || (document.forms[0].schmCode.value == "CA224") || (document.forms[0].schmCode.value == "CA240") || (document.forms[0].schmCode.value == "CA299") || (document.forms[0].schmCode.value == "CA351") || (document.forms[0].schmCode.value == "CA352") || (document.forms[0].schmCode.value == "SB100") || (document.forms[0].schmCode.value == "SB105") || (document.forms[0].schmCode.value == "SB108") || (document.forms[0].schmCode.value == "SB109") || (document.forms[0].schmCode.value == "SB115") || (document.forms[0].schmCode.value == "SB118") || (schmCode == "SB119") || (document.forms[0].schmCode.value == "SB123") || (document.forms[0].schmCode.value == "SB102") || (document.forms[0].schmCode.value == "SB103") || (document.forms[0].schmCode.value == "SB126") || (document.forms[0].schmCode.value == "SB127") || (document.forms[0].schmCode.value == "SB128") || (document.forms[0].schmCode.value == "SB129") || (document.forms[0].schmCode.value == "SB110") || (document.forms[0].schmCode.value == "SB117") || (document.forms[0].schmCode.value == "SB154") || (document.forms[0].schmCode.value == "SB130") || (document.forms[0].schmCode.value == "SB190") || (document.forms[0].schmCode.value =="SB135") || (document.forms[0].schmCode.value == "SB136") || (document.forms[0].schmCode.value == "SB140") || (document.forms[0].schmCode.value == "SB144") || (document.forms[0].schmCode.value == "SB303") || (document.forms[0].schmCode.value == "SB304") || (document.forms[0].schmCode.value == "SB305") || (schmCode == "SB306") || (document.forms[0].schmCode.value == "SB777") || (document.forms[0].schmCode.value == "TD400"))
			{
				document.getElementById('A').style.display = "block";
				document.getElementById('B').style.display = "block";
				document.getElementById('C').style.display = "none";
				document.getElementById('D').style.display = "block";
			}
			else
			{
				document.getElementById('A').style.display = "none";
				document.getElementById('B').style.display = "none";
				document.getElementById('C').style.display = "none";
				document.getElementById('D').style.display = "none";
			}
		}
		if((objForm.custNumOfDocRecs.value != "") && (parseInt(objForm.custNumOfDocRecs.value) > 0))
		{
			getFieldsFromCustomData("custNumOfDocRecs","custDocDetailsRecData","entityType");
		}
		else
		{
			getFieldsFromCustomData("acctNo");
			code = document.forms[0].customData.value.split("~");
			for(i = 0; i < code.length;  i++)
			{
				temp = code[i].split("|");
				if(temp[0] == "hacmcrit")
				{
					var acctNo = temp[1];

					var inputNameValues       = "acctId|"+acctNo;
					var outputNames           = "custDocDetailsRecData|custNumOfDocRecs";
					var scrName               = "fetch_entityType_details.scr";
					var isAutoPopulationRqrd  = false;
					var retVal = appFnExecuteScript(inputNameValues,outputNames,scrName,isAutoPopulationRqrd);
					
					var code = retVal.split("|");
					objForm.custDocDetailsRecData.value = code[1];
					objForm.custNumOfDocRecs.value = code[3];
					objForm.entityType.value = code[5];
					if(retVal != undefined)
					{
						if((objForm.custNumOfDocRecs.value != "") && (parseInt(objForm.custNumOfDocRecs.value) > 0))
						{
							for(i = 0 ; i < parseInt(objForm.custNumOfDocRecs.value); i++)
							{
								addMultiRec(i,"AP");
							}
							
							var docArray = objForm.custDocDetailsRecData.value.split(";");

							for(i = 0; i < docArray.length; i++)
							{
								var j=i+1;
								var tempStr = docArray[i];
								temp = tempStr.split(":");
								
								if(document.getElementById("custName"+j))
								{
									if((document.forms[0].schmCode.value == "CA200") || (document.forms[0].schmCode.value == "CA203") || (document.forms[0].schmCode.value == "CA204") || (document.forms[0].schmCode.value == "CA202") || (document.forms[0].schmCode.value == "CA205") || (document.forms[0].schmCode.value == "CA209") || (document.forms[0].schmCode.value == "CA214") || (document.forms[0].schmCode.value == "CA207") || (document.forms[0].schmCode.value == "CA221") || (document.forms[0].schmCode.value == "CA220") || (document.forms[0].schmCode.value == "CA223") || (document.forms[0].schmCode.value == "CA235") || (document.forms[0].schmCode.value == "CA244") || (document.forms[0].schmCode.value == "SB106") || (document.forms[0].schmCode.value == "SB101") || (document.forms[0].schmCode.value == "SB104") || (document.forms[0].schmCode.value == "SB125") || (document.forms[0].schmCode.value == "SB113") || (document.forms[0].schmCode.value == "SB153") || (document.forms[0].schmCode.value == "TD404"))
									{
										    document.getElementById("custName"+j).value      = temp[0];
										    document.getElementById("idNum"+j).value         = temp[1];
										    document.getElementById("address"+j).value       = temp[2];
										    document.getElementById("residence"+j).value     = temp[3];
										    document.getElementById("dob_ui"+j).value        = temp[4];
										    document.getElementById("pob"+j).value           = temp[5];
										    document.getElementById("tin"+j).value           = temp[6];
										    document.getElementById("other"+j).value         = temp[7];
										    document.getElementById("virtue"+j).value        = temp[8];
									}
									else
									{
										if((document.forms[0].schmCode.value == "CA117") || (document.forms[0].schmCode.value == "CA126") || (document.forms[0].schmCode.value == "CA190") || (document.forms[0].schmCode.value == "CA201") || (document.forms[0].schmCode.value == "CA215") || (document.forms[0].schmCode.value == "CA210") || (document.forms[0].schmCode.value == "CA222") || (document.forms[0].schmCode.value == "CA234") || (document.forms[0].schmCode.value == "CA224") || (document.forms[0].schmCode.value == "CA240") || (document.forms[0].schmCode.value == "CA299") || (document.forms[0].schmCode.value == "CA351") || (document.forms[0].schmCode.value == "CA352") || (document.forms[0].schmCode.value == "SB100") || (document.forms[0].schmCode.value == "SB105") || (document.forms[0].schmCode.value == "SB108") || (document.forms[0].schmCode.value =="SB109") || (document.forms[0].schmCode.value == "SB115") || (document.forms[0].schmCode.value == "SB118") || (schmCode == "SB119") || (document.forms[0].schmCode.value == "SB123") || (document.forms[0].schmCode.value == "SB102") || (document.forms[0].schmCode.value == "SB103") || (document.forms[0].schmCode.value == "SB126") || (document.forms[0].schmCode.value == "SB127") || (document.forms[0].schmCode.value == "SB128") || (document.forms[0].schmCode.value == "SB129") || (document.forms[0].schmCode.value == "SB110") || (document.forms[0].schmCode.value == "SB117") || (document.forms[0].schmCode.value == "SB154") || (document.forms[0].schmCode.value == "SB130") || (document.forms[0].schmCode.value == "SB190") || (document.forms[0].schmCode.value =="SB135") || (document.forms[0].schmCode.value == "SB136") || (document.forms[0].schmCode.value == "SB140") || (document.forms[0].schmCode.value == "SB144") || (document.forms[0].schmCode.value == "SB303") || (document.forms[0].schmCode.value == "SB304") || (document.forms[0].schmCode.value == "SB305") || (schmCode == "SB306") || (document.forms[0].schmCode.value == "SB777") || (document.forms[0].schmCode.value =="TD400"))
										{
											document.getElementById("custName"+j).value      = temp[0];
											document.getElementById("idNum"+j).value         = temp[1];
											document.getElementById("address"+j).value       = temp[2];
											document.getElementById("residence"+j).value     = temp[3];
											document.getElementById("dob_ui"+j).value        = temp[4];
											document.getElementById("pob"+j).value           = temp[5];
											document.getElementById("tin"+j).value           = temp[6];
											document.getElementById("other"+j).value         = temp[7];
											document.getElementById("noOfShares"+j).value    = temp[8];
										}
									}	

								}
							}
							setFieldsToCustomData("custNumOfDocRecs","custDocDetailsRecData","entityType");
						}
					}
				}
			}
		}
	}
}
function SafaricomDealChk(obj){
    var cschCode = "<%=schmcode%>"
    var ccifId = "<%=cifId%>"
    if (mopId == "HACM") {
            if ((document.forms[0].remarks.value != "") && (cschCode =="SB167")) {
                var dealCode = document.forms[0].remarks.value;
                var inputNameValues =  "DealCode" + "|" + dealCode + "|" + "cifId" + "|" + ccifId;
                var outputNames = "SucYN|DealerDetails|DealerNAme|DealerLimit";
                var scrName = "ebSafaricomDealVal.scr";
                var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                var ret = retVal.split("|");
                //alert(ret);
                if(ret[1] == "N") {
                        alert("Safaricom Agent Validation Failed - Agent does not exist");
                        return false;
                }else if (ret[1] == "NA"){
                        alert("Safaricom Agent Validation Failed - Agent does not exist");
                        return false;
                }else if (ret[1] == "Y"){
                        //Dealer Code
                        alert(ret[3]);
                        //Dealer Name
                        alert(ret[5]);
                        //Dealer Limit
                        alert(ret[7]);
                        return true;
                }else {
                        return true;
                }
            }
    }
}


if(profileId == 50)
{
	with (document)
        {
		write('<input type="hidden" name="schmCode" id="schmCode" >');
                write('<input type="hidden" name="custNumOfDocRecs" id="custNumOfDocRecs" >');
                write('<input type="hidden" name="custDocDetailsRecData" id="custDocDetailsRecData" >');
                write('<input type="hidden" name="custDocDetailsRecDataTmp1" id="custDocDetailsRecDataTmp1" >');
                write('<input type="hidden" id="dob"  name="'+sGroupName+'.dob" >');
                write('<input type="hidden" name="'+ sGroupName +'".valSchmCode" id="valSchmCode">');
                write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
                write('<tr id="A">');
                write('<td>');
                write('<table border="0" cellspacing="0" cellpadding="0">');
                write('<tr>');
                write('</tr>');
                write('</table>');
                write('<!-- DETAILSBLOCK-BEGIN -->');
                write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
                write('<tr>');
                write('<td valign="top">');
                write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
                write('<tr>');
                write('<td>');
                write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
                write('<tr>');
                write('<td>');
                write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
                write('</table>');
                write('</td>');
                write('</tr>');

		write('<td class="textfield">&nbsp;</td>');
		write('<td class="columnwidth">&nbsp;</td>');
		write('<td class="textlabel">&nbsp;</td>');
		write('<td class="textfield">&nbsp;</td>');

		write('<tr>');
		write('<td class="textlabel">ENTITY TYPE</td>');
		write('<td class="textfield">');
		write('<select name="' + sGroupName + '.entityType" class="listboxfont" id="entityType" OnChange="javascript: return fnchange(this);"  fdt="String">');
		write('<option value="">Select</option>');
		write('<option value="A">Active non-financial entity</option>');
		write('<option value="P">Passive non-financial entity</option>');
		write('</select>');
		write('</td>');
		write('</tr>');

		write('<td class="textfield">&nbsp;</td>');
		write('<td class="columnwidth">&nbsp;</td>');
		write('<td class="textlabel">&nbsp;</td>');
		write('<td class="textfield">&nbsp;</td>');

                // Export Reference Details

                write('<tr class="subhdrbg">');
                write('<td colspan="2" class="subhdr">Common Reporting standard</td>')
                write('<td colspan="3" align="right"></td>');
                write("</tr>");
                write('<tr class="rowspacing">');
                write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
                write("</tr>");
                write('<tr>');
                write('<td class="textlabel">&nbsp;');
                write('<table border="0" cellpadding="0" cellspacing="0" width="100%" >' );
                write('<tr>' );
                write('<td>&nbsp;&nbsp;&nbsp;' );
                write('<input id="custDocTab_AddNew' + '" type="button" name="custDocTab_AddNew" value="Add" onClick="javascript:return addMultiRec(document.forms[0].custNumOfDocRecs.value,\'A\');" class="button1">' );
                write('&nbsp; <input id="custDocTab_DelNew' + '" type="button" name="custDocTab_DelNew" value="Delete" onClick="javascript:return delMultiRec(document.forms[0].custNumOfDocRecs.value,\'A\');" class="button1">' );
                write('</td>' );
                write('</tr>' );
                write('</table>');
                write('</td>');
                write('<td class="textfield">&nbsp;</td>');
                write('<td class="columnwidth">&nbsp;</td>');
                write('<td class="textlabel">&nbsp;</td>');
                write('<td class="textfield">&nbsp;</td>');
                write('<tr id="B">');
                write('<td colspan="5">');
                write('<table width="100%" id="EntityAccountDetails" >');
		write('<tr id="C">');
                {
                                write('<td class="searcheader">Name<\/script></td>');
                                write('<td class="searcheader">Role by virtue</td>');
                                write('<td class="searcheader">ID/passport number</td>');
                                write('<td class="searcheader">Address<\/script></td>');
                                write('<td class="searcheader">Jurisdiction of residence<\/script></td>');
                                write('<td class="searcheader">Date of birth<\/script></td>');
                                write('<td class="searcheader">Place of birth<\/script></td>');
                                write('<td class="searcheader">TIN<\/script></td>');
                                write('<td class="searcheader">Others<\/script></td>');
                }
                write('</tr>');
                write('<tr id="D">');
                {
                                write('<td class="searcheader">Name<script>setMandatory("Y");<\/script></td>');
                                write('<td class="searcheader">No. of Shares</td>');
                                write('<td class="searcheader">ID/passport number<script>setMandatory("Y");<\/script></td>');
                                write('<td class="searcheader">Address<script>setMandatory("Y");<\/script></td>');
                                write('<td class="searcheader">Jurisdiction of residence<script>setMandatory("Y");<\/script></td>');
                                write('<td class="searcheader">Date of birth<script>setMandatory("Y");<\/script></td>');
                                write('<td class="searcheader">Place of birth<script>setMandatory("Y");<\/script></td>');
                                write('<td class="searcheader">TIN<\/script></td>');
                                write('<td class="searcheader">Others<\/script></td>');
                }
                write('</tr>');
                write('</table>');
                write('</td>');
                write('</tr>');
                write('<tr>');
                write('<td class="textlabel" style="height: 15px"> </td>');
                write('<td class="textfield"> </td>');
                write('<td class="columnwidth"> </td>');
                write('<td class="textlabel"> </td>');
                write('<td class="textfield"> </td>');
                write('</tr>');
                write('</table>');
                write('</td>');
                write('</tr>');
                write('</table>');
                write('</td>');
                write('</tr>');
                write('</table>');

                write('</td>');
                write('</tr>');
                write('</table>');
                write('<!-- DETAILSBLOCK-END -->');
                write('</td>');
                write('</tr>');
                write('</table>');
        }


        function delMultiRec(custDocRecIdx,docFuncCode)
        {
                objForm = document.forms[0];

                if(custDocRecIdx > 0)
                {
                        var docsTableObj = document.getElementById("EntityAccountDetails");
                        docsTableObj.deleteRow(objForm.custNumOfDocRecs.value);
                        objForm.custNumOfDocRecs.value = parseInt(objForm.custNumOfDocRecs.value) - 1;
                        custSetFieldsValues();
                }
        }

        function addMultiRec(custDocRecIdx,docFuncCode)
        {
		var schmCode = "<%=schmcode%>"
		document.forms[0].schmCode.value = schmCode;
                objForm = document.forms[0];


                if((custDocRecIdx == "") || (custDocRecIdx == 0))
                {
                        custDocRecIdx = 1;
                }
                else
                {
                        custDocRecIdx = parseInt(custDocRecIdx) + 1
                }

                if(docFuncCode == "A")
                {
                        for(inx = 1; inx < custDocRecIdx ; inx++)
                        {
                                if(fnIsNull(document.getElementById("custName"+inx).value))
                                {
                                        alert("Enter a value in the field");
                                        document.getElementById("custName"+inx).focus();
                                        return false;
                                }
                        }
                        if(objForm.custNumOfDocRecs.value == "")
                                objForm.custNumOfDocRecs.value = 1;
                        else
                                objForm.custNumOfDocRecs.value = parseInt(objForm.custNumOfDocRecs.value) + 1;
                }

		if((document.forms[0].schmCode.value == 'CA200') || (document.forms[0].schmCode.value == 'CA203') || (document.forms[0].schmCode.value == 'CA204') || (document.forms[0].schmCode.value == 'CA202') || (document.forms[0].schmCode.value == 'CA205') || (document.forms[0].schmCode.value == 'CA209') || (document.forms[0].schmCode.value == 'CA214') || (document.forms[0].schmCode.value == 'CA207') || (document.forms[0].schmCode.value == 'CA221') || (document.forms[0].schmCode.value == 'CA220') || (document.forms[0].schmCode.value == 'CA223') || (document.forms[0].schmCode.value == 'CA235') || (document.forms[0].schmCode.value == 'CA244') || (document.forms[0].schmCode.value == 'SB106') || (document.forms[0].schmCode.value == 'SB101') || (document.forms[0].schmCode.value == 'SB104') || (document.forms[0].schmCode.value == 'SB125') || (document.forms[0].schmCode.value == 'SB113') || (document.forms[0].schmCode.value == 'SB153') || (document.forms[0].schmCode.value == 'TD404'))
                {
                                if(custDocRecIdx >= 1)
                                {
                                        var docsTableObj = document.getElementById("EntityAccountDetails");

                                        var row = docsTableObj.insertRow();

                                        var cell1 = row.appendChild(document.createElement('td'));
                                        cell1.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.custName'+custDocRecIdx+'" id="custName'+custDocRecIdx+'" maxlength="50" fdt="String">';

                                        var cell2 = row.appendChild(document.createElement('td'));
                                        cell2.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.virtue'+custDocRecIdx+'" id="virtue'+custDocRecIdx+'" maxlength="20"   fdt="String">';

                                        var cell3 = row.appendChild(document.createElement('td'));
                                        cell3.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.idNum'+custDocRecIdx+'" id="idNum'+custDocRecIdx+'" size="50"  maxlength="30" fdt="String">';

                                         var cell4 = row.appendChild(document.createElement('td'));
                                        cell4.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.address'+custDocRecIdx+'" id="address'+custDocRecIdx+'" size="50"  maxlength="30" fdt="String">';

                                        var cell5 = row.appendChild(document.createElement('td'));
                                        cell5.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.residence'+custDocRecIdx+'" id="residence'+custDocRecIdx+'" maxlength="50"  fdt="String">';

                                        var cell6 = row.appendChild(document.createElement('td'));
                                        cell6.innerHTML = '<input hotKeyId="calender1"  type="date" class="textfieldfont" style="width:83%;" fdt="uidate" maxlength="10" mnebl="false" onBlur="javascript:return calender_det_ONBLUR1(this,this,this);" name="' + sGroupName + '.dob_ui'+custDocRecIdx+'" id="dob_ui'+custDocRecIdx+'" maxlength="50" fdt="String">';
                                        cell6.innerHTML = cell6.innerHTML + '<a  href="javascript:openDate(document.forms[0].dob_ui,BODDate)"   id="sLnk5"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" ><br>';

                                        var cell7 = row.appendChild(document.createElement('td'));
                                        cell7.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.pob'+custDocRecIdx+'" id="pob'+custDocRecIdx+'" maxlength="50"   fdt="String">';

                                        var cell8 = row.appendChild(document.createElement('td'));
                                        cell8.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.tin'+custDocRecIdx+'" id="tin'+custDocRecIdx+'" maxlength="50"   fdt="String">';

                                        var cell9 = row.appendChild(document.createElement('td'));
                                        cell9.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.other'+custDocRecIdx+'" id="other'+custDocRecIdx+'" maxlength="50"   fdt="String">';
                                }
                }
                else
                {
			if((document.forms[0].schmCode.value == 'CA117') || (document.forms[0].schmCode.value == 'CA126') || (document.forms[0].schmCode.value == 'CA190') || (document.forms[0].schmCode.value == 'CA201') || (document.forms[0].schmCode.value == 'CA215') || (document.forms[0].schmCode.value == 'CA210') || (document.forms[0].schmCode.value == 'CA222') || (document.forms[0].schmCode.value == 'CA234') || (document.forms[0].schmCode.value == 'CA224') || (document.forms[0].schmCode.value == 'CA240') || (document.forms[0].schmCode.value == 'CA299') || (document.forms[0].schmCode.value == 'CA351') || (document.forms[0].schmCode.value == 'CA352') || (document.forms[0].schmCode.value == 'SB100') || (document.forms[0].schmCode.value == 'SB105') || (document.forms[0].schmCode.value == 'SB108') || (document.forms[0].schmCode.value == 'SB109') || (document.forms[0].schmCode.value == 'SB115') || (document.forms[0].schmCode.value == 'SB118') || (schmCode == 'SB119') || (document.forms[0].schmCode.value == 'SB123') || (document.forms[0].schmCode.value == 'SB102') || (document.forms[0].schmCode.value == 'SB103') || (document.forms[0].schmCode.value == 'SB126') || (document.forms[0].schmCode.value == 'SB127') || (document.forms[0].schmCode.value == 'SB128') || (document.forms[0].schmCode.value == 'SB129') || (document.forms[0].schmCode.value == 'SB110') || (document.forms[0].schmCode.value == 'SB117') || (document.forms[0].schmCode.value == 'SB154') || (document.forms[0].schmCode.value == 'SB130') || (document.forms[0].schmCode.value == 'SB190') || (document.forms[0].schmCode.value =='SB135') || (document.forms[0].schmCode.value == 'SB136') || (document.forms[0].schmCode.value == 'SB140') || (document.forms[0].schmCode.value == 'SB144') || (document.forms[0].schmCode.value == 'SB303') || (document.forms[0].schmCode.value == 'SB304') || (document.forms[0].schmCode.value == 'SB305') || (schmCode == 'SB306') || (document.forms[0].schmCode.value == 'SB777') || (document.forms[0].schmCode.value == 'TD400'))
			{
                                if(custDocRecIdx >= 1)
                                {
                                        var docsTableObj = document.getElementById("EntityAccountDetails");

                                        var row = docsTableObj.insertRow();

                                        var cell1 = row.appendChild(document.createElement('td'));
                                        cell1.innerHTML = '<input type="text" class="textfieldfont" style="width:85%;" name="' + sGroupName + '.custName'+custDocRecIdx+'" id="custName'+custDocRecIdx+'" maxlength="50" fdt="String">';

					var cell2 = row.appendChild(document.createElement('td'));
                                        cell2.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.noOfShares'+custDocRecIdx+'" id="noOfShares'+custDocRecIdx+'" size="50"  maxlength="30" fdt="String">';

                                        var cell3 = row.appendChild(document.createElement('td'));
                                        cell3.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.idNum'+custDocRecIdx+'" id="idNum'+custDocRecIdx+'" size="50"  maxlength="30" fdt="String">';

                                         var cell4 = row.appendChild(document.createElement('td'));
                                        cell4.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.address'+custDocRecIdx+'" id="address'+custDocRecIdx+'" size="50"  maxlength="30" fdt="String">';

                                        var cell5 = row.appendChild(document.createElement('td'));
                                        cell5.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.residence'+custDocRecIdx+'" id="residence'+custDocRecIdx+'" maxlength="50"  fdt="String">';

                                        var cell6 = row.appendChild(document.createElement('td'));
                                        cell6.innerHTML = '<input hotKeyId="calender1"  type="date" class="textfieldfont" style="width:100%;" fdt="uidate" maxlength="10" mnebl="false" onBlur="javascript:return calender_det_ONBLUR1(this,this,this);" name="' + sGroupName + '.dob_ui'+custDocRecIdx+'" id="dob_ui'+custDocRecIdx+'" maxlength="50" fdt="String">';
                                        cell6.innerHTML = cell6.innerHTML + '<a  href="javascript:openDate(document.forms[0].dob_ui,BODDate)"   id="sLnk5"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >';

                                        var cell7 = row.appendChild(document.createElement('td'));
                                        cell7.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.pob'+custDocRecIdx+'" id="pob'+custDocRecIdx+'" maxlength="50"   fdt="String">';

                                        var cell8 = row.appendChild(document.createElement('td'));
                                        cell8.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.tin'+custDocRecIdx+'" id="tin'+custDocRecIdx+'" maxlength="50"   fdt="String">';

                                        var cell9 = row.appendChild(document.createElement('td'));
                                        cell9.innerHTML = '<input type="text" class="textfieldfont" style="width:100%;" name="' + sGroupName + '.other'+custDocRecIdx+'" id="other'+custDocRecIdx+'" maxlength="50"   fdt="String">';
                                }
			}

                }

                return true;
        }

        function custSetFieldsValues()
        {
		var schmCode = "<%=schmcode%>"
		document.forms[0].schmCode.value = schmCode;
                var objForm = document.forms[0];

		if((document.forms[0].schmCode.value == "CA200") || (document.forms[0].schmCode.value == "CA203") || (document.forms[0].schmCode.value == "CA204") || (document.forms[0].schmCode.value == "CA202") || (document.forms[0].schmCode.value == "CA205") || (document.forms[0].schmCode.value == "CA209") || (document.forms[0].schmCode.value == "CA214") || (document.forms[0].schmCode.value == "CA207") || (document.forms[0].schmCode.value == "CA221") || (document.forms[0].schmCode.value == "CA220") || (document.forms[0].schmCode.value == "CA223") || (document.forms[0].schmCode.value == "CA235") || (document.forms[0].schmCode.value == "CA244") || (document.forms[0].schmCode.value == "SB106") || (document.forms[0].schmCode.value == "SB101") || (document.forms[0].schmCode.value == "SB104") || (document.forms[0].schmCode.value == "SB125") || (document.forms[0].schmCode.value == "SB113") || (document.forms[0].schmCode.value == "SB153") || (document.forms[0].schmCode.value == "TD404"))
                {
                        if((objForm.custNumOfDocRecs.value != "") && (parseInt(objForm.custNumOfDocRecs.value) > 0))
                        {
                                objForm.custDocDetailsRecData.value = "";

                                for(i = 1 ; i <= parseInt(objForm.custNumOfDocRecs.value); i++)
                                {
                                        if(eval("document.forms[0].custName"+i))
                                        {
                                                var docData = eval("document.forms[0].custName"+i+".value").replace(/[;:]/g,'');
                                                docData = docData +":"+ eval("document.forms[0].virtue"+i+".value").replace(/[;:]/g,'');
                                                docData = docData +":"+ eval("document.forms[0].idNum"+i+".value").replace(/[;:]/g,'');
                                                docData = docData +":"+ eval("document.forms[0].address"+i+".value").replace(/[;:]/g,'');
                                                docData = docData +":"+ eval("document.forms[0].residence"+i+".value").replace(/[;:]/g,'');
                                                docData = docData +":"+ eval("document.forms[0].dob_ui"+i+".value").replace(/[;:]/g,'');
                                                docData = docData +":"+ eval("document.forms[0].pob"+i+".value").replace(/[;:,]/g,'');
                                                docData = docData +":"+ eval("document.forms[0].tin"+i+".value").replace(/[;:]/g,'');
                                                docData = docData +":"+ eval("document.forms[0].other"+i+".value").replace(/[;:,]/g,'');

                                                if(objForm.custDocDetailsRecData.value != "")
                                                {
                                                        docData = ";" + docData;
                                                }

                                                objForm.custDocDetailsRecData.value = objForm.custDocDetailsRecData.value + docData;
                                        }

                                }

                        }
                }
                else
                {
			if((document.forms[0].schmCode.value == "CA117") || (document.forms[0].schmCode.value == "CA126") || (document.forms[0].schmCode.value == "CA190") || (document.forms[0].schmCode.value == "CA201") || (document.forms[0].schmCode.value == "CA215") || (document.forms[0].schmCode.value == "CA210") || (document.forms[0].schmCode.value == "CA222") || (document.forms[0].schmCode.value == "CA234") || (document.forms[0].schmCode.value == "CA224") || (document.forms[0].schmCode.value == "CA240") || (document.forms[0].schmCode.value == "CA299") || (document.forms[0].schmCode.value == "CA351") || (document.forms[0].schmCode.value == "CA352") || (document.forms[0].schmCode.value == "SB100") || (document.forms[0].schmCode.value == "SB105") || (document.forms[0].schmCode.value == "SB108") || (document.forms[0].schmCode.value == "SB109") || (document.forms[0].schmCode.value == "SB115") || (document.forms[0].schmCode.value == "SB118") || (schmCode == "SB119") || (document.forms[0].schmCode.value == "SB123") || (document.forms[0].schmCode.value == "SB102") || (document.forms[0].schmCode.value == "SB103") || (document.forms[0].schmCode.value == "SB126") || (document.forms[0].schmCode.value == "SB127") || (document.forms[0].schmCode.value == "SB128") || (document.forms[0].schmCode.value == "SB129") || (document.forms[0].schmCode.value == "SB110") || (document.forms[0].schmCode.value == "SB117") || (document.forms[0].schmCode.value == "SB154") || (document.forms[0].schmCode.value == "SB130") || (document.forms[0].schmCode.value == "SB190") || (document.forms[0].schmCode.value =="SB135") || (document.forms[0].schmCode.value == "SB136") || (document.forms[0].schmCode.value == "SB140") || (document.forms[0].schmCode.value == "SB144") || (document.forms[0].schmCode.value == "SB303") || (document.forms[0].schmCode.value == "SB304") || (document.forms[0].schmCode.value == "SB305") || (schmCode == "SB306") || (document.forms[0].schmCode.value == "SB777") || (document.forms[0].schmCode.value == "TD400"))
			{
				if((objForm.custNumOfDocRecs.value != "") && (parseInt(objForm.custNumOfDocRecs.value) > 0))
				{
					objForm.custDocDetailsRecData.value = "";

					for(i = 1 ; i <= parseInt(objForm.custNumOfDocRecs.value); i++)
					{
						if(eval("document.forms[0].custName"+i))
						{
							var docData = eval("document.forms[0].custName"+i+".value").replace(/[;:]/g,'');
							docData = docData +":"+ eval("document.forms[0].noOfShares"+i+".value").replace(/[;:]/g,'');
							docData = docData +":"+ eval("document.forms[0].idNum"+i+".value").replace(/[;:]/g,'');
							docData = docData +":"+ eval("document.forms[0].address"+i+".value").replace(/[;:]/g,'');
							docData = docData +":"+ eval("document.forms[0].residence"+i+".value").replace(/[;:]/g,'');
							docData = docData +":"+ eval("document.forms[0].dob_ui"+i+".value").replace(/[;:]/g,'');
							docData = docData +":"+ eval("document.forms[0].pob"+i+".value").replace(/[;:,]/g,'');
							docData = docData +":"+ eval("document.forms[0].tin"+i+".value").replace(/[;:]/g,'');
							docData = docData +":"+ eval("document.forms[0].other"+i+".value").replace(/[;:,]/g,'');

							if(objForm.custDocDetailsRecData.value != "")
							{
								docData = ";" + docData;
							}

							objForm.custDocDetailsRecData.value = objForm.custDocDetailsRecData.value + docData;
						}

					}

				}
			}
                }

                setFieldsToCustomData("custNumOfDocRecs","custDocDetailsRecData","entityType");
        }
}
else
{
	with (document)
	{
		write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable" >');
		write('<tr>');
		write('<td>');
		write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >');
		write('<tr>');
		write('<td>');
		write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable" >');
		write('<tr>');
		write('<td>');
		write('<table width="100%" border="0" cellpadding="2" cellspacing="2" class="innertabletop1">');
		write('<tr>');
		write('<td class="textlabel">Tertiary RMID</td>');
		write('<td>');
		write('<input class="textfieldamount" type="text" name="trmid" id="trmid" align="right" size="3" maxlength="30">&nbsp;&nbsp;');
		write('</td>');
		write('</tr>');
		write('</table>');
		write('</td>');
		write('</tr>');
		write('</table>');
		write('</td>');
		write('</tr>');
		write('</table>');
		write('</td>');
		write('</tr>');
		write('</table>');
	}
}
</script>
