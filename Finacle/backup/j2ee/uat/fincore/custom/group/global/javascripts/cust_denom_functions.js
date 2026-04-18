/*-----------------------------------------------------------------------------------------
	NAME		: cust_denom_functions.js
	Calling Jsp	: tmdet_custom.jsp
	Module Code	: DENOM
	Date		: 01 Dec 2008
	Description	: This JS file holds the common functions used in DENOM module.
	Menu Option	: HCASHDEP,HCASWD,HTM,HCASHX,HCASHDX,HDDMI,HDDII
	Author		: Castro
------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------
Function to convert the input stream of array into the required unique combination.
INPUTS	-	Arr1 : Tunes Arr1 to an array with unique elements and thus removes the duplicate elements.
				say [ C~USD|C~INR|C~USD|D~INR|D~INR ]
		-	Arr2 : The amount values in this array corresponding to the removed elements in Arr1 
			gets consolidated with the elements in Arr2 corrsponding to the unique elements in Arr1.
				say [ 300|100|100|200|200 ]
OUTPUT	-	Arr1 concatenated with Arr2 (Arr1 elements with Arr2 elements).
					[C~USD~400|C~INR~100|D~INR~400]
-----------------------------------------------------------------------------------------*/
function uniqueIndex( Arr1, Arr2 )
{
	var a = [], b = [], c = [], tmp = [], i, l = Arr1.length;
	for( i=0; i<l; i++ ) 
	{
		var pos = a.indexOf(Arr1[i], 0);
		if( pos < 0 ) 
		{
			a.push( Arr1[i] );
			b.push( Arr2[i] ); 
		}
		else
		{
			b[pos] = parseFloat(b[pos]) + parseFloat(Arr2[i]);
			b[pos] = parseFloat(b[pos].toFixed(6));
			var sNum;
			var Num = '' + b[pos];
			if (Num.indexOf(".") != -1)
				sNum=Num.substring(0,Num.indexOf(DEF_DECIMAL_SEPARATOR));
			else
				sNum = Num;
			if (sNum.length > 14)
			{
				alert("Maximum 14 digits allowed in Numeric part of the transaction sum");
				return false;
			}
		}
	}
	for( i=0; i<a.length; i++ ) 
	{
		c[i] = a[i] + "~" + b[i];
	}
	return c;
}

/*-----------------------------------------------------------------------------------------
Function to add index to the the array elements as per the currencies.
INPUTS	-	Arr1 : Pagenames Array
				say [ C~USD|C~INR|C~USD|D~INR|D~INR ]
		-	Arr2 : The Amount values array corresponding to the Pagenames Array
				say [ 300|100|100|200|200 ]
OUTPUT	-	Arr1 concatenated with Arr2 (Arr1 elements with Arr2 elements witth the index added at last).
					[C~USD~300~0|C~INR~100~0|C~USD~100~1|D~INR~200~0|D~INR~200~1]
-----------------------------------------------------------------------------------------*/
function putIndexOnElements( Arr1, Arr2 )
{
	var cnt = 0;
	var b = [];
	var aUniq = Arr1.unique(true);
	for(var u=0; u < Arr1.length; u++)
	{
		cnt = 0;
		var d = Arr1.indexOf(aUniq[u]);
		while(d != -1)
		{
			Arr1[d] = Arr1[d] + "~" + Arr2[d] + "~" + cnt;
			cnt++;
			var d = Arr1.indexOf(aUniq[u]);
		}
	}
	return Arr1;
}

/*-----------------------------------------------------------------------------------------
This function handles the denomination screens.
INPUTS	-	funcCode
		-	tranType
		-	tranSubType
		-	acctIds
		-	acctCrncy	: multiple currencies separated by "|"
		-	acctCrncyAmt	: multiple amounts corresponding to the above input separated by "|"
		-	TotPTranTypes	: multiple part tran types corresponding to the above inputs separated by "|"
		-	tranDate	(Not for Add mode)
		-	tranId		(Not for Add mode)
		-	menuType	: Product or Custom menu (P/C), based on which the sUrl is set
		-	PbGb		: Pay Back and Getback feature to be included or not (included by default)
		The number of pipe separated values should be the same.
OUTPUT	-	The currency details are fetched and stored in ARJspCurr repositories.
		-	The Denomination details screen(s) is(are) popped up which makes use of these ARJSPCurr repositories.
			(MultiRec screens)
CALLING JSPS - denomdp003.jsp,denomdp008.jsp - to fetch the currency denomination details and store it in ARJSPCurr.
			 - denomdp006.jsp,denomdp007.jsp - the denomination details MultiRec popup screen.
-----------------------------------------------------------------------------------------*/

function cust_fndenompopup(funcCode,tranType,tranSubType,acctIds,acctCrncy,acctCrncyAmt,TotPTranTypes,tranDate,tranId,menuType,PbGb,referralFlg)
{
//alert("in");

	var bUrl,sUrl;
	if(PbGb==undefined)	PbGb = "Y";
	if(funcCode==""||tranType==""||tranSubType==""||menuType=="")
	{
		alert("Null values passed");
		return false;
	}
	if(funcCode!="A"&&funcCode!="M"&&funcCode!="I"&&funcCode!="V"&&funcCode!="P"&&funcCode!="C"&&funcCode!="D"&&funcCode!="T"&&funcCode!="M1"&&funcCode!="R")
	{
		alert("Invalid function code");
		return false;
	}
	(menuType=="C") ? bUrl = "../../" : bUrl = "../";
	if(funcCode=="A"||funcCode=="M"||funcCode=="C"||funcCode=="T")
	{
		acctCrncyAmt = removeCommas(acctCrncyAmt);
		var aAcctCrncy		= acctCrncy.split("@");
		var aAcctCrncyAmt	= acctCrncyAmt.split("@");
		var aTotPTranTypes	= TotPTranTypes.split("@");
		if(aAcctCrncy.length!=aAcctCrncyAmt.length || aAcctCrncy.length!=aTotPTranTypes.length)
		{
			alert("Mismatch in the no of fields passed");
			return false;
		}
		var aTranDtls = [],aPageNames = [],TranDtls = "";
		for (var i=0; i<aAcctCrncy.length ; i++)
		{
			aPageNames[i] = aTotPTranTypes[i] + "~" + aAcctCrncy[i];
		}
		if((tranType+tranSubType) == "CCT")
		{
			aTranDtls = putIndexOnElements(aPageNames,aAcctCrncyAmt);
			TranDtls = aTranDtls.join("!");
			var uniqCrncys=aAcctCrncy.join("!");
		}
		else
		{
			if(aAcctCrncyAmt != "")	{
			aTranDtls = uniqueIndex(aPageNames,aAcctCrncyAmt);
			if(!aTranDtls) return false;
			TranDtls = aTranDtls.join("!");
			var aCrncyUniq=aAcctCrncy.unique();
			var uniqCrncys=aCrncyUniq.join("!");
			}
		}
	}
	if(funcCode=="A"||funcCode=="C"||funcCode=="T")
		sUrl=bUrl+"custom/jsp/denomdp008.jsp?Func=A&TranDtls="+TranDtls+"&uniqCrncys="+uniqCrncys+"&tranType="+tranType+tranSubType+"&acctIds="+acctIds+"&PbGb="+PbGb+"&TotPTranTypes="+TotPTranTypes+"&referralFlg="+referralFlg;
	if(funcCode=="I"||funcCode=="D"||funcCode=="V"||funcCode=="P"||funcCode=="M1"||funcCode=="R")
	{

		if(tranId.trim()=="")
		{
			alert("Tran Id is mandatory");
			return false;
		}
		if(tranDate.trim()=="")
		{
			alert("Tran Date is mandatory");
			return false;
		}
		tranId = tranId.trim();
		if(funcCode=="M1"||funcCode=="R")
			sUrl=bUrl+"custom/jsp/denomdp003.jsp?Func="+funcCode+"&tranId="+tranId+"&tranDate="+tranDate+"&referralFlg="+referralFlg;
		else
			sUrl=bUrl+"custom/jsp/denomdp003.jsp?Func=I&tranId="+tranId+"&tranDate="+tranDate+"&tranType="+tranType+tranSubType+"&referralFlg="+referralFlg;
	}
	if(funcCode=="M")
		sUrl=bUrl+"custom/jsp/denomdp003.jsp?Func=M&tranId="+tranId+"&tranDate="+tranDate+"&uniqCrncys="+uniqCrncys+"&tranType="+tranType+tranSubType+"&acctIds="+acctIds+"&TranDtls="+TranDtls+"&referralFlg="+referralFlg;
	var xMax = screen.width, yMax = screen.height;
	var xOffset = (xMax - 120), yOffset = (yMax - 150);
	var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
	params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";
	
	var ret = window.showModalDialog(sUrl,"",params);
	

	var retVal = ret.split("|");
	if(retVal[0]=="N")
	{
		if(retVal[1]=="DIS")
			return "DISABLED";
		else if (retVal[1]=="NOTCASH")
			return true;
		else 
		{
			var conf = confirm(retVal[1]);
			return conf;
		}
	}	
    else if(retVal[0]=="F") {
        alert(retVal[1]);
        return false;
    }
	if(funcCode == "M" )
		sUrl=bUrl+"custom/jsp/denomdp007.jsp?Func="+funcCode+"&refFlg="+referralFlg;
	else
		sUrl=bUrl+"custom/jsp/denomdp006.jsp?Func="+funcCode;
	var params = "dialogWidth:43;dialogHeight:29;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
	params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";
	var ret1=window.showModalDialog(sUrl,"denom",params);
	if(ret1=="cancel")
		return false;
	if (ret1==undefined)
		return "cancel";
	else
	{
		var vals = ret1.split("@");
		var obj1 = document.getElementById("payBckAmt");
		var obj2 = document.getElementById("getBckAmt");
		if(obj1!=undefined)
			document.forms[0].payBckAmt.value = vals[1];
		if(obj2!=undefined)
			document.forms[0].getBckAmt.value = vals[2];
		return vals[0];
	}
}

