<!---------------------------------------------------------------------------------------------------------------->
<!--Name              :document_details_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 24-08-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HOAACLA,HOAACCL
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		24-08-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function document_details_post_ONLOAD(obj)
		{
	
	  if ((mopId=="HOAACCL") || (mopId=="HOAACLA"))
			{
			   document.forms[0].docScanFlg.value="N";
			   document.forms[0].docFreeText1.disabled=true;  
			   //document.forms[0].docFreeText2.value="S";
			}
		}

function isValidAmount(str){
	
    for (i=0; i<str.length; i++)
        {
                var validChars = "0123456789,";
                if((validChars.indexOf(str.charAt(i)) == -1))
                {
						//alert("Invalid Phone No");
                        return false;
                }
    }
	return true;
	
}

/*function isValidDate(str){

    SimpleDateFormat sdf = new SimpleDateFormat(dd/MM/yyyy);
    date = sdf.parse(value);
    if (!value.equals(sdf.format(date)))
		{
        date = null;

		if (date == null) 
			{
				return false;
			}
		}
}*/

function document_details_pre_ONCLICK(obj)
		{
			if ((mopId=="HOAACCL") || (mopId=="HOAACLA"))
			{
				doccode=document.forms[0].docCode.value;
				//alert(doccode);
			if ((doccode=="CR001")||(doccode=="CR002")||(doccode=="CR003")||(doccode=="CR004")||(doccode=="CR005")||(doccode=="CR006")||(doccode=="CR007")||(doccode=="CR008")||(doccode=="CR009")||(doccode=="CR0010"))
				{
					
					if((obj.id=="Validate")|| (obj.id =="Submit"))
					{
						 //alert("Enter S-secured or N-Not secured");
						if (fnIsNull(document.forms[0].docFreeText2.value))
						{
							//document.forms[0].docFreeText2.value="S"; 
							 alert("Enter S-secured or N-Not secured");
							 document.forms[0].docFreeText2.focus();
							 return false;
							 
						} 

						if ((document.forms[0].docFreeText2.value!="S")&&(document.forms[0].docFreeText2.value!="N"))
							 {
								alert("Enter S-secured or N-Not secured");
								document.forms[0].docFreeText2.focus();
								return false;
							 }

						if (document.forms[0].docFreeText2.value=="S")
						{
							if (fnIsNull(document.forms[0].docFreeText3.value))
							{
								//document.forms[0].docFreeText2.value="S"; 
								 alert("Enter Collateral details");
								 document.forms[0].docFreeText3.focus();
								 return false;
							}

							if (fnIsNull(document.forms[0].docFreeText4.value))
							{
								//document.forms[0].docFreeText2.value="S"; 
								 alert("Enter Collateral Valuation date in this format(dd/mm/yyyy)");
								 //fnSetFocusForDate(document.forms[0].docFreeText4.value);
								 document.forms[0].docFreeText4.focus();
								 return false;
							}

							if (fnIsNull(document.forms[0].docFreeText5.value))
							{
								//document.forms[0].docFreeText2.value="S";
								 alert("Enter Collateral Market Value in this format(000,000,000)");
								 document.forms[0].docFreeText5.focus();
								 return false;
							}
							else
							{
								if(!isValidAmount(document.forms[0].docFreeText5.value))
								{
									alert("Enter 11 Collateral Market Value in this format(000,000,000)");
									document.forms[0].docFreeText5.focus();
									return false;
								}

							}

							if (fnIsNull(document.forms[0].docFreeText6.value))
							{
								//document.forms[0].docFreeText2.value="S"; 
								 alert("Enter Collateral Forced Value in this format(000,000,000)");
								 document.forms[0].docFreeText6.focus();
								 return false;
							}
							else
							{
								if(!isValidAmount(document.forms[0].docFreeText6.value))
								{
									alert("Enter Collateral Market Value in this format(000,000,000)");
									document.forms[0].docFreeText6.focus();
									return false;
								}

							}

							if (fnIsNull(document.forms[0].docFreeText7.value))
							{
								//document.forms[0].docFreeText2.value="S"; 
								 alert("Enter Collateral Charged Value in this format(000,000,000)");
								 document.forms[0].docFreeText7.focus();
								 return false;
							}
							else
							{
								if(!isValidAmount(document.forms[0].docFreeText7.value))
								{
									alert("Enter Collateral Market Value in this format(000,000,000)");
									document.forms[0].docFreeText7.focus();
									return false;
								}

							}

							if (fnIsNull(document.forms[0].docFreeText8.value))
							{
								//document.forms[0].docFreeText2.value="S"; 
								 alert("Enter Valuer");
								 document.forms[0].docFreeText8.focus();
								 return false;
							}
							

							/*if(!isValidDate(document.forms[0].docFreeText4.value))
								{
									alert("Enter Collateral Valuation date in this format(dd/mm/yyyy)");
									document.forms[0].docFreeText4.focus();
									return false;
								}*/
						}
					}
				}
			}

		}

function document_details_pre_TAB_SWITCH(obj)
		{
			if ((mopId=="HOAACCL") || (mopId=="HOAACLA"))
			{

				doccode=document.forms[0].docCode.value;
				//alert(doccode);
			if ((doccode=="CR001")||(doccode=="CR002")||(doccode=="CR003")||(doccode=="CR004")||(doccode=="CR005")||(doccode=="CR006")||(doccode=="CR007")||(doccode=="CR008")||(doccode=="CR009")||(doccode=="CR0010"))
				{
					 //alert("Enter S-secured or N-Not secured");
					if (fnIsNull(document.forms[0].docFreeText2.value))
					{
						//document.forms[0].docFreeText2.value="S"; 
						 alert("Enter S-secured or N-Not secured");
						 document.forms[0].docFreeText2.focus();
						 return false;
					} 

					if (document.forms[0].docFreeText2.value=="S")
					{
						if (fnIsNull(document.forms[0].docFreeText3.value))
						{
							//document.forms[0].docFreeText2.value="S"; 
							 alert("Enter Collateral details");
							 document.forms[0].docFreeText3.focus();
							 return false;
						}

						if (fnIsNull(document.forms[0].docFreeText4.value))
						{
							//document.forms[0].docFreeText2.value="S"; 
							 alert("Enter Collateral Valuation date");
							 document.forms[0].docFreeText4.focus();
							 return false;
						}

						if (fnIsNull(document.forms[0].docFreeText5.value))
						{
							//document.forms[0].docFreeText2.value="S"; 
							 alert("Enter Collateral Market Value");
							 document.forms[0].docFreeText5.focus();
							 return false;
						}

						if (fnIsNull(document.forms[0].docFreeText6.value))
						{
							//document.forms[0].docFreeText2.value="S"; 
							 alert("Enter Collateral Forced Value");
							 document.forms[0].docFreeText6.focus();
							 return false;
						}

						if (fnIsNull(document.forms[0].docFreeText7.value))
						{
							//document.forms[0].docFreeText2.value="S"; 
							 alert("Enter Collateral Charged Value");
							 document.forms[0].docFreeText7.focus();
							 return false;
						}

						if (fnIsNull(document.forms[0].docFreeText8.value))
						{
							//document.forms[0].docFreeText2.value="S"; 
							 alert("Enter Valuer");
							 document.forms[0].docFreeText8.focus();
							 return false;
						}
					}

				}

			}

		}

function document_details_pre_ONLOAD(obj)
		{
		if ((mopId=="HOAACCL") || (mopId=="HOAACLA") || (mopId=="HOAACCA") || (mopId=="HOAACSB"))
			{
			document.forms[0].chkdocumentdetails.checked=true;
			document.forms[0].chkdocumentdetails.disabled=true;
			//document.forms[0].chkdocumentdetails.mandatory=true;
			document.getElementById('chkdocumentdetails').readOnly=true;
			//document.getElementById('chkdocumentdetails').disabled=true;
			//document.getElementById('chkdocumentdetails').checked=true;  
			}
		}

</script>
