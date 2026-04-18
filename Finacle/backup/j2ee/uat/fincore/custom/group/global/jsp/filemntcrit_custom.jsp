<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : filemntcrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 09-09-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HEFM
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		09-09-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
//Edwin Renaming AGTM Start 

function filemntcrit_pre_ONLOAD(obj)
{
	if (mopId == "HAGTM")
	{
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Agent Code','TID Number')
	}
	if((mopId.toUpperCase() == "HAGTM") && (profileId == "43"))
        {
                if(document.forms[0].funcCode.value == "A")
                {
			getFieldsFromCustomData("CrncyCode");
                }
        }
}

//Edwin Renaming AGTM END
function filemntcrit_pre_ONCLICK(obj)
	{
		if (mopId == "HEFM")
		{
			 setFieldsToCustomData("funcCode");
		}
		
			if((mopId.toUpperCase() == "HAGTM") && (profileId == "43"))
        {
                if((document.forms[0].funcCode.value == "A") && (document.forms[0].agent_code.value !=""))
                {
			setFieldsToCustomData("CrncyCode");
			if(obj.id !="Clear")
			{

				setFieldsToCustomData("CrncyCode");
				var crncycode = document.forms[0].CrncyCode.value;
				if(crncycode =="")
				{
					alert("Enter Currency Code");
					document.forms[0].CrncyCode.focus();
					return false;
				}

				if(crncycode=="CDF" ||crncycode=="USD"||crncycode=="cdf" ||crncycode=="usd")
				{
					var id = obj.id;
					setCustomFieldValue("CrncyCode");
					var val = document.getElementById('CrncyCode').value;
				}
				else
				{
					alert("Enter Valid Currency CDF or USD..!");
					document.forms[0].CrncyCode.focus();
					return false;

				}
			}
			else
			{
				if(obj.id =="Clear")
				{
					document.forms[0].CrncyCode.value ="";
				}
			}
		}
		else
		{
			if(document.forms[0].funcCode.value !="A")
			{
				alert("Only addition can be allowed here remaining operation shoulb be performed in CAGTM menu option");
				document.forms[0].funcCode.focus();
				return false;
			}
		}
	}
	return true;
	
	}
function filemntcrit_post_ONLOAD()
{
	if((mopId.toUpperCase() == "HAGTM") && (profileId == "43"))
        {
                if(document.forms[0].funcCode.value == "A")
                {
			getCustomFieldValue("CrncyCode");
                }
        }
}		
function postEventCall(tmdet,obj,ONCHANGE)
{
	if((mopId.toUpperCase() == "HAGTM") && (profileId == "43") && (document.forms[0].funcCode.value == "A"))
        {
		showImage("crncy");
		setCustomFieldValue("CrncyCode");
	}
	else
	{
		hideImage("crncy");
	}
	return true;
}

function fetchCurrency()
{
	var ObjForm = document.forms[0];
	var inputNameValues = "funcCode|A";
	var outputNames  = "CrncyCode|CrncyDesc";
	var pageTitle    = "Currency Code List";
	var literalNames = "Currency Code|Currency Desc";
	var scrName      = "eCurrencyPop.scr";
	var hyperLnkCols = "1";
	var retVal       = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,false);
	if (retVal != null && retVal != undefined)
	{
		var vals = retVal.split("|");
		if(vals[0] != "")
		{
			document.forms[0].CrncyCode.value = vals[0];
		}
	}
}

</script>
<input type=hidden id=CHQHIDE >
        <div id="crncy" >
        <table id = "tag" width="98.7%" align="center" border="0" cellpadding="0" cellspacing="0" class="table">
        <tr>
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
        <tr>
        <tr>
        <td>&nbsp;&nbsp;
        </td>
        </tr>
        <tr>
        <td class="textlabel" nowrap="nowrap" id = "search1tab"> Currency Code</td>
	<td>&nbsp;&nbsp;
	<input type="text" class="textfieldfont" id="CrncyCode" name="CrncyCode"  size="5" maxlength="3">&nbsp;&nbsp;
	<a href="javascript:fetchCurrency();">
	<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/INFENG/search_icon.gif" width="14">
	</td>
        </tr>
        <tr>
        <td>&nbsp;&nbsp;
        </td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        </div>

