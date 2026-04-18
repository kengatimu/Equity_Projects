function printBlock()
{
	writeCustomHeader("cshare_crit");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031700") + '</td>');
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
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'crit_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 29px; width: 248px">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfield">');
	write('<select onChange="SelectChange()" name="' + subGroupName + '.funcCode" id="funcCode" ' + cshareProps.get("funcCode_ENABLED") + '  >');
	write('<option value="">' + jspResArr.get("FLT031317") + '</option>');
	write('<option value="A">' + jspResArr.get("FLT031309") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT031323") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT031340") + '</option>');
	write('<option value="X">' + jspResArr.get("FLT031341") + '</option>');

	write('</select>');
	write('</td>');
	write('<td class="textlabel" style="height: 15px; width: 248px">' + jspResArr.get("FLT031589") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtsolid" id="txtsolid" ' + cshareProps.get("txtsolid_ENABLED") + ' style="width: 210px" />');
	write('<input type="hidden" class="textfieldfont" name="' + subGroupName + '.testtxtcdsno" id="testtxtcdsno" ' + cshareProps.get("txtsolid_ENABLED") + ' style="width: 210px" />');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 193px">' + jspResArr.get("FLT031590") + '</td>');
	write('<td class="textfield" style="height: 30px">');
	write('<input type="text" onchange="fetchWithID()" class="textfieldfont" name="txtid" id="txtid"  style="width: 86px" />');
	write('<input type="text" onchange="fetchWithCDS()" class="textfieldfont" name="' + subGroupName + '.txtcdsno" id="txtcdsno" ' + cshareProps.get("txtcdsno_ENABLED") + ' style="width: 124px" />');
	write('</td>');
	write('<td class="textlabel" style="height: 15px; width: 193px">' + jspResArr.get("FLT031587") + '</td>');
	write('<td class="textfield" style="height: 30px">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtclientnames" id="txtclientnames" ' + cshareProps.get("txtclientnames_ENABLED") + ' style="width: 210px" />');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px; width: 193px">' + jspResArr.get("FLT031596") + '</td>');
	write('<td class="textfield" style="height: 30px">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtorderid" id="txtorderid" ' + cshareProps.get("txtorderid_ENABLED") + ' style="width: 210px" />');
	write('<a id="sLnk3" target=_self href="Javascript:Searchorderid()">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="13" height="13" border="0" hotKeyId="search2"></img>');
	write('</td>');
	write('<td class="textlabel" style="height: 15px; width: 193px">' + jspResArr.get("FLT025922") + '</td>');
	write('<td class="textfield" style="height: 30px">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtOrderdate" id="txtOrderdate" ' + cshareProps.get("txtOrderdate_ENABLED") + ' style="width: 210px" />');
	write('<input type="hidden"  class="textfieldfont" name="' + subGroupName + '.input4345" id="input4345" ' + cshareProps.get("txtcdsno_ENABLED") + ' style="width: 210px" />');	
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
	write('<div class="ctable">');
	write('<input id="Accept" name="Go" type="button" class="button"	onClick="javascript:return cshare_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
	write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"	onClick="javascript:return cshare_crit_ONCLICK2(this);"">');
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cshare_crit',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cshare_crit',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.funcCode.value = funcCode;
	ObjForm.txtsolid.value = txtsolid;
	ObjForm.txtcdsno.value = txtcdsno;
	ObjForm.txtclientnames.value = txtclientnames;
	ObjForm.txtorderid.value = txtorderid;
	ObjForm.txtOrderdate.value = txtOrderdate;

	ObjForm.txtorderid.disabled = true;
	ObjForm.txtOrderdate.disabled = true;




}


function cshare_crit_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cshare_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cshare_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cshare_crit_ONCLICK2(obj)
{
	var retVal = "";
	if (preEventCall('cshare_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnClearFields()) == false) {
		return false;
	}
	if (postEventCall('cshare_crit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fetchWithID()  
{

var x=document.getElementById("txtid");

if( x !==""){

 var inputNameValues ="idnumber|"+x.value;
  var outputNames     = "";
   var scrName         = "Fetch_Trading_id.scr";
    var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
     var ret1 = retVal.split("|");          
         if (ret1[1]=="s=Error, Err De")
		    {
			  alert("Invalid ID/Passport no:");			 
			  document.getElementById("txtcdsno").value="";	
			  document.getElementById("txtclientnames").value="";
			  document.getElementById("testtxtcdsno").value="";
			  document.getElementById("input4345").value="";
			  document.getElementById("txtid").value="";
			  document.getElementById("Accept").disabled=true;
			 
			  return false;

		       }
          else{
	          var Details=ret1[1].split(":")
			  var Names=Details[0];
		      var cdsno=Details[1];
		      var Account=Details[2];
			 
		   }
	    
}
    var cd=document.getElementById("txtcdsno");
    var n=document.getElementById("txtclientnames");    
	var cds=document.getElementById("testtxtcdsno");
	var Acc=document.getElementById("input4345");
	
		
		cd.value=cdsno;
         n.value=Names;
		 cds.value=cdsno;
		 Acc.value=Account;
 
	  document.getElementById("Accept").disabled=false;	

}

function fetchWithCDS() 
{

	var x=document.getElementById("txtcdsno");
       var cdscnolength =x.value.length;
	      if (cdscnolength !=15)
	      {
	      
             if (cdscnolength = 0 || cdscnolength > 15 )
             {
				  alert("Invalid Cdsc Number Length");				
				  return false;
             }

			 else  
			 {
				 var zeros="";
				 var remaininglenght =  15 - x.value.length ;
                 var topadd=remaininglenght-2;
                      for (var m=0;m<topadd ;m++ )
                      {
						  var padd="0";
                           zeros=padd+zeros;
                      }
					
				   var cdsval= zeros + x.value + "LI";
	
				 document.getElementById("txtcdsno").value=cdsval;
			 }
          }

 

if( x !==""){

 var inputNameValues ="cds|"+x.value;
  var outputNames     = "";
   var scrName         = "Fetch_Trading_CDS.scr";
    var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
     var ret1 = retVal.split("|"); 
       

		 if (ret1[1]=="s=Error, Err De")
		 {
			  alert("Invalid CDSC no:");			 
			  document.getElementById("txtcdsno").value="";	
			  document.getElementById("txtclientnames").value="";
			  document.getElementById("testtxtcdsno").value="";
			  document.getElementById("input4345").value="";
			  document.getElementById("txtid").value="";
			  document.getElementById("Accept").disabled=true;
			  return false;

		 }
           else{
	           var Details=ret1[1].split(":");
		      var Names=Details[0];
		      var iddet=Details[1];
		      var cdsno=Details[2];
		      var Account=Details[3];
		   }
	    
}   
    var id=document.getElementById("txtid");
    var n=document.getElementById("txtclientnames");    
	var cds=document.getElementById("testtxtcdsno");
	var Acc=document.getElementById("input4345");
	
		
	   	 id.value=Account;
         n.value=Names;
		 cds.value=cdsno;
		 Acc.value=Account;
		   document.getElementById("Accept").disabled=false;	

}

function SelectChange(){

 var val = document.getElementById("funcCode").value;

  if (val=="A")
  {
       document.getElementById("txtorderid").disabled=true;
       document.getElementById("txtOrderdate").disabled=true;
	   document.getElementById("txtid").disabled=false;
       document.getElementById("txtclientnames").disabled=false;
	   document.getElementById("txtcdsno").disabled=false;
	   document.getElementById("txtid").focus();
	   document.getElementById("sLnk3").disabled=true;
	   
  }

 else{
       document.getElementById("txtorderid").disabled=false;
       document.getElementById("txtOrderdate").disabled=false;
	   document.getElementById("txtid").disabled=true;
       document.getElementById("txtclientnames").disabled=true;
	   document.getElementById("txtcdsno").disabled=true;
	   document.getElementById("txtorderid").focus();
	    document.getElementById("sLnk3").disabled=false;
    }
}

function Searchorderid(){


    var inputNameValues = "orderid|396";
    var outputNameValues = "orderid|cdsc|custnames|status|code|sharetraded";
	var scriptName = "cshare_search_Orderid.scr";
	var listHeading = "List of Orders Placed Today";
    var colHeader = "Order ID|CDSC|Customer Names|Status|Shares Code|Shares Traded";
    var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",false)      
	var val= retVal.split("|");
	
	     document.getElementById("txtorderid").value = val[0];

		

		
}
