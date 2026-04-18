function printBlock()
{
	writeCustomHeader("cautomnu_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">'+menuTitle+' </td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textfielddisplaylabel"> </td>');
	write('</tr>');
	write('</table>');
	write('<br />');
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
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'uituplddet_help.htm\');">');
	write('<img align="right" class="img" border="0" src="../Renderer/images/' + applangcode + '/help.gif" hotKeyId="finHelp">');
	write('</img></a>'); 
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.funcCode" id="funcCode" style="width: 218px"  fdt="String" ' + cautomnuProps.get("funcCode_ENABLED") + '>');
	
	var workclass=USER_MENU_ID.substring(9, 12);
       //	alert(workclass);
 	if (profileId == 54){
			write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
			write('<option value="OA">' + jspResArr.get("FLT012907") + '</option>');
			write('<option value="UD">' + jspResArr.get("FLT012902") + '</option>');
			write('<option value="DR">' + jspResArr.get("FLT012903") + '</option>');
			write('<option value="UC">' + jspResArr.get("FLT012904") + '</option>');
			write('<option value="CR">' + jspResArr.get("FLT012905") + '</option>');
			write('<option value="US">' + jspResArr.get("FLT012908") + '</option>');
			write('<option value="SR">' + jspResArr.get("FLT012909") + '</option>');
			write('<option value="UA">' + jspResArr.get("FLT012910") + '</option>');
			write('<option value="AR">' + jspResArr.get("FLT012911") + '</option>');
			write('<option value="UB">' + jspResArr.get("FLT012913") + "</option>");
			write('<option value="BR">' + jspResArr.get("FLT012914") + "</option>");
			write('<option value="VA">' + jspResArr.get("FLT012915") + "</option>");
			write('<option value="VV">' + jspResArr.get("FLT012917") + "</option>");
			write('<option value="VR">' + jspResArr.get("FLT012916") + "</option>");
			write('<option value="B2C">' + jspResArr.get("FLT012918") + "</option>");
			write('<option value="SC">' + jspResArr.get("FLT012922") + "</option>");
			write('<option value="VC">' + jspResArr.get("FLT012923") + "</option>");
          	if (workclass == "146"){
			    write('<option value="LI">' + jspResArr.get("FLT012906") + '</option>');
		        write('<option value="UL">' + jspResArr.get("FLT012900") + '</option>');
		        write('<option value="LR">' + jspResArr.get("FLT012901") + '</option>');
		     }
	 	
		  if ((workclass == "260")||(workclass=="152")){
	           write('<option value="LI">' + jspResArr.get("FLT012906") + '</option>');
		       write('<option value="VL">' + jspResArr.get("FLT012924") + "</option>");
		   	   write('<option value="LR">' + jspResArr.get("FLT012901") + '</option>');
		    }
	}	

        if (profileId == 56){
					write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
		        if (workclass == "144"){
					write('<option value="LO">' + jspResArr.get("FLT012919") + "</option>");
					                }
		        if (workclass == "310"){
					write('<option value="LV">' + jspResArr.get("FLT012920") + "</option>");
					 }
		        if (workclass == "153"){
					write('<option value="LD">' + jspResArr.get("FLT012921") + "</option>");
					                }
				if ((workclass == "146")){
					write('<option value="UD">' + jspResArr.get("FLT012902") + '</option>');
					write('<option value="DR">' + jspResArr.get("FLT012903") + '</option>');
					write('<option value="LI">' + jspResArr.get("FLT012906") + '</option>');
					write('<option value="UL">' + jspResArr.get("FLT012900") + '</option>');
				    write('<option value="VL">' + jspResArr.get("FLT012924") + '</option>');
					write('<option value="LR">' + jspResArr.get("FLT012901") + '</option>');
					write('<option value="UC">' + jspResArr.get("FLT012904") + '</option>');
			        write('<option value="CR">' + jspResArr.get("FLT012905") + '</option>');
					write('<option value="UF">' + jspResArr.get("FLT012928") + '</option>');
			        write('<option value="FR">' + jspResArr.get("FLT012925") + '</option>');
					write('<option value="DD">' + jspResArr.get("FLT012926") + '</option>');
					write('<option value="RD">' + jspResArr.get("FLT012927") + '</option>');
							}
							
				if ((workclass == "260")||(workclass=="350")){
					write('<option value="UD">' + jspResArr.get("FLT012902") + '</option>');
					write('<option value="DR">' + jspResArr.get("FLT012903") + '</option>');
					write('<option value="LI">' + jspResArr.get("FLT012906") + '</option>');
					write('<option value="LR">' + jspResArr.get("FLT012901") + '</option>');
					write('<option value="UC">' + jspResArr.get("FLT012904") + '</option>');
				    write('<option value="CR">' + jspResArr.get("FLT012905") + '</option>');
					write('<option value="UF">' + jspResArr.get("FLT012928") + '</option>');
				    write('<option value="FR">' + jspResArr.get("FLT012925") + '</option>');
					write('<option value="DD">' + jspResArr.get("FLT012926") + '</option>');
					write('<option value="RD">' + jspResArr.get("FLT012927") + '</option>');
			    	write('<option value="VL">' + jspResArr.get("FLT012924") + "</option>");
					                }
									
		if ((workclass == "999")){
					write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
					write('<option value="UD">' + jspResArr.get("FLT012902") + '</option>');
					write('<option value="DR">' + jspResArr.get("FLT012903") + '</option>');
					write('<option value="UC">' + jspResArr.get("FLT012904") + '</option>');
					write('<option value="CR">' + jspResArr.get("FLT012905") + '</option>');
					write('<option value="OA">' + jspResArr.get("FLT012907") + '</option>');
					write('<option value="US">' + jspResArr.get("FLT012908") + '</option>');
					write('<option value="SR">' + jspResArr.get("FLT012909") + '</option>');
					write('<option value="UA">' + jspResArr.get("FLT012910") + '</option>');
					write('<option value="AR">' + jspResArr.get("FLT012911") + '</option>');
					write('<option value="UB">' + jspResArr.get("FLT012913") + '</option>');
					write('<option value="BR">' + jspResArr.get("FLT012914") + '</option>');
					write('<option value="VA">' + jspResArr.get("FLT012915") + '</option>');
					write('<option value="VR">' + jspResArr.get("FLT012916") + '</option>');
					write('<option value="VV">' + jspResArr.get("FLT012917") + '</option>');
					write('<option value="B2C">' + jspResArr.get("FLT012918") + '</option>');
					write('<option value="SC">' + jspResArr.get("FLT012922") + '</option>');
					write('<option value="VC">' + jspResArr.get("FLT012923") + '</option>');
					write('<option value="UF">' + jspResArr.get("FLT012928") + '</option>');
					write('<option value="FR">' + jspResArr.get("FLT012925") + '</option>');
					write('<option value="DD">' + jspResArr.get("FLT012926") + '</option>');
					write('<option value="RD">' + jspResArr.get("FLT012927") + '</option>');
					write('<option value="LI">' + jspResArr.get("FLT012906") + '</option>');
					write('<option value="UL">' + jspResArr.get("FLT012900") + '</option>');
					write('<option value="VL">' + jspResArr.get("FLT012924") + '</option>');
					write('<option value="LR">' + jspResArr.get("FLT012901") + '</option>');
						}
		
		
	}

		
	write('</select>');
	write('</td>');
	write('<td>');
	write('<td class="textlabel">' + jspResArr.get("FLT021699") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="file" class="normal textfieldfont" fdt="lcase" name="' + subGroupName + '.fileName" id="fileName" >');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel"> </td>');
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
	// alert(profileId);
	} //End with()
} //End function

function printFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div align="left" class="ctable">');
	//if (sReferralMode == 'S'){
	//write('<input type="button" class="Button" id="Submit" value="Submit" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	//}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="Clear" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Upload" type="button" name="Submit" value="Upload" class="button" onClick="javascript:return cautomnu_det_ONCLICK1(this,this);"" hotKeyId="Submit">');
	
	//write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cautomnu_det_ONCLICK1(this,this);"" value="Submit" hotKeyId="Submit">');
	//write('<input id="Validate" name="Validate" type="button" class="button" value="Validate"	onClick="javascript:return cautomnu_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="Clear"	onClick="javascript:return cautomnu_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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
	document.forms[0].funcCode.focus();
	pre_ONLOAD('cautomnu_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.fileName.value = fileName;
}


function cautomnu_det_ONCLICK1(obj, p1) {
  // Validate that a function code is selected
  if (fnIsNull(document.forms[0].funcCode.value)) {
      alert("Enter the Function Code");
      document.forms[0].funcCode.focus();
      return false;
  }

  if(document.forms[0].funcCode.value == "VV"){
	document.getElementById("fileName").value = '/data/testdata.txt';
  }

  // Validate that a file is selected
  if (document.forms[0].fileName.value == "") {
      alert("Please Enter the File Name.");
      document.forms[0].fileName.focus(); // Fixed the focus target from 'period' to 'fileName'
      return false;
  }

  // File processing
  var file = document.getElementById("fileName").value;

  var fileIndex = file.lastIndexOf("\\");
  var fileName = file.substring(fileIndex + 1);

  if (!fnCheckSpecialChar(fileName)) {
      return false;
  }

  var index = file.lastIndexOf(".");
  var ext = file.substring(index + 1).toUpperCase();
  if (ext != "TXT" && ext != "CSV") {
      alert("Please enter only csv/txt extension file for uploading");
      return false;
  }

  fnUpload();

  var retVal = fnValAndSubmit(p1);
  if (retVal === false) {
      return false;
  }

  return (retVal === undefined) ? true : retVal;
}


function fnCheckSpecialChar(name)
{

        //alert("checking For Special Chars ");
        returnFlg="true";
        //alert("Customer Name : "+name )
        if (name!="" || name!=null) {
                var string = name;
                for (var i=0;i<string.length;i++)
                {
                        asciiNum = string.charCodeAt(i);
                        //alert(i + " " + asciiNum + " " + returnFlg)
                        if ((asciiNum>96 && asciiNum<123) ||(asciiNum>64 && asciiNum<91) || (asciiNum>45 && asciiNum<58)  ){
                                returnFlg="true";   }
                                else {
                                returnFlg="false";
                                break;
                                }
                }
                if (returnFlg == "true"){
                        //alert("Name is correct");
                        return true;
                 }
                else {
                        alert("File Name shoud not contain special charecters or space: "+name);
                        return false;
                }

        }
        return true;
}

function fnUpload()
{
var objForm = document.getElementById("detform");
objForm.encoding = "multipart/form-data";
var qrystr ="";
for (var i = 0;i < objForm.elements.length; i++)
{
var locVal = objForm.elements[i].value;
if(objForm.elements[i].name == "actionCode")
objForm.elements[i].value = "upload";
if (locVal != null && locVal.length > 0 && locVal != "" && locVal != " ")
{
if(objForm.elements[i].name == "undefined" || (objForm.elements[i].value != null && objForm.elements[i].value == "undefined")
)
continue;
if(qrystr.length == 0)
{
qrystr = objForm.elements[i].name + "=" + objForm.elements[i].value
}
else
{
qrystr = qrystr + "&" + objForm.elements[i].name + "=" + objForm.elements[i].value
}
}
}
if(qrystr.indexOf("actionCode")==-1)
{
qrystr = qrystr + "&actionCode=upload"
}
if(qrystr.indexOf("?")==-1 || qrystr.indexOf("?")!=0)
{
qrystr = "?" + qrystr
}
objForm.action = objForm.action + qrystr
objForm.submit();
return true;

}


function cautomnu_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cautomnu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('cautomnu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cautomnu_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cautomnu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	 if ((retVal =  fnClearFields()) == false) {
                return false;
        }

	return (retVal == undefined) ? true : retVal;
}
