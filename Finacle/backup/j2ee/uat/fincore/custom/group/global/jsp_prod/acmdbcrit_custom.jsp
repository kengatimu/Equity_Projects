<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : acmdbcrit_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This is used to pass
<!--                      the values
<!--Date                : 24-05-2018
<!--Author              : Khan
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HACMDB
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1			24/05/2018			 Jane			Modified for TOL 
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript">

function acmdbcrit_pre_ONCLICK(obj)
{
	if (mopId == "HACMDB")
	{
			if (obj.id == "Go") 
			{
			var funcCode=document.forms[0].funcCodeACMDB.value;
					//alert("am in");
					var dco=userId;
					var input      = "dco|"+dco;
					var outputNames    = "output|outVal";
					var scrName     =   "b_uprcheck.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var c = value;
					//alert (c);
					
					var dco=userId;
					var input      = "dco|"+dco;
					var outputNames    = "output|outVal";
					var scrName     =   "b_workclass.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					//alert(a);


					if ((c!=54)&&(a<600))
					{
						alert("Modification/Add not allowed");
							return false;
					}

					//alert(funcCode);

			if (funcCode=="M")
			{
					var dco=userId;
					var input      = "dco|"+dco;
					var outputNames    = "output|outVal";
					var scrName     =   "b_workclass.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					alert (a);
					if (a<600)
					{
						alert("Modification not allowed");
							return false;
					}
			}
			if (funcCode=="V")
			{
					var dco=userId;
					var input      = "dco|"+dco;
					var outputNames    = "output|outVal";
					var scrName     =   "b_workclass.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;

					var dco=acctId;
					var input      = "dco|"+dco;
					var outputNames    = "output|outVal";
					var scrName     =   "b_hacmdbadtcheck.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var b = value;
					//alert (b);


					if (a<600)
					{
						if (b>1)
						{
							alert("Verification not allowed");
							return false;
						}
					}

			}

		}
	/*else
		if ((obj.id=="Go") &&(profileId!=54))
		{
			alert("Modification/Add not allowed");
			return false;
			
		}*/
	}
	


}




</script>