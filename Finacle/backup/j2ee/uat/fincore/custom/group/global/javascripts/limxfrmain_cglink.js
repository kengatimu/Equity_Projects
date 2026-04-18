function printFunctionBlock(){
    with(document){

    write('<html>');

    write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
    write('<tr>');
    write('<td>');
    write('&nbsp;');
    write('</td>');
    write('</tr>');
    write('</table>');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
    write('<tr>');
    write('<td>');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
    write('<tr>');
    write('<td class="textlabel">&nbsp&nbsp<b>Purpose</b></td>');
    write('<td class="textfield">')
    write('<input class="textfieldfont" type="text" size="15" maxlength="15"  name="REFCODE" id="REFCODE" >');
	write('&nbsp; <a href=\"javascript:showModuleList()">');
	write('<img class="img" border="0" height="17" src="../Renderer/images/search_icon.gif" width="16" hotKeyId="search1"');
    write('</a>');
	write('</td>');
    write('</tr>');
    write('</table>');
    write('</td>');
    write('</tr>');
    write('</table>');
				}
						}


function showModuleList()
{
		//var	dco="D"
		//alert(dco);
		
		//alert("check");
      var ObjForm = document.forms[0];
	  //alert(ObjForm.REFCODE.value);
      var inputNameValues = "REFCODE|"+ObjForm.REFCODE.value;
	// alert("t1");
      var outputNameValues = "REFCODE|REFDESC";
	  	  //alert("t2");
      var scriptName = "b_purpose.scr";
	  	// alert("t3");
      var listHeading = "Module List";
      var colHeader = "Module ID|Module Description";
		//alert("t4");
      var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true)

			//alert("value");
}

function limxfrmain_pre_ONLOAD(obj)
{


      //alert("hello onload"); 
	  getFieldsFromCustomData("REFCODE"); 

        return true;
}

function limxfrmain_pre_ONCLICK(obj)
{


      //alert("hello on click");
      setFieldsToCustomData("REFCODE"); 

        return true;
}



                                          
