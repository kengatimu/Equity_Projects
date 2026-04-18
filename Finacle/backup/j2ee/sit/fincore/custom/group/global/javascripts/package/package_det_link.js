<!--    This is getting executing on click of submit and validate button -->
var AmountCrncyMap = {
                value1: "tmpCrncyCode|N"
}

ObjForm=document.forms[0];
function fnValidateData()
{
	if (!fnCheckMandatoryFields())
	{
		return false;
	}
	if(fnIsNull(document.forms[0].packageDesc.value))
        {
                alert("Package Desc cannot be left blank");
                document.forms[0].packageDesc.focus();
                return false;
        }
	if(fnIsNull(document.forms[0].product1.value))
        {
                alert("Product1 cannot be left blank");
                document.forms[0].product1.focus();
                return false;
        }
	if((document.forms[0].product1.value != "") && (document.forms[0].schmCode1.value == ""))
	{
		alert("Product1 Subtype cannot be left blank");
                document.forms[0].schmCode1.focus();
                return false;
	}
	if((document.forms[0].product2.value != "") && (document.forms[0].schmCode2.value == ""))
        {
                alert("Product2 Subtype cannot be left blank");
                document.forms[0].schmCode2.focus();
                return false;
        }
	if((document.forms[0].product3.value != "") && (document.forms[0].schmCode3.value == ""))
        {
                alert("Product3 Subtype cannot be left blank");
                document.forms[0].schmCode3.focus();
                return false;
        }
	if((document.forms[0].product4.value != "") && (document.forms[0].schmCode4.value == ""))
        {
                alert("Product4 Subtype cannot be left blank");
                document.forms[0].schmCode4.focus();
                return false;
        }
	if((document.forms[0].product5.value != "") && (document.forms[0].schmCode5.value == ""))
        {
                alert("Product5 Subtype cannot be left blank");
                document.forms[0].schmCode5.focus();
                return false;
        }
	if((document.forms[0].product6.value != "") && (document.forms[0].schmCode6.value == ""))
        {
                alert("Product6 Subtype cannot be left blank");
                document.forms[0].schmCode6.focus();
                return false;
        }
	if((document.forms[0].product7.value != "") && (document.forms[0].schmCode7.value == ""))
        {
                alert("Product7 Subtype cannot be left blank");
                document.forms[0].schmCode7.focus();
                return false;
        }
	if((document.forms[0].product8.value != "") && (document.forms[0].schmCode8.value == ""))
        {
                alert("Product8 Subtype cannot be left blank");
                document.forms[0].schmCode8.focus();
                return false;
        }
	if((document.forms[0].product9.value != "") && (document.forms[0].schmCode9.value == ""))
        {
                alert("Product9 Subtype cannot be left blank");
                document.forms[0].schmCode9.focus();
                return false;
        }
	if((document.forms[0].product10.value != "") && (document.forms[0].schmCode10.value == ""))
        {
                alert("Product10 Subtype cannot be left blank");
                document.forms[0].schmCode10.focus();
                return false;
        }
	if(fnIsNull(document.forms[0].packagePrising.value))
        {
                alert("Package Prising cannot be left blank");
                document.forms[0].packagePrising.focus();
                return false;
        }
	if((document.forms[0].packagePrising.value == "P") && (document.forms[0].value2.value == ""))
        {
                alert("Value cannot be left blank");
                document.forms[0].value2.focus();
                return false;
        }
	if((document.forms[0].packagePrising.value == "A") && (document.forms[0].value1.value == ""))
        {
                alert("Value cannot be left blank");
                document.forms[0].value1.focus();
                return false;
        }
	ObjForm.packagePrising.value = removeCommas( ObjForm.packagePrising.value);
	return true;
}


function package_det_post_ONLOAD()
{
        document.forms[0].packageDesc.focus();
	if(document.forms[0].packagePrising.value == "")
        {
                document.getElementById('X').style.display = "none";
                document.getElementById('Z').style.display = "none";
        }
	if((funcCode == "V") || (funcCode == "I") || (funcCode == "X"))
        {
                hideImage("sLnk11");
                hideImage("sLnk12");
                hideImage("sLnk13");
                hideImage("sLnk14");
                hideImage("sLnk15");
                hideImage("sLnk16");
                hideImage("sLnk17");
                hideImage("sLnk18");
                hideImage("sLnk19");
                hideImage("sLnk110");
	}	
	functioncode();
}
function schmcodeClear(index)
{
	var ObjForm=document.forms[0];
	
	clearDescField("schmCode"+index,"schmCodeDesc"+index);
}
function functioncode()
{
        if(document.forms[0].packagePrising.value == "P")
        {
                document.getElementById('Z').style.display = "block";
                document.getElementById('X').style.display = "none";
        }
        if(document.forms[0].packagePrising.value == "A")
         {
                document.getElementById('X').style.display = "block";
                document.getElementById('Z').style.display = "none";
        }
}

function packageDet_ONBLUR1(e, f, d, b, a) {
        if((e.value == "99999999999999") || (e.value == "99999999999999.99"))
        {
                var c = "";
                if ((c = newformatAmt(f, d, b, a)) == false) {
                        e.value = "";
                        e.focus();
                        return false
                }
                if(!fnCheckNegativeAmt(e))
                {
                        e.value = "";
                        e.focus();
                        return false
                }
                return (c == undefined) ? true : c
        }
        return true;
}

function packageDet_ONCHANGE1(e, f, d, b, a) {
        var c = "";
        if ((c = newformatAmt(f, d, b, a)) == false) {
                e.value = "";
                e.focus();
                return false
        }
        if(!fnCheckNegativeAmt(e))
        {
                e.value = "";
                e.focus();
                return false
        }
        return (c == undefined) ? true : c
}

function packageDet_ONCHANGE3(b, c) {
    var a = "";
    if ((a = conditionalCheckPreferredData('0')) == false) {
            b.value = "";
            b.focus();
        return false
    }
    return (a == undefined) ? true : a
}

function conditionalCheckPreferredData(b) 
{
	objForm = document.forms[0];
	if (funcCode == "A" || funcCode == "M") 
	{
		var a = objForm.value2.value;
		if (!fnIsNull(a)) 
		{
			if ((!isNumber(a)) || (a.indexOf(" ") != -1) || (getValInFloat(a)) < 0 || (!fnValidatePercent(a, 6))) 
			{
				alert(finbranchResArr.get("FAT000167"));
				objForm.value2.focus();
				return false
			}
		}
	}
	return true;
}
function schmCodSearcher(index)
{
	//showSchmCodes(document.forms[0].product1,'',document.forms[0].solId,'schmcode','F',document.forms[0].schmCodeDesc,document.forms[0].product1.value,document.forms[0].crncy)
//	showSchmCodes(document.forms[0].schmCode,document.forms[0].glSubHeadCode,contextSolId,'schmcode','F','',document.forms[0].product1.value,document.forms[0].crncy)
	var ObjForm=document.forms[0];

	if((eval("ObjForm.product"+index+".value") == "LAA") || (eval("ObjForm.product"+index+".value") == "CAA") || (eval("ObjForm.product"+index+".value") == "TDA") || (eval("ObjForm.product"+index+".value") == "SBA") || (eval("ObjForm.product"+index+".value") == "ODA"))
	{
		showSchmCodes(eval("document.forms[0].schmCode"+index),document.forms[0].glSubHeadCode,contextSolId,'schmcode','F',eval("document.forms[0].schmCodeDesc"+index),eval("document.forms[0].product"+index+".value"),document.forms[0].homeCrncyCode);

	document.forms[0].glSubHeadCode.value = "";	
	document.forms[0].crncy.value = "";	
	}
	if(eval("ObjForm.product"+index+".value") == "B")
	{
		showDynSearcher('HFBTYPE','entity_cre_flg=Y',':schmCode'+index+'=bill_param_type|:schmCodeDesc'+index+'=bill_param_desc');
	}
	if(eval("ObjForm.product"+index+".value") == "G")
	{
		showDynSearcher('HBGTYPE','',':schmCode'+index+'=bg_type|:schmCodeDesc'+index+'=bg_type_desc');
	}
	if(eval("ObjForm.product"+index+".value") == "D")	
	{
		showDynSearcher('HDCREG','',':schmCode'+index+'=reg_type|:schmCodeDesc'+index+'=reg_desc')
	}
	if(eval("ObjForm.product"+index+".value") == "R")
	{
		showDynSearcher('HSRREM','entity_cre_flg=Y',':schmCode'+index+'=remit_type|:schmCodeDesc'+index+'=remit_desc');	
	}
}
