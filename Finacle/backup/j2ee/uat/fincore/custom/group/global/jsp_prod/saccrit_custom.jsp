<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : saccrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 20-05-2013
<!--Author            : charles
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HSAC
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		20-05-2013	charles		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function saccrit_pre_ONCLICK(obj)
{
  
	if((obj.id=="Accept") || (obj.id=="Validate"))
	{
	     
			if (document.forms[0].funcCode.value=="D")
			{
			
					var	dco=document.forms[0].funcCode.value;
					var	dcco=document.forms[0].usrId.value.toUpperCase();
					var input      = "dco|"+dco+"|dcco|"+dcco;
					var outputNames    = "output|outVal";
					var outputNames    = "output2|outVal";
					var outputNames    = "output4|outVal";
					var scrName     =   "b_hsacebl.scr";
	
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					var retBuff = retVal.split("|");
					var output = retBuff[2];
					var value = retBuff[3];
					var b = value;
					//alert(b);
					var retBuff = retVal.split("|");
					var output = retBuff[4];
					var value = retBuff[5];
					var c = value;
					//alert(c);
					var retBuff = retVal.split("|");
					var output = retBuff[6];
					var value = retBuff[7];
					var d = value;
					//alert(d);
					//alert("try script_end2")

				if (profileId!="54" && a>"500" )
					{
					//alert(profileId);
					document.forms[0].solSetId.disabled=false;
						if (document.forms[0].usrId.value=="")
						{
						alert("Please enter User id...Batch Delete Not Allowed");
						document.forms[0].usrId.focus();
						return false;
						}
							//alert("in!");
							if (d=="YES" && profileId="54")
							{
								//alert("enabled");
							 else
								alert("Not allowed to delete the user");
								document.forms[0].usrId.focus();
								return false;
							}
					}

				if (a>"500")
				{
					//alert("why in");
					document.forms[0].solSetId.disabled=false;
					if (document.forms[0].solSetId.disabled==false)
					{
						//alert("enabled");
					}
					
				}
				if (a<"500")
				{
					if (document.forms[0].usrId.value=="")
					{
						alert("Please enter User id...Batch Delete Not Allowed");
						document.forms[0].usrId.focus();
						return false;
					}
					else 
					{	
						if (d=="YES")
						{
							alert("Not allowed to delete the user");
							document.forms[0].usrId.focus();
							return false;
						}
						  else
						       {
						         if (b!=c)
					                {
						               alert("Inter_Sol User Delete not allowed");
						               document.forms[0].usrId.focus();
						                return false;
					                 }
					           }	
					    }
					
					
//					var	dcco=document.forms[0].usrId.value;
//						//alert(document.forms[0].usrId.value);
//						var input      = "dcco|"+dcco;
//						var outputNames    = "output3|outVal";
//						var scrName     =   "b_hsacebl.scr";
//						//alert("before script");
//						var retVal = appFnExecuteScript(input,outputNames,scrName,false);
//						//alert("after script");
//							var retBuff = retVal.split("|");
//							var output = retBuff[4];
//							var value = retBuff[5];
//							var c = value;
//							if ((document.forms[0].solSetId.value!=c) && (dcco!="BJMS54") && (dcco!="BJMS43") && (dcco!="BJMS50") && (dcco!="BJMS56") && (dcco!="BJMS55") && (dcco!="BJMS11") && (dcco!="CDCI11") && (dcco!="CDCI50") && (dcco!="CDCI55") && (dcco!="CDCI56") && (dcco!="CDCI54") && (dcco!="CDCI43") && (dcco!="BS02317") && (dcco!="JM03645") && (dcco!="JA03291") && (dcco!="TK07747") && (dcco!="JM01904"))
//							{
//								alert("INTER_SOL CLEARING OF USERS NOT ALLOWED");
//								document.forms[0].usrId.select();
//								document.forms[0].usrId.focus();
//								return false;
//							}
//					}
				
				}
			}
	}
}

</script>
