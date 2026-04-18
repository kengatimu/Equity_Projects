function printBlock()
{
        writeCustomHeader("package_det");
        with (document){
       	write('<input type="hidden" id="tmpCrncyCode" fdt="String" mneb1="N" name="' + subGroupName + '.tmpCrncyCode" value="'+ tmpCrncyCode +'">'); 
       	write('<input type="hidden" id="glSubHeadCode" name="' + subGroupName + '.glSubHeadCode" value="">'); 
       	write('<input type="hidden" id="crncy" name="' + subGroupName + '.crncy" value="">'); 
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
        write('<tr>');
        write('<td>');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('<tr>');
        write('<td class="page-heading">' + jspResArr.get("FLT648012") + '</td>');
        write('</tr>');
        write('</table>');
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT648230") + '</td>');
        write('<td class="textfielddisplaylabel">');
        if(funcCode == "A")
        {
                write('<label id="compField">' + jspResArr.get("FLT648014") + '</label>');
        }
        if(funcCode == "M")
        {
                write('<label id="compField">' + jspResArr.get("FLT648017") + '</label>');
        }
        if(funcCode == "V")
        {
                write('<label id="compField">' + jspResArr.get("FLT648181") + '</label>');
        }
        if(funcCode == "X")
        {
                write('<label id="compField">' + jspResArr.get("FLT648182") + '</label>');
        }
	if(funcCode == "I")
        {
                write('<label id="compField">' + jspResArr.get("FLT648183") + '</label>');
        }
        write('</td>');
        write('<td class="columnwidth">&nbsp; </td>');
        write('<td class="textlabel">' + jspResArr.get("FLT648007") + '</td>');
        write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + packageCode + '</label>');
        write('</td>');
        write('</tr>');
        write('</table>');

        write('<br />');
        write('<!-- DETAILSBLOCK-BEGIN -->');
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write('<tr>');
        write('<td valign="top">');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
        write('<tr>');
        write('<td height="25" colspan="5" align="right">');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('<tr>');
        write('<td align="right">');
        write('<a href="javascript:showHelpFile(\'package_det_help.htm\');" id="sLnk1">');
        write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
        write('</a>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');


	//Package Desc
        write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000600") + '<script>setMandatory("Y");</script>' +'</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.packageDesc" id="packageDesc" fmnd= "Y" size= "20" maxlength="50"  fdt="String" ' + packageProps.get("packageDesc_ENABLED") + '>');
        write('</td>');

        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel"> </td>');
        write('<td class="textfield"> </td>');
        write('</tr>');

	for(i=1;i<=10;i++)
	{
		write('<tr>');
		write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT00000"+i) + '<script>setMandatory("N");</script></td>');
		write('<td class="textfield" colspan="4">');
		write('<select name="' + subGroupName + '.product'+i+'" id="product'+i+'"  fdt="String" onChange="javascript:return schmcodeClear('+i+');"  ' + packageProps.get("product"+i+"_ENABLED") + ' class="listboxfont" >');
		write('<option value="">' + jspResArr.get("FLT000011") + '</option>');
		write('<option value="LAA">' + jspResArr.get("FLT000012") + '</option>');
		write('<option value="CAA">' + jspResArr.get("FLT000013") + '</option>');
		write('<option value="TDA">' + jspResArr.get("FLT000014") + '</option>');
		write('<option value="SBA">' + jspResArr.get("FLT000015") + '</option>');
		write('<option value="ODA">' + jspResArr.get("FLT000016") + '</option>');
		write('<option value="B">' + jspResArr.get("FLT000017") + '</option>'); 
		write('<option value="D">' + jspResArr.get("FLT000018") + '</option>');
                write('<option value="G">' + jspResArr.get("FLT000019") + '</option>');	
		write('<option value="R">' + jspResArr.get("FLT000020") + '</option>');	
		write('</select>');
		write('&nbsp;');
		write('<input name="' + subGroupName + '.schmCode'+i+'" id="schmCode'+i+'" type="text" fdt="String" class="textfieldfont" hotKeyId="search1'+i+'" onChange="javascript:return schmcode(i);" readonly size="21" maxlength="20">');
		write('&nbsp; <a id="sLnk1'+i+'" href="javascript:schmCodSearcher('+i+')">');
		write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16"></a>');	
		write('&nbsp;<input class="label" id="schmCodeDesc'+i+'" name="' + subGroupName + '.schmCodeDesc'+i+'" size="30" border="0" maxlength=30 fds="Y" disabled>');
		write("</td>");
		write('</tr>');
	}

	//Package Prising
    	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000620") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.packagePrising" id="packagePrising"  fdt="String"  onChange="javascript:return functioncode(this);"' + packageProps.get("persent_ENABLED") + ' class="listboxfont" >');
        write('<option value="">' + jspResArr.get("FLT200123") + '</option>');
        write('<option value="P">' + jspResArr.get("FLT200124") + '</option>');
        write('<option value="A">' + jspResArr.get("FLT200125") + '</option>');
        write('</select>');
        write('</td>');
        write('</tr>');

        //Value
        write('<tr id="X">');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT200122") + '<script>setMandatory("Y");</script>' + '</td>');
        write('<td class="textfield">');
        write('<input  type="text" class="textfieldfont" fdt="amount" mnebl="false" onchange="javascript:return packageDet_ONCHANGE1(this,\'' + "LAKH" + "',this,'" + tmpCrncyCode + '\',\'N\');" onblur="javascript:return packageDet_ONBLUR1(this,\'' + "LAKH" + "',this,'" + tmpCrncyCode + '\',\'N\');" name="' + subGroupName + '.value1" id="value1" size="24" maxlength="17" style="TEXT-ALIGN:right">');
        write('</td>');
        write('</tr>');

        //Value
        write('<tr id="Z">');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT200126") + '<script>setMandatory("Y");</script>' +'</td>');
        write('<td class="textfield">');
        write('<input type="text" id="value2" name="' + subGroupName + '.value2" size="12" maxlength="10" class="textfieldfont" fdt="fpcnt" onchange="javascript:return packageDet_ONCHANGE3(this,document.forms[0].percentAmount);" style="TEXT-ALIGN:right"></td>');
        write('</td>');
        write('</tr>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield"><td>');
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
        } //End with()
} //End function


function printFooterBlock()
{
        with (document) {
        if ((sReferralMode == 'I')||(sReferralMode == 'S')){
        write('<div align="left" class="ctable">');
        if (sReferralMode == 'S'){
        write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
        }
        writeRefFooter();
        write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
        write('</div>');
        }else{
        if(funcCode !='I'){
        write('<div class="ctable">');
        write('<input id="Submit" name="Submit" type="button" class="button"    onClick="javascript:return package_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
        write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '" onClick="javascript:return package_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
        }else{
        write('<div class="ctable">');
        write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
        }
        writeFooter();
        write('</div>');
        }
        } //End with()
}//End function



function fnOnLoad()
{
        var ObjForm = document.forms[0];

        initFocusHandler();

        pre_ONLOAD('package_det',this);

        var funcName = "this."+"locfnOnLoad";
        if(eval(funcName) != undefined){
                eval(funcName).call(this);
        }

        fnPopulateControlValues();
        fnAssignDateOnLoad(ObjForm);
        if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
                fnDisableFormDataControls('V',ObjForm,0);
        }
        fnPopUpExceptionWindow(ObjForm.actionCode);
        if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
                checkCustErrExecNextStep(Message);
        }

        post_ONLOAD('package_det',this);
}



function fnCheckMandatoryFields()
{
        var ObjForm = document.forms[0];

        return true;
}



function fnPopulateControlValues()
{
        var ObjForm = document.forms[0];
	ObjForm.packageDesc.value = packageDesc;
	ObjForm.product1.value = product1;
	ObjForm.product2.value = product2;
	ObjForm.product3.value = product3;
	ObjForm.product4.value = product4;
	ObjForm.product5.value = product5;
	ObjForm.product6.value = product6;
        ObjForm.product7.value = product7;
        ObjForm.product8.value = product8;
        ObjForm.product9.value = product9;
        ObjForm.product10.value = product10;
	ObjForm.packagePrising.value = packagePrising;
	ObjForm.schmCodeDesc1.value = schmCodeDesc1;
	ObjForm.schmCodeDesc2.value = schmCodeDesc2;
	ObjForm.schmCodeDesc3.value = schmCodeDesc3;
        ObjForm.schmCodeDesc4.value = schmCodeDesc4;
	ObjForm.schmCodeDesc5.value = schmCodeDesc5;
        ObjForm.schmCodeDesc6.value = schmCodeDesc6;
	ObjForm.schmCodeDesc7.value = schmCodeDesc7;
        ObjForm.schmCodeDesc8.value = schmCodeDesc8;
	ObjForm.schmCodeDesc9.value = schmCodeDesc9;
        ObjForm.schmCodeDesc10.value = schmCodeDesc10;
	ObjForm.schmCode1.value = schmCode1;
	ObjForm.schmCode2.value = schmCode2;
	ObjForm.schmCode3.value = schmCode3;
        ObjForm.schmCode4.value = schmCode4;
	ObjForm.schmCode5.value = schmCode5;
        ObjForm.schmCode6.value = schmCode6;
	ObjForm.schmCode7.value = schmCode7;
        ObjForm.schmCode8.value = schmCode8;
	ObjForm.schmCode9.value = schmCode9;
        ObjForm.schmCode10.value = schmCode10;	
	ObjForm.value1.value = value1;
	ObjForm.value2.value = value2;	
	newformatAmt('LAKH', ObjForm.value1, tmpCrncyCode, "N");

//	schmcodeClear(onload);
}

function package_det_ONCLICK1(obj,p1)
{
        var retVal = "";
        if (preEventCall('package_det',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  fnValAndSubmit(p1)) == false) {
                return false;
        }
        if (postEventCall('package_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function package_det_ONCLICK2(obj,p1)
{
        var retVal = "";
        if (preEventCall('package_det',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  fnValAndSubmit(p1)) == false) {
                return false;
        }
        if (postEventCall('package_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function package_det_ONCLICK3(obj,p1)
{
        var retVal = "";
        if (preEventCall('package_det',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  doSubmit(p1)) == false) {
                return false;
        }
        if (postEventCall('package_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function package_det_ONBLUR1(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('package_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('package_det',obj,'ONBLUR') == false) {
                return false;
	 }
   //     if(!validateTypes(document.forms[0]))
   //     {
   //             obj.value = "";
   //             return false;
   //     }
        return (retVal == undefined) ? true : retVal;

}
function package_det_ONBLUR6(e,f,d,b,a)
{
        var c="";
        if(preEventCall("package_det",e,"ONBLUR")==false)
        {
                return false
        }
        if(preEventCallForLocale("package_det",e,"ONBLUR")==false)
        {
                return false
        }
        if((c=newformatAmt(f,d,b,a))==false)
        {
                return false
        }
        if(postEventCallForLocale("package_det",e,"ONBLUR")==false)
        {
                return false
        }
        if(postEventCall("package_det",e,"ONBLUR")==false)
        {
                return false
        }
        if(!validateTypes(document.forms[0]))
        {
                obj.value = "";
                return false;
        }
        return(c==undefined)?true:c
}







	










































































































































































































































































































