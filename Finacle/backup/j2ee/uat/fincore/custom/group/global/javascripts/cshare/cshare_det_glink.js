function printBlock()
{
	writeCustomHeader("cshare_det");
	with (document){
    if (txtcdsno =="" && txtclientnames=="" )
    {
		    txtcdsno=custcdscno;
			txtclientnames=custname;
    }   
   
	write('<input type="hidden" name="cshare.cdsno" id="cdsno">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031700") + '</td>');
	write('</tr>');
	write('</table>');
	write('<br>');
	write('</br>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031699") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + txtcdsno + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031585") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + txtclientnames + '</label>');
	write('</td>');
	write('</tr>');
	write('</table>');	
	write('<hr noshade size=1> ');

	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel" style="width: 107px">' + jspResArr.get("FLT031580") + '</td>');
	write('<td class="textfielddisplaylabel" style="width: 193px">');
	write('<input type="text" readOnly = true class="textfieldfont" name="' + subGroupName + '.txtdetorderno" id="txtdetorderno" ' + cshareProps.get("txtdetorderno_ENABLED") + ' style="width: 182px">');
	write('</td>');
	write('<td class="textlabel" style="width: 107px">' + jspResArr.get("FLT007251") + '</td>');
	write('<td class="textfielddisplaylabel" style="width: 150px">');
	write('<input type="text"readOnly = true class="textfieldfont" name="' + subGroupName + '.txtbranch" id="txtbranch" ' + cshareProps.get("txtbranch_ENABLED") + ' style="width: 179px">');
	write('</td>');
	write('<td class="textlabel" style="width: 107px">' + jspResArr.get("FLT000625") + '</td>');
	write('<td class="textfielddisplaylabel" style="width: 102px">');
	write('<input type="text" readOnly = true class="textfieldfont" name="' + subGroupName + '.txtcreatedby" id="txtcreatedby" ' + cshareProps.get("txtcreatedby_ENABLED") + ' style="width: 156px">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="width: 107px">' + jspResArr.get("FLT025922") + '</td>');
	write('<td class="textfielddisplaylabel" style="width: 193px">');
	write('<input type="text" readOnly = true class="textfieldfont" name="' + subGroupName + '.txtdetorderdate" id="txtdetorderdate" ' + cshareProps.get("txtdetorderdate_ENABLED") + ' style="width: 182px">');
	write('</td>');
	write('<td class="textlabel" style="width: 89px">' + jspResArr.get("FLT019099") + '</td>');
	write('<td class="textfielddisplaylabel" style="width: 209px">');
	write('<input type="text" readOnly = true class="textfieldfont" name="' + subGroupName + '.txtordertype" id="txtordertype" ' + cshareProps.get("txtordertype_ENABLED") + ' style="width: 179px ">');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<hr noshade size=1> ');

	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<h5 style="height: 11px">Order Details</h5>');
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
	write('<a href="javascript:showHelpFile(\'det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');




	  if (TranType=="Add")
    {
    write('<table border="0" id="SharesTable"  cellpadding="0" cellspacing="0" width="100%">');
    write('<thead>');
    write('<tr>');
    write('<th style="background:#C0C0C0 text-align:left;padding:.2em;border:1px solid #fff"> Check');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.2em;border:1px solid #fff"> No.');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.5em;border:1px solid #fff"> Security Code');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.5em;border:1px solid #fff"> Security Name');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.5em;border:1px solid #fff"> Holdings');
	write('</th>');
	 write('<th style="background:#C0C0C0 text-align:left;padding:.5em;border:1px solid #fff"> Quantity');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.5em;border:1px solid #fff"> Asking Price');
	write('</th>');
	 write('<th style="background:#C0C0C0 text-align:left;padding:.5em;border:1px solid #fff"> Total');
	write('</th>');
    write('</tr>');
    write('</thead>'); 
	write('<tfoot>');
	 write('<tr>');
	write('<td> ');
	write('</td>');
	 write('<td> ');
	write('</td>');
	 write('<td> ');
	write('</td>');
	 write('<td> ');
	write('</td>');
	 write('<td> ');
	write('</td>');
	 write('<td > ');
	write('</td>')
	write('<td > ');
    write('<input id="Add"  onClick="calculateTotal()"  value ="Total Amount" name="Add" type="button" class="button">');
	write('</td>');
	write('<td>');
    write('<input type="text" class="textfieldfont" id="txtTotalAmount" name="txtTotalAmount" style="width: 153px">');
	write('</td>');
    write('</tr>');
    write('</tfoot>');
    write('<tbody>');
	write('</tbody>');
    write('</table>');
	}

	else if (TranType=="Verify")
	{

    write('<table border="0" id="VerificationSharesTable"  cellpadding="0" cellspacing="0" width="100%">');
    write('<thead>');
    write('<tr>');
    write('<th style="background:#C0C0C0 text-align:left;padding:.1em;border:1px solid #fff"> Check');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.1em;border:1px solid #fff"> No.');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Serial No.');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Code');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Holdings');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Share Traded');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Holding Bal');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Selling Price');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Amount');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Tran Date');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Tran Status');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Posted By');
	write('</tr>');
    write('</thead>'); 
    write('<tbody>');
	write('</tbody>');
    write('</table>'); 
	}

 	else if (TranType=="Inquiry")
	{ 
    write('<table border="0" id="InquitySharesTable"  cellpadding="0" cellspacing="0" width="100%">');
    write('<thead>');
    write('<tr>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.1em;border:1px solid #fff"> No.');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.2em;border:1px solid #fff"> Serial No.');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.2em;border:1px solid #fff"> Code');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Holdings');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Share Traded');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Holding Bal');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Selling Price');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Amount');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Tran Date');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Tran Status');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Posted By');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Verified By');
	write('</tr>');
    write('</thead>'); 
    write('<tbody>');
	write('</tbody>');
    write('</table>'); 
    }

	else if (TranType=="Cancell")
	{ 
    write('<table border="0" id="InquitySharesTable"  cellpadding="0" cellspacing="0" width="100%">');
    write('<thead>');
    write('<tr>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.1em;border:1px solid #fff"> No.');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.2em;border:1px solid #fff"> Serial No.');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.2em;border:1px solid #fff"> Code');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Holdings');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Share Traded');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Holding Bal');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Selling Price');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Amount');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Tran Date');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Tran Status');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Posted By');
	write('</th>');
	write('<th style="background:#C0C0C0 text-align:left;padding:.3em;border:1px solid #fff"> Verified By');
	write('</tr>');
    write('</thead>'); 
    write('<tbody>');
	write('</tbody>');
    write('</table>'); 
    }


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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="preValidate(this,this)"  value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cshare_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cshare_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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

	pre_ONLOAD('cshare_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cshare_det',this);
}
 
function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.txtdetorderno.value = txtdetorderno;
	ObjForm.txtbranch.value = txtbranch;
	ObjForm.txtcreatedby.value = txtcreatedby;
	ObjForm.txtdetorderdate.value = txtdetorderdate;
	ObjForm.txtordertype.value = txtordertype;

    if (TranType=="Add")

    {
		
      populateshare();
    }
     else if (TranType=="Verify")
		
	  
	 {

		 if (status=="Success")
		     {
			  
		 
           var serial=SERIALNUM.split(":");
		   var code= CODE.split(":");
		   var holdings =HOLDINGS.split(":");
		   var sharetraded=SHARESTRADED.split(":");
           var holdbal =HOLDINGBAL.split(":");
		   var sellprice =SELLINGPRICE.split(":");
		   var amount = AMOUNT.split(":");
		   var transtatus=TRANSSTATUS.split(":");
           var name=ENTEREDBY;

    

		   k=recnumber;
          for(var m=0;m<recnumber;m++){		     
		       populateVerificationTable(k,serial[m],code[m],holdings[m],sharetraded[m],holdbal[m],sellprice[m],amount[m],TRANDATE,transtatus[m],name);
		        k--;
              }	
  
	    	 }

          else {
			  var table=document.getElementById("VerificationSharesTable");
              var rowCount =table.rows.length;
              var row = table.insertRow(1);
              var cell1=row.insertCell(0);
                  cell1.innerHTML=status;

		     }

	 }

    else if (TranType=="Inquiry"){
     
    var serial=SERIALNUM.split(":");
		   var code= CODE.split(":");
		   var holdings =HOLDINGS.split(":");
		   var sharetraded=SHARESTRADED.split(":");
           var holdbal =HOLDINGBAL.split(":");
		   var sellprice =SELLINGPRICE.split(":");
		   var amount = AMOUNT.split(":");
		   var transtatus=TRANSSTATUS.split(":");
           var name=ENTEREDBY;
           var verifiedby= VERIFIEDBY;

        k=recnumber;
          for(var m=0;m<recnumber;m++){		     
		       populateInquiryTable(k,serial[m],code[m],holdings[m],sharetraded[m],holdbal[m],sellprice[m],amount[m],TRANDATE,transtatus[m],name,verifiedby);
		        k--;
          }	
	}

	else if (TranType=="Cancell"){
     
    var serial=SERIALNUM.split(":");
		   var code= CODE.split(":");
		   var holdings =HOLDINGS.split(":");
		   var sharetraded=SHARESTRADED.split(":");
           var holdbal =HOLDINGBAL.split(":");
		   var sellprice =SELLINGPRICE.split(":");
		   var amount = AMOUNT.split(":");
		   var transtatus=TRANSSTATUS.split(":");
           var name=ENTEREDBY;
           var verifiedby= VERIFIEDBY;

        k=recnumber;
          for(var m=0;m<recnumber;m++){		     
		       populateInquiryTable(k,serial[m],code[m],holdings[m],sharetraded[m],holdbal[m],sellprice[m],amount[m],TRANDATE,transtatus[m],name,verifiedby);
		        k--;
          }	
	}


}
  
  function preValidate(obj,obj1){
  
  if (TranType=="Add"){
       SaveShareDetails();
	   var ret= cshare_det_ONCLICK1(obj,obj1);
  } else if (TranType=="Verify")
		 {
	       var ret= cshare_det_ONCLICK1(obj,obj1);
		 }
     else if (TranType=="Cancell")
		 {
	       var ret= cshare_det_ONCLICK1(obj,obj1);
		 }
    
  }

function cshare_det_ONCLICK1(obj,p1)
{

	
	var retVal = "";
	if (preEventCall('cshare_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cshare_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cshare_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cshare_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('cshare_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cshare_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cshare_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cshare_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}


function showModuleList(){
	var ObjForm = document.forms[0];
	var inputNameValues = "cdsnumber|0000001100882LI";
    var outputNameValues = "test1|test2|test3|test4";
	var scriptName = "Fetch_Trading_Holdings.scr";
	var listHeading = "List of Shares";
    var colHeader = "Count|Share code|Share Desc|Holdings";
    var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",false)



	var val= retVal.split("|");
    displayResult(val[0],val[1],val[2],val[3]);

}

function displayResult(no,code,name,hold)
{


var table=document.getElementById("SharesTable");

var rowCount =table.rows.length;
var row = table.insertRow(1);



var cell1=row.insertCell(0);
var cell2=row.insertCell(1);
var cell3=row.insertCell(2);
var cell4=row.insertCell(3);
var cell5=row.insertCell(4);
var cell6=row.insertCell(5);
var cell7=row.insertCell(6);
var cell8=row.insertCell(7);

cell2.innerHTML=no;
cell3.innerHTML=code;
cell4.innerHTML=name;
cell5.innerHTML=hold;


 
  var element1 = document.createElement("input");
        element1.type = "checkbox";
        element1.name="chkbox:"+no;
        element1.onclick=Check;
        cell1.appendChild(element1);


  var element2 = document.createElement("input");
       element2.id="qty:"+[no];
	   element2.type='text';
	   element2.disabled=true;
	   element2.onchange = QtyTotal;
       cell6.appendChild(element2);


 var element3 = document.createElement("input");
     element3.id="askp:"+[no];
	 element3.type='text';
	 element3.disabled=true;
	 element3.onchange = Asptotal;
     cell7.appendChild(element3);

var TotalAmt = document.createElement("input");
   
     TotalAmt.id="total:"+[no];
	 TotalAmt.type='text';
	 TotalAmt.readOnly = true;
    cell8.appendChild(TotalAmt);



	 
}

function RemoveModuleList(){
var table=document.getElementById("myTable");

}

function populateshare(){
  

  var output= CustDet.split(",");  
  
  
  if (output=="Error")
  {
    var table=document.getElementById("SharesTable");
     var rowCount =table.rows.length;
      var row = table.insertRow(1);
       var cell1=row.insertCell(0);
       cell1.innerHTML="Customer Holds NO Shares";
       document.getElementById("Submit").disabled=true;
	   document.getElementById("Validate").disabled=true;

  }else{
       var k =recnumber;
         
		  var a =isNaN(k);
		    if(a){
                var num= k.substring(1,2)
					
                  recnumber=num;
			}
		 k=recnumber;
	  for(var m=0;m<recnumber;m++)

			{ 
		         
				 var  output2=output[m].split(":");		     
		             displayResult(k,output2[0],output2[1],output2[2]); 
					 k--;
                    
		}
          
  }	

   
}
function Check(){
 var rowNum = this.name.split(":")[1];
if(null != this && true == this.checked) {                     
    document.getElementById("qty:"+[rowNum]).disabled=false;
    document.getElementById("askp:"+[rowNum]).disabled=false;
    document.getElementById("qty:"+[rowNum]).focus();
   }
   else{ 
	   document.getElementById("qty:"+[rowNum]).value="";
      document.getElementById("askp:"+[rowNum]).value="";
	  document.getElementById("total:"+[rowNum]).value="";
	  document.getElementById("qty:"+[rowNum]).disabled=true;
      document.getElementById("askp:"+[rowNum]).disabled=true;
	   
	   }

 
}


function calculateTotal(){

 try {

      var table=document.getElementById("SharesTable"); 
       var rowCount = table.rows.length ; 
	    var sum =0;
	
	            for(var i=0; i<rowCount; i++) {
                var row = table.rows[i];
                var chkbox = row.cells[0].childNodes[0];
                if(null != chkbox && true == chkbox.checked) {
                     sum += parseInt(document.getElementById("total:"+[i]).value);
                }
 
 
            }


    
var table=document.getElementById("txtTotalAmount").value=sum;

 }catch(e) {alert(e);}
}

function deleteRow() {
            try {
           
			var table=document.getElementById("SharesTable");
            var rowCount = table.rows.length;
 
            for(var i=0; i<rowCount; i++) {
                var row = table.rows[i];
                var chkbox = row.cells[0].childNodes[0];
                if(null != chkbox && true == chkbox.checked) {
                    table.deleteRow(i);
                    rowCount--;
                    i--;
                }
 
 
            }
            }catch(e) {
                alert(e);
            }
        }

function Asptotal(){

try {

	var val = this.id;
    var rowNum = val.split(":")[1] ;
    var AskPrice = this.value;
  

var qty = document.getElementById("qty:"+[rowNum]).value

if (qty !=null)
   {
	  var total =  qty  * AskPrice;
   }else{ 
	   var total = 0;
   }

document.getElementById("total:"+[rowNum]).value=total;
}catch(e) {  alert(e); }
}

function QtyTotal(){


try {
   var val = this.id;
   var rowNum = val.split(":")[1] ;
   var AskPrice = document.getElementById("askp:"+[rowNum]).value
   var holdings =parseInt(document.getElementById("SharesTable").rows[rowNum].cells[4].innerHTML);
    

var qty = parseInt(this.value);

 if (qty > holdings)
 {
	  alert("Quantity Cannot be Greater than Clients Holdings");
	  document.getElementById("qty:"+[rowNum]).value=0;
	  var total = 0;
 }else{


 if (AskPrice !=null)
   {
	  var total =  qty  * AskPrice;
   }else{
     var total = 0;
   }
	
	  }

document.getElementById("total:"+[rowNum]).value=total; 
   }catch(e) { alert(e);  }
}





function SaveShareDetails(){
var code = new Array(); 
var holdings = new Array(); 
var sharesTraded = new Array(); 
var sellingPrice = new Array(); 
var amount = new Array(); 
var Bal = new Array(); 
var Acct;

 try {
            
			var table=document.getElementById("SharesTable");
            var rowCount = table.rows.length;
            var count=0;
            for(var i=0; i<rowCount; i++) {
                var row = table.rows[i];
                var chkbox = row.cells[0].childNodes[0];
                if(null != chkbox && true == chkbox.checked) {                               
				 
					  code[count]=row.cells[2].innerHTML;
					  holdings[count]= row.cells[4].innerHTML;
					  sharesTraded[count]=row.cells[5].childNodes[0].value;
					  sellingPrice[count]=row.cells[6].childNodes[0].value;
					  amount[count]=row.cells[7].childNodes[0].value;
					  Bal[count]=parseInt(holdings[count])- parseInt(sharesTraded[count]);
                 
				                   
					count ++ ;

					
                }
            }




var kcode="";
var kholdings="";
var kshareTraded="";
var kHoldingBal="";
var ksellingPrice="";
var kamount="";

     for (var i=0; i< code.length; i++){
            kcode = "code"+[i]+"|"+code[i]+"|" + kcode;
			kholdings="holdings"+[i]+"|"+holdings[i]+"|" + kholdings;
			kshareTraded="sharesTraded"+[i]+"|"+sharesTraded[i]+"|" + kshareTraded;
			kHoldingBal="Bal"+[i]+"|"+Bal[i]+"|" + kHoldingBal;
			ksellingPrice="sellingPrice"+[i]+"|"+sellingPrice[i]+"|" + ksellingPrice;
			kamount="amount"+[i]+"|"+amount[i]+"|" + kamount;
			
	   }

var rec="NoRec|"+code.length;
var acc="|AccNumber|"+AcctNumber;
var trxndate="|Trxndate|"+trxdate
var serialnum ="|SerialNum|"+ document.getElementById("txtdetorderno").value;
var clientnames="|clientnames|"+txtclientnames
var cdsnum="|cdscnumber|"+txtcdsno

var inputNameValues =kcode+kholdings+kshareTraded+kHoldingBal+ksellingPrice+kamount+rec+acc+serialnum+trxndate+clientnames+cdsnum;
  var outputNames     = "";
 var scrName         = "Save_Trading.scr";
  var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);		
			



			}catch(e) {
                alert(e);
            }
       
}


function populateVerificationTable(no,serial,code,holding,shareTraded,holdbal,sellprice,amt,trandate,transtatus,name){


var table=document.getElementById("VerificationSharesTable");

var rowCount =table.rows.length;
var row = table.insertRow(1);



var cell1=row.insertCell(0);
var cell2=row.insertCell(1);
var cell3=row.insertCell(2);
var cell4=row.insertCell(3);
var cell5=row.insertCell(4);
var cell6=row.insertCell(5);
var cell7=row.insertCell(6);
var cell8=row.insertCell(7);
var cell9=row.insertCell(8);
var cell10=row.insertCell(9);
var cell11=row.insertCell(10);
var cell12=row.insertCell(11);

cell2.innerHTML=no;
cell3.innerHTML=serial;
cell4.innerHTML=code;
cell5.innerHTML=holding;
cell6.innerHTML=shareTraded;
cell7.innerHTML=holdbal;
cell8.innerHTML=sellprice ;
cell9.innerHTML=amt ;
cell10.innerHTML=trandate;
cell11.innerHTML=transtatus;
cell12.innerHTML=name;


 
  var element1 = document.createElement("input");
        element1.type = "checkbox";
        element1.name="chkbox:";
        element1.onclick=Check;
        cell1.appendChild(element1);


 

}

function populateInquiryTable(no,serial,code,holding,shareTraded,holdbal,sellprice,amt,trandate,transtatus,name,verifiedby){


var table=document.getElementById("InquitySharesTable");

var rowCount =table.rows.length;
var row = table.insertRow(1);



var cell1=row.insertCell(0);
var cell2=row.insertCell(1);
var cell3=row.insertCell(2);
var cell4=row.insertCell(3);
var cell5=row.insertCell(4);
var cell6=row.insertCell(5);
var cell7=row.insertCell(6);
var cell8=row.insertCell(7);
var cell9=row.insertCell(8);
var cell10=row.insertCell(9);
var cell11=row.insertCell(10);
var cell12=row.insertCell(11);
var cell13=row.insertCell(12);

cell1.innerHTML=no;
cell2.innerHTML=serial;
cell3.innerHTML=code;
cell4.innerHTML=holding;
cell5.innerHTML=shareTraded;
cell6.innerHTML=holdbal;
cell7.innerHTML=sellprice ;
cell8.innerHTML=amt ;
cell9.innerHTML=trandate;
cell10.innerHTML=transtatus;
cell11.innerHTML=name;
cell12.innerHTML=verifiedby;

  

}
