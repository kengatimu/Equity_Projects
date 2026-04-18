<script type="text/javascript">
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
        write('<table width="100%" border="0" cellpadding="4" cellspacing="5" class="innertabletop1">');
        write('<tr>');
        write('<td class="textlabel">PAYMENT ORDER NUMBER</td>');
        write('<td>');
        write('<input class="textfieldamount" type="text" name="pordnum" id="pordnum" align="right" size="2" maxlength="30">&nbsp;&nbsp;');
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

        
//Ebl customization Start 

   if(mopId == "HPORDM")
        {
			function pordmcrit_post_ONCHANGE(obj)
			{
				//alert(document.forms[0].funcCode.value)
				if (document.forms[0].funcCode.value=="")
				{
						//alert("PLEASE SELECT FUCTION CODE");
							document.forms[0].pymtRefNum.disabled=true;
							document.forms[0].orderType.disabled=false;
							document.forms[0].funcCode.focus();
							return false;
				}
				else
				{
					if ((profileId == 55) && (document.forms[0].funcCode.value=="A"))
					{
						document.forms[0].pymtRefNum.disabled=false;
					}
					else
					{
						document.forms[0].pymtRefNum.disabled=true;
						document.forms[0].orderType.disabled=false;
					}
				}
			}
			function pordmcrit_pre_ONCLICK(obj)
			{
				//alert(obj.id);
				if (obj.id=="Accept")
					{
						//alert(document.forms[0].funcCode.value);
						if (document.forms[0].funcCode.value!="A") 
							{ 
								document.forms[0].pymtRefNum.disabled=true;
								document.forms[0].orderType.disabled=false;
								if (document.forms[0].pordnum.value =="")
								{
									alert("PLEASE ENTER  PAYMENT ORDER NUMBER");
									document.forms[0].pordnum.focus();
									return false;
								}
								else
								{
									if (document.forms[0].funcCode.value!="I")
									{
									
										//alert(document.forms[0].pordnum.value);
										var	dco=document.forms[0].pordnum.value;				
										var input      = "dco|"+dco;
										var outputNames    = "output|outVal";
										var scrName     =   "b_pordcrit.scr";					
										var retVal = appFnExecuteScript(input,outputNames,scrName,false);							
										var retBuff = retVal.split("|");
										var output = retBuff[0];
										var value = retBuff[1];
										
										var a = value;
										if( output != "output")
										{
											alert(a);
										}
										else
										{
											//alert(a);
											//alert("try script_end2");
											if (a!="")
											{
												document.forms[0].pymtRefNum.value = a ;
												//alert(document.forms[0].pymtRefNum.value);
											}
										}
									}
									else 
										if (document.forms[0].funcCode.value=="I")
										{
										document.forms[0].pymtRefNum.value=document.forms[0].pordnum.value;
										}
								}
							}
						if ((profileId =="55") && (document.forms[0].funcCode.value=="A"))
							//if (document.forms[0].funcCode.value=="A")
							{
								//alert(document.forms[0].pordnum.value);
								var controlnum=document.forms[0].pordnum.value;
								//alert(controlnum);
								document.forms[0].pymtRefNum.value=controlnum;
								var pymtRefNum=document.forms[0].pymtRefNum.value;

								var input = "controlnum|" + controlnum;
								//var inputNameValues = "applcntNo" + "|" + remitInfo1;
								var outputNames = "";
								//var scrName = "b_pordcritnumval.scr";
								//alert("B4 calling Script");
								var scrName     =   "b_pordcritnumval.scr";
								//alert("After calling Script");
								var retVal = appFnExecuteScript(input,outputNames,scrName,false);
								var ret = retVal.split("|");
								//alert(ret);
								var a = ret[1];
								if(ret[0] == "MSG1"){	
									//alert(a);
									//alert("its ok");
									}
									if (a=="CONTROL NUMBER ALREADY USED")
									{
										alert(a);
										document.forms[0].pordnum.focus();
										return false;
									}
										

									setFieldsToCustomData("pymtRefNum");

							}
					}

					
			}
		}
//Ebl customization Start 
</script>
