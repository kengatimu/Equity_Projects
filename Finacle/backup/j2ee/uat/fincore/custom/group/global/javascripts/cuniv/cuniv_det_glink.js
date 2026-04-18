function printBlock()
{
    writeCustomHeader("cuniv_det");
    with (document){
    write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
    write('<tr>');
    write('<td>');
    write('<table border="0" cellspacing="0" cellpadding="0">');
    write('<tr>');
    if (funcCode == 'A')
    {
	funcDesc="Add";
	write('<td class="page-heading" style="height: 15px; width:400px">COLLLECTION A/C DETAILS CAPTURE SCREEN</td>');
    }
    if (funcCode == 'B')
    {
	funcDesc="Biller";
	write('<td class="page-heading">BILLER A/C DETAILS CAPTURE SCREEN</td>');
    }
    if (funcCode == 'D')
    {
	funcDesc="Delete";
	write('<td class="page-heading">COLLLECTION A/C DETAILS CAPTURE SCREEN</td>');
    }
    if (funcCode == 'M')
    {
	funcDesc="Modify";
	write('<td class="page-heading">COLLLECTION A/C DETAILS CAPTURE SCREEN</td>');
    }
        write('</tr>');
        write('<tr>');
        write('<td class="textlabel">Function :</td>');
	write('<td>'+funcCode+ " - " +funcDesc+ '</td>');

    write('</tr>');
    write('</table>');
    write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
    write('<tr>');
    write('<td valign="top">');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
    write('<tr>');
    write('<td class="activetab3" width="100%"></td>');
    write('</tr>');
    write('</table>');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
    write('<tr>');
    write('<td>');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
    write('<tr>');
    write('<td>');
    write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop">');
    write('<tr>');
    write('<a href="javascript:showHelpFile(\'cuniv_det_help.htm\');" id="sLnk1">');
    write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
    write('</tr>');
    write('<tr>');
    write('</td>');
    write('</tr>');
    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT022002") + '<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.foracid" id="foracid" ' + cunivProps.get("foracid_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onChange="javascript:fnOnchangeFacid(this);">');
    write('<a href="javascript:fnshowAccountIdList(document.forms[0].foracid);" id="actNoList">');
    write('<img id="benfList1" width="16" height="17" border="0"  hotKeyId="search1" src="../Renderer/images/search_icon.gif"></img></a>');
	//363800
	write('&nbsp;<input name="' + subGroupName + '.acctname" id="acctname" ' + cunivProps.get("acctname_ENABLED") + ' type="text" disabled="true" class="label onChange="javascript:fnname(foracid);">');
	//363800

    write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT022003") + '<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.regNo" id="regNo" ' + cunivProps.get("regNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="50" onChange="javascript:checkValidRegNo(this);">');
    write('</td>');
    write('</tr>');

    write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT022004") + '<font color=red size=2>*</font></td>');
    write('<td><input name="' + subGroupName + '.stdName" id="stdName" ' + cunivProps.get("stdName_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="80" onChange="javascript:checkValidName(this);">');
    write('</td>');
    write('</tr>');

    write('<tr>');
    write('</tr>');
    write('</table></td>');
    write('</tr>');
    write('</table></td>');
    write('</tr>');
    write('</table></td>');
    write('</tr>');
    write('</table></td>');
    write('</tr>');
    write('</table>');
    } //End with()
} //End function

function printFooterBlock()
{
    with (document) {
    if ((sReferralMode == 'I')||(sReferralMode == 'S')){
    write('<div align="left" class="ctable">');
    if (sReferralMode == 'S'){
    write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
    }
    writeRefFooter();
    write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
    write('</div>');
    }else{
    if(funcCode !='I'){
    write('<div class="ctable">');
    write('<input name="Submit" type="button" class="button" onClick="javascript:return cuniv_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
    write('<input name="Cancel" type="button" class="button" onClick="javascript:return cuniv_det_ONCLICK2(this);" id="Cancel" value="Cancel">');
    }else{
    write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
    }
    writeFooter();
    write('</div>');
    }
    } //End with()
}//End function

function fnOnLoad()
{
    var ObjForm = document.forms[0];

    pre_ONLOAD('cuniv_det',this);

    post_ONLOAD('cuniv_det',this);
	fnPopulateControlValues();
}

function post_ONLOAD(obj1,obj2)
{
    fnPopulateControlValues();
}

function fnValidateData()
{
    var ObjForm = document.forms[0];

    return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.foracid.value=foracid;
	ObjForm.regNo.value=regNo;
	ObjForm.stdName.value=stdName;
}


function cuniv_det_ONCLICK1(obj,p1)
{
    var retVal = "";

    if(fnIsNull(document.forms[0].foracid.value)) 
    {
        alert("Enter the Account Number");
        document.forms[0].foracid.focus();
        return false;
    }
    
    if(fnIsNull(document.forms[0].regNo.value)) 
    {
        alert("Enter the Reg No");
        document.forms[0].regNo.focus();
        return false;
    }
	
	if(fnIsNull(document.forms[0].stdName.value)) 
    {
        alert("Enter the Name");
        document.forms[0].stdName.focus();
        return false;
    }

    if ((retVal = fnValAndSubmit(p1)) == false) 
    {
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function cuniv_det_ONCLICK2(obj)
{
        var retVal = "";
        if (pre_ONCLICK('cuniv_det',obj) == false) {
                return false;
        }
        if ((retVal = fnClearFields()) == false) {
                return false;
        }
        if (post_ONCLICK('cuniv_det',obj) == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
    showAccountIdList(obj,null,null,'F');
	fnname();
}

function fnOnchangeFacid(obj) {
        var foracid             = document.forms[0].foracid.value.toUpperCase();
        var inputNameValues     = "acctNum|"+foracid
        var outputNames         = ""
        var scrName             = "cunivdp004.scr";
        var retVal              = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret                 = retVal.split("|");
        var msg                 = ret[0];
        if(msg == "RESULT_MSG"){
                alert(ret[1]);
                document.forms[0].foracid.focus();
                document.forms[0].foracid.value = ""
                return false;
        }
		fnname();
}

function checkValidRegNo(obj)
{
        var invalidChars = "~`!@#$%^*+=|?;:'\"{},_[]{}";
        var str = obj.value;
        for (i = 0; i < str.length; i++)
        {
                if (invalidChars.indexOf(str.charAt(i)) != -1)
                {
                        alert("Enter a Valid Reg. No.");
                        document.forms[0].regNo.focus()
                        document.forms[0].regNo.value = ""
                        return false
                }
        }
        return true;
}


/*function checkValidName(obj)
{
	var invalidChars = "1234567890~`!@#$%^*+=|?;:'\"{},-_[]{}";
	var str = obj.value;
	for (i = 0; i < str.length; i++)
	{
		if (invalidChars.indexOf(str.charAt(i)) != -1)
		{
			alert("Enter a Valid Name");
			document.forms[0].stdName.focus() 
			document.forms[0].stdName.value = ""
			return false
		}
	}
	return true;
}*/

//363800 start
function fnname(obj)
{
	var dco=document.forms[0].foracid.value;
	var input      = "dco|"+dco;
	var outputNames    = "output|outVal";
	var scrName     =   "b_acctname.scr";
	var retVal = appFnExecuteScript(input,outputNames,scrName,false);
	var retBuff = retVal.split("|");
	var output = retBuff[0];
	var value = retBuff[1];
	var a = value;
			//alert(a);

	document.forms[0].acctname.value=a;

}
//363800 end
