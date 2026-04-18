/* THIS IS A GENERATED FILE. DO NOT MODIFY IT MANUALLY.*/
var objForm 			= null;
var bgColorStyle   		= null;
var LODGE_MODE		='G';
var REALISE_MODE		='R';
var DISHONOUR_MODE		='N';
var DELINK_MODE		='K';
var CANCEL_MODE		='X';
var INQUIRE_MODE		='I';
var VERIFY_MODE 		='V';
var MODIFY_MODE 		='M';
var LODGE			='G';
var LODGE_PURCHASE		='H';
var REALISE			='R';
var DISHONOUR		='N';
var PURCHASE			='P';
var PROCEED_RECV		='B';
var TRANSFER_MODE		='T';
var COPY_MODE		='C';
var LODGE_REALISE_MODE		='J';
var RECOVERY_MODE		='O';
var MT			='M';
var CLOSE_MODE			='Z';
var UNCLOSE_MODE		='Y';
var Bic = null;

var AmountCrncyMap =
{
	instrAmt : "stRemitCcy|N"
}

function fnOnLoad(){
	
	objForm = document.forms[0];
                             fnPopulateControlValues();
	objForm.recordFlg.value = recordFlg;
	newformatAmt(format, document.forms[0].instrAmt,stRemitCcy, 'N');
	
	initFocusHandler();
	/* Modifying as per the call id 220570 */
	if(remitSubType == 'T') 
	{ 
		disableFields("invClass","invtType","instrDate","instrNum","instrAlpha","quantity"); 
        hideImage("sLnk7"); 
        hideImage("sLnk16"); 
        objForm.instrAmt.focus(); 
	}
	if(remitSubType == 'T' || remitSubType == 'M'){
		fnPopulateDraweeDtls();
	}
	fnClick(""); 
	if (objForm.selectDel.value == 'Y')
	{
		objForm.chkselectDel.checked = true;
	}
    fnFetchDrwBranchDetails();
	fnHandleFieldsOnLoad();	
	fnOnblurOfinstrType();
	fnAssignUIDate(objForm.instrDate);
	return true;	
}

function fnHandleFieldsOnLoad()
{	
	switch(stFuncCode)
	{
		
		case REALISE_MODE:
		case DISHONOUR_MODE:
			fnDisableFields();
			break;
		case PURCHASE:
			if(actualFuncCode == LODGE_MODE)
			{
				objForm.instrType.value = remitSubType;
		                objForm.instrType.disabled=true;
		   	}
		   	else
		   	{
		   		fnDisableFormControls("V",objForm,17);
		   	}
			break;		
		case TRANSFER_MODE:
		case PROCEED_RECV:
		case CLOSE_MODE:
		case UNCLOSE_MODE:
		case RECOVERY_MODE:					            
			fnDisableFormControls("V",objForm,17);
			break;
		case INQUIRE_MODE:		
		case CANCEL_MODE:
		case VERIFY_MODE:	
			fnDisableFormControls(stFuncCode,objForm,17);
			if(stFuncCode==INQUIRE_MODE)
			{
				objForm.Back.focus();
			}
			else
			{
				if (sReferralMode != 'I' && sReferralMode != 'S')
				{
					objForm.Submit.focus();
				}
			}	
			break;
							
		case MODIFY_MODE:
		case LODGE_MODE:
		case COPY_MODE:
		case LODGE_REALISE_MODE:
		                objForm.instrType.value = remitSubType;
		                objForm.instrType.disabled=true;
		                if(eventType!=MODIFY_MODE && remitSubType != 'T')
					objForm.instrNum.focus();		            
             	
				break;						
			
	}
	if(eventType==MODIFY_MODE)
	{
		fnDisableFormControls("V",objForm,17);
	}		
	if(objForm.instrAlpha.value == "!")
	{
		objForm.instrAlpha.value="";
	}

}


function fnValidateForm(sArg)
{
	if (fnIsPstLLEmpty() && (sNewRecord == 'true'))
	{
		if (sArg != multiRecName+"::next" && sArg != multiRecName+"::AddNew")
		{
			return true;
		}
	}
	if (fnIsPstLLEmpty() && (sNewRecord == 'false')) 
	{ 
		var option = showConfirmDialog("irminstm"); 
		return true; 
	} 
	if(!fnValidateForms(objForm)) return false; 
	
	return true;
}
	
function fnValidateForms()
{	
	
	//if(isEmptyObjValue(sArg.id) && sArg.id!= undefined && fnIsPstLLEmpty())
	//	return true;
	
	if((stFuncCode == INQUIRE_MODE) || (stFuncCode == VERIFY_MODE) || (stFuncCode == CANCEL_MODE))
	{
		return true;
	}
	
	if(!fnValidateMandatoryFields())
		return false;
	
	if(!validateTypes(objForm) )
		return false;
	
	if(calledFrom == "HORM")
    {


        if(fnIsNull(objForm.drwName.value))
        {
            alert(finbranchResArr.get("FAT000200"));
            objForm.drwName.focus();
            return false;
        }

        if(fnIsNull(objForm.drwBnkName.value))
        {
            alert(finbranchResArr.get("FAT000200"));
            objForm.drwBnkName.focus();
            return false;
        }

    }	
	
	if(objForm.instrType.value == 'C' || objForm.instrType.value == 'N' || objForm.instrType.value == 'R'|| objForm.instrType.value == 'T' ||objForm.instrType.value == 'M')
	{
		
		if (fnIsNull(objForm.instrAmt.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.instrAmt.focus();
			return false;
		}
	}
	if(objForm.instrType.value == 'C')
	{
		if(fnIsNull(objForm.drwName.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.drwName.focus();
			return false;
		}
		if(fnIsNull(objForm.addr1.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.addr1.focus();
			return false;
		}
		/*if(fnIsNull(objForm.drwBank.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.drwBank.focus();
			return false;
		}
		if(fnIsNull(objForm.drwBranch.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.drwBranch.focus();
			return false;
		}*/
		if(fnIsNull(objForm.drwBnkName.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.drwBnkName.focus();
			return false;
		}
		if(fnIsNull(objForm.drwAddr1.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.drwAddr1.focus();
			return false;
		}
	}
	if(objForm.instrType.value == 'R' || objForm.instrType.value == 'N')
	{
		if (fnIsNull(objForm.quantity.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.quantity.focus();
			return false;
		}
	}
	if(objForm.instrType.value == 'C')
	{
		if (fnIsNull(objForm.instrDate_ui.value))
		{
			alert(finbranchResArr.get("FAT000200"));
			objForm.instrDate_ui.focus();
			return false;
		}
	        /*if (fnIsNull(objForm.instrAlpha.value)) 
		  { 
			alert(finbranchResArr.get("FAT000200")); 
			objForm.instrAlpha.focus(); 
			return false; 
			} */	

		if (fnIsNull(objForm.instrNum.value)) 
		{ 
			alert(finbranchResArr.get("FAT000200")); 
			objForm.instrNum.focus(); 
			return false; 
		} 
		if(calledFrom == "HIRM")
		{
			if(!isValidInt(objForm.quantity.value))
			{
				alert(finbranchResArr.get("FAT000277"));
				objForm.quantity.focus();
				return false;
			}

			var invalidChars = /[^0-9]/; //Anything other than 0-9 is invalid.
			if(invalidChars.test(objForm.quantity.value)){
				alert(finbranchResArr.get("FAT000485"));
				objForm.quantity.focus();
				return false;
			}
			if(objForm.quantity.value < 1)
			{
				alert(finbranchResArr.get("FAT004769"));
				objForm.quantity.focus();
				return false;
			}
		}

	}
	enableFormElements();
	if((objForm.instrAlpha.value == "")&& (!fnIsNull(objForm.instrNum.value)))
	{
	objForm.instrAlpha.value="!";
	}

	return true;
}

function fnIsPstLLEmpty()
{
    var bIsPageEmpty = false;
	if (objForm.instrType.value == 'C'){ 
	if (fnIsNull(objForm.instrNum.value) &&fnIsNull(objForm.instrAlpha.value) && fnIsNull(objForm.instrAmt.value)) 
	{ 
		bIsPageEmpty = true; 
	} 
	} 
	else if(fnIsNull(objForm.instrAmt.value)) 
    {

           bIsPageEmpty = true;
    }
        objForm.IsPageEmpty.value = bIsPageEmpty;

        return bIsPageEmpty;
}


function fnOnButtonClick(btnObj)
{
    	
	if(btnObj.id == Const.ACTION_VALIDATE || btnObj.id == Const.ACTION_SUBMIT  || btnObj.id == 'ViewTransaction')
	{
		if((stFuncCode==LODGE_MODE)||(actualFuncCode == LODGE_MODE)||(stFuncCode==LODGE_REALISE_MODE)||(stFuncCode==REALISE_MODE)||(stFuncCode==MODIFY_MODE))
		{
		
			if(!fnValidateForms(btnObj.id)) return false;
		}

		objForm.IsPageEmpty.value = false;
		objForm.direction.value = "";
	}
	if(btnObj.id == Const.ACTION_CANCEL )
	{
		if(!(confirm(finbranchResArr.get("FAT000925"))==true))
		{
			return false;
		}
		formReset(document.forms[0]);
	}
	doSubmit(btnObj.id);
	return true;
}


function getStatusDesc(statusVal) 
{

  if(remitSubType == 'M' || remitSubType == 'T') 
                   return " "; 

	switch(statusVal)
	{
		case LODGE		: return finbranchResArr.get("FAT002895");
		case LODGE_REALISE_MODE		: return finbranchResArr.get("FAT002928");
		case LODGE_PURCHASE	: return finbranchResArr.get("FAT002925");
		case REALISE		: return finbranchResArr.get("FAT002928");
		case DISHONOUR		: return finbranchResArr.get("FAT003298");
		default 		: return statusVal;
	}
}

function getInstrDesc(instrType) 
{
	switch(instrType)
	{
		case "C"		: return finbranchResArr.get("FAT002444");
		case "R"		: return finbranchResArr.get("FAT003306");
		case "N"		: return finbranchResArr.get("FAT003307");
	    case "T"        : return finbranchResArr.get("FAT003901"); 
        case "M"        : return "Mail Transfer"; 
		default 		: return instrType;
	}
}



function addRow(arrObj)
{
	var numRecNum 	= arrObj[0];    //Record Number.
	var blIsCurrRec 	= arrObj[1];    //Is the record is current one.
	var tmpInstrType 	= arrObj[3];    //Instrument Type
	var tmpInvntType    	= arrObj[4];
	var tmpInstNumA     	= arrObj[5];
	var tmpInstNumN     	= arrObj[6]; 
	var tmpInstrmntDate 	= arrObj[7];
	var tmpInstrCcy     	= arrObj[8];
	var tmpInstrmntAmt	= arrObj[9];
	var tempInstrQnty   	= arrObj[10];
	var tmpInstrCcy     	= arrObj[11];
	var tmpTotalAmt     	= arrObj[12];
	var tmpStatus 		= arrObj[13];
	var tmpDel          	= arrObj[14];
	var serNo          		= arrObj[15];
	var locStyle 		= "";
	var index 		= 0;
	var status		= "";
	var visibilityType		= ""
	if(arrObj[2]=='Y')
	{
		if(arrObj[3]=='T' || arrObj[3]=='M') 
		visibilityType="disabled";
		else 
		status="checked"; 

	}
	if ( tmpStatus == REALISE_MODE || tmpStatus == DISHONOUR_MODE || tmpInstrType == "" )
	{
		visibilityType="disabled" 
	}
	if ((stFuncCode == LODGE ||stFuncCode==LODGE_REALISE_MODE ||actualFuncCode == LODGE_MODE || eventType == LODGE_MODE) && tmpInstrType != "")
	{
		status="checked";
		visibilityType="disabled";
	}

	bgColorStyle = 'class="searclist1arow"';
	if( blIsCurrRec != 't') 
	{
		if(numRecNum % 2 == 0)
	    		bgColorStyle = 'class="searclist1a"';
		else
	    		bgColorStyle = 'class="searclist2a"';
	}

	document.write('<tr '+bgColorStyle+'>');
	document.write('<td width="3%"><input type="checkbox" id="chkrecordFlg" value="'+serNo+'" name="' + sGroupName + '.chkrecordFlg" numRecNum="'+numRecNum+'" onclick="fnClick(\'' + numRecNum + '\');"  '+ status +' '+visibilityType+'></td>');
	document.write('<td width="12%">'+jsUtil.encodeChar(getInstrDesc(tmpInstrType))+'&nbsp;');
	document.write('</td>');

	document.write('<td width="12%">'+jsUtil.encodeChar(tmpInvntType)+'&nbsp;');
	document.write('</td>');

	document.write('<td width="6%">'+jsUtil.encodeChar(tmpInstNumA)+'&nbsp;');
	document.write('</td>');

	document.write('<td width="6%">'+jsUtil.encodeChar(tmpInstNumN)+'&nbsp;');
	document.write('</td>');

	document.write('<td width="9%">'+jsUtil.encodeChar(fnConvertToUIDate(getDate(tmpInstrmntDate,tmpInstrType)))+'&nbsp;');
	document.write('</td>');
	document.write('<td width="4%">'+jsUtil.encodeChar(tmpInstrCcy)+'&nbsp;');
	document.write('</td>');

	document.write('<td align="right" width="10%">');         
	if(!fnIsNull(tmpInstrmntAmt))
	{
		newformatAmt(format,fnRemoveCrncy(tmpInstrmntAmt),stRemitCcy,"Y");
	}
	else
	{
		document.write(tmpInstrmntAmt);
	}   
	document.write('&nbsp;');
	document.write('</td>');

	document.write('<td width="8%">'+jsUtil.encodeChar(tempInstrQnty)+'&nbsp;');
	document.write('</td>');

	document.write('<td width="4%">'+jsUtil.encodeChar(tmpInstrCcy)+'&nbsp;');
	document.write('</td>');


	document.write('<td align="right" width="10%">');	  
	if(!fnIsNull(tmpTotalAmt))
	{
		newformatAmt(format,fnRemoveCrncy(tmpTotalAmt),stRemitCcy,"Y");
	}    else    {
		document.write(tmpTotalAmt);
	 }	    
	document.write('&nbsp;');
	document.write('</td>');

	document.write('<td width="10%">'+ jsUtil.encodeChar(getStatusDesc(tmpStatus))+'&nbsp;');    
	document.write('</td>');

	document.write('<td width="4%">'+jsUtil.encodeChar(tmpDel)+'&nbsp;');
	document.write('</td>');

	/*up and down arrow*/    

	document.write('<td class="leftscroll">');

	document.write('</td>');
	document.write('</tr>');  
}

function getDate(date,tmpInstrType)
{
     if(!isEmptyObjValue(tmpInstrType) && tmpInstrType != "N")
        return date;
    else
        return " ";
}

function fnOnblurOfinstrType() {

	if(objForm.instrType.value == 'C')    
	{
		
		if(fnIsNull(objForm.instrDate.value))
		{
			objForm.instrDate.value = stInstrDate;
		}
		objForm.instrDate_ui.disabled = false;  	
		if(calledFrom == "HIRM")
		{
			//objForm.quantity.value = 000;
			//objForm.quantity.disabled=true;
		}
		else
		{
			objForm.quantity.value = 001;
			objForm.quantity.disabled=true;
		}
		
		
	}

	          else if(objForm.instrType.value == 'T' || objForm.instrType.value == 'M') 
           { 
                   if(fnIsNull(objForm.instrDate.value)) 
                   { 
                           objForm.instrDate.value = stInstrDate; 
                   } 
                   objForm.instrDate_ui.disabled = false; 
                   objForm.quantity.value = 001; 
           } 


	else if(objForm.instrType.value == 'N')    
	{
		objForm.instrDate_ui.disabled = false;
		
		if(fnIsNull(objForm.instrDate.value))
		{
			objForm.instrDate.value = stInstrDate;
		}
		objForm.instrDate_ui.disabled = true;
		
		
		objForm.invClass.value = invClassCC;
		disableFields("drwName", "addr1", "addr2","addr3", "city", "state","cntry","postalCode");
		disableFields("drwBank", "drwBranch", "drwBnkName","drwAddr1", "drwAddr2", "drwAddr3","drwCity","drwState","drwCntry","drwPostalCode","drwBic");
		hideImage("sLnk9");
		hideImage("sLnk10");
		hideImage("sLnk6");
		hideImage("sLnk11");
		hideImage("sLnk12");
		hideImage("sLnk13");
		hideImage("sLnk14");
		hideImage("sLnk15");
		hideImage("sLnk17");
	}
	else if(objForm.instrType.value == 'R')
	{
		objForm.instrDate_ui.disabled = false;
		
		if(fnIsNull(objForm.instrDate.value))
		{
			objForm.instrDate.value = stInstrDate;
		}
		objForm.instrDate_ui.disabled = true;
		
		objForm.quantity.disabled = false;  
		
		objForm.invClass.value = invClassTC;
		disableFields("drwName", "addr1", "addr2","addr3", "city", "state","cntry","postalCode");
		disableFields("drwBank", "drwBranch", "drwBnkName","drwAddr1", "drwAddr2", "drwAddr3","drwCity","drwState","drwCntry","drwPostalCode","drwBic");
		hideImage("sLnk9");
		hideImage("sLnk10");
		hideImage("sLnk6");
		hideImage("sLnk11");
		hideImage("sLnk12");
		hideImage("sLnk13");
		hideImage("sLnk14");
		hideImage("sLnk15");
		hideImage("sLnk17");
	}
 }
 
 function fnOnBlurInstrAlpha()
 {
	 // Anything other than a-z/A-Z is invalid.
    var invalidChars = /[^a-zA-Z]/;

    if(invalidChars.test(objForm.instrAlpha.value))
    {
        alert(finbranchResArr.get("FAT002506"));
        objForm.instrAlpha.focus(); 
		return false;
    }
 }
 function fnOnBlurInstrNum()
 {
 	if(isNaN(objForm.instrNum.value))
 	{
 		alert(finbranchResArr.get("FAT000189"));
 		objForm.instrNum.focus();
 		return false;
 	}
 }


function fnGetBankDetails()
{
	listBankCodes('N',document.forms[0].drwBank,'F',document.forms[0].drwBankDesc);
	fnFetchDrwBranchDetails();
}

function fnGetBranchDetails()
{
	showDynCritSearcher('HSRRECEI','bank_identifier=:drwBic|bank_code=:drwBank|branch_code=:drwBranch',':drwBic=bank_identifier|:drwBank=bank_code|:drwBranch=branch_code');
	Bic=objForm.drwBic.value;
	fnFetchDrwBranchDetails(); 
	objForm.drwBic.value=Bic;
}


function fnFetchDrwBranchDetails()
{
clearDescField('drwCityDesc','drwStateDesc','drwCntryDesc');
	if (fnIsNull(objForm.drwBranch.value) && fnIsNull(objForm.drwBnkName.value) && fnIsNull(objForm.drwAddr1.value))
	{
		fnClearCBank1Flds();
		objForm.drwBranch.focus();
	}
	if ((!fnIsNull(objForm.drwBank.value))&&(!fnIsNull(objForm.drwBranch.value)))
    {
   		var rtn =   sendDataToServer('myframe','FBMBRANCHCODE','F','drwBank|drwBranch','drwBnkName|drwAddr1|drwAddr2|drwAddr3|drwCity|drwCityDesc|drwState|drwStateDesc|drwCntry|drwCntryDesc|drwPostalCode|drwBic|drwBankDesc');
      }


if (rtn == false)
	{
		fnClearCBank1Flds();
		objForm.drwBranch.focus();
	} 
    if(!fnIsNull(objForm.drwBranch.value))
	{
		objForm.drwBranchDesc.value=objForm.drwBnkName.value; 
	}
	
}



function fnClearCBank1Flds()
{
	   objForm.drwBnkName.value="";
       objForm.drwAddr2.value="";
       objForm.drwAddr1.value="";
       objForm.drwAddr3.value="";
	   objForm.drwCity.value="";
	   objForm.drwCityDesc.value="";
	   objForm.drwState.value="";
	   objForm.drwStateDesc.value="";
	   objForm.drwCntry.value="";
	   objForm.drwCntryDesc.value=""
	   objForm.drwPostalCode.value=""
	   objForm.drwBic.value="";
	   objForm.drwBranchDesc.value="";

}




function fnEditNameAddr()
{

        if(objForm.drwBnkName.value !="")
        {
            disableFields("drwBnkName");
        }
        else{
            enableFields("drwBnkName");

        }
        if(objForm.drwAddr1.value !="")
        {
            disableFields("drwAddr1");
        }
        else{
            enableFields("drwAddr1");
        }
        if(objForm.drwAddr2.value !="")
        {
            disableFields("drwAddr2");
        }
        else{
            enableFields("drwAddr2");
        }
        if(objForm.drwAddr3.value !="")
        {
            disableFields("drwAddr3");
        }
        else{
            enableFields("drwAddr3");
        }
        if(objForm.drwCity.value !="")
        {
            disableFields("drwCity");
            hideImage("sLnk13");
        }
        else{
            enableFields("drwCity");
            showImage("sLnk13");
        }
        if(objForm.drwState.value !="")
        {
            disableFields("drwState");
            hideImage("sLnk14");
        }
        else{
            enableFields("drwState");
            showImage("sLnk14");
        }
        if(objForm.drwCntry.value !="")
        {
            disableFields("drwCntry");
            hideImage("sLnk15");
        }
        else{
            enableFields("drwCntry");
            showImage("sLnk15");
        }
        if(objForm.drwPostalCode.value !="")
        {
            disableFields("drwPostalCode");
        }
        else{
            enableFields("drwPostalCode");
        }
}
function fnGetLength(objId)
{
	var noOfRows = 0;
	if(eval("objForm." + objId) != undefined)
		noOfRows = eval("objForm." + objId + ".length");
		
	if(noOfRows == undefined)
	{
		noOfRows = 1;
	}
	
	return noOfRows;
}

function fnCheckSelectAll()
{	
	var chk = true;
	var noOfRows = 0;
	var selFlg = true;
		
	chk = objForm.chkrecord.checked;
	
	noOfRows = fnGetLength("chkrecordFlg");
	
	for (var i = 0; i < noOfRows; i++)
	{
		chkBoxObj = eval(objForm.chkrecordFlg[i]);
		
		if(chkBoxObj == undefined)
		{	
			chkBoxObj = eval(objForm.chkrecordFlg);
		}

		chkBoxObj.checked = chk;
		
	}
	objForm.chkrecord.checked = selFlg;
	objForm.srlNum.value="-1";
	objForm.selFlgtmp.value=chkBoxObj.checked;
	doSubmitForm("chkSelFlg");
	return true
}

function fnClick(serNo)
{
	var selFlg = true;
	var noOfRows = 0;
		
	noOfRows = fnGetLength("chkrecordFlg");
		
	for (var i = 0; i < noOfRows; i++)
	{
		chkBoxObj = eval(objForm.chkrecordFlg[i]);
		if(chkBoxObj == undefined)
		{
			chkBoxObj = eval(objForm.chkrecordFlg);
		}
						
		if(chkBoxObj != undefined && !(chkBoxObj.checked))
		{
			selFlg = false;
			break;
		}
	}	
	objForm.chkrecord.checked = selFlg;
	if (serNo !="")
	{
		chkBoxObj = eval(objForm.chkrecordFlg[serNo]);
		if(chkBoxObj == undefined)
		{
			chkBoxObj = eval(objForm.chkrecordFlg);
		}
		objForm.srlNum.value=chkBoxObj.value;
		objForm.selFlgtmp.value=chkBoxObj.checked;
		doSubmitForm("chkSelFlg");
		return true;
	}
}

function fnDisableFields()
{
	var frm = document.forms[0];

	frm.instrAmt.disabled = true;
	frm.instrType.disabled = true;
	frm.invtType.disabled = true;
	frm.invtTypeDesc.disabled = true;
	frm.instrNum.disabled = true;
	frm.instrAlpha.disabled = true;
	frm.quantity.disabled = true;
	frm.selectDel.disabled = true;
	frm.drwName.disabled = true;
	frm.addr1.disabled = true;
	frm.addr2.disabled = true;
	frm.addr3.disabled = true;
	frm.city.disabled = true;
	frm.cityDesc.disabled = true;
	frm.state.disabled = true;
	frm.stateDesc.disabled = true;
	frm.cntry.disabled = true;
	frm.cntryDesc.disabled = true;
	frm.postalCode.disabled = true;
	frm.drwBank.disabled = true;
	frm.drwBankDesc.disabled = true;
	frm.drwBranch.disabled = true;
	frm.drwBranchDesc.disabled = true;
	frm.drwBnkName.disabled = true;
	frm.drwAddr1.disabled = true;
	frm.drwAddr2.disabled = true;
	frm.drwAddr3.disabled = true;
	frm.drwCity.disabled = true;
	frm.drwCityDesc.disabled = true;
	frm.drwState.disabled = true;
	frm.drwStateDesc.disabled = true;
	frm.drwCntry.disabled = true;
	frm.drwCntryDesc.disabled = true;
	frm.drwPostalCode.disabled = true;
	frm.drwBic.disabled = true;
	frm.drwBicDesc.disabled = true;
	frm.instrDate_ui.readOnly = true;
	frm.chkselectDel.disabled = true;
	disableHyperLnks(15);
     } 
    
   function fnPopulateDraweeDtls() 
   { 
		if(fnIsNull(objForm.drwName.value) && fnIsNull(objForm.addr1.value))
		{
           objForm.drwName.value = draweeName; 
           objForm.addr1.value = draweeAddr1; 
           objForm.addr2.value = draweeAddr2; 
           objForm.addr3.value = draweeAddr3 
           objForm.city.value = draweeCity; 
           objForm.state.value = draweeState; 
           objForm.cntry.value = draweeCntry; 
           objForm.postalCode.value = draweePin;
		} 
   }
   function isValidInt(fldValue) {
	fldValue = getValInStdFormat(fldValue);
	if(isEmptyObjValue(fldValue) || isNaN(fldValue) ||
			(-1 != fldValue.indexOf(".")) ||
			(-1 != fldValue.toUpperCase().indexOf("E")))    {
		return false;
	}
	return true;
   }
