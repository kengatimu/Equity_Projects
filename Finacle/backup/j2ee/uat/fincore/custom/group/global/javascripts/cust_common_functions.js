var ns4=document.layers?1:0;
var ie4=document.all?1:0;
var ns6=document.getElementById&&!document.all?1:0;
var browser_name = navigator.appName;
var gfkmCookie = null;
var MAX_AMOUNT = "9999999999999999";
var frm = document.forms[0];
var displayDateFormat="00";
// Trims the input string of leading and trailing spaces and returns the new string
function fnTrim(a_strString)
{
	var cnt;
	len = a_strString.length;
	var str = a_strString;
	begin = -1;
	for(cnt=0;cnt<len;cnt++)
	{
		if (str.charAt(cnt) == " ")
		{
			begin = cnt;
		}
		else
		break;
	}
	str = str.slice(begin+1,len);
	len = str.length;
	end = len;
	for(cnt=len-1;cnt>=0;cnt--)
	{
		if (str.charAt(cnt) == " ")
		{
			end = cnt;
		}
		else
		break;
	}
	str = str.slice(0,end);
	return str;
}

// Checks if the input string is null or blanks
function fnIsNull(a_strString)
{
	if (fnTrim(a_strString) == null || fnTrim(a_strString) == "" )
    {
    	return true;
    }

	return false;
}

// Checks if the passed date is a valid date. Expects date in dd/mm/yyyy format
function fnIsValidDate(dateObj){

	var mnemonicEnabled = dateObj.getAttribute("mnebl");
	a_strDate=dateObj.value;
	if(a_strDate=="")
		return true;

	if((null != mnemonicEnabled) && (mnemonicEnabled))
	{
		if(isValidDateMneumonic(a_strDate))
		{
			return true;
		}
	}

	if(a_strDate.indexOf("/") != -1)
		var a_strDate = a_strDate.split("/");
	else
	if(a_strDate.indexOf("-") != -1)
		var a_strDate = a_strDate.split("-");
	else
	if(a_strDate.indexOf(".") != -1)
		var a_strDate = a_strDate.split(".");
	else
	{
		return false;
	}
	a_strDay = a_strDate[0];
	a_strMonth = a_strDate[1];
	a_strYear = a_strDate[2];
	if(a_strDay.length==1)
	{
	a_strDay="0"+a_strDay;
	}
	if(a_strMonth.length==1)
	{
	a_strMonth="0"+a_strMonth;
	}
	if ( ( isNaN( a_strYear ) ) || ( isNaN( a_strMonth ) ) || ( isNaN( a_strDay ) ) || a_strDay.length <=1)	{
		return false;
	}
	else {
		if (  ( a_strYear < 1900 ) || ( a_strYear > 2099 ) || ( a_strMonth > 12 ) || ( a_strMonth<1 ) || ( a_strDay < 1 ) || ( a_strDay > 31 ) || ( ( ( a_strMonth == 4 ) || ( a_strMonth == 6 ) || ( a_strMonth == 9 ) || (  a_strMonth == 11 ) ) && ( a_strDay > 30 ) ) )
			return false;
		else {
			if ( ( a_strYear % 4 == 0 ) && ( ( a_strYear % 100 != 0 ) || ( a_strYear % 400 == 0 ) ) )	{
				if ( ( a_strMonth == 2 ) && ( ( a_strDay > 29 ) || ( a_strDay < 1 ) ) ) {
					return false;
				}
			}
			else {
				if ( ( a_strMonth == 2 ) && ( ( a_strDay > 28 ) || ( a_strDay < 1 ) ) ) {
					return false;
				}
			}
		} // end of else
	}//end of else
	dateObj.value=a_strDay+"-"+a_strMonth+"-"+a_strYear;
	return true;
}

// Checks if the passed date1 is greater than date2. Expects the dates in the dd-mm-yyyy format
// a==b true, a < b = true, a > b false.
// Modified to return true/false if one of the inputs is "" to avoid split failing.
function fnCompareDates(a_strDate1, a_strDate2) {

	var a_strMonth1;
	var a_strDay1;
	var a_strYear1;
	var a_strMonth2;
	var a_strDay2;
	var a_strYear2;

	var blFlag = true;

/* If any of the dates is null , then the function will return true */
	if (a_strDate1=="" ||  a_strDate2==""){return true;}

			var arrDate1 = a_strDate1.split("-");
			var arrDate2 = a_strDate2.split("-");
			a_strMonth1 = arrDate1[1];
			a_strDay1 = arrDate1[0];
			a_strYear1 = arrDate1[2];
			a_strMonth2 = arrDate2[1];
			a_strDay2 = arrDate2[0];
			a_strYear2 = arrDate2[2];
	
/* If Date1 is greater than Date2, then the function will return false */
	if (parseInt(a_strYear1, 10) > parseInt(a_strYear2, 10))
		return false;
	else
		if ((parseInt(a_strMonth1, 10) > parseInt(a_strMonth2, 10)) && (parseInt(a_strYear1, 10) == parseInt(a_strYear2, 10)))
			return false;
		else
			if ((parseInt(a_strDay1, 10) > parseInt(a_strDay2, 10))
				&& (parseInt(a_strYear1, 10) == parseInt(a_strYear2, 10))
				&& (parseInt(a_strMonth1, 10) == parseInt(a_strMonth2, 10)))
				return false;

	return true;
}


// Checks if the passed string is a positive number
function fnIsPositiveNumber(a_strString) {

	if(( isNaN(a_strString) ) || ( a_strString.indexOf( " " ) != -1 ) || ( a_strString.indexOf(".") != -1 ))
		return false;
	// Number should be >= 0
	else if (a_strString < 0 )
		return false;
	else
		return true;
}

//Prints the Error Code and Description
function PrintErrorList(Code, Type, Desc)
{
	len = Desc.length;
	for(index = 0; index < len; index++)
	{
		with(document) {
		write('<TR>');
		write('<TD ALIGN="left">' + Code[index] + '</TD>');
		write('<TD ALIGN="left">' + Type[index] + '</TD>');
		write('<TD ALIGN="left" WIDTH="70%">' + Desc[index] + '</TD>');
		write('</TR>');
		}
	}
}

//This function removes commas from the given amount
function removeCommas(sNum)
{
	sNew ="";
	var sTemp = sNum.split(",");
	for (i=0;i<sTemp.length;i++)
	{
		if (sTemp[i]!=null)
			sNew = sNew + sTemp[i];
	}
	return sNew;
}

//This function converts the given number to Lakh format
//Included by Vasudevan G on 07-03-01
function formatToLakh(Num)
{
	if (fnIsNull(Num))
		return "";
	//Return if invalid number
	if (isNaN(removeCommas(Num)))
	{
		alert(finbranchResource.FAT000029);
		return 0;
	}
	//If no of digits less than 3 return the number
	if ((Num.indexOf(".")!=-1) && (Num.substring(0,Num.indexOf(".")-1).length < 3))
		return Num;
	//Take mantissa part out of the number
	if (Num.indexOf(".") != -1)
		sNum=Num.substring(0,Num.indexOf("."));
	else
		sNum = Num;
	if (sNum.length<4)
		return Num+".00";
	//Remove commas if present
	sNum = removeCommas(sNum);
	var sRes="";
	var j=0;
	if (sNum.length >4)
	{
		for (i=sNum.length-4;i>=0;i--)
		{
			sRes=sRes + sNum.charAt(i);
			temp = (sRes.substring(0,j+1)).length;
			if ((temp%2)==0)
				sRes=sRes+",";
			j+=1;
		}
		var sOrig="";
		for (i=sRes.length-1;i>=0;i--)
		{
			sOrig=sOrig + sRes.charAt(i);
		}
		sOrig=sOrig+","+sNum.substring(sNum.length-3);
	}
	if (sNum.length==4)
		sOrig=sNum.charAt(0)+","+sNum.substring(1);
	if (Num.indexOf(".") == -1)
		sOrig=sOrig+".00";
	else
		sOrig=sOrig+Num.substring(Num.indexOf("."));
	if (sOrig.charAt(0) == ",")
		sOrig=sOrig.substring(sOrig.indexOf(",")+1);
	return sOrig;
}

//This function converts the given number to Million format
//Included by Vasudevan G on 07-03-01
function formatToMillion(Num)
{
	if (fnIsNull(Num))
		return "";
	//Return if invalid number
	if (isNaN(removeCommas(Num)))
	{
		alert(finbranchResource.FAT000029);
		return 0;
	}
	//If no of digits less than 3 return the number
	if ((Num.indexOf(".")!=-1) && (Num.substring(0,Num.indexOf(".")-1).length < 3))
		return Num;
	//Take mantissa part out of the number
	if (Num.indexOf(".") != -1)
		sNum=Num.substring(0,Num.indexOf("."));
	else
		sNum = Num;
	if (sNum.length<4)
		return Num+".00";
	//Remove commas if present
	sNum = removeCommas(sNum);
	var sRes="";
	var j=0;
	for (i=sNum.length-1;i>=0;i--)
	{
		sRes=sRes + sNum.charAt(i);
		temp = (sRes.substring(0,j+1)).length;
		if ((temp%3)==0)
			sRes=sRes+",";
		j+=1;
	}
	var sOrig="";
	for (i=sRes.length-1;i>=0;i--)
	{
		sOrig=sOrig + sRes.charAt(i);
	}
	if (Num.indexOf(".") == -1)
		sOrig=sOrig+".00";
	else
		sOrig=sOrig+Num.substring(Num.indexOf("."));
	if (sOrig.charAt(0) == ",")
	{
		sOrig=sOrig.substring(sOrig.indexOf(",")+1);
	}
	return sOrig;
}

function fnFormatDate(cStr,evt)
{
	var HYPHEN = "-";
	var sEnteredDate = cStr.value;
	var sRawDate = "";
	var mnebl = cStr.getAttribute("mnebl");
   	if((null != mnebl )&& (mnebl) && ("$" == sEnteredDate.substring(0,1)) )
   	{
   		return;
   	}
   	if((9 == evt.keyCode) || (16 == evt.keyCode))
   	{
   		cStr.focus();
		return;
	}
	if((8==evt.keyCode)||(37==evt.keyCode)||(39==evt.keyCode)||(46==evt.keyCode))
		return;
	var arrDate = sEnteredDate.split(HYPHEN);
	if(arrDate.length == 3)
	{
		if(arrDate[2].length > 0 && arrDate[2].length <= 4 && arrDate[1].length > 0 && arrDate[1].length <= 2 && arrDate[0].length > 0 && arrDate[0].length <= 2)
			return true;
	}

	if(arrDate.length == 2)
	{
		if(arrDate[1].length != 2 || arrDate[0].length != 2)
			if(arrDate[1].length > 0 && arrDate[1].length <= 2 && arrDate[0].length > 0 && arrDate[0].length <= 2)
				return true;
	}

	//remove HYPHENS to form raw date string
	for(i=0; i<sEnteredDate.length; i++)
	{
		if(sEnteredDate.charAt(i) != HYPHEN)
			sRawDate += sEnteredDate.charAt(i);
	}
	var iRawDateLen = sRawDate.length;
	var sFmtdDate = sRawDate;
	if(iRawDateLen > 8) {			//More than 8 chars entered, format date with first 8 chars and ignore the rest
		sFmtdDate = sRawDate.substring(0,2)+HYPHEN+sRawDate.substring(2,4)+HYPHEN+sRawDate.substring(4,8);
	} else if (iRawDateLen > 4) {	//DD MM and some of YYYY is entered, format date completely
		sFmtdDate = sRawDate.substring(0,2)+HYPHEN+sRawDate.substring(2,4)+HYPHEN+sRawDate.substr(4);
	} else if (iRawDateLen == 4) {	//only DD and MM entered, format date leaving year part
		sFmtdDate = sRawDate.substring(0,2)+HYPHEN+sRawDate.substring(2)+HYPHEN;
	} else if (iRawDateLen == 3) {	//only DD and M entered add HYPHEN btwn DD and M
		sFmtdDate = sRawDate.substring(0,2)+HYPHEN+sRawDate.substr(2);
	} else if (iRawDateLen == 2) {	//only DD entered add HYPHEN
		sFmtdDate = sRawDate.substring(0,2)+HYPHEN;
	}
	cStr.value = sFmtdDate;
}

function validFields(isMandatory,ctrl,msg1,msg2)
{
	if(isMandatory=="Mandatory")
		{
			if(fnIsNull(ctrl.value))
			{
				alert(msg1);
				ctrl.focus();
				return false;
			}
			if((!(fnIsPositiveNumber(ctrl.value))||(ctrl.value==0))&&(msg2!=""))
			{
				alert(msg2);
				ctrl.focus();
				return false;
			}
		}
		return true;
}

function onSaveVerify(s)
{
	var frm = document.forms[0];
	if(validatefields())
	{
		convertToCaps();
		frm.saveVerify.value=s;
		if(s=="Authorize")
			return true;
		frm.Save.disabled=true;
		frm.Verify.disabled=true;
		frm.Cancel.disabled=true;
		frm.Authorize.disabled=true;
		frm.submit();
	}
 	else
	{
 		return false;
	}
}

function openWindow(sURL,ctrl,inVal,msg)
{
	if((inVal!='optional')&&(inVal==""))
	{
		alert(msg);
		return ;
	}
//Check for browser
	if("Netscape" == browser_name)
	{
			window.open(sURL,"title","width=500,height=500,modal=yes,top=40,left=150,scrollbars=yes,toolbar=no,menubar=no");
	}
	else {
	var retValue=window.showModalDialog(sURL,"title","dialogWidth:40;dialogHeight:25;status=no;toolbar=no;menubar=no;resizable=yes");
		if(ctrl!="")
		{
			if(retValue!=null)
				ctrl.value=retValue;
		}
	}
}

function openAuthorizeWindow(URL)
{
	if(onSaveVerify('Authorize'))
	{
		convertToCaps();
		window.open(URL,"Authorize","Width=300,Height=110, Top=230, Left=270");
	}
	else
		return false;
}

function fillEndCheque()
{
	var frm = document.forms[0];
	n1=frm.beginChequeNo.value;
	n2=frm.noOfLeaves.value;
	if(!fnIsNull(n1)&& !fnIsNull(n2)&&(n1!=0)&&(n2!=0))
	{
		if(fnIsPositiveNumber(n1) && fnIsPositiveNumber(n2))
			frm.endChequeNo.value=eval(n1)+eval(n2)-1;
	}
	else
	{
		frm.endChequeNo.value="";
	}
	if((!fnIsNull(n2))&&(n2 > 1))
	{
		frm.chequeAmount.value = "";
		frm.chequeAmount.readOnly = true;
		frm.chequeDate.value = "";
		fnEnableUIField(frm.chequeDate,'N');
		hideImage("sLnk6");
		frm.payeeName.value = "";
		frm.payeeName.readOnly = true;
	}else
	{
		frm.chequeAmount.readOnly = false;
		fnEnableUIField(frm.chequeDate,'Y');
		showImage("sLnk6");
		frm.payeeName.readOnly = false;
	}
	return true;
}

function getMainMenu()
{
	document.location="../../arjspmorph/cleanup.jsp?logout=NO";
}

function openGetDetailsWindow(tobj,sGrpName,sAmtFormat,sMaskString)
{
	if (fnIsNull(tobj.value))
	{
		alert(finbranchResource.FAT000109);
		tobj.focus();
	}
	else{
		if("Netscape" == browser_name)
		{
				window.open("../../arjspmorph/"+applangcode+"/get_details.jsp?groupName="+sGrpName+"&AcctNo="+(tobj.value).toUpperCase()+"&AmountFormat="+sAmtFormat+"&maskBalString="+sMaskString,"GetDetails","height=500,width=600,modal=yes,left=100,top=40,scrollbars=yes,toolbar=no,menubar=no");
		}
		else
			window.showModalDialog("../../arjspmorph/"+applangcode+"/get_details.jsp?groupName="+sGrpName+"&AcctNo="+(tobj.value).toUpperCase()+"&AmountFormat="+sAmtFormat+"&maskBalString="+sMaskString,"GetDetails","dialogWidth:40;dialogHeight:25;status=no;toolbar=no;menubar=no;resizable=yes");
	}
}

function openLienListWindow(sAcctId)
{
	if(sAcctId == "")
	{
		alert(finbranchResource.FAT000519);
	}
	else
	{
		window.open("../../arjspmorph/"+applangcode+"/lien_list.jsp?AcctId="+sAcctId, "LienList", "width=700, height=400,top=20,left=80,scrollbars=1");
	}
}

function checkFieldMandatory(strFieldValue,strMessage)
{
    if (fnIsNull(strFieldValue))
	{
		alert(strMessage);
		return true;
	}
}

function openMemoPadEntryWindow(AcctId)
{
//Check the browser
    if("Netscape" == browser_name)
        window.open("../../arjspmorph/"+applangcode+"/memo_pad_inquiry.jsp?AcctId="+AcctId,"MemoPadInquiry","MemoPadInquiry","width=500,height=500,modal=yes");
    else
		window.showModalDialog("../../arjspmorph/"+applangcode+"/memo_pad_inquiry.jsp?AcctId="+AcctId,"MemoPadInquiry","dialogWidth:40;dialogHeight:25;status=no;toolbar=no;menubar=no;resizable=yes");
}

function CheckLinkStatus(Obj)
{
    if(Obj.value == "True")
    {
        return true;
    }else
    {
        alert(finbranchResource.FAT000054);
        return false;
    }
}

//This function converts the given number to Million format
//Included by Srinivas.B
function formatToLakh1(Num, precision)
{
    var mantissa;
    var ordinate;
    precision = parseInt(precision,10) + 1;
    var pre=precision-1;
    if (fnIsNull(Num))
        return "";
    //Return if invalid number
    if (isNaN(removeCommas(Num)))
    {
        alert(finbranchResource.FAT000029);
        return 0;
    }

    if (Num.indexOf(".")!=-1)
    {
        mantissa=Num.substring(0,Num.indexOf("."));
        ordinate=Num.substring(Num.indexOf(".")+1);
        mantissa= removeCommas(mantissa);
        ordinate= removeCommas(ordinate);
        if(ordinate.length < pre)
        {
            var noOfZeros = pre - ordinate.length;
            for(i=0;i<noOfZeros;i++)
            {
                ordinate +="0";
            }
        }
        else if(ordinate.length > pre)
        {
            ordinate = ordinate.substring(0,precision);
            var tn=ordinate.charAt(pre);
            if(tn>=5)
            {
                if(ordinate.charAt(0)=='0')
                {
                    ordinate=parseInt(ordinate.substring(0,pre),10)+1;
                    if(ordinate !=10)ordinate="0"+ordinate;
                }
                else
                {
                    befOrdinate = ordinate;
                    ordinate=parseInt(ordinate.substring(0,pre),10)+1;
                    strOrdi = ordinate+"";
                    if(strOrdi.length > (befOrdinate.length-1))
                    {
                        imantissa = parseInt(mantissa,10)+1 ;
                        mantissa = imantissa + "";
                        ordinate = strOrdi.substring(1);
                    }
                }
            }
            else
            {
                ordinate=ordinate.substring(0,pre);
            }
        }

    }
     else
    {
        mantissa=Num;
        ordinate='';
        var noOfZeros = pre;
        for(i=0;i<noOfZeros;i++)
        {
            ordinate +="0";
        }
    }
	/* added to avoid putting comma after minus sign */
	var bIsAmtNegative = Number(mantissa) < 0 ? true : false;
	var sSign = "";	//default no sign[positive number]
	if( bIsAmtNegative )
	{
		mantissa = mantissa.substring(1);//remove negative sign
		sSign = "-";//update sign to negative
	}

    if(mantissa.length <=3)
    {
		if(precision == 1)
			return  sSign+""+mantissa;

        return  sSign+""+mantissa+"."+ordinate;
    }

    if (mantissa.length>3)
    {
        var sRes="";
        var temp="";
        for(i=mantissa.length-1;i>=0;i--)
        {
            sRes += mantissa.charAt(i);
        }
            for(j=0;j<sRes.length;j++)
            {
                temp +=sRes.charAt(j);
                if((j!=0)&&(j%2)==0)temp += ",";
            }
            mantissa="";
            for(k=temp.length-1;k>=0;k--){
            mantissa += temp.charAt(k);
        }
    if(mantissa.charAt(0)==',') mantissa = mantissa.substring(1);
    }

	if(precision == 1)
		return  sSign+""+mantissa;

    return sSign+""+mantissa+"."+ordinate;
}

//This function converts the given number to Million format
//Included by Srinivas.B
function formatToMillion1(Num, precision)
{
        var mantissa="";
        var ordinate="";
        precision = parseInt(precision,10) + 1;
        var pre=precision-1;
        if (fnIsNull(Num))
            return "";
        //Return if invalid number
        if (isNaN(removeCommas(Num)))
        {
            alert(finbranchResource.FAT000029);
            return 0;
        }
        if (Num.indexOf(".")!=-1)
        {
        mantissa=Num.substring(0,Num.indexOf("."));
        ordinate=Num.substring(Num.indexOf(".")+1);
        mantissa= removeCommas(mantissa);
        ordinate= removeCommas(ordinate);
        if(ordinate.length < pre)
            {
                var noOfZeros = pre - ordinate.length;
                for(i=0;i<noOfZeros;i++)
                {
                    ordinate +="0";
                }
            }
        if(ordinate.length >pre)
        {
        ordinate = ordinate.substring(0,precision);
        var tn=ordinate.charAt(pre);
        if(tn>=5)
        {
            if(ordinate.charAt(0)=='0')
            {
            ordinate=parseInt(ordinate.substring(0,pre),10)+1;
            if(ordinate !=10)ordinate="0"+ordinate;
                }
            else
            {
                befOrdinate = ordinate;
                ordinate=parseInt(ordinate.substring(0,pre),10)+1;
                strOrdi = ordinate+"";
                if(strOrdi.length > (befOrdinate.length-1))
                {
                    imantissa = parseInt(mantissa,10)+1 ;
                    mantissa = imantissa + "";
                    ordinate = strOrdi.substring(1);
                }
            }
        }
        else
        {
            ordinate=ordinate.substring(0,pre);
        }
        }
        }
         else
        {
            mantissa=Num;
            ordinate='';
            var noOfZeros = pre;
            for(i=0;i<noOfZeros;i++)
            {
                ordinate +="0";
            }
        }
		/* added to avoid putting comma after minus sign */
		var bIsAmtNegative = Number(mantissa) < 0 ? true : false;
		var sSign = "";	//default no sign[positive number]
		if( bIsAmtNegative )
		{
			mantissa = mantissa.substring(1);//remove negative sign
			sSign = "-";//update sign to negative
		}

        if(mantissa.length <=3)
        {
       		if(precision == 1)
				return  sSign+""+mantissa;

            return  sSign+""+mantissa+"."+ordinate;
        }
        if (mantissa.length>3)
        {
            var sRes="";
            var temp="";
            for(i=mantissa.length-1;i>=0;i--)
            {
            sRes += mantissa.charAt(i);
            }
            for(j=1;j<=sRes.length;j++)
            {
            temp +=sRes.charAt(j-1);
            if((j!=0)&&(j%3)==0)temp += ",";
            }
            mantissa="";
            for(k=temp.length-1;k>=0;k--){
            mantissa += temp.charAt(k);
            }
            if(mantissa.charAt(0)==',')mantissa = mantissa.substring(1);
        }

	if(precision == 1)
		return  sSign+""+mantissa;

    return sSign+""+mantissa+"."+ordinate;
}

function formatAmountToMillionOrLakh(format, obj, precision, prn, idx)
{
	var sourceAmt;
	var res = 1;
	var retVal = true;

    if(prn != 'Y')
	{
		res = RetAmount(obj,precision);
	}

	if(prn == 'Y')
		sourceAmt = obj;
	else
		sourceAmt = obj.value;

	if(res == 0)
	{
		if(obj.disabled != true)
		{
			obj.focus();
			if(null == idx)
			{
				setTimeout('document.forms[0].'+obj.id+'.focus()', 10);
			}else
			{
				setTimeout('document.forms[0].'+obj.id+'['+idx+'].focus()', 10);
			}
			return false;
		}
	}
    else
    {
   		var val;
		sourceAmt = checkZeroes(sourceAmt,precision);
    	if (format == 'MILLION')
    	{
        	val=formatToMillion1(sourceAmt,precision);
		}
    	else
    	{
        	val=formatToLakh1(sourceAmt,precision);
    	}
    	if(prn == 'Y')
    	{
        	document.write(val);
    	}
    	else
    	{
        	obj.value = val
    	}
	}
	return retVal;
}

function fnChangePage(sAction)
{
	var frm = document.forms[0];
	frm.action.value = sAction;
	frm.submit();
}

function getAmountCodeValue(Code)
{
  var multiplierMap =
  {

     T : 1000
    ,L : 100000
    ,M : 1000000
    ,C : 10000000
    ,B : 100000000

  };

  return multiplierMap[Code];
}

function templateCheck(templateStatus)
{
    if(("C" != templateStatus) && ("M" != templateStatus))
    {
        return true;
    }
    return false;
}

function fnsubmitStopRevPay(form)
{
	if(validateForm(form) && fnIsValidChqDate())
    {
		return onSaveVerify('Verify');
    }
}

function fnClearFields()
{
	var obj=document.forms[0];
	var len=obj.length;
	for(i=0;i<len;i++)
	{
		if(obj[i].type == "text")
	        {
			var txtStr = obj[i].value;
			obj[i].value = "";
		}
		else if(obj[i].type == "select-one"){
                        obj[i].options[0].selected ="true";
                }
                else if(obj[i].type == "radio"){
                        obj[i].checked ="false";
                }
	}
// The following change done for fixing the clear fields with errors
// in all custom studio menus calling thsi function by default
//	obj.submit();
	doSubmit("CLEAR");
}

function fnsaveStopRevPay(form)
{
      if(validateForm(form) && fnIsValidChqDate())
      {
              return onSaveVerify('Save');
      }
}

function fnIsacctIdNull(acctIdVal)
{
      if (fnIsNull(acctIdVal))
      {
              alert(finbranchResource.FAT000090);
              document.forms[0].acctId.focus();
              return 0;
      }
      return 1;
}

function fnIsValidChqDate()
{
      var frm = document.forms[0];
	  if(!fnIsNull(frm.chequeDate.value))
      {
              if(!fnIsValidDate(frm.chequeDate))
              {
                      alert(finbranchResource.FAT000101);
					  fnSetFocusForDate(chequeDate);
                      return false;
              }
      }
      return true;
}

function showCurrencyList(currObj)
{
    var retVal = popModalWindow("../arjspmorph/"+applangcode+"/get_currency.jsp?wReturn="+currObj.id+"&Currency="+escape(currObj.value),"CurrencyList");
    if (retVal != null)
    {
    	var j = retVal.split("|");
        currObj.value = j[0];
     }
}

function showGLSubHeadCodeList(glObj)
{
    var retVal = popModalWindow("../../arjspmorph/"+applangcode+"/get_gl_subhead.jsp?wReturn="+glObj.id+"&GLSubHead="+escape(glObj.value),"GetGLSubHeadList");
    if (retVal != null)
        glObj.value = retVal;
}

function showSolList(solObj)
{
    var retVal = popModalWindow("../arjspmorph/"+applangcode+"/get_sol_list.jsp?wReturn="+solObj.id+"&SolId="+escape(solObj.value),"SolIdList");
    if (retVal != null)
        solObj.value = retVal;
}

function checkTolerance(lowTolerance,highTolerance,rate)
{
    if((lowTolerance == "" && highTolerance == "") ||(fnIsNull(rate)))
    {
        return true;
    }
    lowFloatTolerance = parseFloat(lowTolerance);
    highFloatTolerance = parseFloat(highTolerance);
    rateFloat = parseFloat(rate);

    rateNew = document.forms[0].rate.value;
    if(rateNew == "")
    return true;
    lowLimit = rateFloat - (rateFloat*lowFloatTolerance)/100 ;
    highLimit = rateFloat + (rateFloat*highFloatTolerance)/100 ;

    if(rateNew <= highLimit && rateNew >= lowLimit)
    {
            return true;
    }
    else
    {
        alert(finbranchResource.FAT000039);
        return true;
    }
}

function changeRateCodeFlag(rate)
{
	var frm = document.forms[0];
	if("selected" != frm.flag.value)
	{
		if((frm.rateCode.value).toUpperCase() != rate)
		{
		frm.rate.value="";
		frm.rateCodeFlag.value="False";
		}
	}
}

function showTreasuryInfo(sNum)
{
	var frm = document.forms[0];
   if((frm.Currency.value).toUpperCase() != (frm.xCurrency.value).toUpperCase())
   {
    sUrl = "../../arjspmorph/"+applangcode+"/treasinfo.jsp?sNum="+sNum;
        window.open(sUrl,"","width=300,height=150,top=170, left=230");
    }
    else
    {
    	alert(finbranchResource.FAT000544);
    }
}

function onChangeCurrency()
{
    var frm = document.forms[0];
	frm.Amount.value="";
    frm.rate.value="";
}

function showRateCodesCommon(obj1,val1,val2,rateInfo,inPreceedence)
{
	var frm = document.forms[0];
	var preceedence = 'B';
	if(arguments.length > 4)
    {
	   preceedence = inPreceedence;
    }
	if("selected" != frm.flag.value)
	{
		var rateCode = obj1.value;
		var retVal = popModalWindow("../../arjspmorph/"+applangcode+"/rate_codes.jsp?wReturn=document.forms[0].rateCode&DebitCrncy="+val1+"&preceedence="+preceedence+"&CreditCrncy="+val2,"RateCodes");
		if (retVal != null)
		{
			frm.rateCode.value = retVal;
			if ((!fnIsNull(frm.rate.value)) && (frm.rate.value != undefined))
			{
				frm.rate.value = "";
			}
		}
		if (!fnIsNull(frm.rateCode.value) &&
			(rateCode.toUpperCase() != frm.rateCode.value.toUpperCase()))
		{
			if(!fnIsNull(val1) && !fnIsNull(val2))
			{
				changeRateCodeFlag(retVal);
				getRateInfoCommon(rateInfo,val1,val2);
			}
		}
	}
}

function openPartitionedDtlsWindow(spartSelFlg,sConVarSuffix)
{
	window.open("../../arjspmorph/"+applangcode+"/partitioned_details.jsp?partSelFlg="+spartSelFlg+"&sConVarSuffix="+sConVarSuffix+"&preceedence=B","PartitionedDetails","width=300,height=150,top=230,left=270");
}

function fnShowAdditionalDetails(sAcctId,tobj,sFlag,sFieldstatus)
{
	if(fnIsNull(tobj.value))
	{
		alert(finbranchResource.FAT000041);
		return;
	}
	openAdditionalDetailsWindow(sAcctId,tobj,sFlag,sFieldstatus);
}

function getRateInfoCrossCurrency(sAction,Currency,type,lowTolerance,highTolerance,rate)
{
   var frm = document.forms[0];
   var xcurr = frm.xCurrency.value;
   if ( (null == Currency) || (Currency.length <= 0) || (null == xcurr) || (xcurr.length <= 0))
	{
		alert(finbranchResource.FAT000032);
		return;
	}
    if ((frm.xCurrency.value).toUpperCase() != Currency)
	{
		if(!(frm.xAmount.value =="" || frm.xCurrency.value=="" || frm.Currency.value==""))
		{
			if("Rate" == type)
			{
				if(checkTolerance(lowTolerance,highTolerance,rate))
				{
					 frm.action.value  = sAction;
					 convertToCaps();
					 frm.submit();
				}
			}
			else
			{
				frm.action.value  = sAction;
				convertToCaps();
				frm.submit();
			}
		}
	}
    else
    {
	frm.rateCode.value = "";
	alert(finbranchResource.FAT000001);
	}
}

function fnShowListNreturn(sURL,obj)
{
    openModalWindow(sURL,obj);
}

function openDocWindow(URL)
{
	window.open(URL,"DocumentDetails","Width=800,Height=400, Top=100, Left=70");
}
function openDenomWindow(URL)
{
	window.open(URL,"DenominationDetails","Width=600,Height=400, Top=100, Left=70");
}
function getRateInfoCommon(sAction,Currency1,Currency2)
{
	var frm = document.forms[0];
	if (Currency1.toUpperCase() != Currency2.toUpperCase())
    {
        frm.action.value  = sAction;
        convertToCaps();
        frm.submit();
    }
    else
    {
    	frm.rateCode.value = "";
    	alert(finbranchResource.FAT000001);
    }
}

function getRateInfoCommonTC(sAction,Currency1,Currency2,type,lowTolerance,highTolerance,rate)
{
   var frm = document.forms[0];
   	if (fnIsNull(frm.rateCode.value))
	{
		return;
	}
   if (Currency1.toUpperCase() != Currency2.toUpperCase())
    {
		if(!(frm.amount.value ==""  || Currency1 =="" || Currency2 ==""))
		{
		if("Rate" == type)
		{
		    if(checkTolerance(lowTolerance,highTolerance,rate))
		    {
		       frm.action.value  = sAction;
		       convertToCaps();
		       frm.submit();
		    }
		}
			else
			{
		           frm.action.value  = sAction;
           	 	   convertToCaps();
           	 	   frm.submit();
			}
		}
    }
    else
    {
        frm.rateCode.value = "";
        alert(finbranchResource.FAT000001);
    }
}

function setValue(obj,string)
{
    var objCtr=eval("document.forms[0]."+obj);
    objCtr.value = string;
}

function writeDenom()
{
    if(null == writeCustDenominations())
    {
	    with(document) {
		write('<OPTION selected VALUE=""></OPTION>');
	    write('<OPTION VALUE="1000">1000</OPTION>');
	    write('<OPTION VALUE="500">500</OPTION>');
	    write('<OPTION VALUE="100">100</OPTION>');
	    write('<OPTION VALUE="50">50</OPTION>');
	    write('<OPTION VALUE="20">20</OPTION>');
	    write('<OPTION VALUE="10">10</OPTION>');
	    write('<OPTION VALUE="5">5</OPTION>');
	    write('<OPTION VALUE="2">2</OPTION>');
	    write('<OPTION VALUE="1">1</OPTION>');
		}
    }
}

function writeDoc()
{
	if(null == writeCustDocumentTypes())
	{
		with(document) {
		write('<OPTION selected VALUE=""></OPTION>');
		write('<OPTION VALUE="PSPRT">Passport</OPTION>');
		write('<OPTION VALUE="SSNUM">Social Security No</OPTION>');
		write('<OPTION VALUE="NATID">Nation Id</OPTION>');
		write('<OPTION VALUE="DRVLC">Drivers Licence</OPTION>');
		write('<OPTION VALUE="OTHER">Other</OPTION>');
		}
	}
}

function formatAmtOnBlur(sAmtFormat,amtObj,crncyCode,checkValueObj)
{
	if("true" != checkValueObj.value)
	{
		formatAmountToMillionOrLakh(sAmtFormat,amtObj,crncyCode,"N")
	}
	if(isNaN(removeCommas(amtObj.value)))
	{
		amtObj.focus();
	}
	checkValueObj.value="false";
}

function fnOpenChargesWindow(chrgFlgObjName,chrgAmtObjName,
			exchgAmtObjName,grExchgAmtObjName,acctIdObjName,
			sellPurCrncyObj,evtIdObj,tcCrncyObj,chrgPgVisitedFlg,sGroupName,templateStatus)
{
	if(!templateCheck(templateStatus))
    {
    	return;
	}
	var frm = document.forms[0];
	chrgFlgObj 		= eval("frm."+chrgFlgObjName);
	chrgAmtObj		= eval("frm."+chrgAmtObjName);
	exchgAmtObj		= eval("frm."+exchgAmtObjName);
	grExchgAmtObj	= eval("frm."+grExchgAmtObjName);
	acctIdObj		= eval("frm."+acctIdObjName);
	if(null != acctIdObj)
	{
		acctIdVal = acctIdObj.value;
	}else
	{
		acctIdVal = "";
	}

	if(fnIsNull(sellPurCrncyObj.value))
	{
		alert(finbranchResource.FAT000520);
		sellPurCrncyObj.focus();
		return;
	}
	if(fnIsNull(evtIdObj.value))
	{
		alert(finbranchResource.FAT000521);
		evtIdObj.focus();
		return;
	}
	if((sGroupName == "cpurchase") ||(sGroupName == "tcpurchase"))
	{
		if(fnIsNull(grExchgAmtObj.value))
		{
			alert(finbranchResource.FAT000522);
			grExchgAmtObj.focus();
			return;
		}
		window.open("../../arjspmorph/"+applangcode+"/tc_crncy_charges.jsp?flag="+chrgFlgObj.value+"&chrgTCAmount="+grExchgAmtObj.value+"&eventID="+evtIdObj.value+"&acCrncy="+sellPurCrncyObj.value+"&chrgAmtObjName="+chrgAmtObjName+"&exchgAmtObjName="+exchgAmtObjName+"&grExchgAmtObjName="+grExchgAmtObjName+"&debitAcct="+acctIdVal+"&tcCrncy="+tcCrncyObj.value+"&chrgFlgObjName="+chrgFlgObjName,"chargesPage","width=650,height=300,top=60,left=80");

	}else
	{
		if(fnIsNull(exchgAmtObj.value))
		{
			alert(finbranchResource.FAT000522);
			exchgAmtObj.focus();
			return;
		}
		window.open("../../arjspmorph/"+applangcode+"/tc_crncy_charges.jsp?flag="+chrgFlgObj.value+"&chrgTCAmount="+exchgAmtObj.value+"&eventID="+evtIdObj.value+"&acCrncy="+sellPurCrncyObj.value+"&chrgAmtObjName="+chrgAmtObjName+"&exchgAmtObjName="+exchgAmtObjName+"&grExchgAmtObjName="+grExchgAmtObjName+"&debitAcct="+acctIdVal+"&tcCrncy="+tcCrncyObj.value+"&chrgFlgObjName="+chrgFlgObjName,"chargesPage","width=650,height=300,top=60,left=80");
	}
	chrgPgVisitedFlg.value ="True";
}

function openUserAdditionalDtlWindow()
{
	window.open("../../arjspmorph/"+applangcode+"/additional_dtl.jsp","AdditionalDetails","width=750, height=300,left=25,top=100");
}

function showRateCodes()
{
	var frm = document.forms[0];
	if("selected" != frm.flag.value)
	{
		rateCode = frm.rateCode.value;
		var retVal = popModalWindow("../../arjspmorph/"+applangcode+"/rate_codes.jsp?wReturn=document.forms[0].rateCode&DebitCrncy="+frm.xCurrency.value+"&CreditCrncy="+frm.Currency.value,"RateCodes");
		if (retVal != null)
		{
			frm.rateCode.value = retVal;
		}
		if (!fnIsNull(frm.rateCode.value))
		{
			if(rateCode != frm.rateCode.value)
			{
				frm.rate.value = "";
				sCurr = frm.Currency.value;
				getRateInfoCrossCurrency("4",sCurr,"Code","","","");
			}
		}
	}
}

function checkForEnter(evt, obj)
{
    if (evt.keyCode == 13)
    {
        obj.focus();
        return false;
    }
}

function clearDescField(){

	for(i=0; i < arguments.length; i++  ){
		eval("document.forms[0]."+arguments[i]+".value=''");
	}
}
function getStatus(sTabReqd, sTabName){
	var frm = document.forms[0];
	var objCB = eval("frm.chk"+sTabName);
	if(fnValidateForm(sTabName)) {
		if( (sTabReqd == "Y") && !(objCB.checked) ) {
			if( (objCB.getAttribute("fds") == null)||(objCB.getAttribute("fds") == "")||(objCB.getAttribute("fds") != "Y") )
				objCB.click();
		}
		frm.submitform.value=sTabName;
		convertToCaps();
		disableButtons();
		fnEnableDescFields(frm);
		frm.submit();
		return true;
	} else {
		return false;
	}
}

function setMandatory(blnMandatory){
	var sStar = "";
	if((blnMandatory == "true") || (blnMandatory == "Y")){
		sStar = "<font color='red'>*<font>";
	}
	document.write(sStar);
}
/*as directed by Srinivas for commenting this part
//Function to show the calendar
function openDate(obj,inpDate)
{
      //alert("cust_common_functions - openDate");
	var date = "";
	if(inpDate == null) inpDate = '';
	date = popModalWindowVar("../../arjspmorph/"+applangcode+"/date.jsp?txtDate="+obj.id+"&date="+inpDate,"Calendar",250,350,15,20);
	if(date != null)
	{
		//set the value to ui and hidden fields.
		obj.value = fnConvertToUIDate(date);
		fnAssignDateOnEnter(obj);
	}
}
*/
//Function to check if the amount is valid.
function isValidAmount(amount)
{
    amt = removeCommas(amount);
    if((amt.length >17)||(isNaN(amt)))
        return false;
    index =amt.indexOf(".");
    if(index > 14)
        return false;
    if((index== -1)&&(amt.length > 14))
        return false;
    return true;
}

function formReset(objForm)
{
	var frmElements = objForm.elements;
	var totalElements = frmElements.length;
	for(i = 0; i < totalElements; i++)
	{
			if((((frmElements[i].readOnly==false)||frmElements[i].readOnly==undefined)&&(frmElements[i].disabled ==false)) && ( (frmElements[i].type == 'text') || (frmElements[i].type == 'select-one') )){
						frmElements[i].value = '';
			}
			fieldObj = frmElements[i];
			dateFieldObjAttribute  = fieldObj.getAttribute("fdt");
			if (dateFieldObjAttribute != null && dateFieldObjAttribute == "fdate")
				frmElements[i].value = '';

			fieldObjAttributeValue = fieldObj.getAttribute("fds");
			/* field attribute value is null or blank, skip */
			if( (fieldObjAttributeValue == null) || (fieldObjAttributeValue == "") ) continue;
			fieldObjAttributeValue = fieldObjAttributeValue.toUpperCase();
			/* field attribute value is found, clear the field object*/
			if(fieldObjAttributeValue == "Y") frmElements[i].value = '';
	}
}

function setNumVal(sField,sVal)
{
	if(sVal =="0")
	eval("document.forms[0]."+sField+".value=''");
}

function fnValidateNumberFields(){
	var i = 0;
	var argc = arguments.length;
	for(; i < argc ; i++){
		arguments[i].value = fnTrim(arguments[i].value);
		if( !fnIsNull(arguments[i].value) && !fnIsPositiveNumber(arguments[i].value) ){
			err.setErr(arguments[i],finbranchResource.FAT000189);
			return false;
		}
	}
	return true;
}

function showConfirmDialog(sGrpName)
{
	var sMsg = finbranchResource.FAT000554;
	var sBtnOne = "Delete";
	var sBtnTwo = "Restore";
	var sBtnThree = "Modify";
	var frm = document.forms[0];
	if("Netscape" == browser_name)	{
		window.open("../../arjspmorph/"+applangcode+"/confirm_dialog.jsp?groupName="+sGrpName+"&Msg="+sMsg+"&BtnOne="+sBtnOne+"&BtnTwo="+sBtnTwo+"&BtnThree="+sBtnThree, "title",	"modal=yes, width=600, height=110,top=230,left=270,scrollbars=yes,toolbar=no,menubar=no");
	} else {
		frm.ConfirmChoice.value = window.showModalDialog("../../arjspmorph/"+applangcode+"/confirm_dialog.jsp?groupName="+sGrpName+"&Msg="+sMsg+"&BtnOne="+sBtnOne+"&BtnTwo="+sBtnTwo+"&BtnThree="+sBtnThree,"title","dialogWidth:40;dialogHeight:10;status=no;toolbar=no;menubar=no;resizable=no");
	}
	return frm.ConfirmChoice.value;
}

function submitFromErr(sGroupName, sErrLLName, sRecNo, sFocusField, sOuterErrLLName, sOuterRecNo)
{
	if(fnValidateForm())
	{
		var frm = document.forms[0];
		frm.submitform.value=sGroupName;
		frm.ErrLLName.value=sErrLLName;
		frm.RecNo.value=sRecNo;
		frm.FocusField.value=sFocusField;
		if(sOuterErrLLName != undefined && sOuterRecNo != undefined && !fnIsNull(sOuterErrLLName) && !fnIsNull(sOuterRecNo))
		{
			frm.OuterErrLLName.value = sOuterErrLLName;
			frm.OuterRecNo.value = sOuterRecNo;
		}
		convertToCaps();
		disableButtons();
		frm.submit();
	 }
}

//FUNCTIONS to handle ALERT errors
function displayErr(){
	if(this.hasErr){
		//set the focus for ui field.
		if(this.oId.getAttribute("fdt") == "fdate")
			fnSetFocusForDate(this.oId);
		else
			this.oId.focus();
		alert(this.sMsg);
		this.clearErr();
		this.hasErr = false;
	} else {
		//alert(finbranchResource.FAT000199);
	}
}

function setErr(oId, sMsg){
	this.hasErr = true;
	this.oId = oId;
	this.sMsg = sMsg;
}

function clearErr(){
	this.oId = "";
	this.sMsg = "";
}

function ErrObject(){
	this.hasErr = false;
	this.oId = "";
	this.sMsg = "";
	this.setErr = setErr;
	this.clearErr = clearErr;
	this.displayErr = displayErr;
}

function fnSelectField(groupName, errField){
	var ERR_FIELD_SEPARATOR = "_";
	var errFieldId = errField;
	var pgPos = errField.indexOf("pg");
	var dotPos = errField.indexOf(ERR_FIELD_SEPARATOR);
	if((dotPos != -1) && (pgPos != -1))
	{
		var fieldPrefix = errField.substr(0,2)

		if(fieldPrefix == "pg") //multi-page error
		{
			var errPgNum = errField.substring(2,dotPos);

			if(objForm.pgNum.value == errPgNum) {	//errField is on currenct page
				errFieldId = errField.substring(dotPos+1);
			} else {	//errField is on some other page
				if(fnValidateForm())
				{
					var frm = document.forms[0];
					frm.submitform.value=groupName;
					frm.FocusField.value=errField;
					convertToCaps();
					disableButtons();
					frm.submit();
				}
				return true;
			}
		}
	}

	var FieldObj= eval("document.forms[0]."+errFieldId);
	if(undefined !=  FieldObj && null != FieldObj)
	{
		if(FieldObj.disabled == false)
		{
			if(FieldObj.type == "text")
			{
				FieldObj.select();
			} else {
				FieldObj.focus();
			}
		}
	}
}

function fnValidateAmount(objAmtField, precision){

	var numericPart = 0;
	var decimalPart = 0;
	var iIndex = 0;
	var bValidAmount = true;
	var sourceAmt = removeCommas(objAmtField);
	var DEC_PART_LEN = 4;
	var NUM_PART_LEN = 14;
	var TOTAL_LEN = 17;

	if(isNaN(sourceAmt)){
		bValidAmount = false;
		alert(finbranchResource.FAT000189);
	} else {
		DEC_PART_LEN = DEC_PART_LEN > precision ? precision : DEC_PART_LEN;
		sourceAmt = checkZeroes(sourceAmt,precision);
		iIndex = sourceAmt.indexOf(".");
		if(iIndex == -1){
			numericPart = sourceAmt;
		} else {
			numericPart = sourceAmt.substring(0,iIndex);
			decimalPart = sourceAmt.substring(iIndex+1);
		}
		if(sourceAmt.length > TOTAL_LEN){
			bValidAmount = false;
			alert(finbranchResource.FAT000523+TOTAL_LEN + " " + finbranchResource.FAT000524);
		} else if(numericPart.length > NUM_PART_LEN){
			bValidAmount = false;
			alert(finbranchResource.FAT000525);
		} else if(decimalPart.length > DEC_PART_LEN){
			bValidAmount = false;
			alert(finbranchResource.FAT000523+DEC_PART_LEN + " " + finbranchResource.FAT000526);
		} else {

			switch(parseInt(DEC_PART_LEN,10))
			{
				case 3 :
					if(numericPart.length > 13)
					{
						bValidAmount = false;
						alert(finbranchResource.FAT000527 + DEC_PART_LEN);
					}
					break;
				case 4 :
					if(numericPart.length > 12)
					{
						bValidAmount = false;
						alert(finbranchResource.FAT000528 + DEC_PART_LEN);
					}
					break;
			}
		}
	}
	return bValidAmount;
}

// This Function Disables controls on a form.
function disableButtons()
{
	var obj=document.forms[0].elements;
	var len=obj.length;
	for(var i=0;i<len;i++)
	{
		switch(obj[i].type)
		{
			case "button" :
			case "submit" :
			case "reset" :

			obj[i].disabled=true;
			break;
		}
	}
	disableTabs();
}

/**	This function refines the string and returns the
*	parsed string. It looks for single quotes ('),
*	double quotes ("),less than (<), greater than (>),
*	etc. and precedes them with a "\".
*/
function refineString (parseString)
{
	var charArray=["'", "\"", "<", ">"];

	for(var i=0;i<charArray.length;i++)
	{
		var fromIndex = 0;
		var index = 0;
		var parseStr = null;

		switch(charArray[i])
		{
			case "'": parseStr="#39"; 	//ASCII for '\'';
				break;
			case "\"": parseStr="#34";	//ASCII for '"';
				break;
			case "<": parseStr="#60";	//ASCII for '<';
				break;
			case ">": parseStr="#62";	//ASCII for '>';
				break;
			default: parseStr="#34";	//ASCII for '"';
		}

		if (parseString == null || parseString.length == 0)
			return parseString;

		var tmp1,tmp2,tmp3;

		while (fromIndex < parseString.length)
		{
			index = parseString.indexOf (charArray[i]);

			if (index == -1)
			{
				fromIndex = parseString.length;
				continue;
			}

			tmp1 = parseString.substring(0,index);
			tmp2 = parseString.substring(index,index+1);
			tmp3 = parseString.substring(index+1,parseString.length);

			tmp2 = "&"+parseStr+";";

			parseString = tmp1+tmp2+tmp3;

			fromIndex++;
		}
	}

	return parseString;
}//End of refineString


/**	This function refines the string and returns the
*	parsed string. It looks for ASCII values of single quotes (&#39;),
*	double quotes (&#34;), etc. and precedes them with a "\".
*/
function addSlash (parseString)
{
	var charArray=["&#39;", "&#34;"];

	for(var i=0;i<charArray.length;i++)
	{
		var fromIndex = 0;
		var index = 0;
		var parseStr = null;

		if (parseString == null || parseString.length == 0)
			return parseString;

		var tmp1,tmp2,tmp3;

		while (fromIndex < parseString.length)
		{
			index = parseString.indexOf (charArray[i],fromIndex);

			if (index == -1)
			{
				fromIndex = parseString.length;
				continue;
			}

			tmp1 = parseString.substring(0,index);
			tmp2 = parseString.substring(index,index+1);
			tmp3 = parseString.substring(index+1,parseString.length);

			tmp2 = "\\"+tmp2;

			parseString = tmp1+tmp2+tmp3;

			fromIndex = index + 2;
		}
	}

	return parseString;
}//End of addSlash

/**
	To open a Search Account Id window - 13-Aug-2002 16:57:20.
	Modified by Sachin Tiwari, date: 01-Jan-05
	"doAutoSubmit" parameter is added to submit the results automatically. 
*/
function cust_showAccountIdList(acctObj,solId,acctName,inPreceedence,currDesc,defCrncyCode,defSchemeCode,defSchemeType,defSolId,defCifId,defGLSubHead,defOwnership,defShortName,defAcctLbl,defPartn,doAutoSubmit,defMasterAcctId)
{
/* Function modified to add input parameters to default in Account Id Criteria.
If these are not supplied, the list would continue working as before.
Note that the arguments.length <5 should be modified with care. */

	var sUrl = "";
	var preceedence = 'B';
	var strCrncyCode = "";
	var strSchemeCode = "";
	var strSchemeType = "";
	var strSolId = "";
	var strCifId = "";
	var strGLSubHead = "";
	var strOwnership = "";
	var strShortName = "";
	var strAcctLbl = "";
	var strPartn = "";
	var strSubmit = "";

/* Assigning default if passed */
	if(acctObj.value != ""){strShortName = acctObj.value;}

    if(defCrncyCode  == undefined){ strCrncyCode  = "";} else { strCrncyCode  = defCrncyCode;}
    if(defSchemeCode == undefined){ strSchemeCode = "";} else { strSchemeCode = defSchemeCode;}
    if(defSchemeType == undefined){ strSchemeType = "";} else { strSchemeType = defSchemeType;}
    if(defSolId      == undefined){ strSolId      = "";} else { strSolId      = defSolId;}
    if(defCifId     == undefined){ strCifId     = "";} else { strCifId     = defCifId;}
    if(defGLSubHead  == undefined){ strGLSubHead  = "";} else { strGLSubHead  = defGLSubHead;}
    if(defOwnership  == undefined){ strOwnership  = "";} else { strOwnership  = defOwnership;}
    if(defShortName  != undefined){ strShortName  = defShortName;}
    if(defAcctLbl    == undefined){ strAcctLbl  = "";} else { strAcctLbl  = defAcctLbl;}
    if(defPartn      == undefined){ strPartn = "";} else { strPartn = defPartn;}
	if(defMasterAcctId  == undefined){ strMasterAcctId  = "";} else { strMasterAcctId  = defMasterAcctId;}
	if(doAutoSubmit  == undefined){ strSubmit = "";} else { strSubmit = doAutoSubmit;}

    if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }
	if (arguments.length < 5)
	{
		sUrl = "../../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy=NULL&wReturnSol=NULL&wReturnAcct=NULL&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+strAcctLbl+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&doAutoSubmit="+strSubmit;
	}else
	{
		sUrl = "../../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy="+currDesc.id+"&wReturnSol="+solId.id+"&wReturnAcct="+acctName.id+"&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+strAcctLbl+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&doAutoSubmit="+strSubmit;
	}

	var retVal = popModalWindow(sUrl,"");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        if(acctObj!=null) acctObj.value = liarrBufArray[0];
			if(currDesc!=null) currDesc.value = liarrBufArray[1];
			if(solId!=null) solId.value = liarrBufArray[2];
			if(acctName!=null) acctName.value = liarrBufArray[3];
			
		}
    }
}

function popModalWindow(sUrl,wName){
	if("Netscape" == browser_name){
	window.open(sUrl,wName,"width=500,height=500,modal=yes,left=150,top=40,scrollbars=yes,toolbar=no,menubar=0");
	return;
	}
	else {
	var retval = window.showModalDialog(sUrl,wName,"dialogWidth:54;dialogHeight:27.25;status=no;toolbar=no;menubar=no;resizable=yes");
		return(retval);
		}
}

function showAcctLblCodes(txtObj,inPreceedence,txtObjDesc,ctrlOrMorph)
{
	var sUrl = "";
	var preceedence = 'B';

	if(arguments.length > 1)
    {
        preceedence = inPreceedence;
    }

	if (arguments.length < 3)
	{
		sUrl = "../../arjspmorph/"+applangcode+"/get_acctlbl_code.jsp?wReturn="+txtObj.id+"&wReturnDesc=NULL&acctLblCode="+escape(txtObj.value)+"&preceedence="+preceedence;
	}else
	{
		if (ctrlOrMorph != undefined && ctrlOrMorph != null && ctrlOrMorph == 'morph') {
			sUrl = "../";
		}
		var descId = (txtObjDesc != undefined && txtObjDesc != null) ? txtObjDesc.id : "NULL";
		sUrl += "../../arjspmorph/"+applangcode+"/get_acctlbl_code.jsp?wReturn="+txtObj.id+"&wReturnDesc="+descId+"&acctLblCode="+escape(txtObj.value)+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"",400,200,50,30);

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        txtObj.value = liarrBufArray[0];
			if(txtObjDesc != null) txtObjDesc.value = liarrBufArray[1];
		}
    }
}

function showAppLangCodes(txtObj,inPreceedence, txtObjDesc)
{
	var sUrl = "";
	var preceedence = 'B';

	if(arguments.length > 1)
    {
        preceedence = inPreceedence;
    }
	if (arguments.length < 3)
	{
		sUrl = "../../arjspmorph/"+applangcode+"/get_applang_list.jsp?wReturn="+txtObj.id+"&wReturnDesc=NULL&preceedence="+preceedence;
	}else
	{
		sUrl = "../../arjspmorph/"+applangcode+"/get_applang_list.jsp?wReturn="+txtObj.id+"&wReturnDesc="+txtObjDesc.id+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"AppLangCode");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        txtObj.value = liarrBufArray[0];
			if(txtObjDesc != null) txtObjDesc.value = liarrBufArray[1];
		}
    }
}

function  showCurrency(obj,ctrlOrMorph,inPreceedence,objDesc, delFlg)
{
	var crncyObj;
	var sUrl = "";
	var preceedence = 'B';
	var url = "../../";
	var delFlag = 'N';

/*	 Pass delFlg value 'N' (or default)for non-deleted records,
	'Y' for deleted records and 'B' for both					*/

	if(delFlg != null && delFlg != undefined)
	{
		delFlag = delFlg;
	}
    if(arguments.length > 1)
    {
		if(ctrlOrMorph == 'ctrl')
		url = "../../arjspmorph/";
    }
    if(browser_name != "Microsoft Internet Explorer")
    {
    		url = "../../arjspmorph/";
    }
	if(inPreceedence != null && inPreceedence != undefined)
    {
        preceedence = inPreceedence;
    }

	if(obj != null)	crncyObj = obj.id;

	if(objDesc ==null || objDesc == undefined)
	{
		sUrl = url +applangcode+"/get_currency.jsp?wReturn="+crncyObj+"&wReturnDesc=NULL&Currency="+escape(obj.value)+"&preceedence="+preceedence+"&delFlg="+delFlag;
	}else
	{
		sUrl = url +applangcode+"/get_currency.jsp?wReturn="+crncyObj+"&wReturnDesc="+objDesc.id+"&Currency="+escape(obj.value)+"&preceedence="+preceedence+"&delFlg="+delFlag;
	}

    var retVal = popModalWindow(sUrl,"CurrencyList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        obj.value = liarrBufArray[0];
			if(objDesc != null) objDesc.value = liarrBufArray[1];
		}
    }
}

function showRoutingCurrency(obj,ctrlOrMorph,inPreceedence,objDesc)
{
	var crncyObj;
	var sUrl = "";
	var preceedence = 'B';
	var url = "../../";

    if(arguments.length > 1)
    {
		if(ctrlOrMorph == 'ctrl')
		url = "../../arjspmorph/";
    }
    if(browser_name != "Microsoft Internet Explorer")
    {
    		url = "../../arjspmorph/";
    }
    if(arguments.length > 2)
    {
        preceedence = inPreceedence;
    }

	if(obj != null)	crncyObj = obj.id;

	if (arguments.length < 4)
	{
		sUrl = url +applangcode+"/get_currency.jsp?wReturn="+crncyObj+"&wReturnDesc=NULL&Currency="+escape(obj.value)+"&preceedence="+preceedence+"&ccyFlg=Y";
	}else
	{
		sUrl = url +applangcode+"/get_currency.jsp?wReturn="+crncyObj+"&wReturnDesc="+objDesc.id+"&Currency="+escape(obj.value)+"&preceedence="+preceedence+"&ccyFlg=Y";
	}

    var retVal = popModalWindow(sUrl,"CurrencyList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        obj.value = liarrBufArray[0];
			if(objDesc != null) objDesc.value = liarrBufArray[1];
		}
    }
}

function showCustId(obj,ctrlOrMorph,inPreceedence,objDesc)
{
	var custObj = "";
	var sUrl = "";
	var preceedence = 'B';
	var url = "../../arjspmorph/";

    if(arguments.length > 1)
    {
		if(ctrlOrMorph == 'morph')
		url = "../../";
	}

    if(browser_name != "Microsoft Internet Explorer")
    {
    		url = "../../arjspmorph/";
    }
    if(arguments.length > 2)
    {
        preceedence = inPreceedence;
    }

	if(obj != null)	custObj = obj.id;

	if (arguments.length < 4)
	{
		sUrl = url + applangcode+"/get_cust_id.jsp?wReturn="+custObj+"&wReturnDesc=NULL&preceedence="+preceedence;
	}else
	{
		sUrl = url + applangcode+"/get_cust_id.jsp?wReturn="+custObj+"&wReturnDesc="+objDesc.id+"&preceedence="+preceedence;
	}
    var retVal = popModalWindow(sUrl,"CustId");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        obj.value = liarrBufArray[0];
			if(objDesc != null) objDesc.value = liarrBufArray[1];
		}
    }
}

function showDsaList(dsaObj,schm,crncy,type,inPreceedence,dsaObjDesc)
{
	var sUrl = "";
	var preceedence = 'B';

	if(arguments.length > 4)
    {
        preceedence = inPreceedence;
    }
	if (arguments.length < 6)
	{
		sUrl = "../../arjspmorph/"+applangcode+"/get_dsa_list.jsp?wReturn="+dsaObj.id+"&wReturnDesc=NULL&dsaId="+escape(dsaObj.value)+"&schmCode="+schm+"&crncyCode="+crncy+"&dsaType="+type+"&preceedence="+preceedence;
	}else
	{
		sUrl = "../../arjspmorph/"+applangcode+"/get_dsa_list.jsp?wReturn="+dsaObj.id+"&wReturnDesc="+dsaObjDesc.id+"&dsaId="+escape(dsaObj.value)+"&schmCode="+schm+"&crncyCode="+crncy+"&dsaType="+type+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"DsaList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        dsaObj.value = liarrBufArray[0];
			if(dsaObjDesc != null) dsaObjDesc.value = liarrBufArray[1];
		}
    }
}

function showEmplList(empObj,solObj,ctrlOrMorph,inPreceedence,empObjDesc,delFlg,verFlg)
{
	var custObj = "";
	var sUrl = "";
	var preceedence = 'B';
	var solId = "";
	var url = "../../";
    	if(arguments.length > 2)
	{
		if(ctrlOrMorph == 'ctrl')
			url = "../../arjspmorph/";
	}
	if(browser_name != "Microsoft Internet Explorer")
	{
		url = "../../arjspmorph/";
	}
	if (delFlg == null || delFlg == undefined)
        delFlg = "";
    if (verFlg == null || verFlg == undefined)
	        verFlg = "";


    	if(arguments.length > 3)
    	{
			preceedence = inPreceedence;
    	}
	if (solObj != null && solObj != undefined) solId = solObj.value;

	if (arguments.length < 5)
	{
		sUrl = url +applangcode+"/emp_list.jsp?wReturn="+empObj.id+"&wReturnDesc=NULL&shortName="+escape(empObj.value)+"&solId="+solId+"&preceedence="+preceedence+"&delFlg="+delFlg+"&verFlg="+verFlg;
	}else
	{
		sUrl = url +applangcode+"/emp_list.jsp?wReturn="+empObj.id+"&wReturnDesc="+empObjDesc.id+"&shortName="+escape(empObj.value)+"&solId="+solId+"&preceedence="+preceedence+"&delFlg="+delFlg+"&verFlg="+verFlg;
	}

    var retVal = popModalWindow(sUrl,"EmplIdList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        empObj.value = liarrBufArray[0];
			if(empObjDesc != null) empObjDesc.value = liarrBufArray[1];
		}
    }
}

function showGLSubHead(glObj,ctrlOrMorph,inPreceedence, glObjDesc,solId, crncy)
{
	  var glsubhead = "";
	var sUrl = "";
	var preceedence = 'B';
	 var url = "../../";

 	if(arguments.length > 1)
	{
		if(ctrlOrMorph == 'ctrl')
		url = "../../arjspmorph/";
	}
	if(browser_name != "Microsoft Internet Explorer")
	{
		url = "../../arjspmorph/";
	}

    	if(arguments.length >2)
    	{
    	    preceedence = inPreceedence;
    	}

    	if (solId == null || solId == undefined)
	{
		solId = "";
	}
	if (crncy == null || crncy == undefined)
	{
		crncy = "";
    	}

    if(glObj != null)
	{
		glsubhead = glObj.id;
	}

	if (glObjDesc == null || glObjDesc == undefined)
	{
		sUrl = url +applangcode+ "/get_gl_subhead.jsp?wReturn="+glsubhead+"&wReturnDesc=NULL&GLSubHead="+escape(glObj.value)+"&solId="+solId+"&crncy="+crncy+"&preceedence="+preceedence;
	}else
	{
		sUrl = url +applangcode+ "/get_gl_subhead.jsp?wReturn="+glsubhead+"&wReturnDesc="+glObjDesc.id+"&GLSubHead="+escape(glObj.value)+"&solId="+solId+"&crncy="+crncy+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"GetGLSubHeadList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        glObj.value = liarrBufArray[0];
	    	if(glObjDesc != null) glObjDesc.value = liarrBufArray[1];
		}
	}
}

function showIntRateCodes(txtObj,inPreceedence,txtObjDesc)
{
	var sUrl = "";
	var preceedence = 'B';

	if(arguments.length > 1)
    {
        preceedence = inPreceedence;
    }

	if (arguments.length < 3)
	{
		sUrl = "../../arjspmorph/"+applangcode+"/search_intratecode.jsp?wReturn="+txtObj.id+"&wReturnDesc=NULL&acctLblCode="+escape(txtObj.value)+"&preceedence="+preceedence;
	}else
	{
		sUrl = "../../arjspmorph/"+applangcode+"/search_intratecode.jsp?wReturn="+txtObj.id+"&wReturnDesc="+txtObjDesc.id+"&acctLblCode="+escape(txtObj.value)+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"IntRateCodes");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        txtObj.value = liarrBufArray[0];
			if(txtObjDesc != null) txtObjDesc.value = liarrBufArray[1];
		}
    }
}


function showIntRateCodesWithSchmType(txtObj,inPreceedence,schmType,txtObjDesc)
{
    var sUrl = "";
    var preceedence = 'B';

    if(arguments.length > 1)
    {
        preceedence = inPreceedence;
    }

    if (arguments.length < 4)
    {
        sUrl = "../../arjspmorph/"+applangcode+"/search_intratecode.jsp?wReturn="+txtObj.id+"&wReturnDesc=NULL&acctLblCode="+escape(txtObj.value)+"&preceedence="+preceedence+"&schmType="+schmType;
    }else
    {
        sUrl = "../../arjspmorph/"+applangcode+"/search_intratecode.jsp?wReturn="+txtObj.id+"&wReturnDesc="+txtObjDesc.id+"&acctLblCode="+escape(txtObj.value)+"&preceedence="+preceedence+"&schmType="+schmType;
    }

    var retVal = popModalWindow(sUrl,"IntRateCodes");

    if ("Microsoft Internet Explorer" == browser_name)
    {
        if (retVal != null && retVal != undefined )
        {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");

            txtObj.value = liarrBufArray[0];
            if(txtObjDesc != null) txtObjDesc.value = liarrBufArray[1];
        }
    }
}


//Function to show the ref_code list
function showRefCode(obj1,refType,delFlgInd,inPreceedence,obj2)
{
	var refCode = obj1.value;
	var url = "";
	var preceedence = 'B';

	if(refCode == null) refCode = '';

	if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }

	if (arguments.length < 5)
	{
		url = "../../arjspmorph/"+applangcode+"/get_ref_code.jsp?wReturn="+ obj1.id +"&wReturnDesc=NULL&refType="+refType+"&refCode="+escape(refCode)+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
	}else
	{
		url = "../../arjspmorph/"+applangcode+"/get_ref_code.jsp?wReturn="+ obj1.id +"&wReturnDesc="+ obj2.id +"&refType="+refType+"&refCode="+escape(refCode)+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(url,"RefCodeList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        obj1.value = liarrBufArray[0];
			if(obj2 != null) obj2.value = liarrBufArray[1];
		}
    }
}

function showSchemeCode(schmCode,ctrlOrMorph,inPreceedence,schmCodeDesc)
{
	var sUrl = "";
	var preceedence = 'B';
	var url = "../../arjspmorph/";

	if(arguments.length > 1)
	{
		if(ctrlOrMorph == 'ctrl')
			url = "../../arjspmorph/";
    	}
	if(browser_name != "Microsoft Internet Explorer")
	{
		url = "../../arjspmorph/";
	}

    	if(arguments.length >2)
    {
        preceedence = inPreceedence;
    }
	if (arguments.length < 4)
	{
		sUrl = url +applangcode+ "/get_scheme_code.jsp?wReturn="+schmCode.id+"&wReturnDesc=NULL&SchemeCode="+escape(schmCode.value)+"&preceedence="+preceedence;
	}else
	{
		sUrl = url +applangcode+ "/get_scheme_code.jsp?wReturn="+schmCode.id+"&wReturnDesc="+schmCodeDesc.id+"&SchemeCode="+escape(schmCode.value)+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"SchemeCodeList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        schmCode.value = liarrBufArray[0];
	    	if(schmCodeDesc != null) schmCodeDesc.value = liarrBufArray[1];
		}
	}
}

function showSchemeType(schmType,ctrlOrMorph,inPreceedence,schmTypeDesc)
{
	var sUrl = "";
	var preceedence = 'B';
	var url = "../../";

	if(arguments.length > 1)
	{
		if(ctrlOrMorph == 'ctrl')
			url = "../../arjspmorph/";
    	}
	if(browser_name != "Microsoft Internet Explorer")
	{
		url = "../../arjspmorph/";
	}

	if(arguments.length > 2)
	{
		preceedence = inPreceedence;
	}

	if (arguments.length < 4)
	{
		sUrl = url+applangcode + "/get_scheme_type.jsp?wReturn="+schmType.id+"&wReturnDesc=NULL&SchemeType="+escape(schmType.value)+"&preceedence="+preceedence;
	}else
	{
		sUrl = url+ applangcode +"/get_scheme_type.jsp?wReturn="+schmType.id+"&wReturnDesc="+schmTypeDesc.id+"&SchemeType="+escape(schmType.value)+"&preceedence="+preceedence;
	}
	var retVal = popModalWindow(sUrl,"SchemeTypeList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        schmType.value = liarrBufArray[0];
	    	if(schmTypeDesc != null) schmTypeDesc.value = liarrBufArray[1];
		}
	}
}

function showSchmCodes(schmObj,glObj,sol,listWanted,inPreceedence,schmDesc,SchmType,crncyCode)
{
	var id = '';
	var schm = "";
	var glSubHead="";
	var DummySchmType = "";
	var DummyCrncy = "";

	var sUrl = "";
	var preceedence = 'B';
	var other = "NULL";

	if(SchmType == undefined)
	{
		DummySchmType = "";
	}
	else
	{
		DummySchmType = SchmType;
	}
	if(crncyCode == undefined)
	{
		DummyCrncy = "";
	}
	else
	{
		DummyCrncy = crncyCode.value;
	}

	if (listWanted == "schmcode")
	{
		id = schmObj.id;
		schm = schmObj.value;
		if(glObj != null)
			glSubHead=glObj.value;


		if(glObj != null) other = glObj.id;
	}else
	{
		id = glObj.id;
		if(schmObj != null)
			schm = schmObj.value;
		glSubHead=glObj.value;

		if(schmObj != null) other = schmObj.id;
	}

	if(arguments.length > 4)
    	{
    	    preceedence = inPreceedence;
    	}
	if (arguments.length < 6)
	{

		sUrl = "../../arjspmorph/"+applangcode+"/search_scheme.jsp?wReturn="+id+"&wReturnDesc=NULL&solId="+sol+"&listreqd="+listWanted+"&schmCode="+escape(schm)+"&glSubHead="+escape(glSubHead)+"&other="+other+"&preceedence="+preceedence+"&schemeType="+DummySchmType+"&crncy="+DummyCrncy;
	}
	else
	{
		sUrl = "../../arjspmorph/"+applangcode+"/search_scheme.jsp?wReturn="+id+"&wReturnDesc="+schmDesc.id+"&solId="+sol+"&listreqd="+listWanted+"&schmCode="+escape(schm)+"&glSubHead="+escape(glSubHead)+"&other="+other+"&preceedence="+preceedence+"&schemeType="+DummySchmType+"&crncy="+DummyCrncy;
	}


	var retVal = popModalWindow(sUrl,"SchemeCodes");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined)
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

			if (listWanted == "schmcode")
			{
				if(schmObj != null) schmObj.value = liarrBufArray[0];
				if(schmDesc != null) schmDesc.value = liarrBufArray[1];
				if(glObj != null) glObj.value = liarrBufArray[2];
			}else
			{
				if(glObj != null) glObj.value = liarrBufArray[0];
				if(schmDesc != null) schmDesc.value = liarrBufArray[1];
				if(schmObj != null) schmObj.value = liarrBufArray[2];
			}
		}
	}
}

function showSetList(obj,ctrlOrMorph,inPreceedence,objDesc)
{
	var set = "";
	var sUrl = "";
	var preceedence = 'B';
	var url = "../../arjspmorph/";

    if(arguments.length > 1)
    {
		if(ctrlOrMorph == 'morph')
		url = "../../";
	}

	obj.value = obj.value.replace(/\'/,"\"");

    if(arguments.length > 2)
    {
        preceedence = inPreceedence;
    }

	if(obj != null)
	{
		set = obj.id;
	}

	if (arguments.length <4)
	{
		sUrl = url +applangcode+"/get_set_list.jsp?SetId="+escape(obj.value)+"&wReturn="+set+"&wReturnDesc=NULL&preceedence="+preceedence;
	}else
	{
		sUrl = url +applangcode+"/get_set_list.jsp?SetId="+escape(obj.value)+"&wReturn="+set+"&wReturnDesc="+objDesc.id+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"SetIdList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        obj.value = liarrBufArray[0];
			if(objDesc != null) objDesc.value = liarrBufArray[1];
		}
    }
}

function showSolId(obj,ctrlOrMorph,inPreceedence,objDesc)
{
	var sol = "";
	var sUrl = "";
	var preceedence = 'B';
	var url = "../../arjspmorph/";

    if(arguments.length > 1)
    {
		if(ctrlOrMorph == 'morph')
		url = "../../";
    }
    if(browser_name != "Microsoft Internet Explorer")
    {
	url = "../../arjspmorph/";
    }
    if(arguments.length > 2)
    {
        preceedence = inPreceedence;
    }

	if(obj != null)
	{
		sol = obj.id;
	}

	if (arguments.length <4)
	{
		sUrl = url +applangcode+"/get_sol_list.jsp?wReturn="+sol+"&SolId="+escape(obj.value)+"&wReturnDesc=NULL&preceedence="+preceedence;
	}else
	{
		sUrl = url +applangcode+"/get_sol_list.jsp?wReturn="+sol+"&SolId="+escape(obj.value)+"&wReturnDesc="+objDesc.id+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"SolIdList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        obj.value = liarrBufArray[0];
			if(objDesc != null) objDesc.value = liarrBufArray[1];
		}
    }
}

function showUserIdList(userObj,solObj,inPreceedence,userDescObj, delFlg)
{
    var solId = "";
	var sUrl = "";
	var preceedence = 'B';
	var userDesc = "NULL";
	if(arguments.length > 2)
    {
        preceedence = inPreceedence;
    }

    if (solObj != null && solObj != undefined)
        solId = solObj.value;
	if (delFlg == null || delFlg == undefined)
		delFlg = "";
	if (userDescObj != null && userDescObj != undefined)
		userDesc = userDescObj.id;
	if (arguments.length < 4)
	{
		sUrl = "../../arjspmorph/"+applangcode+"/user_list.jsp?wReturn="+userObj.id+"&wReturnDesc=NULL&userId="+escape(userObj.value)+"&solId="+solId+"&preceedence="+preceedence+"&delFlg="+delFlg;
	}else
	{
		sUrl = "../../arjspmorph/"+applangcode+"/user_list.jsp?wReturn="+userObj.id+"&wReturnDesc="+userDesc+"&userId="+escape(userObj.value)+"&solId="+solId+"&preceedence="+preceedence+"&delFlg="+delFlg;
	}

    var retVal = popModalWindow(sUrl,"UserIdList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        userObj.value = liarrBufArray[0];
	    	if(userDescObj != null) userDescObj.value = liarrBufArray[1];
		}
    }
}

function showPrinterList(prntrIdObj, prntrInd, delFlg, inPreceedence, prntrDescObj)
{
    var prntrId		= "";
	var sUrl		= "";
	var preceedence = 'B';
	var prntrDesc	= "NULL";
	preceedence = inPreceedence;

    if (prntrIdObj != null && prntrIdObj != undefined)
        prntrId = prntrIdObj.value;
	if (delFlg == null || delFlg == undefined)
		delFlg = "";
	if (prntrDescObj != null && prntrDescObj != undefined)
		prntrDesc = prntrDescObj.id;

	if (arguments.length < 4)
	{
		sUrl = "../../arjspmorph/"+applangcode+"/get_printer_list.jsp?wReturn="+prntrIdObj.id+"&wReturnDesc=NULL&prntrId="+escape(prntrId)+"&prntrInd="+ prntrInd +"&preceedence="+preceedence+"&delFlg="+delFlg;
	}else
	{
		sUrl = "../../arjspmorph/"+applangcode+"/get_printer_list.jsp?wReturn="+prntrIdObj.id+"&wReturnDesc="+prntrDesc+"&prntrId="+escape(prntrId)+"&prntrInd="+ prntrInd +"&preceedence="+preceedence+"&delFlg="+delFlg;
	}

    var retVal = popModalWindow(sUrl,"PrinterIdList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        prntrIdObj.value = liarrBufArray[0];
	    	if(prntrDescObj != null) prntrDescObj.value = liarrBufArray[1];
		}
    }
}
function disableFields()
{
	for(i=0; i < arguments.length; i++  ){
			obj = 	eval("document.forms[0]."+arguments[i]);
			if((undefined != obj)&&
				(null != obj))
			{
				//disable UI field for given hidden field.
				if(obj.fdt == "fdate")
					fnEnableUIField(obj,"N");
				else
					obj.disabled = true;
			}
	}
}

function enableFields()
{
	for(i=0; i < arguments.length; i++  ){
		obj = 	eval("document.forms[0]."+arguments[i]);
		if((undefined != obj) && (null != obj))
		{
			//enable ui field for given hidden field.
			if( obj.fdt == "fdate" )
				fnEnableUIField(obj,"Y");
			else
				obj.disabled = false;
		}
	}
}

function fnPopUpExceptionWindow(returnObj){
        funcName = "this."+"locfnPopUpExceptionWindow";
        if(eval(funcName) != undefined){
                return eval(funcName).call(this);
        }
        if(sPopUpExceptionWindow.toUpperCase() != 'TRUE') return;
        var returnObjId = "submitform"; //default return object id
        if((returnObj != null) && (returnObj != undefined)){
                returnObjId = returnObj.id;
        }
        var retVal = popModalWindowVarRef("../arjspmorph/"+applangcode+"/excp_popup_screen.jsp?wReturn=submitform", "excp_popup_screen","300","200","43","24");
        if ((retVal != null) && (retVal != undefined)){
                eval("document.forms[0]."+returnObjId+".value = '"+retVal+"'");
        }
        if(eval("document.forms[0]."+returnObjId+".value == 'Submit'")){
                fnAssignDateOnLoad(document.forms[0]);
                document.forms[0].callMode.value = 'N';
                document.forms[0].Submit.click();
        }
    if( eval("document.forms[0]."+returnObjId+".value == 'Refer'")){
                document.forms[0].submitform.value = 'REFERDATA';
                document.forms[0].actionCode.value='REFERDATA';
                document.forms[0].submit();
    }
        
        if( eval("document.forms[0]."+returnObjId+".value == 'RefSubmit'")){
                fnAssignDateOnLoad(document.forms[0]);
                document.forms[0].Submit.click();
    }
}


function validateAsciiData(obj)
{

   var isMultByte = obj.getAttribute("fmb");
   if (!(isMultByte =='Y' ) && (!isAsciiVal(obj.value)) )
   {
       return false;
   }
   return true;
}
function isAsciiVal(str)
{
     if(fnIsNull(str)) {
	     return true;
     }

    for (i=0,n=str.length;i<n;i++)
    {
      if(str.charCodeAt(i) >= 127)
      {
         return false;
      }
    }
   return true;
}

//	This function validates all the form controls based on their datatypes
//	Added by Vasudevan G on 29-08-02

function validateTypes(objForm) {
	var frmElements = objForm.elements;
	var obj;
	for(var i=0; i < frmElements.length; i++){
		obj = frmElements[i];
		var datatype = obj.getAttribute("fdt");
		if ((obj.type != "hidden") && (obj.disabled != true) && (obj.readOnly != true)) {
			if ((datatype == null) && (!validateAsciiData(obj)))
			{
       			alert(finbranchResource.FAT000591);
       			obj.focus();
	       		return false;
  	    	}
		}

		if ((datatype != null) && ((datatype != "")) && ((datatype.length != 0))){

			//If DataType is Date
			if (datatype == 'fdate')	{
				if (!fnIsValidDate(obj)) {
					alert(finbranchResource.FAT000188);
					fnSetFocusForDate(obj);
					return false;
				}
			}

			//If DataType is Date
			if (datatype == 'ftime')	{
				if (!fnIsValidTime(obj.value)) {
					alert(finbranchResource.FAT000278);
					obj.focus();
					return false;
				}
			}

			//If DataType is Percentage
            if (datatype == 'fpcnt' || datatype == 'fnpcnt')
            {
                if (!fnIsNull(obj.value))
                {
                    var chk = (isNaN(obj.value) || obj.value.indexOf(" ") != -1 || parseFloat(obj.value)>100) || (datatype == 'fpcnt' && parseFloat(obj.value) < 0);
                    if (chk)
                    {
                        alert("Invalid Entry");
                        obj.focus();
                        return false;
                    }

                    if (!fnValidatePercent(obj.value,6))
                    {
                        obj.focus();
                        return false;
                    }
                }
            }

			//If DataType is Integer
			if (datatype == 'fint')	{
				if (!fnIsNull(obj.value)) {
					if ((isNaN(obj.value)) || (obj.value.indexOf(".") != -1)) {
						alert(finbranchResource.FAT000201);
						obj.focus();
						return false;
					}
				}
			}

			//If DataType is PositiveInteger
			if (datatype == 'fpint')	{
				if (!fnIsNull(obj.value)) {
					if (((isNaN(obj.value)) || (obj.value.indexOf(".") != -1) || (parseFloat(obj.value) <= 0))) {
						alert(finbranchResource.FAT000202);
						obj.focus();
						return false;
					}

					if(!fnValidateSpecialChars(obj))
						return false;
				}
			}

			//If DataType is Conversion Rate
			//((!isNaN(obj.value)) ||
			if (datatype == 'frate')	{
				if ((isNaN(obj.value)) || (((!fnIsNull(obj.value)) && (!fnValidateConvRate(obj,10))))){
						alert(finbranchResource.FAT000203);
						obj.focus();
						return false;
				}
				if(parseFloat(obj.value)<0) {
					alert(finbranchResource.FAT000487);
					obj.focus();
					return false;
				}
			}
			//If DataType is PositiveInteger with Zero
			if (datatype == 'fpzint')    {
					if (!fnIsNull(obj.value)) {
							if (((isNaN(obj.value)) || (obj.value.indexOf(".") != -1) || (parseFloat(obj.value) < 0))) {
									alert(finbranchResource.FAT000277);
									obj.focus();
									return false;
							}
					}
			}
		}
	}
	return true;
}

//	This function validates the coversion rate form field
//	Added by Vasudevan G on 29-08-02
function fnValidateConvRate(objAmtField, precision){
	var numericPart = 0;
	var decimalPart = 0;
	var iIndex = 0;
	var bValidAmount = false;
	var sourceAmt = objAmtField.value;
	var DEC_PART_LEN = 10;
	var NUM_PART_LEN = 11;
	var TOTAL_LEN = 21;

	if(isNaN(sourceAmt)){
		alert(finbranchResource.FAT000189);
	} else {
		iIndex = sourceAmt.indexOf(".");
		if(iIndex == -1){
			numericPart = sourceAmt;
		} else {
			numericPart = sourceAmt.substring(0,iIndex);
			decimalPart = sourceAmt.substring(iIndex+1);
			DEC_PART_LEN = DEC_PART_LEN > precision ? precision : DEC_PART_LEN;
		}
		if(sourceAmt.length > TOTAL_LEN){
			alert(finbranchResource.FAT000523+TOTAL_LEN+finbranchResource.FAT000524);
		} else if(numericPart.length > NUM_PART_LEN){
			alert(finbranchResource.FAT000529);
		} else if(decimalPart.length > DEC_PART_LEN){
			alert(finbranchResource.FAT000523+DEC_PART_LEN+finbranchResource.FAT000526);
		} else {
			bValidAmount = true;
		}
	}
	objAmtField.value = sourceAmt;
	return bValidAmount;
}

function isPageEmpty(objForm)
{
	var FMND_ATTRIB_NAME = "fmnd";
	var frmElem = objForm.elements;
	var fmndVal = ""

	for(var i=0; i < frmElem.length; i++)
	{
		fmndVal = frmElem[i].getAttribute(FMND_ATTRIB_NAME) ;
		if( (fmndVal != null) && (fmndVal != "") )
		{
			fmndVal = fmndVal.toUpperCase();
			if( ( (fmndVal == 'Y' ) || (fmndVal == 'TRUE' ) )  && !fnIsNull(frmElem[i].value) )
				return false;
		}
	}
	return true;
}

//Function to show the report code list
function showReportCode(inpObj, acctIdValue, inPrecedence)
{
	var url = "";
	var precedence = 'B';

	if(arguments.length > 2)
	{
	    precedence = inPrecedence;
   	}
	url = "../../arjspmorph/"+applangcode+"/report_codes.jsp?wReturn="+ inpObj.Id+"&acctId="+acctIdValue+"&precedence="+precedence;

	var retVal = popModalWindow(url,"RefCodeList");
	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			var liarrBufArray = retVal.split("|");
	        if(inpObj!=null) inpObj.value = liarrBufArray[0];
		}
	}
}

/* enables label[readonly] fields */
function fnEnableDescFields(objForm)
{
	fnEnableFieldsBasedOnAttribute(objForm, "fds", "Y")
}

/* enables fields based on the attribute and its value */
function fnEnableFieldsBasedOnAttribute(objForm, sAttributeName, sAttributeValue)
{
	var frmElem = objForm.elements;
	var frmElemLen = frmElem.length;
	var fieldObj = "";
	var fieldObjAttributeValue = "";
	for(iCount = 0; iCount < frmElemLen; iCount++)
	{
		fieldObj = frmElem[iCount];
		fieldObjAttributeValue = fieldObj.getAttribute(sAttributeName);

		/* field attribute value is null or blank, skip */
		if( (fieldObjAttributeValue == null) || (fieldObjAttributeValue == "") ) continue;
		fieldObjAttributeValue = fieldObjAttributeValue.toUpperCase();

		/* field attribute value is found, disable the field object*/
		if(fieldObjAttributeValue == sAttributeValue.toUpperCase()) fieldObj.disabled = false;
	}
}

/* validates form fields based on fmnd [mandatory] attribute and its value */
function fnValidateMandatoryFields()
{
	var frmElem = document.forms[0].elements;
	var frmElemLen = frmElem.length;
	var fieldObj = "";
	var mandatoryAttributeValue = "";

	for(iCount = 0; iCount < frmElemLen; iCount++)
	{
		fieldObj = frmElem[iCount];

		/* field obj is neither text or select type, skip validation */
	if((fieldObj.type != 'text') && (fieldObj.type != 'select-one') && (fieldObj.type != 'textarea')) continue;
		mandatoryAttributeValue = fieldObj.getAttribute("fmnd");

		/* mandatory attribute value is null or blank, skip validation */
		if( (mandatoryAttributeValue == null) || (mandatoryAttributeValue == "") ) continue;
		mandatoryAttributeValue = mandatoryAttributeValue.toUpperCase();

		/* mandatory attribute value is either true or y[es], do validation */
		if( (mandatoryAttributeValue == "TRUE") || (mandatoryAttributeValue == "Y") )
		{
			/* field object value is either null or blank, alert err msg */
			if( fnIsNull(fieldObj.value) )
			{
				fieldObj.focus();
				alert(finbranchResource.FER000134);
				return false;
			}

			fieldType = fieldObj.getAttribute("fdt");
			/* field type is numeric type, check if it is zero*/
			if( (fieldType != null) && (fieldType != "") && ((fieldType == "fint") || (fieldType == "fpint") || (fieldType == "frate")) )
			{
				if( isNaN(fieldObj.value) || (Number(fieldObj.value) == 0) )
				{
					fieldObj.focus();
					alert(finbranchResource.FAT000146);
					return false;
				}
			}
		}
	}
	/* everything is okey */
	return true;
}

/*	CALL THIS FUNCTION IN PAGE ONLOAD EVENT HANDLER		*/
var theBuffer;

function initialize()
{
	theBuffer = new exchanger("myframe");
}

/*	CALL THIS FUNCTION WHEN DATA NEEDS TO BE SENT TO THE SERVER		****
*	This function builds a url based on the return values expected and sends the data to server.
*	@fetchId		- 	This field is helpful to indicate which function to call in the backend
*	@precedence		-	This field is helpful to set the precedence (FAB or FIN) in the backend
*	@wReturn		-	This field is helpful to the take the value as parameter for fetching the record from the backend
*	@wReturnDesc	-	This field is the helpful to populate the return value. This is used for populating return values.
*						This field will contain '|' seperated html element id's into which the return values need to be
*						populated.
*
* This function needs to be called from a local javascript function with the
* group link javacript after checking the field for null value.If the field is
* null then call the clearDescField() function with the required parameters.
*/
function sendDataToServer(frameName,fetchId, precedence, wReturn, wReturnDesc)
{
	var strArray = wReturn.split("|");
	var tmpStr="";

	if (strArray.length > 0)
	{
		for (var i=0;i<strArray.length;i++)
		{
			tmpStr = tmpStr+"|"+eval('document.forms[0].'+strArray[i]+'.value');
		}

		tmpStr = tmpStr.substring(1);
	}

    var sUrl = "../arjspmorph/"+applangcode+"/frm_fetch.jsp?fetchId="+fetchId+"&precedence="+precedence;
	if(wReturn != '')
		sUrl = sUrl+"&wReturn="+tmpStr;

	if(wReturnDesc != '')
		sUrl = sUrl+"&wReturnDesc="+wReturnDesc;

    var xMax = screen.width, yMax = screen.height;
    var xOffset = (xMax - 120), yOffset = (yMax - 150);
    var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
    params += ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no";

    if("Netscape" == browser_name)
        window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
    else {
    var inpData = wReturnDesc;
    var obj = document.forms[0];
    var outData = window.showModalDialog(sUrl,document.forms[0],params);
	if (outData.toLowerCase().indexOf("|") == -1)
	{
		if(outData != "")
			alert("\""+outData+"\"");
		return false;
	}

	var inBufferArr 	= 	inpData.split("|");
	var outBufferArr 	= 	outData.split("|");
	var checkDoubleSel	=   'N';

	if (inBufferArr.length > outBufferArr.length)
	{
		 alert("Input fields which needs to be populated are \nnot matching the return values");
		 return false;
	}

	for (i=0;i<inBufferArr.length;i++)
	{
		if(inBufferArr[i].substring(0,4) == 'sel1')
		{
		    eval("obj."+inBufferArr[i].substring(4,inBufferArr[i].length)+".value=\""+outBufferArr[i]+"\"");
			checkDoubleSel = 'N';
		}
		else if(inBufferArr[i].substring(0,4) == 'sel2')
		{
			var tmpOutBufferArr = outBufferArr[i]+"/"+outBufferArr[i+1];
		    eval("obj."+inBufferArr[i].substring(4,inBufferArr[i].length)+".value=\""+tmpOutBufferArr+"\"");
			checkDoubleSel = 'Y';
		}
		else if(inBufferArr[i].substring(0,3) != 'chk')
		{
			if(checkDoubleSel != 'Y')
			{
				if(inBufferArr[i].substring(0,3) == 'rdo')
					setRadioValue(inBufferArr[i].substring(3,inBufferArr[i].length),outBufferArr[i]);
				else
					eval("obj."+inBufferArr[i]+".value=\""+outBufferArr[i]+"\"");
			}
			else
			{
				if(inBufferArr[i].substring(0,3) == 'rdo')
					setRadioValue(inBufferArr[i].substring(3,inBufferArr[i].length),outBufferArr[i+1]);
				else
					eval("obj."+inBufferArr[i]+".value=\""+outBufferArr[i+1]+"\"");
			}

//			checkDoubleSel = 'N';
		}
		else
		{
			if(outBufferArr[i] == 'Y')
					eval("obj."+inBufferArr[i]+".checked=true");

//			checkDoubleSel = 'N';
		}
	}
        if(i>0&& inBufferArr.length < outBufferArr.length && !isEmptyObjValue(outBufferArr[i]))
        {
                errIndex=outData.indexOf(FETCH_ERR);
                if (errIndex != -1)
                {
                        alert(outData.substring(errIndex + FETCH_ERR_LEN));
                        return false;
                }
        }
	}
	return true;
}

function setRadioValue(obj,value)
{
    var obj1 = document.forms[0];
    if("Netscape" == navigator.appName) {
        obj1 = parent.window.opener.document.forms[0];
    }
    var isArray = (typeof(obj.length)=="undefined")?false:true;

    if(value=="") return;

    if(isArray && (typeof(obj.type)=="undefined"))
    {
        for(var i=0;i<obj.length;i++)
        {
            if(eval("obj1."+obj+"["+i+"].value") == value)
            {
                eval("obj1."+obj+"["+i+"].checked = true");
                break;
            }
        }
    }

    return;
}

// Holds id of currently visible layer
var cur_lyr;

function loadLyr(lyr) {
	if (cur_lyr) {
		var curcss = get_lyr_css(cur_lyr);
		if (curcss) curcss.display="none";
	}
	cur_lyr = lyr;
	var curcss = get_lyr_css(cur_lyr);
	if (curcss) {
		curcss.display = "";
		curcss.zIndex = 1000;	// some browsers need z-index set
	}
}

//Hides the currently visible layer
function hideLyr(id) {
	if (cur_lyr) {
		var curcss = get_lyr_css(cur_lyr);
		if (curcss) curcss.display="none";
	}
}

// Get reference
function get_lyr_css(id) {
	var lyr, lyrcss;
	lyr = (document.getElementById)? document.getElementById(id): (document.all)? document.all[id]: null;
	if (lyr) lyrcss = (lyr.style)? lyr.style: lyr;
	return lyrcss;
}

//This function disables all the search icons having the id 'sLnk*'
function disableHyperLnks(count)
{
	var lnkStr = "sLnk";

	for (var i=1;i<=parseInt(count+1,10);i++)
	{
		var lnkStrId = lnkStr+i;
		hideImage(lnkStrId);
	}
}

function showExpOrderNumber(obj,ctrlOrMorph,precedence,sCustId,sSolId,sExportOrderRefNum) {
	var sExpRefNum = "";
	var sUrl = "";
	var url = "../../arjspmorph/";

	if(arguments.length > 1) {
		if(ctrlOrMorph == 'morph')
		url = "../";
	}

	if(obj != null) {
		sExpRefNum = obj.id;
	}

	sUrl = url +applangcode+"/get_exp_ord_refnum.jsp?wReturn="+sExpRefNum+"&preceedence="+precedence+"&CustId="+sCustId+"&SolId="+sSolId+"&ExpOrderNum="+sExportOrderRefNum;

	var retVal = popModalWindow(sUrl,"ExpOrdNumList");

	if (retVal != null && retVal != undefined) {
		obj.value = retVal;
		//set the date value to UI field from hidden field.
		fnAssignUIDate(obj);
	}

}

function showInwDCList(obj,ctrlOrMorph,precedence,sSolId,sInwardDCNum) {
	var sDCNum = "";
	var sUrl = "";
	var url = "../../arjspmorph/";

	if(arguments.length > 1) {
		if(ctrlOrMorph == 'morph')
		url = "../";
	}

	if(obj != null) {
		sDCNum = obj.id;
	}

	sUrl = url +applangcode+"/get_inw_dc_num.jsp?wReturn="+sDCNum+"&preceedence="+precedence+"&SolId="+escape(sSolId)+"&InwDCNum="+escape(sInwardDCNum);

	var retVal = popModalWindow(sUrl,"InwardDCSolList");

	if (retVal != null && retVal != undefined) {
		obj.value = retVal;
	}
}

function newformatAmt(format, obj, crncy, prn)
{
	//alert("cust_comm");
	var prec = getPrec(crncy);
	if(fnIsNull(crncy))
	{
		var amt;
		if(prn == 'Y')
			amt = obj;
		else
			amt = obj.value;

		var decLen = 0;
		var iIndex = 0;
		var sourceAmt = removeCommas(amt);

		if(!isNaN(sourceAmt)){
			iIndex = sourceAmt.indexOf(".");
			if(iIndex != -1){
				decLen = sourceAmt.substring(iIndex+1).length;
			}
		}
		if(decLen > prec)
			prec = decLen;
	}
	formatAmountToMillionOrLakh(format, obj, prec, prn)
}

function getPrec(crncy)
{
	var crncyPrec = 2;
	var defaultPrec = 2;

	if(fnIsNull(crncy))
		return crncyPrec;
	crncy = crncy.replace('\'','\\\'');
	var prec = eval("precArray['"+crncy.toUpperCase()+"']");
	if(prec != undefined && prec != "")
		return prec;
	else
		return defaultPrec;
}

function checkAmtWithCrncy(format,amtObj,crncyObj)
{
	var amt = amtObj.value;
	var crncy = crncyObj.value;
	if(fnIsNull(crncy))
	{
		alert(finbranchResource.FAT000530);
		if(!crncyObj.disabled)
			crncyObj.focus();
		return;
	}

	var prec = getPrec(crncy);
	formatAmountToMillionOrLakh(format, amtObj, prec, 'N');
}

function checkZeroes(amt,prec)
{
	var sourceAmt = removeCommas(amt);
	var finalAmt = "";
	var numericPart = 0;
	var decimalPart = 0;
	var iIndex = 0;

	iIndex = sourceAmt.indexOf(".");
	if(iIndex != -1)
	{
		numericPart = sourceAmt.substring(0,iIndex);
		decimalPart = sourceAmt.substring(iIndex+1);
	}
	else
	{
		return sourceAmt;
	}

	var decPartLength = decimalPart.length;

	if(decPartLength > prec)
	{
		var ZERO = '0';
		var val = ZERO;
		var diff = decPartLength - prec;
		var bCheck = true;

		for(var i=decPartLength;i>prec;i--)
		{
			val = decimalPart.charAt(i - 1);
			if(val != ZERO)
			{
				bCheck = false;
				break;
			}
		}

		if(bCheck)
		{
			if(prec == 0)
				finalAmt = numericPart;
			else
				finalAmt = sourceAmt.slice(0,-(diff));
		}
	}

	if(finalAmt != "")
		return finalAmt;

	return sourceAmt;
}

function showAgentList(agentObj,solObj,delFlgInd,inPreceedence,agentObjDesc)
{
    var sUrl = "";
    var preceedence = 'F';
    var solId = "";

    if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }

    if (solObj != null && solObj != undefined) solId = solObj.value;

    if (arguments.length < 5)
    {
        sUrl = "../../arjspmorph/"+applangcode+"/agent_list.jsp?wReturn="+agentObj.id+"&wReturnDesc=NULL&shortName="+escape(agentObj.value)+"&solId="+solId+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
    }else
	{
        sUrl = "../../arjspmorph/"+applangcode+"/agent_list.jsp?wReturn="+agentObj.id+"&wReturnDesc="+agentObjDesc.id+"&shortName="+escape(agentObj.value)+"&solId="+solId+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
    }

	var retVal = popModalWindow(sUrl,"AgentIdList");

    if ("Microsoft Internet Explorer" == browser_name)
    {
        if (retVal != null && retVal != undefined )
        {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");

            agentObj.value = liarrBufArray[0];
            if(agentObjDesc != null) agentObjDesc.value = liarrBufArray[1];
        }
    }
}

function submitFromAddrTypeErr(sGroupName,sErrLLName, sFocusField)
{
	if(fnValidateForm())
	{
		var frm = document.forms[0];
		frm.submitform.value="addrType";
		frm.addrType.value=sErrLLName;
		frm.FocusField.value=sFocusField;
		frm.submit();
	 }
}

function fnIsLeapYear(sYear)
{
	var iYear = Number(sYear);
	return ( (((iYear % 4) == 0) && ((iYear % 100) == 0)) || ((iYear % 400) == 0) );
}

function fnAddYearsToDate(sYearsToAdd, sDate)
{
	var arrDate = sDate.split("-");
	var iDay = arrDate[0];
	var iMonth = arrDate[1];
	var iYear = arrDate[2];
	var bSrcYrLeapYr = fnIsLeapYear(iYear);

	iYear = Number(iYear)+Number(sYearsToAdd);

	if(	(bSrcYrLeapYr)
	&& 	(!fnIsLeapYear(iYear))
	&& 	(Number(iMonth) == 2)
	&&	(Number(iDay) > 28))
	{
		iDay = 28;
	}
	return iDay+"-"+iMonth+"-"+iYear;
}

function fnRemoveCrncy(sSrcAmt)
{
	var iCrncyIndex = sSrcAmt.indexOf("|");
	if(iCrncyIndex != -1)	return sSrcAmt.substring(0, iCrncyIndex);
	else return sSrcAmt;
}

function showZoneCode(obj1,obj2,sol,inPreceedence)
{
    var znDate = obj1.value;
    var znCode = obj2.value;
 	var preceedence = 'F';

	/*	Show the Zone Code List only if the zone date
		is a valid date	*/
	if ((znDate != null) && (!fnIsValidDate(obj1))) {
		alert(finbranchResource.FAT000188);
		obj1.focus();
		return;
	}

    if(znDate == null) znDate = ' ';
    if(znCode == null) znCode = ' ';
    if(sol == null ) sol =' ';
	if(arguments.length > 3)
    {
       preceedence = inPreceedence;
	}

    var retVal = popModalWindow("../../arjspmorph/" +applangcode+"/get_zone_code.jsp?wReturn="+ obj2.id +"&wReturnDate="+ obj1.id + "&znDate="+znDate+"&ZoneCode="+escape(znCode)+"&solId="+sol,"ZoneCodeList"+"&preceedence="+preceedence);
     if (retVal != null && retVal != undefined )
	{
		//Array for taking the values after splitting the value with "|".
		var liarrBufArray = retVal.split("|");

		obj2.value = liarrBufArray[0];
		if(obj1 != null) obj1.value = liarrBufArray[1];
		//set the date value to UI field from hidden field.
		fnAssignUIDate(obj1);
	}

}

function showSortCode(obj1,obj2,obj3,listWanted,clgCd,inPreceedence)
{
    var srtCode = obj1.value;
    var bkCode = '';

    var id1 = obj1.id;
    var id2 = '$';
    var id3 = '$';
	var preceedence = 'B';

    if(obj2 != null)
    {
        bkCode = obj2.value;
        id2 = obj2.id;
    }
    if(obj3 != null)
    {
        id3 = obj3.id;
    }
	if(arguments.length > 5) {
        preceedence = inPreceedence;
    }

    if(srtCode == null) srtCode = '';
    if(bkCode == null) bkCode ='';

    var retVal = popModalWindow("../../arjspmorph/"+applangcode+"/get_sort_code.jsp?wReturn1="+id1+"&wReturn2="+id2+"&wReturn3="+id3+"&sortCode="+escape(srtCode)+"&bkCode="+bkCode.toUpperCase()+"&listreqd="+listWanted+"&preceedence="+preceedence+"&clgRefCd="+clgCd,"SortCodeList");
    if (retVal != null)
    {
        if(listWanted == 'bkbrcode')
        {
			var pipeIndex = retVal.indexOf('|');
			var bkCd = retVal.substring(0,pipeIndex);
			retVal = retVal.substring(pipeIndex + 1);
			pipeIndex = retVal.indexOf('|');
			var brCd = retVal.substring(0,pipeIndex);
			var srtCd = retVal.substring(pipeIndex + 1);

			obj1.value = brCd;
			obj2.value = bkCd;
		}
		else
		{
			obj1.value = retVal;
		}
	}
}

function showTranCode(obj,objDesc, inPreceedence)
{
	var sUrl = "";
	var trnCode = obj.value;
	var preceedence = 'B';

	if(trnCode == null) trnCode = '';
	if(arguments.length > 2) {
        preceedence = inPreceedence;
    }

	if (arguments.length < 2)
	{
		sUrl = "../../arjspmorph/"+applangcode+"/get_tran_code.jsp?wReturn="+obj.id+"&wReturnDesc=NULL&tranCode="+escape(trnCode)+"&preceedence="+preceedence;
	}else
	{
		sUrl = "../../arjspmorph/"+applangcode+"/get_tran_code.jsp?wReturn="+obj.id+"&wReturnDesc="+objDesc.id+"&tranCode="+escape(trnCode)+"&preceedence="+preceedence;
	}
	var retVal = popModalWindow(sUrl,"TranCodeList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        obj.value = liarrBufArray[0];
	    	if(objDesc != null) objDesc.value = liarrBufArray[1];
		}
	}
}

/*  Function added for ICTM - instrumentType also populated from
    tran code list  */
function showICTMTranCode(obj,inPreceedence, objInstrType)
{
    var sUrl = "";
    var trnCode = obj.value;
    var preceedence = 'B';

    if(trnCode == null) trnCode = '';

    if(!fnIsNull(inPreceedence)) {
        preceedence = inPreceedence;
    }

    sUrl = "../../arjspmorph/"+applangcode+"/get_tran_code.jsp?wReturn="+obj.id+"&tranCode="+trnCode+"&preceedence ="+preceedence+"&wReturnInstrType="+objInstrType.id;
    var retVal = popModalWindow(sUrl,"TranCodeList");

    if ("Microsoft Internet Explorer" == browser_name)
    {
        if (retVal != null && retVal != undefined )
        {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");
            obj.value = liarrBufArray[0];
            objInstrType.value = liarrBufArray[2];
        }
    }
}


function getMsgCodeList(msgCodeObj,msgDescObj)
{
	var valUpper = (msgCodeObj.value).toUpperCase();
	var sUrl = "../../arjspmorph/"+applangcode+"/messagecode_list.jsp?val="+valUpper+"&wReturn="+msgCodeObj.id+"&wReturnDesc="+msgDescObj.id;
	var retVal = popModalWindow(sUrl,"Message Code List");
	if ("Microsoft Internet Explorer" == browser_name)
	{
	        if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");
		        msgCodeObj.value = liarrBufArray[0];
			if(msgDescObj != null) msgDescObj.value = liarrBufArray[1];
		}
   	}
}

function getFlowIdList(flowIdObj, flowIdDescObj)
{
	var valUpper = (flowIdObj.value).toUpperCase();
	var flowIdDesc = "NULL";
	if(flowIdDescObj != null && flowIdDescObj != undefined) flowIdDesc = flowIdDescObj.id;
	var sUrl = "../../arjspmorph/"+applangcode+"/flowid_list.jsp?val="+escape(valUpper)+"&wReturn="+flowIdObj.id+"&wReturnDesc="+flowIdDesc;
	var retVal = popModalWindow(sUrl,"Flow Id List");
	if ("Microsoft Internet Explorer" == browser_name)
	{
        if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");
		    flowIdObj.value = liarrBufArray[0];
			if(flowIdDescObj !=null && flowIdDescObj != undefined)
				flowIdDescObj.value = liarrBufArray[1];
		}
   	}
}

/*	Function to show Limit Liability List
		Added by Vasudevan G on Oct 10, 2002	*/
/* Function is modified to populate the Description Field for the Limit */
function showLmtLiabList(objPrefix, objSuffix, ctrlOrMorph,sCrncyCode, sDelFlg, objLmtDesc) {
	var sLimitId = "";
	var sUrl = "";
	var url = "../../arjspmorph/";

	if(arguments.length > 2) {
		if(ctrlOrMorph == 'morph')
		url = "../";
	}

	sCrncyCode = new String(sCrncyCode).toUpperCase();
	
	if(arguments.length < 6) {
		sUrl = url +applangcode+"/search_limitId.jsp?ReturnPrefix="+objPrefix.id+"&ReturnSuffix="+objSuffix.id+"&ReturnDesc=NULL&Prefix="+escape(objPrefix.value)+"&Suffix="+escape(objSuffix.value)+"&CrncyCode="+sCrncyCode+"&DelFlg="+sDelFlg;
	}
	else
	{
		sUrl = url +applangcode+"/search_limitId.jsp?ReturnPrefix="+objPrefix.id+"&ReturnSuffix="+objSuffix.id+"&ReturnDesc="+objLmtDesc.id+"&Prefix="+escape(objPrefix.value)+"&Suffix="+escape(objSuffix.value)+"&CrncyCode="+sCrncyCode+"&DelFlg="+sDelFlg;

	}
		
	var retVal = popModalWindow(sUrl,"LmtLiabList");

	if (retVal != null && retVal != undefined) {
		var str = retVal.substring(0,retVal.indexOf("|"))
		objPrefix.value = str.substring(0,str.indexOf("/"));
		objSuffix.value = str.substring(str.indexOf("/")+1);
		if(objLmtDesc!=null)objLmtDesc.value = retVal.substring(retVal.indexOf("|")+1);
	}

}

function addRow(arrObj)
{
	var recNum = arrObj[0]; //Record Number.
	var isCurrRec = arrObj[1]; //Is the record is current one.

	var locStyle = "";
	var suffix = "[" + recNum + "]";
	var status = "";

	if( isCurrRec == 'Y')
		locStyle = bgColor;
	else
	{
		if(recNum % 2 == 0)
		{
			locStyle = 'class="ctext_small"';
		}
		else
		{
			locStyle = 'class="ctext_smallw"';
		}
	}

	document.write('<tr ' + locStyle + ' >');

	for(iInputs = 0;iInputs < inputs.length;iInputs++)
	{
		document.write('<td class="ctext_small" align="' + inputs[iInputs][1] + '">');

		if(inputs[iInputs][0] == "checkbox")
		{
			if(arrObj[iInputs+2] == 'Y')
				status = " checked ";
			document.write('<input type="checkbox" name="chkBox' + suffix + '" disabled ' + status + '> </td>' );
		}
		else if(inputs[iInputs][0] == "radio")
		{
			if(arrObj[iInputs+2] == 'Y')
				status = " checked ";
			document.write('<input type="radio" name="rad' + suffix + '" disabled ' + status + '> </td>' );
		}
		else
		{
			 if(inputs[iInputs][2] != null && inputs[iInputs][2] == "amt")
			 {
				var locAmt = '';
				var locCurr = '';
				var index = arrObj[iInputs+2].indexOf('|');
				if(index != -1)
				{
					locAmt = arrObj[iInputs+2].substring(0,index);
					locCurr = arrObj[iInputs+2].substring(index+1);
				}
				newformatAmt(amtFormat,locAmt,locCurr,'Y');
				document.write('&nbsp; </td>');
			}
			else if(inputs[iInputs][2] != null && inputs[iInputs][2] == "date")
            		{
            			document.write(fnConvertToUIDate(arrObj[iInputs+2])+'&nbsp;</td>');
            		}
            		else
			{
				document.write(arrObj[iInputs+2] + '&nbsp; </td>');
			}
		}
		status = "";
	}

	document.write('</tr>');
}

/*this function is meant to display chargetype list based on scheme type
If last parameter is not required, then pass null.
Note:- Use chargeTypeList function to display chargetype list based on
scheme code and Currency Code.*/
function getChargeTypeList(chargeObj,schmType,inPreceedence,chargeDesc)
{
    var locChrgDesc = "NULL";

    if(chargeDesc != null)
        locChrgDesc = chargeDesc.id;

    var sUrl = "";

    sUrl = "../../arjspmorph/"+applangcode+"/chargetype_list.jsp?wReturn="+chargeObj.id+"&wReturnDesc="+locChrgDesc+"&schmType="+ schmType+"&preceedence="+inPreceedence;

    var retVal = popModalWindow(sUrl,"Charge Type List");

    if ("Microsoft Internet Explorer" == browser_name)
    {
        if (retVal != null && retVal != undefined )
        {
            var liarrBufArray = retVal.split("|");

            chargeObj.value = liarrBufArray[0];
            if(chargeDesc != null) chargeDesc.value = liarrBufArray[1];
        }
    }
}

/*this function is meant to display chargetype list based on scheme code
and currency code.  If last parameter is not required, then pass null.
Note:- Use getChargeTypeList function to display chargetype list based on
scheme type.*/
function chargeTypeList(chargeObj,schm,crncy,inPreceedence,chargeDesc)
{
	var locChrgDesc = "NULL";

	if(chargeDesc != null)
		locChrgDesc = chargeDesc.id;

	var sUrl = "";

	sUrl = "../../arjspmorph/"+applangcode+"/chargetype_list.jsp?wReturn="+chargeObj.id+"&wReturnDesc="+locChrgDesc+"&schmCode="+schm+"&crncyCode="+crncy+"&preceedence="+inPreceedence;

    var retVal = popModalWindow(sUrl,"Charge Type List");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			var liarrBufArray = retVal.split("|");

	        chargeObj.value = liarrBufArray[0];
			if(chargeDesc != null) chargeDesc.value = liarrBufArray[1];
		}
    }
}

/*The months and days will be added to initDate and will be  displayed in dispDate.
 First and last fields are objects
 Second and third fields are strings
 Date in dd-mm-yyyy form */
function addDayMonthsToDate(initDateObj,adnMonths,adnDays,dispDateObj)
{
	var tempDate;
	if(fnIsNull(initDateObj.value) || !fnIsValidDate(initDateObj))
	{
		dispDateObj.value="";
		return false;
	}

	tempDate=initDateObj.value;
	var mnemonicEnabled = initDateObj.getAttribute("mnebl");
	if((null != mnemonicEnabled) && (mnemonicEnabled) && isValidDateMneumonic(tempDate))
	{
		return true;
	}
	var strArray = tempDate.split("-");
	var iDay = parseFloat(strArray[0]);
	var iMonth = parseFloat(strArray[1]);
	var iYear = parseFloat(strArray[2]);
		if(!fnIsNull(adnMonths) &&fnIsPositiveNumber(adnMonths))
		{
			iMonth = iMonth+parseInt(adnMonths,10);
		}
		if(!fnIsNull(adnDays)&& fnIsPositiveNumber(adnDays))
		{
			iDay = iDay+parseInt(adnDays,10);
		}
	/*
	Create a date object, set the above computed iDay/iMonth/iYear to it
	get the day/month/year from date object and set these to dispObject field
	*/
	var targetDate = new Date();
	targetDate.setFullYear(iYear, --iMonth, iDay);	//"--" because JS month range is 0-11 [Jan-Dec]
	iDay = targetDate.getDate();
	iMonth = targetDate.getMonth() + 1;	//"+1" because JS month range is 0-11 [Jan-Dec]
	iYear = targetDate.getYear();
	iDay = iDay < 10 ? "0"+iDay : iDay;
	iMonth = iMonth < 10 ? "0"+iMonth : iMonth;
	dispDateObj.value = iDay+"-"+iMonth+"-"+iYear;
}

function fnDisableFormDataControls(sMode, objForm, iLinksCount)
{
	VERIFY = "V";
	INQUIRY = "I";
	DELETE = "D"
	UNDELETE = "U";
	CANCEL = "X";

	if(sMode == VERIFY || sMode == INQUIRY || sMode == DELETE || sMode == UNDELETE || sMode == CANCEL) {
		var frmElements = objForm.elements;
		var totalElements = frmElements.length;
		var argc = arguments.length;
		if(Number(iLinksCount) > 0)		disableHyperLnks(Number(iLinksCount));
		for(i = 0; i < totalElements; i++){
			if(( frmElements[i].type == 'text' )||( frmElements[i].type == 'textarea' )) {
				frmElements[i].readOnly = true;
			} else if (frmElements[i].type == 'select-one'){
				frmElements[i].disabled = true;
			} else if ( frmElements[i].type == 'checkbox' ) {
				frmElements[i].disabled = true;
				frmElements[i].setAttribute("fds", "Y"); //will never reset again
			}else if ( frmElements[i].type == 'radio' ) {
				frmElements[i].disabled = true;
			}

			objForm.menuName.readOnly = false;
		}
		if( (objForm.Validate != undefined) && (objForm.Validate != null) )
		{
			objForm.Validate.disabled = true;
		}
		if( (objForm.Cancel != undefined) && (objForm.Cancel != null) )
		{
			objForm.Cancel.disabled = true;
		}
	}

}

function fnEnableFormDataControls(objForm)
{
	var frmElements = objForm.elements;
	var totalElements = frmElements.length;
	var argc = arguments.length;

	for(i = 0; i < totalElements; i++){
		if (frmElements[i].type == 'select-one'){
			frmElements[i].disabled = false;
		} else if ( frmElements[i].type == 'checkbox' || frmElements[i].type == 'radio') {
			frmElements[i].disabled = false;
		}
	}
	if( (objForm.Clear != undefined) && (objForm.Clear != null) )
	{
		objForm.Clear.disabled = false;
	}
}

function showDraweeCode(DraweeNoObj,partyNameObj)
{
        var valUpper = (DraweeNoObj.value).toUpperCase();
        var sUrl = "";
        if(partyNameObj == null)
        	sUrl = "../../arjspmorph/"+applangcode+"/draweeCode_list.jsp?val="+escape(valUpper)+"&wReturn="+DraweeNoObj.id;
        else
        	sUrl = "../../arjspmorph/"+applangcode+"/draweeCode_list.jsp?val="+escape(valUpper)+"&wReturn="+DraweeNoObj.id+"&wReturnName="+partyNameObj.id;

        var retVal = popModalWindow(sUrl,"Drawee Code List");
        if ("Microsoft Internet Explorer" == browser_name)
        {
                if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");
                        DraweeNoObj.value = liarrBufArray[0];
				        if(partyNameObj != null)
                        	partyNameObj.value = liarrBufArray[1];

                }
        }
}

function showDcNextNoCode(dcNoObj, dcNoDescObj, numtype)
{
	var valUpper = (dcNoObj.value).toUpperCase();
	var sUrl = "";
	if((numtype == undefined) || (numtype == null))
		numtype = "";
	if(dcNoDescObj == null)
    	sUrl = "../../arjspmorph/"+applangcode+"/nextDcNo_list.jsp?val="+escape(valUpper)+"&numtype="+numtype+"&wReturn="+dcNoObj.id;
    else
    	sUrl = "../../arjspmorph/"+applangcode+"/nextDcNo_list.jsp?val="+escape(valUpper)+"&numtype="+numtype+"&wReturn="+dcNoObj.id+"&wReturnName="+dcNoDescObj.id;

	var retVal = popModalWindow(sUrl,"Next No List");
	if ("Microsoft Internet Explorer" == browser_name)
	{
	        if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
				var liarrBufArray = retVal.split("|");
		        dcNoObj.value = liarrBufArray[0];
				if(dcNoDescObj != null)
    	    	    dcNoDescObj.value = liarrBufArray[1];

		}
   	}
}

function fnLpad(str,len)
{
    var tempstr = "";
    for(i = 0;i<(len - str.length);i++)
        tempstr = tempstr + "0";
    tempstr = tempstr + str;
    return tempstr;

}

function fnRpad(str,len)
{
    var templen = str.length;
    for(i = 0;i<(len - templen);i++)
        str = str + "0";
    return str;

}

function fnAddAmount(String1,String2)
{
    var numericPart1 = '0';
    var numericPart2 = '0';
    var decimalPart1 = '0';
    var decimalPart2 = '0';
    var decimalPart3 = '0';
    var iIndex1 = 0;
    var iIndex2 = 0;
    var index = 0;
    var mantLenMax = 0;
    var decLenMax = 0;
    var decimalSum = 0;
    var mantSum = 0;
    var carry = 0;
    var amt1 = removeCommas(String1);
    var amt2 = removeCommas(String2);

    iIndex1 = amt1.indexOf(".");
    iIndex2 = amt2.indexOf(".");
    if(iIndex1 == -1){
        numericPart1 = amt1;
    } else {
        numericPart1 = amt1.substring(0,iIndex1);
        decimalPart1 = amt1.substring(iIndex1+1);
    }
    if(iIndex2 == -1){
        numericPart2 = amt2;
    } else {
        numericPart2 = amt2.substring(0,iIndex2);
        decimalPart2 = amt2.substring(iIndex2+1);
    }
    mantLenMax = (numericPart1.length >numericPart2.length)?numericPart1.length : numericPart2.length;
    decLenMax = (decimalPart1.length>decimalPart2.length)?decimalPart1.length:decimalPart2.length;

    numericPart1 = fnLpad(numericPart1,mantLenMax);
    numericPart2 = fnLpad(numericPart2,mantLenMax);
    decimalPart1 = fnRpad(decimalPart1,decLenMax);
    decimalPart2 = fnRpad(decimalPart2,decLenMax);

    var numericPart3 = new Array();
    decimalSum = parseInt(decimalPart1,10) + parseInt(decimalPart2,10);
    decimalPart3 = (decimalSum) % (Math.pow(10,decLenMax));
    decimalPart3 = decimalPart3 + '';
    decimalPart3 = fnLpad(decimalPart3,decLenMax);

    carry = (decimalSum/(Math.pow(10,decLenMax))) >= 1 ? 1 : 0;
    for(index = mantLenMax - 1;index >= 0;index--)
    {
        mantSum = parseInt(numericPart1.charAt(index),10) + parseInt(numericPart2.charAt(index),10) + carry;
        numericPart3[index + 1] = mantSum % 10;
        carry = mantSum > 9 ? 1 : 0;
    }
    numericPart3[0] = (carry == 1)? carry :"";
    var i =0;
    var len=numericPart3.length;
    var result = "";
    for (i =0;i<len ; i++)
    {
        result = result+numericPart3[i];
    }

    result = result+"."+decimalPart3;

    return result;
}

function fnSubtractAmt(String1,String2)
{
    var numericPart1 = '0';
    var numericPart2 = '0';
    var decimalPart1 = '0';
    var decimalPart2 = '0';
    var decimalPart3 = '0';
    var iIndex1 = 0;
    var iIndex2 = 0;
    var index = 0;
    var mantLenMax = 0;
    var decLenMax = 0;
    var decimalSub = 0;
    var mantSub = 0;
    var carry = 0;
	var decCheck = false;
	var negCheck = false;
    var amt1 = removeCommas(String1);
    var amt2 = removeCommas(String2);
    var result = "";

    iIndex1 = amt1.indexOf(".");
    iIndex2 = amt2.indexOf(".");
    if(iIndex1 == -1){
        numericPart1 = amt1;
    } else {
        numericPart1 = amt1.substring(0,iIndex1);
        decimalPart1 = amt1.substring(iIndex1+1);
    }

    if(iIndex2 == -1){
        numericPart2 = amt2;
    } else {
        numericPart2 = amt2.substring(0,iIndex2);
        decimalPart2 = amt2.substring(iIndex2+1);
    }
    mantLenMax = (numericPart1.length >numericPart2.length)?numericPart1.length : numericPart2.length;
    decLenMax = (decimalPart1.length>decimalPart2.length)?decimalPart1.length:decimalPart2.length;

	numericPart1 = fnLpad(numericPart1,mantLenMax);
    numericPart2 = fnLpad(numericPart2,mantLenMax);
    decimalPart1 = fnRpad(decimalPart1,decLenMax);
    decimalPart2 = fnRpad(decimalPart2,decLenMax);

	if(parseInt(numericPart2,10) > parseInt(numericPart1,10))
	{
		var numTemp = numericPart1;
		var decTemp = decimalPart1;
		numericPart1 = numericPart2;
		numericPart2 = numTemp;
		decimalPart1 = decimalPart2;
		decimalPart2 = decTemp;
		negCheck = true;
	}
	else if(parseInt(numericPart1,10) == parseInt(numericPart2,10))
	{
		if(parseInt(decimalPart2,10) > parseInt(decimalPart1,10))
		{
			var decTemp = decimalPart1;
			decimalPart1 = decimalPart2;
			decimalPart2 = decTemp;
			negCheck = true;
		}
	}

	decimalSub = parseInt(decimalPart1,10) - parseInt(decimalPart2,10);
	if(decimalSub < 0)
	{
		decimalPart3 = 	Math.pow(10,decLenMax) + decimalSub;
		decCheck = true;
	}
	else
		decimalPart3 = decimalSub;
	decimalPart3 = decimalPart3 + '';
	decimalPart3 = fnLpad(decimalPart3,decLenMax);

	mantSub = parseInt(numericPart1,10) - parseInt(numericPart2,10);
	if(decCheck)
	{
		mantSub -= 1;
	}
	result = mantSub+"."+decimalPart3;
	if(negCheck)
	{
		result = "-" + result;
	}
    return result;
}

//This function disables all the tabs
function disableTabs()
{
    var sTabcss = get_lyr_css('sTab');
    var hTabcss = get_lyr_css('hTab');

    if ((hTabcss != undefined && hTabcss != null) && (sTabcss != undefined && sTabcss != null))
    {
        hTabcss.cssText = "position:absolute; visibility:visible;"
        sTabcss.cssText = "position:absolute; visibility:hidden;"
    }
}
function showCookies()
{
	if(gfkmCookie != null && gfkmCookie != '')
	{
		var xMax = screen.width, yMax = screen.height;
		var xOffset = (xMax - 360), yOffset = (yMax - 205);
		var cookieArr = gfkmCookie.split("|");
		var msgWin=window.open('','msgWin','width=300,height=150,left='+xOffset+',top='+yOffset+'');
        msgWin.location.reload();
		with(msgWin.document)
		{
			write("<head><title>Cookie Info</title>");
			write("<script language='javascript'>");
			write("self.focus();");
            write("setTimeout('self.close()',120000)");
            write("</script>");
			write("</head>")
			write("<LINK href='../Renderer/stylesheets/services.css' rel=STYLESHEET  title='Finacle Stylesheet'type=text/css /><body><form>");
			write("<table class=ctable border=0 cellspacing=1 cellpadding=1 width=100%>");
			write("<tr><td class=slabel>Created by</td>");
			write("<td class=stable>"+cookieArr[2]+"</td></tr>");
			write("<tr><td class=slabel>Created on</td>");
			write("<td class=stable>"+cookieArr[3]+"</td></tr>");
			write("<tr><td class=slabel>Modified by</td>");
			write("<td class=stable>"+cookieArr[4]+"</td></tr>");
			write("<tr><td class=slabel>Modified on</td>");
			write("<td class=stable>"+cookieArr[5]+"</td></tr>");
			write("<tr><td class=slabel>Deleted (Y/N)</td>");
			write("<td class=stable>"+cookieArr[8]+"</td></tr></table>");
            write("<div align=center>");
            write("<input type=\"button\" class=\"button\" id=\"Close\" value=" + finbranchResource.FAT000773 + " onClick=\"javascript:self.close();\">");
            write("<script> document.forms[0].Close.focus(); </script>");
            write("</div>");
            write("</form></body>");
		}
	}
}
function showBICCodes(obj,ctrlOrMorph,inPreceedence,objDesc)
 {
 	var bicObj = "";
 	var sUrl = "";
 	var preceedence = 'B';
 	var url = "../../arjspmorph/";

     if(arguments.length > 1)
     {
 		if(ctrlOrMorph == 'morph')
 		url = "../../";
 	}

     if(arguments.length > 2)
     {
         preceedence = inPreceedence;
     }

 	if(obj != null)	bicObj = obj.id;

 	if (arguments.length < 4)
 	{

 		sUrl = "../../arjspmorph/"+applangcode+"/search_biccode.jsp?wReturn="+bicObj+"&wReturnDesc=NULL&preceedence="+preceedence;
 	}else
 	{
 		sUrl ="../../arjspmorph/"+applangcode+"/search_biccode.jsp?wReturn="+bicObj+"&wReturnDesc="+objDesc.id+"&preceedence="+preceedence;
 	}
     var retVal = popModalWindow(sUrl,"BICCode");

 	if ("Microsoft Internet Explorer" == browser_name)
 	{
 	    if (retVal != null && retVal != undefined )
 		{
 			//Array for taking the values after splitting the value with "|".
 			var liarrBufArray = retVal.split("|");

 	        obj.value = liarrBufArray[0];
 			if(objDesc != null) objDesc.value = liarrBufArray[1];
 		}
     }
 }


function  showBacid(obj,ctrlOrMorph,inPreceedence,objDesc)
{
	var bacidObj;
	var sUrl = "";
	var preceedence = inPreceedence;
	var url = "../../arjspmorph/";
	var desc = "NULL";

	if(objDesc != null)
		desc = objDesc.id;

	if(ctrlOrMorph == 'morph')
		url = "../";

	if(obj != null)	bacidObj = obj.id;

	sUrl = url +applangcode+"/get_bacid.jsp?wReturn="+bacidObj+"&wReturnDesc="+desc+"&Bacid="+escape(obj.value);

	var retVal = popModalWindow(sUrl,"BacidIdList");

	setObjAndDescValuesForIE(retVal,obj,objDesc);
}


function setObjAndDescValuesForIE(retVal,obj,objDesc)
{

	if ("Microsoft Internet Explorer" == browser_name)
	{
		if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

			obj.value = liarrBufArray[0];
			if(objDesc != null) objDesc.value = liarrBufArray[1];
		}
	}
}

function showRefCodeFromMorph(obj1,refType,delFlgInd,inPreceedence,obj2)
 {
	var refCode = obj1.value;
	var url = "";
	var preceedence = 'B';

	if(refCode == null) refCode = '';

	if(arguments.length > 3)
	 {
		 preceedence = inPreceedence;
	 }

	if (arguments.length < 5)
	{
		url = "../"+applangcode+"/get_ref_code.jsp?wReturn="+ obj1.id +"&wReturnDesc=NULL&refType="+refType+"&refCode="+escape(refCode)+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
	}else
	{
		url = "../"+applangcode+"/get_ref_code.jsp?wReturn="+ obj1.id +"&wReturnDesc="+ obj2.id +"&refType="+refType+"&refCode="+escape(refCode)+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(url,"RefCodeList");

	setObjAndDescValuesForIE(retVal,obj1,obj2);
}

function listBankCodes(delInd,objBankCode, preceedence, objBankCodeDesc)
{
	var bankCode = "";
	var bankCodeId = "NULL";
	var bankCodeDescId = "NULL";
	//var sUrl = "";
	var url = "../../arjspmorph/";

	bankCode = objBankCode.value;
	bankCodeId = objBankCode.id;

	if(objBankCodeDesc != null)
	{
		bankCodeDescId = objBankCodeDesc.id;
	}
	if (bankCodeId == 'LimitTypeId')
        url = "../";
	sUrl =  url+applangcode+"/bank_codes.jsp?wReturn="+bankCodeId+"&wReturnDesc="+bankCodeDescId+"&preceedence="+preceedence+"&issuedOnBank="+escape(bankCode)+"&delInd="+delInd;
    var retVal = popModalWindow(sUrl,"Bank Codes");

	setObjAndDescValuesForIE(retVal,objBankCode,objBankCodeDesc);
}
function fnIsbeginChequeNoNull(bnchenoVal)
{
      if (fnIsNull(bnchenoVal))
      {
              alert(finbranchResource.FAT000092);
              document.forms[0].beginChequeNo.focus();
              return 0;
      }
      return 1;
}
function fnIsnoOfLeavesNull(noOfLeavesVal)
{
      if (fnIsNull(noOfLeavesVal))
      {
              alert(finbranchResource.FAT000095);
              document.forms[0].noOfLeaves.focus();
              return 0;
      }
      return 1;
}

function fnIsreasonCodeNull(reaCodeVal)
{
      if (fnIsNull(reaCodeVal))
      {
              alert(finbranchResource.FAT000098);
              document.forms[0].reasonCode.focus();
              return 0;
      }
      return 1;
}

function RetAmount(Amtobj,precision)
{
        var FinalAmt,Amount,TextValue="",Temp="",Amountlength,Code,NumericPart,Amt,ThirdLastChar,SecondLastChar,LastChar,flag=0;
        result=0;
        Temp=Amtobj.value;
        if(Temp != undefined && Temp != "")
        TextValue=removeCommas(Temp);
        Amount=TextValue.toUpperCase();
        Amountlength=Amount.length;
        ThirdLastChar=Amount.charAt(Amountlength-3);

			  if(isNaN(ThirdLastChar) && ThirdLastChar != "." && ThirdLastChar == "-" && Amountlength != 3)
					{
						alert(finbranchResource.FAT000518);

                        }
                  else
                        {
                             SecondLastChar=Amount.charAt(Amountlength-2);

                             if(isNaN(SecondLastChar)  && SecondLastChar != ".")
                                {
                                  Code=Amount.substring(Amountlength-2,Amountlength);
                                  NumericPart=Amount.substring(0,Amountlength-2);
                                }
                             else
                                {
                                  LastChar=Amount.charAt(Amountlength-1)
                                  if(isNaN(LastChar) && LastChar != ".")
                                       {
                                         Code=Amount.charAt(Amountlength-1);
                                         NumericPart=Amount.substring(0,Amountlength-1);
                                       }
                                     else
                                       {
                                         Code="NAN"
                                         NumericPart=Amount;
                                       }
                                 }


                            if(Code != "NAN" && isNaN(NumericPart)== false)
                             {
                                  Amt=parseFloat(NumericPart);
                                  CodeValue="";
                                  if(custfngetAmountCodeValue(Code) == true)
									CodeValue=getAmountCodeValue(Code);
						          else
									CodeValue=custfngetAmountCodeValue(Code);

                                  if(CodeValue != undefined)
                                        {
                                           FinalAmt=Amt * CodeValue;
                                           if(FinalAmt> 99999999999999999)
                                             {
                                              alert(finbranchResource.FAT000531);

                                             }
                                           else
                                             {
                                               Amtobj.value =FinalAmt;
                                               result=1;
                                             }
                                           flag=1;
                                        }

                                  if(flag==0)
                                        {
                                            alert(finbranchResource.FAT000518);

                                        }
                              }
                              else if(isNaN(NumericPart))
                                 {
                                     alert(finbranchResource.FAT000029);

                                 }
                             else
                                 {
									if(!fnValidateAmount(NumericPart,precision))
										return 0;
									 if(NumericPart != "")
										if(NumericPart.length == 17)
										{
											Amt=NumericPart;
										}
										else
										{
											Amt=parseFloat(NumericPart);
										}
									 else
										Amt="";
                                     Amtobj.value =Amt;
                                     result=1;
                                 }
						}
  return result;
}

/** This function will set focus on field id passed as parameter or first
 * editable field */
function fnSetFocusOnFirstField(frmFld)
{
	if(frmFld != null || undefined)
	{
		frmFld.focus();
		return;
	}
	var frmElements = document.forms[0].elements;
	var totalElements = frmElements.length;
	for(i = 0; i < totalElements; i++)
	{
		if(( frmElements[i].type == 'text' )||( frmElements[i].type == 'textarea' ))
		{
			if(frmElements[i].readOnly == false)
			{
				frmElements[i].focus();
				break;
			}
		}
		if((frmElements[i].type == 'select-one')|| ( frmElements[i].type == 'checkbox' ))
		{
			if(frmElements[i].disabled == false)
			{
				frmElements[i].focus();
				break;
			}
		}
	}
}
/** This function is used to get the nostro Account */
function getNoStroAcctList(nostroAcctNum,inPreceedence,nostroAcctName)
{
	var locAcctName  = "NULL";

	if(nostroAcctName != null)
		locAcctName = nostroAcctName.id;
	var AcctNumVal=nostroAcctNum.value;
	var sUrl = "";

	sUrl = "../../arjspmorph/"+applangcode+"/get_nostroacct_list.jsp?wReturn="+nostroAcctNum.id+"&wReturnDesc="+locAcctName+"&preceedence="+inPreceedence+"&AcctNumVal="+escape(AcctNumVal);
	var retVal = popModalWindow(sUrl,"Nostro Account List");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			var liarrBufArray = retVal.split("|");

	        nostroAcctNum.value = liarrBufArray[0];
			if(nostroAcctName != null) nostroAcctName.value = liarrBufArray[1];
		}
    }
}
function getRadioValue(obj)
{
	var isArray = (typeof(obj.length)=="undefined")?false:true;

	if(!isArray)
	{
		return obj.value;
	}

	var str = "";

	if(isArray && (typeof(obj.type)=="undefined"))
	{
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].checked)
			{
				str = obj[i].value;
				break;
			}
		}
	}

	return str;
}

function showTemplateIdList(url)
{
    var retVal = popModalWindow(url,"TemplateIdList");

	if (null != retVal)
	{
		var str = retVal.split("|");
		arguments[1].value = str[0];
		arguments[2].value = str[1];
	}
}
function showRvrslChrgList(objChrgType, sAcctId, sDelFlg, sCtrlOrMorph, sPreceedenceFlg)
{
    var sUrl = "../../arjspmorph/";

	sDelFlg = fnIsNull(sDelFlg) ? " " : sDelFlg;
    if(arguments.length > 3) {
        if(sCtrlOrMorph == 'morph')
        sUrl = "../";
    }

    if(arguments.length < 4) {
        sPreceedenceFlg = 'B';
    }

    sUrl = sUrl + applangcode+"/get_rvrslchrg_list.jsp?AcctId="+escape(sAcctId)+"&ChrgType="+escape(objChrgType.value)+"&DelFlg="+sDelFlg+"&preceedence="+sPreceedenceFlg+"&wReturn="+objChrgType.id;
    var retVal = popModalWindowVar(sUrl, "Charge Types", 600, 400, 50, 30);
    if (retVal != null && retVal != undefined) {
		var liarrBufArray = retVal.split("|");
		objChrgType.value = liarrBufArray[0];
    }
}

function fnSetCheckboxFld(objChkCtrl)
{
	var objChkCtrlId = objChkCtrl.id;
	var objChkFld = eval("document.forms[0]."+objChkCtrlId.substring(3));
	if(objChkCtrl.checked)
		objChkFld.value = "Y";
	else
		objChkFld.value = "N";
}

function fnSetCheckboxCtrl(objForm)
{
	var objChkCtrl = null;
	var objChkCtrlId = "";
	var objChkFldCtr = null;
	var objChkFldVal = "";
	var iCtr = 0;
	for(iCtr = 0; iCtr < objForm.elements.length; iCtr++)
	{
		if(objForm.elements[iCtr].type == 'checkbox')
		{
			objChkCtrl = objForm.elements[iCtr];
			objChkCtrlId = objChkCtrl.id;
			objChkFldCtr = eval("objForm."+objChkCtrlId.substring(3));
			if( (objChkFldCtr != null && objChkFldCtr != undefined) )
			{
				objChkFldVal = objChkFldCtr.value;
				if(objChkFldVal == 'Y') {
					objChkCtrl.checked = true;
				} else {
					objChkCtrl.checked = false;
					objChkFldCtr.value = 'N';
				}
			}
		}
	}
}

// valid time 00:00:00 - 23:59:59
function fnIsValidTime(sTime)
{
	//valid time separator used here is only ':'
	//if new separator(s) are required, append them
	//just after ':' in regular expression 'reInvalidTimeChars'
	//valid time characters are digits and time separator(s)

	//invalid time characters are all but valid time characters
	var reInvalidTimeChars = /[^0-9:]/g;
	if(fnIsNull(sTime))
		return true;
	if(reInvalidTimeChars.test(sTime))
		return false;
	if (sTime.length != 8)
		return false;

	var sHH 	= sTime.substr(0,2);	//extracts hh from [hh:mm:ss]
	var sMM= sTime.substr(3,2);	//extracts mm from [hh:mm:ss]
	var sSS 	= sTime.substr(6,2);	//extracts ss from [hh:mm:ss]

	if( isNaN(sHH) || isNaN(sMM) || isNaN(sSS) )
		return false;

	var iHH 	= Number(sHH);
	var iMM = Number(sMM);
	var iSS	= Number(sSS);

	if(iHH < 0 || iHH > 23 || iMM < 0 || iMM > 59 || iSS < 0 || iSS> 59)
		return false;
	return true;
}

function showRoleList(objRoleId, objRoleDesc, sDelFlg, sCtrlOrMorph, sPreceedenceFlg)
{
    var sRoleDescId = ((objRoleDesc != null) && (objRoleDesc != undefined)) ? objRoleDesc.id : "";
    var sUrl = ( !fnIsNull(sCtrlOrMorph) && (sCtrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
    sDelFlg = fnIsNull(sDelFlg) ? " " : sDelFlg;
	sPreceedenceFlg = (arguments.length < 5) ? 'B' : sPreceedenceFlg;

    sUrl = sUrl + applangcode+"/get_roleid_list.jsp?RoleId="+escape(objRoleId.value)+"&DelFlg="+sDelFlg+"&preceedence="+sPreceedenceFlg+"&wReturn="+objRoleId.id+"&wReturnDesc="+sRoleDescId;
    var retVal = popModalWindow(sUrl, finbranchResource.FLT001678);
    if (retVal != null && retVal != undefined)
    {
		var liarrBufArray = retVal.split("|");
		objRoleId.value = liarrBufArray[0];
		if(sRoleDescId != "")
			objRoleDesc.value = liarrBufArray[1];
    }
}

function showTermList(objTermId, objTermDesc, sDelFlg, sCtrlOrMorph, sPreceedenceFlg)
{
    var sTermDescId = ((objTermDesc != null) && (objTermDesc != undefined)) ? objTermDesc.id : "";
    var sUrl = ( !fnIsNull(sCtrlOrMorph) && (sCtrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
    sDelFlg = fnIsNull(sDelFlg) ? " " : sDelFlg;
	sPreceedenceFlg = (arguments.length < 5) ? 'B' : sPreceedenceFlg;

    sUrl = sUrl + applangcode+"/get_termid_list.jsp?TermId="+escape(objTermId.value)+"&DelFlg="+sDelFlg+"&preceedence="+sPreceedenceFlg+"&wReturn="+objTermId.id+"&wReturnDesc="+sTermDescId;
    var retVal = popModalWindow(sUrl, finbranchResource.FLT001679);
    if (retVal != null && retVal != undefined)
    {
		var liarrBufArray = retVal.split("|");
		objTermId.value = liarrBufArray[0];
		if(sTermDescId != "")
			objTermDesc.value = liarrBufArray[1];
    }
}

/***************************************************
*This function is new version for fnDisableFormDataControls
*It also disables Submit button in case of INQUIRY MODE
****************************************************/
function cust_fnDisableFormControls(sMode, objForm, iLinksCount)
{
	var VERIFY = "V";
	var INQUIRY = "I";
	var DELETE = "D"
	var UNDELETE = "U";
	var CANCEL = "X";

	if(sMode == VERIFY || sMode == INQUIRY || sMode == DELETE || sMode == UNDELETE || sMode == CANCEL)
	{
		var frmElements = objForm.elements;
		var totalElements = frmElements.length;

		//disable links
		if(Number(iLinksCount) > 0)
			disableHyperLnks(Number(iLinksCount));

		//disable form visible data controls
		for(i = 0; i < totalElements; i++)
		{
			if(( frmElements[i].type == 'text' )||( frmElements[i].type == 'textarea' )) {
				frmElements[i].readOnly = true;
			} else if (frmElements[i].type == 'select-one'){
				frmElements[i].disabled = true;
			} else if ( frmElements[i].type == 'checkbox' || frmElements[i].type == 'radio') {
				frmElements[i].disabled = true;
				frmElements[i].setAttribute("fds", "Y");
			}
			objForm.menuName.readOnly = false;
		}
		if( (objForm.Validate != undefined) && (objForm.Validate != null) )
		{
			objForm.Validate.disabled = true;
		}
		if( (objForm.Clear != undefined) && (objForm.Clear != null) )
		{
			objForm.Clear.disabled = true;
		}
	}

	if(sMode == INQUIRY)
	{
		if( (objForm.Submit != undefined) && (objForm.Submit != null) )
		{
			objForm.Submit.disabled = true;
		}
	}
}

function checkRadio(obj,str)
{
    var isArray = (typeof(obj.length)=="undefined")?false:true;

    if(!isArray)
    {
        if(obj.value == str)
        {
            obj.checked = true;
            return;
        }

    }

    if(isArray && (typeof(obj.type)=="undefined"))
    {
        for(var i=0;i<obj.length;i++)
        {
            if(obj[i].value == str)
            {
                obj[i].checked = true;
                break;
            }
        }
    }

    return;
}
function fnShowCancelDialog(sMode)
{
   var VERIFY = "V";
   var INQUIRY = "I";
   var DELETE = "D"
   var UNDELETE = "U";
   var CANCEL = "X";
   var POST = "P";

   if(sMode == VERIFY || sMode == INQUIRY || sMode == DELETE || sMode == UNDELETE || sMode == CANCEL || sMode == POST)
   {
        document.forms[0].submitform.value="Cancel";
        document.forms[0].submit();
   }
   else
   {
        if((confirm(finbranchResource.FER000136)==true))
        {
           document.forms[0].submitform.value="Cancel";
           document.forms[0].submit();
        }
   }
}

function submitFormError(subType)
{
	var frm = document.forms[0];
    frm.submitform.value=subType;
    convertToCaps();
    disableButtons();
    frm.submit();
}
function getSchemeCodes(schmCode,ctrlOrMorph,inPreceedence,schmCodeDesc)
{
	var sUrl = "";
	var preceedence = 'B';
	var url = "../";

	if(arguments.length > 1)
	{
		if(ctrlOrMorph == 'ctrl')
			url = "../../arjspmorph/";
    	}
	if(browser_name != "Microsoft Internet Explorer")
	{
		url = "../../arjspmorph/";
	}

    	if(arguments.length >2)
    {
        preceedence = inPreceedence;
    }
	if (arguments.length < 4)
	{

		sUrl = url +applangcode+ "/show_scheme_code.jsp?wReturn="+schmCode.id+"&wReturnDesc=NULL&SchemeCode="+escape(schmCode.value)+"&preceedence="+preceedence;

	}else
	{
		sUrl = url +applangcode+ "/show_scheme_code.jsp?wReturn="+schmCode.id+"&wReturnDesc="+schmCodeDesc.id+"&SchemeCode="+escape(schmCode.value)+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"SchemeCodeList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");
                if(schmCode.value !="")
                {
               	 	liarrBufArray[0]= schmCode.value +" "+liarrBufArray[0];
	        	schmCode.value = liarrBufArray[0];
	        }
	        else
	          schmCode.value = liarrBufArray[0];


		}
	}
}

function fnToggleCheckbox(chkObj)
{
    var chkObjId = chkObj.id;
    var hdnFldObj = eval("document.forms[0]."+chkObjId.substring(3));
    if(chkObj.checked)
        hdnFldObj.value = "Y";
    else
        hdnFldObj.value = "N";
}
/* function for rgstrtype list */
function showRgstrTypeList(rgstrType,rgstrTypeDesc,inPreceedence,ctrlOrMorph,delFlg,rgstrSubType,rgstrSubTypeDesc,filterInd)
{
	var sUrl = "";
	var preceedence = 'B';
	var url = "../../arjspmorph/";
	var locDelFlg = "N";
	var locRgstrTypeDesc="NULL";
	var locRgstrSubTypeDesc="NULL";
	var rgstrTypeVal="";
	var rgstrSubTypeVal="";
	var locRgstrType="NULL";
	if(arguments.length > 3)
	{
	        preceedence = inPreceedence;
	}
	if(arguments.length > 4)
	{
	        if(ctrlOrMorph == 'morph')
	        url = "../";
	}
	if(arguments.length > 5)
	{
	   locDelFlg = delFlg;
	}

	if(rgstrType != null && rgstrType != undefined )
	{
		rgstrTypeVal=rgstrType.value;
		locRgstrType = rgstrType.id;
	}
	if(rgstrTypeDesc != null && rgstrTypeDesc.id != undefined)
		locRgstrTypeDesc = rgstrTypeDesc.id;

	if(rgstrSubType != null && rgstrSubType.id != undefined)
	{
		locRgstrSubType = rgstrSubType.id;
		rgstrSubTypeVal = rgstrSubType.value;
	}

	if(arguments.length>7)
	{
		if(rgstrSubTypeDesc != null && rgstrSubTypeDesc.id != undefined && rgstrSubTypeDesc != "")
			locRgstrSubTypeDesc = rgstrSubTypeDesc.id;
	}
	sUrl = url+applangcode+"/get_rgstr_list.jsp?wReturn="+locRgstrType+"&wReturnDesc="+locRgstrTypeDesc+"&preceedence="+inPreceedence+"&rgstrType="+escape(rgstrTypeVal)+"&delFlg="+locDelFlg+"&filterInd="+filterInd.value;
	if(arguments.length>6)
		if((rgstrSubTypeDesc != null && rgstrSubTypeDesc.id != undefined) && (rgstrSubType != null && rgstrSubType != undefined))
		sUrl = url+applangcode+"/get_rgstr_list.jsp?wReturn="+locRgstrType+"&wReturnDesc="+locRgstrTypeDesc+"&wSubReturn="+locRgstrSubType+"&wSubReturnDesc="+locRgstrSubTypeDesc+"&preceedence="+preceedence+"&rgstrType="+escape(rgstrTypeVal)+"&rgstrSubType="+rgstrSubTypeVal+"&delFlg="+locDelFlg+"&filterInd="+filterInd.value;
		else
		sUrl = url+applangcode+"/get_rgstr_list.jsp?wReturn="+locRgstrType+"&wReturnDesc="+locRgstrTypeDesc+"&preceedence="+preceedence+"&delFlg="+locDelFlg+"&filterInd="+filterInd.value;
	var retVal = popModalWindow(sUrl,finbranchResource.FLT001803);

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    	if (retVal != null && retVal != undefined )
		{
			var liarrBufArray = retVal.split("|");
			rgstrType.value = liarrBufArray[0];
			if(rgstrTypeDesc != null) rgstrTypeDesc.value = liarrBufArray[1];
			if(rgstrSubType != null) rgstrSubType.value = liarrBufArray[2];
			if(rgstrSubTypeDesc != null) rgstrSubTypeDesc.value = liarrBufArray[3];
		}
    	}
}
/* Function for MRT file list*/
/* OptionCode and optionValue must be passed as parameter */
function showMRTFileList(optionValue,optionDesc,optionCode,inPreceedence,ctrlOrMorph,delFlg)
{
	var sUrl = "";
	var preceedence = 'B';
	var url = "../../arjspmorph/";
	var locOptionCode = "NULL"
	var locDelFlg = "N";
	var locOptionDesc="NULL";
	var locRgstrType="NULL";
	if(arguments.length > 2)
	{
	        preceedence = inPreceedence;
	}
	if(arguments.length > 4)
	{
	        if(ctrlOrMorph == 'morph')
	        url = "../";
	}
	if(arguments.length > 5)
	{
	   locDelFlg = delFlg;
	}

	if(optionDesc != null && optionDesc.id != undefined)
		locRgstrTypeDesc = rgstrTypeDesc.id;
	if(!fnIsNull(optionCode))
		locOptionCode = optionCode;
	sUrl = url+applangcode+"/get_mrtfile_list.jsp?wReturn="+optionValue.id+"&wReturnDesc="+locOptionDesc+"&preceedence="+inPreceedence+"&optionCode="+escape(locOptionCode)+"&delFlg="+locDelFlg;

	var retVal = popModalWindow(sUrl,finbranchResource.FLT001867);

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    	if (retVal != null && retVal != undefined )
		{
			var liarrBufArray = retVal.split("|");
			optionValue.value = liarrBufArray[0];
			if(optionDesc != null) optionDesc.value = liarrBufArray[1];
		}
    	}
}

function showClgZoneCode(obj,ctrlOrMorph,inPreceedence,objDesc,delFlg)
{


    var zoneObj;
    var sUrl = "";
    var preceedence = 'B';
    var url = "../";

    if(arguments.length > 1)
    {
        if(ctrlOrMorph == 'ctrl')
        url = "../../arjspmorph/";
    }
    if(browser_name != "Microsoft Internet Explorer")
    {
    url = "../../arjspmorph/";
    }
    if(arguments.length > 2)
    {
    preceedence = inPreceedence;
    }

    if(obj != null) zoneObj = obj.id;

    sUrl = url +applangcode+"/get_clg_zone_code.jsp?wReturn="+zoneObj+"&wReturnDesc=NULL&preceedence="+preceedence+"&DelFlg="+delFlg+"&ZoneCode="+escape(obj.value);

    var retVal = popModalWindow(sUrl,"ClgZoneCodeList");

    if ("Microsoft Internet Explorer" == browser_name)
    {
       if (retVal != null && retVal != undefined )
       {
        //Array for taking the values after splitting the value with "|".
         var liarrBufArray = retVal.split("|");
         obj.value = liarrBufArray[0];
        if(objDesc != null) objDesc.value = liarrBufArray[1];
       }
    }
}

function getEvtIdList(obj,ctrlOrMorph,inPreceedence,objDesc,delFlg,verFlg,evtType)
{
    var evtObj;
    var sUrl = "";
    var preceedence = 'B';
    var url = "../";

    if(arguments.length > 1)
    {
        if(ctrlOrMorph == 'ctrl')
        url = "../../arjspmorph/";
    }
    if(browser_name != "Microsoft Internet Explorer")
    {
    url = "../../arjspmorph/";
    }
    if(arguments.length > 2)
    {
    preceedence = inPreceedence;
    }

    if(obj != null) evtObj = obj.id;

    sUrl = url + applangcode+"/get_zone_evt_id.jsp?wReturn="+evtObj+"&wReturnDesc=NULL&preceedence="+preceedence+"&DelFlg="+delFlg+"&VerFlg="+verFlg+"&EvtType="+evtType+"&EvtId="+escape(obj.value);
    var retVal = popModalWindow(sUrl,"ClgEvtIdList");

    if ("Microsoft Internet Explorer" == browser_name)
    {
        if (retVal != null && retVal != undefined )
        {
        //Array for taking the values after splitting the value with "|".
        var liarrBufArray = retVal.split("|");

        obj.value = liarrBufArray[0];
        if(objDesc != null) objDesc.value = liarrBufArray[1];
        }
    }

}

function showDenomDetList(objAcctId, objCertAlpha, objCertNum, sDelFlg, sCtrlOrMorph, sPreceedenceFlg)
{
    var sUrl = ( !fnIsNull(sCtrlOrMorph) && (sCtrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
    sDelFlg = fnIsNull(sDelFlg) ? " " : sDelFlg;
    sUrl = sUrl + applangcode+"/get_denomdet_list.jsp?AcctId="+escape(objAcctId.value)+"&DelFlg="+sDelFlg+"&preceedence="+sPreceedenceFlg+"&wReturn="+objCertAlpha.id+"&wReturnDesc="+objCertNum.id;
    var retVal = popModalWindowVar(sUrl, finbranchResource.FLT001679, 800, 400, 50, 30);
    if (retVal != null && retVal != undefined)
    {
		var liarrBufArray = retVal.split("|");
		objCertAlpha.value = liarrBufArray[0];
		objCertNum.value = liarrBufArray[1];
    }
}

function showInstTypeList(objInstType, objInstDesc, sDelFlg, sCtrlOrMorph, sPreceedenceFlg)
{
    var sUrl = ( !fnIsNull(sCtrlOrMorph) && (sCtrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
    var sInstDesc = ( (objInstDesc == null) || (objInstDesc == undefined) ) ? "" : objInstDesc.id;
    sDelFlg = fnIsNull(sDelFlg) ? " " : sDelFlg;
    sUrl = sUrl + applangcode+"/get_insttype_list.jsp?InstType="+escape(objInstType.value)+"&DelFlg="+sDelFlg+"&preceedence="+sPreceedenceFlg+"&wReturn="+objInstType.id+"&wReturnDesc="+sInstDesc;
    var retVal = popModalWindowVar(sUrl, finbranchResource.FLT001679, 800, 400, 50, 30);
    if (retVal != null && retVal != undefined)
    {
		var liarrBufArray = retVal.split("|");
		objInstType.value = liarrBufArray[0];
		if( (objInstDesc != null) && (objInstDesc != undefined) )
			objInstDesc.value = liarrBufArray[1];
    }
}

function fnEnableAllParentFormControls(iLinksCount)
{
	var len = window.opener.document.forms[0].elements.length
	var obj = window.opener.document.forms[0];
	if(Number(iLinksCount) > 0)
	{
		var lnkStr = "sLnk";
		var lnkCount = parseInt(iLinksCount,10);
		for (var i=1;i<=lnkCount;i++)
		{
			var lnkStrId = lnkStr+i;
			fnEnableLink(lnkStrId);
		}
	}
	for(var i=0;i<len;i++)
	{
		if(obj.elements[i].type == 'button')
		{
			obj.elements[i].disabled = false;
		}
	}
}

function fnDisableAllParentFormControls(iLinksCount)
{
	var len = window.opener.document.forms[0].elements.length
	var obj = window.opener.document.forms[0];
	if(Number(iLinksCount) > 0)
	{
		var lnkStr = "sLnk";
		var lnkCount = parseInt(iLinksCount,10);
		for (var i=1;i<=lnkCount;i++)
		{
			var lnkStrId = lnkStr+i;
			fnDisableLink(lnkStrId);
		}
	}
	for(var i=0;i<len;i++)
	{
		if(obj.elements[i].type == 'button')
		{
			obj.elements[i].disabled = true;
		}
	}
}

function get_parent_lyr_css(id) {
	var lyr, lyrcss;
	lyr = (window.opener.document.getElementById)? window.opener.document.getElementById(id): (window.opener.document.all)? window.opener.document.all[id]: null;
	if (lyr) lyrcss = (lyr.style)? lyr.style: lyr;
	return lyrcss;
}

function fnEnableLink(linkId)
{
	var curcss = get_parent_lyr_css(linkId);
	if (curcss) {
	        curcss.display = "";
	        curcss.zIndex = 1000;   // some browsers need z-index set
	}
}

function fnDisableLink(linkId)
{
	var curcss = get_parent_lyr_css(linkId);
	if (curcss) {
		curcss.visibility = "hidden";
		curcss.zIndex = 1000;
	}
}

function showAuthorizeWindow1(sGrpName,lnkCount)
{
	window.open("../../arjspmorph/"+applangcode+"/authorize_user.jsp?groupName="+sGrpName+"&lnkCount="+lnkCount,"UserAuthorization",
								 "width=300, height=110,top=230,left=270");
}
function fnTmplBack(sTmplMode)
{
	if(("A" == sTmplMode) ||
	   ("C" == sTmplMode) ||
	   ("F" == sTmplMode) ||
	   ("M" == sTmplMode))
	{
		if(!confirm(finbranchResource.FER000136))
		{
			return false;
		}
	}
	return true;
}
function fnTmplDelete()
{
	if(!confirm(finbranchResource.FAT000357))
	{
		return false;
	}
	return true;
}
//Function to show the Inventory Type list
function showInventoryTypeList(objInvType,sCtrlOrMorph, sPreceedenceFlg,objInvClass,objDesc)
{


	var sUrl = ( !fnIsNull(sCtrlOrMorph) && (sCtrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";

	sUrl = sUrl+applangcode+"/get_inventory.jsp?wReturn="+objInvType.id+"&preceedence="+sPreceedenceFlg;

	if(objDesc != null)
	{
	sUrl = sUrl+"&wReturnDesc="+objDesc.id;
	}
	if(objInvClass != null)
	{
	sUrl = sUrl+"&InventoryClass="+ objInvClass.value +"&wRetClass="+objInvClass.id;
	}

	var retVal = popModalWindow(sUrl,"Inventory Type List");
	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			if(objDesc == null)
			{
				var liarrBufArray = retVal.split("/");	//Array for taking the values after splitting the value with "/".
				objInvType.value = liarrBufArray[0];
				if(objInvClass != null) objInvClass.value = liarrBufArray[1];
			}
			else
			{
			var liarrBufArray = retVal.split("|");	//Array for taking the values after splitting the value with "/".
			objInvType.value = liarrBufArray[0];
			var liarrBufArrayNew = liarrBufArray[1].split("/");
			if(objDesc != null) objDesc.value = liarrBufArrayNew[0];
			if(objInvClass != null) objInvClass.value = liarrBufArrayNew[1];
			}
		}
    	}
}

function showBranchCodes(objBankCode, objBranchCode, ctrlOrMorph, inPreceedence,objBranchName,brType,delFlg) {
    var sUrl = "";
    var url = "../../arjspmorph/";
	var preceedence = 'B';
	var delFlag = 'N';

	var errObj = new ErrObject();

	if(delFlg != null && delFlg != undefined)	{
		delFlag = delFlg;
	}

	if(fnIsNull(objBankCode.value)) {
        errObj.setErr(objBankCode, finbranchResource.FER000150);
        errObj.displayErr();
        return;
    }

    if(arguments.length > 2) {
        if(ctrlOrMorph == 'morph')
        url = "../";
    }

	if(inPreceedence != null && inPreceedence != undefined) {
        preceedence = inPreceedence;
    }

    if(arguments.length < 6) {
    	sUrl = url +applangcode+"/branch_codes.jsp?issuedOnBank="+escape(objBankCode.value)+"&preceedence="+preceedence+"&issuedOnBranch="+escape(objBranchCode.value)+"&wReturn="+objBranchCode.id+"&delFlg="+delFlag;

    } else {

    	sUrl = url +applangcode+"/branch_codes.jsp?issuedOnBank="+escape(objBankCode.value)+"&preceedence="+preceedence+"&issuedOnBranch="+escape(objBranchCode.value)+"&wReturn="+objBranchCode.id+"&brType="+brType.value+"&delFlg="+delFlag;
	}
    if(objBranchName !=null && objBranchName != undefined)
    {

    	sUrl = sUrl +"&issuedOnBranchName="+objBranchName.id;
    }


    var retVal = popModalWindow(sUrl, "BranchCodes");

    if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

		objBranchCode.value = liarrBufArray[0];
			if(objBranchName != null) objBranchName.value = liarrBufArray[1];
		}
        }

}
/* Function to get the Function Code Description*/
 function fnGetFuncCodeDesc(fnCode)
 {
	 switch(fnCode)
	 {
		 case 'A': return finbranchResource.FLT001566;
		 case 'M': return finbranchResource.FLT001716;
		 case 'C': return finbranchResource.FLT001717;
		 case 'D': return finbranchResource.FLT001718;
		 case 'I': return finbranchResource.FLT001719;
		 case 'U': return finbranchResource.FLT001720;
		 case 'X': return finbranchResource.FLT001721;
		 case 'V': return finbranchResource.FLT001722;
		 case 'P': return finbranchResource.FLT003092;
		 default : return fnCode;
	 }
 }

function showRvrslPartTranList(objTranId, objPartTranSrlNum, objTranDate, objValueDate, objAcctId, sCtrlOrMorph, sPreceedenceFlg)
{
    var sUrl = ( !fnIsNull(sCtrlOrMorph) && !(sCtrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
	var wRetValForNetscape = objTranId.id+"|"+objValueDate.id+"|"+objPartTranSrlNum.id+"|"+objTranDate.id;
	sPreceedenceFlg = (arguments.length < 5) ? 'B' : sPreceedenceFlg;

    sUrl = sUrl + applangcode+"/get_rvrslparttran_list.jsp?wReturn="+wRetValForNetscape+"&TranId="+escape(objTranId.value)+"&PartTranSrlNum="+escape(objPartTranSrlNum.value)+"&TranDate="+objTranDate.value+"&ValueDate="+objValueDate.value+"&AcctId="+escape(objAcctId.value)+"&preceedence="+sPreceedenceFlg;
    var retVal = popModalWindow(sUrl, finbranchResource.FLT002256);
    if (retVal != null && retVal != undefined)
    {
		var liarrBufArray = retVal.split("|");
		objTranId.value = liarrBufArray[0];
		objValueDate.value = liarrBufArray[1];
		//set the date value to ui field from hidden field.
		fnAssignUIDate(objValueDate);

		if(!objPartTranSrlNum.readOnly && !objTranDate.readOnly)
		{
			objPartTranSrlNum.value = liarrBufArray[2];
			objTranDate.value = liarrBufArray[3];
			//set the value to ui field from hidden field
			fnAssignUIDate(objTranDate);
		}
    }
}

function showOriginatingTranList(collRefundAcctId,ctrlOrMorph,inPreceedence,tranId,tranPartSerialNum,tranDate,refNum,solId)
{
	if(fnIsNull(collRefundAcctId.value))
	{
		alert(finbranchResource.FER000134);
		collRefundAcctId.focus();
		return;
	}
	var sUrl = ( !fnIsNull(ctrlOrMorph) && !(ctrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
	sUrl += applangcode+"/get_originating_tran_list.jsp?collRefundAcctId="+escape(collRefundAcctId.value)+"&preceedence="+inPreceedence;

	if(tranId != null && tranId.id != undefined)
	{
		sUrl += "&tranId="+escape(tranId.value)+"&rtnVal1="+tranId.id;
	}

	if(tranPartSerialNum != null && tranPartSerialNum.id != undefined)
	{
		sUrl += "&tranPartSerialNum="+tranPartSerialNum.value+"&rtnVal2="+tranPartSerialNum.id;
	}

	if(tranDate != null && tranDate.id != undefined)
	{
		sUrl += "&tranDate="+tranDate.value+"&rtnVal3="+tranDate.id;
	}

	if(refNum != null && refNum.id != undefined)
	{
		sUrl += "&refNum="+escape(refNum.value)+"&rtnVal4="+refNum.id;
	}

	if(solId != null && solId.id != undefined)
	{
		sUrl += "&solId="+escape(solId.value)+"&rtnVal5="+solId.id;
	}
	var retVal = popModalWindow(sUrl,finbranchResource.FLT002581);
	if ("Microsoft Internet Explorer" == browser_name)
	{
    	if(retVal != null && retVal != undefined)
		{
			var liarrBufArray = retVal.split("|");
			tranId.value = liarrBufArray[0];
			tranPartSerialNum.value = liarrBufArray[1];
			tranDate.value = liarrBufArray[2];
			refNum.value = liarrBufArray[3];
			if(solId != null && solId.id != undefined)
				solId.value = liarrBufArray[4];
		}
    }
}


//Function for amount code list
function showAmtCode(objAmtCode,objCrncy,delFlgInd,inVfdInd,inPreceedence,objAmtCodeDesc)
{
        var amtCode = objAmtCode.value;
        var url = "";
        var preceedence = 'B';
        var VfdInd = '';
        var crncyCode =  '';
        if(objCrncy != null && objCrncy != undefined)
        {
                crncyCode = objCrncy.value;
        }

        if(amtCode == null) amtCode = '';
        if(crncyCode == null) crncyCode = '';
        if(delFlgInd == null) delFlgInd = '';

        if(arguments.length > 3)
        {
                preceedence = inPreceedence;
        }
        if(arguments.length > 4)
        {
                VfdInd = inVfdInd;
        }

        url = "../../arjspmorph/"+applangcode+"/get_amount_code.jsp?wReturn="+objAmtCode.id;

        if(arguments.length > 5)
	{
           url = url +"&wReturnDesc="+ objAmtCodeDesc.id +"&wReturnCrncy="+ objCrncy.id +"&amtCode="+escape(amtCode)+"&crncyCode="+escape(crncyCode);
           url = url +"&delFlgInd="+delFlgInd+"&vfdInd="+VfdInd+"&preceedence="+preceedence;
        }
        else
        {
                url = url +"&wReturnCrncy="+ objCrncy.id +"&amtCode="+escape(amtCode)+"&crncyCode="+escape(crncyCode);
                url = url +"&delFlgInd="+delFlgInd+"&vfdInd="+VfdInd+"&&preceedence="+preceedence;
        }

        var retVal = popModalWindow(url,"Amount Table Code List");

        if ("Microsoft Internet Explorer" == browser_name)
        {
            if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");
                        objAmtCode.value = liarrBufArray[0];
                        if(objAmtCodeDesc != null) objAmtCodeDesc.value = liarrBufArray[1];
                        if(objCrncy != null) objCrncy.value = liarrBufArray[2];
                }
    }
}

function showWaiverRvsrlList(acctId,ctrlOrMorph,inPreceedence,chrgType,waiverType,srlNo,delFlg)
{
	if(fnIsNull(acctId.value))
	{
		alert(finbranchResource.FER000134);
		acctId.focus();
		return;
	}
	if(fnIsNull(waiverType.value))
	{
		alert(finbranchResource.FER000134);
		waiverType.focus();
		return;
	}
	var sUrl = ( !fnIsNull(ctrlOrMorph) && !(ctrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
	sUrl += applangcode+"/get_waiver_rvsrl_list.jsp?acctId="+escape(acctId.value)+"&preceedence="+inPreceedence;
	if(chrgType != null && chrgType.id != undefined)
	{
		sUrl += "&chrgType="+escape(chrgType.value)+"&rtnChrgType="+chrgType.id;
	}
	if(waiverType != null && waiverType.id != undefined)
	{
		sUrl += "&waiverType="+escape(waiverType.value);
	}
	if(srlNo != null && srlNo.id != undefined)
	{
		sUrl += "&rtnSrlNo="+srlNo.id;
	}
	sUrl += "&delFlg="+delFlg;
	var retVal = popModalWindow(sUrl,finbranchResource.FLT002581);
	if ("Microsoft Internet Explorer" == browser_name)
	{
    	if(retVal != null && retVal != undefined)
		{
			var liarrBufArray = retVal.split("|");
			if( chrgType.id != undefined ) chrgType.value = liarrBufArray[0];
			if( srlNo.id != undefined) srlNo.value = liarrBufArray[1];
		}
    }
}

function MnemonicsClass(mnemonicsList,mnemonicsDesc)
{
	this.mnemonicsList = mnemonicsList;
	this.mnemonicsDesc = mnemonicsDesc;
}

function getMnemonics()
{
	var mnemonicsList = new Array("$BOD$","$BOD-1$","$BOD+1$","$MEND$","$QEND$","$HEND$","$YEND$");
	var mnemonicsDesc = new Array("Begin of Day","Date Previous to Begin Of Day","Date Next To Begin Of Day","Month End","Quarter End","Half Year End","Year End");
	var len = mnemonicsDesc.length;
	var mnemonics = new Array(len);
	for(var index = 0 ; index < len; index++)
	{
		mnemonics[index] = new MnemonicsClass(mnemonicsList[index],mnemonicsDesc[index]);
	}
	return mnemonics;
}

function showMnemonics(dateObj)
{

		var retVal	= popModalWindowVar("../../arjspmorph/"+applangcode+"/get_mnemonics_list.jsp?wReturn="+dateObj.id,"Mnemonics List",400,200,50,30);
		if (null != retVal)
        dateObj.value = retVal;
		//set the date value to hidden field from UI field.
		fnAssignDateOnEnter(dateObj);

}

function isValidDateMneumonic(dateMneumonic)
{
	var mnemonics	= getMnemonics();
    var len			= mnemonics.length;
	for(var index = 0; index < len; index++)
    {
		if(mnemonics[index].mnemonicsList == dateMneumonic)
		{
			return true;
		}
	}
	return false;
}

function  showCntryCurrencyCode(obj,ctrlOrMorph,inPreceedence,delFlgInd,objDesc)
{

	var crncyObj;
	var sUrl = "";
	var preceedence = 'B';
	var url = "../";

	if(arguments.length > 1)
	{
		if(ctrlOrMorph == 'ctrl')
		url = "../../arjspmorph/";
	}
	if(browser_name != "Microsoft Internet Explorer")
	{
		url = "../../arjspmorph/";
	}
	if(arguments.length >3)
	{
		preceedence = inPreceedence;
	}

	if(obj != null)	crncyObj = obj.id;

	if (arguments.length < 5)
	{
		sUrl = url +applangcode+"/get_cntrycurrency.jsp?wReturn="+crncyObj+"&wReturnDesc=NULL&Currency="+escape(obj.value)+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
	}else
	{

		sUrl = url +applangcode+"/get_cntrycurrency.jsp?wReturn="+crncyObj+"&wReturnDesc="+objDesc.id+"&Currency="+escape(obj.value)+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"CountryCurrencyList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
		if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

			obj.value = liarrBufArray[0];

			if(objDesc != null) objDesc.value = liarrBufArray[1];
		}
	}
}

function showColtrlCodeList(coltrlType, obj, ctrlOrMorph, inPreceedence, delFlgInd, objDesc) {

    var locObj;
    var sUrl = "";
    var preceedence = 'B';
    var url = "../";

    if(arguments.length > 1) {
        if(ctrlOrMorph == 'ctrl')
        url = "../../arjspmorph/";
    }
    if(browser_name != "Microsoft Internet Explorer") {
            url = "../../arjspmorph/";
    }
    if(arguments.length >3) {
        preceedence = inPreceedence;
    }

    if(obj != null) {
        locObj = obj.id;
    }

    if (arguments.length < 5) {
        sUrl = url +applangcode+"/getColtrlCodeDtls.jsp?wReturn="+locObj+"&wReturnDesc=NULL&ColtrlType="+coltrlType+"&ColtrlCode="+escape(obj.value)+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
    } else {
        sUrl = url +applangcode+"/getColtrlCodeDtls.jsp?wReturn="+locObj+"&wReturnDesc="+objDesc.id+"&ColtrlType="+coltrlType+"&ColtrlCode="+escape(obj.value)+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
    }

    var retVal = popModalWindow(sUrl,"CollateralCodeList");

    if ("Microsoft Internet Explorer" == browser_name) {
        if (retVal != null && retVal != undefined ) {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");
            obj.value = liarrBufArray[0];
            if(objDesc != null) objDesc.value = liarrBufArray[1];
        }
    }
}

function getCrncyFromAmt(sSrcAmt)
{
	var iCrncyIndex = sSrcAmt.indexOf("|");
	if(iCrncyIndex != -1)	return sSrcAmt.substring(iCrncyIndex+1);
	else return "";
}

function isMneblAndValidMnem(dateObj)
{
		if((dateObj.getAttribute("mnebl") && isValidDateMneumonic(dateObj.value)))
		{
			return true;
		}
		return false;
}


/**
	To open a Search ECS Tran Ref List window - 24-Apr-2003 16:57:20.
*/
function showEcsTranRefno(refObj,paymsysId,ecsMembershipId,acctId,settlementDate,inPreceedence)
 {
	var sUrl = "";
	var preceedence = 'F';

    if(arguments.length > 5)
    {
        preceedence = inPreceedence;
    }

	if (arguments.length < 6)
	{
		sUrl = "../../arjspmorph/"+applangcode+"/otcetranreflist.jsp?wReturn="+refObj.id+"&wReturnPaysys=NULL&wReturnMem=NULL&wReturnAcct=NULL&wReturnSetdt=NULL&preceedence="+preceedence;
	}else
	{
		sUrl = "../../arjspmorph/"+applangcode+"/otcetranreflist.jsp?wReturn="+refObj.id+"&wReturnPaysys="+paymsysId.id+"&wReturnMem="+ecsMembershipId.id+"&wReturnAcct="+acctId.id+"&wReturnSetdt="+settlementDate.id +"&preceedence="+preceedence;
	}


	var retVal = popModalWindow(sUrl,"ECSList") ;


	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        if(refObj!=null) refObj.value = liarrBufArray[0];
			if(paymsysId!=null) paymsysId.value = liarrBufArray[1];
			if(ecsMembershipId!=null) ecsMembershipId.value = liarrBufArray[2];
			if(acctId!=null) acctId.value = liarrBufArray[3];
			if(settlementDate!=null) settlementDate.value = liarrBufArray[4];
		}
    }
}


function fnIsNullOrUndefined(obj) {
    if( (obj == null) || (obj == undefined) ) {
            return true;
    } else {
            return false;
    }
}

function fnAppendOption(objSelectBox, sOptionDisplayText, sOptionValue) {
    if( fnIsNullOrUndefined(objSelectBox)
    || fnIsNullOrUndefined(sOptionDisplayText)
    || fnIsNullOrUndefined(sOptionValue)
    || (-1 != getOptionIndex(objSelectBox, sOptionValue)) ) {
        return false;
    } else {
        objSelectBox.options[objSelectBox.options.length] = new Option(sOptionDisplayText, sOptionValue);
        return true;
    }
}

function fnRemoveOption(objSelectBox, sOptionValue) {
    var objIndex = getOptionIndex(objSelectBox, sOptionValue);
    if(objIndex != -1) {
        objSelectBox.options[objIndex] = null;
        return true;
    }
    return false;
}

function getOptionIndex(objSelectBox, sOptionValue) {
    if( fnIsNullOrUndefined(objSelectBox) ) return -2;
    for(var i = 0; i < objSelectBox.options.length; i++) {
        if( objSelectBox.options[i].value == sOptionValue ) {
            return i;
        }
    }
    return -1;
}

function fnValidateTextArea(objTextArea, maxLength)
{
    if (objTextArea.value.length > maxLength)
    {
        alert(finbranchResource.FAT000374+finbranchResource.FAT000532+maxLength);
        objTextArea.focus();
        return false;
    }
    return true;
}


/*
 *      INPUT VALUE     : html form elements separated by comma
 *      RETURN VALUE    : boolean true for success, false for failure with alert
 *      EXAMPLE             : document.forms[0].ipaddress1[, document.forms[0].ipaddress2 [,..]]
 *      ASSUMPTION      : inputs are assumed to be form elements of select-box, input-types
 */
function fnValidateIPAddresses()
{
    var objIPAddress = null;
    for(var i = 0; i < arguments.length; i++)
    {
        objIPAddress = eval(arguments[i]);
        if( (objIPAddress.value != "") && (false == fnIsValidIPAddress(objIPAddress.value)) )
        {
            objIPAddress.focus();
            alert(finbranchResource.FAT000394);
            return false;
        }
    }
    return true;
}


/*
 *      INPUT VALUE     : IP Address (string value)
 *      RETURN VALUE    : boolean true for success, false for failure
 *      EXAMPLE             : 192.168.133.214
 *      ASSUMPTION      : input is assumed to a valid string of characters
 */
function fnIsValidIPAddress(ipaddress)
{
    var IP_ADDRESS_SEPARATOR = ".";
    var IP_ADDRESS_PARTS_LENGTH = 4;
    var IP_ADDRESS_PARTS_MIN_VALUE = 1;
    var IP_ADDRESS_PARTS_MAX_VALUE = 255;
    var IP_ADDRESS_INVALID_CHARS = /[^0-9.]/g; /* reg-exp:: all but valid chars */

    if(IP_ADDRESS_INVALID_CHARS.test(ipaddress))
    {
        return false;
    }

    if(ipaddress.indexOf(IP_ADDRESS_SEPARATOR) == -1)
    {
        return false;
    }

    var ipParts = ipaddress.split(IP_ADDRESS_SEPARATOR);
    if(ipParts.length != IP_ADDRESS_PARTS_LENGTH)
    {
        return false;
    }

    for(var i = 0; i < IP_ADDRESS_PARTS_LENGTH; i++)
    {
        if(isNaN(ipParts[i]))
        {
            return false;
        }
        if((Number(ipParts[i]) < IP_ADDRESS_PARTS_MIN_VALUE) ||
            (Number(ipParts[i]) > IP_ADDRESS_PARTS_MAX_VALUE) )
        {
            return false;
        }
    }
    return true;
}

function validateCrncy(frame,crncyObj,descObj,isValidObj)
{
    if (fnIsNull(crncyObj.value)) {
        return;
    }

    var descId = '';
	var isValidFlg = '';
    if (descObj != null) {
        descId = descObj.id;
    }
	if (isValidObj != null) {
		isValidFlg = isValidObj.id;
		isValidObj.value = 'N';
	}
    sendDataToServer(frame,'CRNCY','F',crncyObj.id,descId + "|" + isValidFlg);
}

function getInstrTypeList(instrTypeObj, acctId, ctrlOrMorph, prec)
{
    var sUrl = (ctrlOrMorph == 'morph') ? "../" : "../../arjspmorph/";
    sUrl += applangcode+"/instrument_type.jsp?wReturn=document.forms[0]."+instrTypeObj.id;
    sUrl += "&AcctId=" + acctId + "&preceedence=" + prec;

    var retVal = popModalWindow(sUrl, "Instr Type List");
    if (retVal != null && retVal != undefined)
    {
        instrTypeObj.value = retVal;
    }
}


function writeFuncCodeDesc(fnCode)
{
    switch(fnCode)
    {
		case 'A':
			document.write(finbranchResource.FLT001566);
			break;
		case 'M':
			document.write(finbranchResource.FLT001716);
			break;
		case 'I':
			document.write(finbranchResource.FLT001719);
			break;
		case 'D':
			document.write(finbranchResource.FLT001718);
			break;
		case 'U':
			document.write(finbranchResource.FLT001720);
			break;
		case 'C':
			document.write(finbranchResource.FLT001717);
			break;
		case 'V':
			document.write(finbranchResource.FLT001722);
			break;
		case 'X':
			document.write(finbranchResource.FLT001721);
			break;
		default:
            document.write("");
			break;
	}
}

//The functions takes the object and a string
//obj should be document.forms[0].<OBJECT_ID>
//str should be either 'E' or 'D' for Enabling / Disabling respectively.
function fnEnableDisableRadioButtons(obj,str)
{
    var isArray = (typeof(obj.length)=="undefined")?false:true;

    if(!isArray)
    {
		if (str == 'D')
		{
        	obj.disabled = true;
	        return;
		}else{
		    obj.disabled = false;
		    return;
		}
    }

    if(isArray && (typeof(obj.type)=="undefined"))
    {
        for(var i=0;i<obj.length;i++)
        {
            if (str == 'D')
            {
	            obj[i].disabled = true;
	        }else{
		        obj[i].disabled = false;
	        }
        }
    }

    return;
}
function showPaySysIdList(objPaySysId, objPaySysIdDesc, sDelFlg, sCtrlOrMorph, sPreceedenceFlg)
{
    var sUrl = ( !fnIsNull(sCtrlOrMorph) && !(sCtrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
    var sDelFlg = fnIsNull(sDelFlg) ? " " : sDelFlg;
    var sPaySysId = objPaySysId.value;
    var sPaySysId = fnIsNull(sPaySysId) ? " " : sPaySysId;
    var sUrl = "../../arjspmorph/"+ applangcode+"/get_paysys_id_list.jsp?wReturn="+objPaySysId.id+"&wReturnDesc="+objPaySysIdDesc.id+"&DelFlg="+sDelFlg+"&PaySysId="+sPaySysId+"&preceedence="+sPreceedenceFlg;
    var retVal = popModalWindowVar(sUrl, finbranchResource.FLT002884, 600, 300, 50, 30);

	setObjAndDescValuesForIE(retVal,objPaySysId,objPaySysIdDesc);
}

function showOutClgInstList(obj,instrId,listReq,inPreceedence)
{
	var instrObj;
	var sUrl = "";
	var sPreceedenceFlg = inPreceedence;
	var url = "../../arjspmorph/";
	var desc = "NULL";

	if(obj != null)	instrObj= obj.id;

	sUrl = url +applangcode+"/get_outClgInstr_list.jsp?wReturn="+instrObj+"&InstrId="+instrId+"&preceedence="+sPreceedenceFlg+"&listRequired="+listReq;

	var retVal = popModalWindow(sUrl,"outClgInst_list");
	if ("Microsoft Internet Explorer" == browser_name)
	{
		if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");
			obj.value = liarrBufArray[0];
		}
	}
}

function  showRejReasonList(obj,objDesc,inPreceedence)
{
	var reasonObj;
	var sUrl = "";
	var sPreceedenceFlg = inPreceedence;
	var url = "../../arjspmorph/";
	var desc = "NULL";
	var sDesc = ( (objDesc == null) || (objDesc == undefined) ) ? "" : objDesc.id;

	if(obj != null)
	{
		reasonObj = obj.id;
	}

	sUrl = url +applangcode+"/get_rejectReason_list.jsp?wReturn="+reasonObj+"&ReasonCode="+escape(obj.value)+"&preceedence="+sPreceedenceFlg+"&wReturnDesc="+sDesc;
	var retVal = popModalWindow(sUrl,"rejReason_list");

	if ("Microsoft Internet Explorer" == browser_name)
	{
		if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");
			obj.value = liarrBufArray[0];
			if( (objDesc != null) && (objDesc != undefined) )
			objDesc.value = liarrBufArray[1];
		}
	}
}

/*
	Function added by Vasudevan G on May 21 2003
	This function evaluates whether form needs to be
	submitted or not for next / prev button click. This will evaluate
	to false when the current record is either the first or last
	record. Based on its return value, form can be submitted

	Parameters
		sAction = will be either next or prev
		currCount = current count of multirec
		totRecs = total size of multirec
		objFocus = if focus needs to be set in any form control

*/

function isNavigationRequired(sAction, currCount, totRecs, objFocus) {
    currCount = parseInt(currCount,10);
    totRecs = parseInt(totRecs,10);
    if ((sAction == 'prev' && currCount == 0) ||
        (sAction == 'next' && (currCount+1 >= totRecs))) {
        alert(finbranchResource.FAT000426);
        if ((objFocus != null) && (objFocus != undefined)) {
	        objFocus.focus();
        }
        return false;
    }
    return true;
}

function showTDAccountIdList(acctObj,solId,acctName,inPreceedence,currDesc)
{
	var sUrl = "";
	if (currDesc == null && currDesc == undefined )
		sUrl = "../../arjspmorph/"+applangcode+"/search_td_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy=NULL&wReturnSol=NULL&wReturnAcct=NULL&preceedence="+inPreceedence;
	else
		sUrl = "../../arjspmorph/"+applangcode+"/search_td_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy="+currDesc.id+"&wReturnSol="+solId.id+"&wReturnAcct="+acctName.id+"&preceedence="+inPreceedence;

	var retVal = popModalWindow(sUrl,"TDAccountIDList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        if(acctObj!=null) acctObj.value = liarrBufArray[0];
			if(currDesc!=null) currDesc.value = liarrBufArray[1];
			if(solId!=null) solId.value = liarrBufArray[2];
			if(acctName!=null) acctName.value = liarrBufArray[3];
		}
    }
}

function showTDSchemeCode(schmObj,glObj,sol,listWanted,inPreceedence,schmDesc,DepType)
{
	var id = '';
	var schm = "";
	var glSubHead="";
	var DummyDepType = "";
	var sUrl = "";
	var other = "NULL";
	if(DepType == undefined)
	{
		DummyDepType = "";
	}
	else
	{
		DummyDepType = DepType;
	}

	if (listWanted == "schmcode")
	{
		id = schmObj.id;
		schm = schmObj.value;
		if(glObj != null)
			glSubHead=glObj.value;


		if(glObj != null) other = glObj.id;
	}else
	{
		id = glObj.id;
		if(schmObj != null)
			schm = schmObj.value;
		glSubHead=glObj.value;

		if(schmObj != null) other = schmObj.id;
	}
	if( schmDesc == null && schmDesc == undefined )
		sUrl = "../../arjspmorph/"+applangcode+"/search_td_scheme.jsp?wReturn="+id+"&wReturnDesc=NULL&solId="+escape(sol)+"&listreqd="+listWanted+"&schmCode="+escape(schm)+"&glSubHead="+escape(glSubHead)+"&other="+other+"&preceedence="+inPreceedence+"&depositType="+DummyDepType;
	else
		sUrl = "../../arjspmorph/"+applangcode+"/search_td_scheme.jsp?wReturn="+id+"&wReturnDesc="+schmDesc.id+"&solId="+escape(sol)+"&listreqd="+listWanted+"&schmCode="+escape(schm)+"&glSubHead="+escape(glSubHead)+"&other="+other+"&preceedence="+inPreceedence+"&depositType="+DummyDepType;

	var retVal = popModalWindow(sUrl,"TDSchemeCodes");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined)
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

			if (listWanted == "schmcode")
			{
				if(schmObj != null) schmObj.value = liarrBufArray[0];
				if(schmDesc != null) schmDesc.value = liarrBufArray[1];
				if(glObj != null) glObj.value = liarrBufArray[2];
			}else
			{
				if(glObj != null) glObj.value = liarrBufArray[0];
				if(schmDesc != null) schmDesc.value = liarrBufArray[1];
				if(schmObj != null) schmObj.value = liarrBufArray[2];
			}
		}
	}
}

function showInClgZoneCode(obj,ctrlOrMorph,inPreceedence,objDesc,delFlg)
{


    var zoneObj;
    var sUrl = "";
    var url = "../";

    if(arguments.length > 1)
    {
        if(ctrlOrMorph == 'ctrl')
        url = "../../arjspmorph/";
    }
    if(browser_name != "Microsoft Internet Explorer")
    {
		url = "../../arjspmorph/";
    }

    if(obj != null) zoneObj = obj.id;

    sUrl = url +applangcode+"/get_inclg_zone_code.jsp?wReturn="+zoneObj+"&wReturnDesc=NULL&preceedence="+inPreceedence+"&DelFlg="+delFlg+"&ZoneCode="+escape(obj.value);
    var retVal = popModalWindow(sUrl,"InwardClgZoneCodeList");

    if ("Microsoft Internet Explorer" == browser_name)
    {
       if (retVal != null && retVal != undefined )
       {
        //Array for taking the values after splitting the value with "|".
         var liarrBufArray = retVal.split("|");
         obj.value = liarrBufArray[0];
         if(objDesc != null) objDesc.value = liarrBufArray[1];
       }
    }
}

function showExceptionCodeList(objExcpCode,delFlgInd, sPreceedenceFlg, objExcpDesc)
{

    var locObj;
    var sUrl = "";
    var url = "../../arjspmorph/";

    if(delFlgInd == "")
    delFlgInd = "N";

    if(sPreceedenceFlg == "")
    sPreceedenceFlg = "F";

    if(objExcpDesc != null && objExcpDesc != undefined)
    {
    sUrl = url +applangcode+"/getExcpCodeList.jsp?wReturn="+objExcpCode.id+"&wReturnDesc="+objExcpDesc.id+"&ExcpCode="+escape(objExcpCode.value)+"&DelFlgInd="+delFlgInd+"&preceedence="+sPreceedenceFlg;
    }
    else
    {
    sUrl = url +applangcode+"/getExcpCodeList.jsp?wReturn="+objExcpCode.id+"&wReturnDesc=NULL&ExcpCode="+escape(objExcpCode.value)+"&DelFlgInd="+delFlgInd+"&preceedence="+sPreceedenceFlg;
    }

    var retVal = popModalWindow(sUrl,"ExceptionCodeList");

    if ("Microsoft Internet Explorer" == browser_name) {
        if (retVal != null && retVal != undefined ) {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");
            objExcpCode.value = liarrBufArray[0];
            if(objExcpDesc != null) objExcpDesc.value = liarrBufArray[1];
        }
    }
}


function showInvtLocnClasCodeList(solId,objInvenDstryClass,delFlgInd,sPreceedenceFlg,objInvenDstryClassDesc)
{
    var sUrl = "";
    var url = "../../arjspmorph/";

    if(delFlgInd == "")
    delFlgInd = "N";

    if(objInvenDstryClassDesc != null && objInvenDstryClassDesc != undefined)
    {
    sUrl = url +applangcode+"/getInvtLocnClasCodeList.jsp?wReturn="+objInvenDstryClass.id+"&wReturnDesc="+objInvenDstryClassDesc.id+"&InvtLocnClass="+escape(objInvenDstryClass.value)+"&SolId="+solId+"&DelFlgInd="+delFlgInd+"&preceedence="+sPreceedenceFlg;
    }
    else
    {
    sUrl = url +applangcode+"/getInvtLocnClasCodeList.jsp?wReturn="+objInvenDstryClass.id+"&wReturnDesc=NULL&InvtLocnClass="+escape(objInvenDstryClass.value)+"&SolId="+solId+"&DelFlgInd="+delFlgInd+"&preceedence="+sPreceedenceFlg;
    }

    var retVal = popModalWindow(sUrl,"InvtLocnClasCodeList");

    if ("Microsoft Internet Explorer" == browser_name) {
        if (retVal != null && retVal != undefined ) {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");
            objInvenDstryClass.value = liarrBufArray[0];
            if(objInvenDstryClassDesc != null) objInvenDstryClassDesc.value = liarrBufArray[1];
        }
    }
}

function showInvtLocnCodeList(invLocnClass, invLocnName, sDelFlg, sPreceedenceFlg)
{
	if(fnIsNull(invLocnClass.value))
	{
		alert(finbranchResource.FAT000200);
		invLocnClass.focus();
		return;
	}

    var sUrl = "../../arjspmorph/";
    sDelFlg = fnIsNull(sDelFlg) ? " " : "N";
    sUrl = sUrl + applangcode+"/get_invLocation_code_list.jsp?invLocnClass="+invLocnClass.value+"&invLocnName="+escape(invLocnName.value)+"&DelFlg="+sDelFlg+"&preceedence="+sPreceedenceFlg+"&wReturnClass="+invLocnClass.id+"&wReturnName="+invLocnName.id;
    var retVal = popModalWindowVar(sUrl, finbranchResource.FLT001679, 800, 400, 50, 30);
    if ("Microsoft Internet Explorer" == browser_name)
    {
    	if (retVal != null && retVal != undefined)
    	{
		var liarrBufArray = retVal.split("|");
		invLocnClass.value = liarrBufArray[0];
		invLocnName.value = liarrBufArray[1];
   	}
   }
}

function showUnPaidDDList(wReturn)
{
	url = "../../arjspmorph/"+applangcode+"/ddunpaidlist.jsp?wReturn="+wReturn;
	var retVal = popModalWindow(url,"unpaiddd_list");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			var outArray = retVal.split("|");
			var inArray = wReturn.split("|");
			for (var i=0; i < inArray.length; i++) {
				if (inArray[i] == "") {
					continue;
				}
				eval("document.forms[0]." + inArray[i] + ".value = \"" + outArray[i] + "\"");
				element = eval("document.forms[0]." + inArray[i]);
				//set the date value from hidden field to ui field.
				if(element != null && element.getAttribute("fdt") == "fdate"){
					fnAssignUIDate(element);
				}
			}
		}
    }
}

function showFABZoneCode(ZoneObj,znStatus)
{
    var retVal = popModalWindow("../../arjspmorph/"+applangcode+"/get_fabinclg_zone_code.jsp?wReturn="+ZoneObj.id+"&zoneCode="+ZoneObj.value+"&zoneStatus="+znStatus,"ZoneCodeList");
    if (retVal != null)
        ZoneObj.value = retVal;
}

function showInwdZoneCode(ZoneObj)
{
    var retVal = popModalWindow("../../arjspmorph/"+applangcode+"/get_inwdclg_zone_code.jsp?wReturn="+ZoneObj.id+"&zoneCode="+escape(ZoneObj.value),"ZoneCodeList");
    if (retVal != null)
        ZoneObj.value = retVal;
}

function showPendingVerificationList(objIntCode, objBaseInd, objCrncy, objVersion, sPreceedenceFlg)
{

     var sUrl = "";
    var url = "../../arjspmorph/";

    if(sPreceedenceFlg == "")
    sPreceedenceFlg = "F";

    sUrl = url +applangcode+"/get_pendverf_list.jsp?wReturnCode="+objIntCode.id+"&wReturnInd="+objBaseInd.id+"&wReturnCrncy="+objCrncy.id+"&wReturnVer="+objVersion.id;
    sUrl = sUrl+"&intCode="+escape(objIntCode.value)+"&baseInd="+objBaseInd.value+"&crncyCode="+objCrncy.value+"&version="+escape(objVersion.value)+"&preceedence="+sPreceedenceFlg;

    var retVal = popModalWindow(sUrl,"PendingVerficationList");

    if ("Microsoft Internet Explorer" == browser_name) {
        if (retVal != null && retVal != undefined ) {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");
            objIntCode.value = liarrBufArray[0];
            objBaseInd.value = liarrBufArray[1];
            objCrncy.value = liarrBufArray[2];
            objVersion.value = liarrBufArray[3];
        }
    }
}

function showPrintReport(title,functionName,buttonsList) {
	popModalWindow("../../arjspmorph/"+applangcode+"/pbp_rpt.jsp","PrintReport");
	retVal = popModalWindow("../../arjspmorph/"+applangcode+"/print_confirm.jsp?buttonsList="+buttonsList,"PrintConfirm");
	if ((retVal != null) && (retVal != undefined)) {
		objForm.printconfirm.value = retVal;
	}
	param = objForm.printconfirm.value;
	eval(functionName+"('"+param+"')");
}

function showPoolIdList(poolIdObj, poolDescObj, custIdObj, ctrlOrMorph, foracid, inPreceedence)
{
	var sUrl = ( !fnIsNull(ctrlOrMorph) && !(ctrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
	if( poolDescObj != null && poolDescObj.id != undefined )
		sUrl += applangcode+"/poolIdList.jsp?poolId=&wReturn1="+custIdObj.id+"&wReturn3="+poolDescObj.id+"&foracid="+escape(foracid.value)+"&custId="+escape(custIdObj.value)+"&preceedence="+inPreceedence;
	else
		sUrl += applangcode+"/poolIdList.jsp?poolId="+poolIdObj.value+"&wReturn1="+custIdObj.id+"&wReturn2="+poolIdObj.id+"&foracid="+escape(foracid.value)+"&custId="+escape(custIdObj.value)+"&preceedence="+inPreceedence;
    var retVal = popModalWindow(sUrl,"PoolID List");
    if (retVal != null)
	{
		var liarrBufArray = retVal.split("|");
		if( custIdObj != null && custIdObj.id != undefined )
			custIdObj.value = liarrBufArray[0];
		if( poolIdObj != null && poolIdObj.id != undefined )
			poolIdObj.value = liarrBufArray[1];
		if( poolDescObj != null && poolDescObj.id != undefined )
			poolDescObj.value = liarrBufArray[2];
    }
}

function showCrncyConverter()
{
	popModalWindow("/finbranch/arjspmorph/"+applangcode+"/crncyconv.jsp","crncyconv");
}

function getTranRptCodes(acct,crncy,solId,rptCodeObj)
{
	var sUrl = "../../arjspmorph/"+applangcode+"/get_TranRpt_list.jsp";
	sUrl += "?AcctId="+acct+"&SolId="+solId+"&Crncy="+crncy+"&ReportCode="+escape(rptCodeObj.value)+"&wReturn="+rptCodeObj.id;
    var retVal = popModalWindow(sUrl,"TranRptCodes");
	setObjAndDescValuesForIE(retVal,rptCodeObj,null);
}

function validateDate(date)
{
    if (!(fnIsValidDate(date))) {
      alert(finbranchResource.FAT000188);
	  fnSetFocusForDate(date);
      return false;
        }
        return true;
}

function fshowZoneCode(obj1,obj2,sol)
{
    var znDate = obj1.value;
    var znCode = obj2.value;
	var retVal = popModalWindow("../../arjspmorph/" +applangcode+"/fget_zone_code.jsp?wReturn="+ obj2.id +"&wReturnDate="+ obj1.id + "&znDate="+znDate+"&ZoneCode="+escape(znCode)+"&solId="+sol,"ZoneCodeList");
    if (retVal != null && retVal != undefined )
	{
		//Array for taking the values after splitting the value with "|".
		var liarrBufArray = retVal.split("|");

		obj2.value = liarrBufArray[0];
		obj1.value = liarrBufArray[1];
		//set the date value from hidden field to ui field.
		fnAssignUIDate(obj1);
	}

}


function showVerfyPendList(tableName, func, mode, schmType, listType,inPreceedence, key1Obj, key2Obj, key3Obj)
{
	var sUrl = "";
	var tmpK1Obj = "";
	var tmpK2Obj = "";
	var tmpK3Obj = "";
	var preceedence = 'B';

    if(inPreceedence != "")
        preceedence = inPreceedence;

	if (func == null || func == undefined)
		func = "";

    if(key1Obj != "")
	   tmpK1Obj = key1Obj.id;

    if(key2Obj != "")
       tmpK2Obj = key2Obj.id;

    if(key3Obj != "")
      tmpK3Obj = key3Obj.id;

 sUrl ="../../arjspmorph/"+applangcode+"/get_pend_verify_list.jsp?wReturn1="+tmpK1Obj+"&wReturn2="+tmpK2Obj+"&wReturn3="+tmpK3Obj+"&tableName="+tableName+"&funcCode="+func+"&preceedence="+preceedence+"&mode="+mode+"&schmType="+schmType+"&listType="+listType;

    var retVal = popModalWindow(sUrl,"VerfyPendList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{

			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        key1Obj.value = liarrBufArray[0];
			if(key2Obj != "")
	          key2Obj.value = liarrBufArray[1];
			if(key3Obj != "")
			  key3Obj.value = liarrBufArray[2];
		}
    }
}

function showInwClgSortCodeList(obj,bankCode,branchCode,localClgFlg,inPreceedence,delFlg) {
	var sortCodeObj;
	var sUrl = "";
	var sPreceedenceFlg = inPreceedence;
	if (fnIsNull(localClgFlg)) {
		localClgFlg = ' ';
	}
	var url = "../../arjspmorph/";
	var desc = "NULL";

	if(obj != null) {
		sortCodeObj = obj.id;
	}

	sUrl = url +applangcode+"/get_InwSortCode_list.jsp?wReturn="+sortCodeObj+"&preceedence="+sPreceedenceFlg+"&BankCode="+escape(bankCode)+"&BranchCode="+escape(branchCode)+"&LocalClgFlg="+localClgFlg+"&DelFlg="+delFlg;
	var retVal = popModalWindow(sUrl,"InwSortCode_list");
	setObjAndDescValuesForIE(retVal,obj,null);
}


function showReFlowConfirmDialog(sGrpName)
{
	var sMsg;
	if(sGrpName == "laparm" || sGrpName == "lareprm")
	{
 		sMsg = finbranchResource.FAT000555;
 	}
 	else
 	{
 		sMsg=finbranchResource.FAT000556;
 	}
 var sBtnOne = "Yes";
 var sBtnTwo = "NO";
 var frm = document.forms[0];
 if("Netscape" == browser_name) {
  window.open("../../arjspmorph/"+applangcode+"/lareflowconfirm.jsp?groupName="+sGrpName+"&Msg="+sMsg+"&BtnOne="+sBtnOne+"&BtnTwo="+sBtnTwo, "title","modal=yes, width=600, height=110,top=230,left=270,scrollbars=yes,toolbar=no,menubar=no");
 } else {
  frm.ConfirmChoice.value = window.showModalDialog("../../arjspmorph/"+applangcode+"/lareflowconfirm.jsp?groupName="+sGrpName+"&Msg="+sMsg+"&BtnOne="+sBtnOne+"&BtnTwo="+sBtnTwo,"title","dialogWidth:45;dialogHeight:11;status=no;toolbar=no;menubar=no;resizable=no");
 }
 return frm.ConfirmChoice.value;
}

// Function Added For LANM
function showNoticeSrlList(objSrlNum, sAcctNum, sNoticeType, sPreceedenceFlg)
{

    if(fnIsNull(sAcctNum.value))
    {
    alert(finbranchResource.FAT000200);
    sAcctNum.focus();
    }
    else
    {
    var sUrl = "../";
        sUrl = sUrl +"/lanm/"+ applangcode+"/lanmlist.jsp?&wReturn="+objSrlNum.id+"&AcctNum="+escape(sAcctNum.value)+"&NoticeType="+sNoticeType+"&preceedence="+sPreceedenceFlg;
    var retVal = popModalWindow(sUrl, finbranchResource.FLT001678);
        if (retVal != null && retVal != undefined)
        {
        objSrlNum.value = retVal;
        }
    }
}
function showTradAcctList(crncy1Obj, crncy2Obj,tradAcctObj, inPreceedence)
{

	var sUrl = "";
	var preceedence = 'B';

	if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }


	if (arguments.length < 5)
	{
		sUrl = "../cyc/"+applangcode+"/get_trading_acct_list.jsp?wReturn1="+crncy1Obj.id+"&wReturn2="+crncy2Obj.id+"&wReturn3="+tradAcctObj+"&crncy1="+escape(crncy1Obj.value.toUpperCase())+"&crncy2="+escape(crncy2Obj.value.toUpperCase())+"&preceedence="+preceedence;
	}

    var retVal = popModalWindow(sUrl,"TradAcctList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{

			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        crncy1Obj.value = liarrBufArray[0];
	       	if(crncy2Obj !=null)
	          crncy2Obj.value = liarrBufArray[1];
		 if(tradAcctObj !=null)
		     tradAcctObj = liarrBufArray[2];
		}
    }

}


/*
 It expects fromAcct,fromCrncy,toAcct,toCrncy as string and
 rateCode,rateObj,treaRateObj as form objects which will be
 populated by this function depending on the Ratecode object
 passed to it as input parameter.
*/
function getRateDtls(frame,fromAcct,fromCrncy,toAcct,toCrncy,rateCode,rateObj,treaRateObj)
{
    var precedence = 'F'

    fromAcct = fnIsNull(fromAcct)?" ":fromAcct;
    fromCrncy = fnIsNull(fromCrncy)?" ":fromCrncy;
    toAcct = fnIsNull(toAcct)?" ":toAcct;
    toCrncy = fnIsNull(toCrncy)?" ":toCrncy;

    if ((fromAcct == " ") && (fromCrncy ==" ")) return false;
    if ((toAcct == " ") && (toCrncy == " ")) return false;
    if (fnIsNull(rateCode.value)) return false;

    var rateId = rateCode.id;
    var rate = rateObj.id;
    var treaRateId = '';
    var retval = '';

    if (treaRateObj != undefined && treaRateObj != null && treaRateObj != '') {
          treaRateId = treaRateObj.id;
    }

    var inputs = fromAcct+"|"+ fromCrncy+"|"+ toAcct+"|"+ toCrncy +"|"+ rateCode.value;
    var outputs = rate + "|" + treaRateId;

	var sUrl = "../../arjspmorph/"+applangcode+"/frm_fetch.jsp?fetchId=RATECODE&precedence="+precedence;
    if(inputs != '')
      sUrl = sUrl+"&wReturn="+inputs;

    if(outputs != '')
      sUrl = sUrl+"&wReturnDesc="+outputs;

     var xMax = screen.width, yMax = screen.height;
     var xOffset = (xMax - 120), yOffset = (yMax - 150);
     var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
     params += ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no";

     if("Netscape" == browser_name)
        window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
     else
	 {
         retval = window.showModalDialog(sUrl,document.forms[0],params);
		 if (retval.toLowerCase().indexOf("|") == -1)
		{
			if(retval != "")
				alert("\""+retval+"\"");
			return false;
		}
	}	
    if ("Microsoft Internet Explorer" == browser_name)
    {
        if (retval != null && retval != undefined )
        {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retval.split("|");

            rateObj.value = liarrBufArray[0];
            treaRateObj.value = liarrBufArray[1];
        }
    }
}

function showLafaiVerfyPendList(foracid,func,chrgType,inPreceedence)
{


	var sUrl = "";
	var preceedence = 'B';

    if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }

	if (func == null || func == undefined)
		func = "";

	//if(key1Obj != null)	key1 = key1Obj.id;
	sUrl = "../lafi/"+applangcode+"/get_lawfai_verify_list.jsp?wReturn1="+foracid.id+"&wReturn2="+chrgType.id+"&foracid="+escape(foracid.value)+"&funcCode="+func+"&preceedence="+preceedence;



    var retVal = popModalWindow(sUrl,"VerfyPendList");


	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{

			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        foracid.value = liarrBufArray[0];

	        chrgType.value = liarrBufArray[1];

	        }
	 }
}

function chkSpace(str)
{
	var regExp = /[ ]/ //for space.
	str = fnTrim(str);
	if (regExp.test(str)) {
		alert(finbranchResource.FAT000483);
		return false;
	}
	return true;
}

function showICTMZoneCodeList(objZoneCode, solId, zoneDate, inPreceedence)
{
	var sUrl = "";
	var preceedence = 'F';

	if(fnIsNull(solId))
	{
		alert(finbranchResource.FAT000200);
		document.forms[0].solId.focus();
		return;
	}

	if(inPreceedence.length > 0)
   	{
   	    preceedence = inPreceedence;
   	}

	sUrl = "../../arjspmorph/"+applangcode+"/get_ICZHeaderList.jsp?wReturn="+objZoneCode.id+"&solId="+solId+"&zoneDate="+zoneDate+"&zoneCode="+escape(objZoneCode.value.toUpperCase())+"&preceedence="+preceedence;

    	var retVal = popModalWindow(sUrl,"ICZHeaderList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			var liarrBufArray = retVal.split("|");
			objZoneCode.value = liarrBufArray[0];
			document.forms[0].zoneDate.value = liarrBufArray[1];
			//set the value from hidden field to ui field.
			fnAssignUIDate(document.forms[0].zoneDate);
		}
	}
}

function showEmployerList(objEmployerId, preceedence, objEmployerName)
{
    var sUrl = "";
    sUrl = "../../arjspmorph/"+applangcode+"/employerList.jsp?employerId="+escape(objEmployerId.value)+"&wReturn="+objEmployerId.id+"&preceedence="+preceedence+"&wReturnDesc="+objEmployerName.id;
    var retVal = popModalWindow(sUrl,"Employer List");

    if ("Microsoft Internet Explorer" == browser_name)
    {
        if (retVal != null && retVal != undefined )
        {
            var liarrBufArray = retVal.split("|");
            objEmployerId.value = liarrBufArray[0];
            if(objEmployerName != null && objEmployerName != undefined )
                objEmployerName.value = liarrBufArray[1];
        }
    }
}

function fnValidateSpecialChars(objectField)
{
    var invalidChars = /[^0-9]/; //Anything other than 0-9 is invalid.

    if(invalidChars.test(objectField.value))
	{
		alert(finbranchResource.FAT000485);
		objectField.focus();
		return false;
	}

	return true;
}


function fnShowTCCharges(strURL,objectField)
{
	var retval = openModalWindow(strURL,objectField);
    if (null != retval || objectField.value!="")
    {
        document.forms[0].ChargeFlag.value ="False";
    }
}

function SetVisitFlg(chrgEvtObj,chrgFlg)
{
	if((!fnIsNull(chrgEvtObj.value)))
	{
		chrgFlg.value ="False";
	}
}

function fnCheckNegativeAmt(obj)
{
    var objVal = removeCommas(obj.value);
	if(parseFloat(objVal) < 0.00)
    {
        alert(finbranchResource.FAT000223);
        obj.focus();
        return false;
    }
    return true;
}

function showAcctDtls(acctIdObj)
{
	if (fnIsNull(acctIdObj.value))
	{
		alert(finbranchResource.FAT000200);
		acctIdObj.focus();
		return;
	}
	var sUrl = "../../arjspmorph/"+applangcode+"/acctdtls.jsp?acctId="+acctIdObj.value+"&isAcctDtlsAvbl=N";
	popModalWindow(sUrl,"Acct Details");
}
//This function generates two Date fields one hidden
//and one UI field.
function PRINTDATEFLD(objName,grpNameReqd,linkNum,literalCode,isMandatoryFlg,isReadOnlyFlg,isMnecEnbld,mneLink,onBlurFn,strEvent,tdNotReqd,altDateSearcher,propNotAvailable){

	var strTdNotReqd = "";
	var strAltDateSearcher = "";
	var strPropNotAvailable = "";

	//The earlier function had only 10 parameters. The expanded fn has 13 params.
	if(arguments.length > 10)
	{
		strTdNotReqd = tdNotReqd;
		strAltDateSearcher = altDateSearcher;
		strPropNotAvailable = propNotAvailable;
	}

	if(grpNameReqd != null && grpNameReqd == "Y")
		eleName = sPrntDtGroupName + "." + objName;
	else
	        eleName = objName;

	if (isMandatoryFlg == "N"  &&  strPropNotAvailable != "Y")
	{
		mandatString = eval(sPrntDtGroupName + "Props."+objName+"_MANDATORY");
	}
	else
	{
		mandatString = isMandatoryFlg;
	}

	if (isReadOnlyFlg != null && isReadOnlyFlg == "Y")
		isReadOnly = "ReadOnly";
	else
		isReadOnly = "";

	if(isMnecEnbld != null && isMnecEnbld == "Y"){
		isMnemonicEnbld = bMnemonic;
	}
	else{
		isMnemonicEnbld = "false";
		bMnemonic = "false";
	}

	if(onBlurFn != null && onBlurFn != "")
		strOnBlurFn = ";" + onBlurFn;
	else
		strOnBlurFn = "";

	if(literalCode != null && literalCode != "")
		strLiteralCode = eval("finbranchResource." + literalCode);
	if(strEvent == null)
		strEvent = "";
	if(strPropNotAvailable != "Y")
	{
		strEnabledFlg = eval(sPrntDtGroupName + "Props." + objName + "_ENABLED") ;
	}else
	{
		strEnabledFlg = "enabled";
	}
	with(document){
	  if( literalCode != null && literalCode !="" )
	  {
		 //This creates display date field.
		 write('<td class="ctext">'+ strLiteralCode + ' ');
		 write('&nbsp;<script>setMandatory("' + mandatString + '")</script></td>');
	  }
            	if (strTdNotReqd != "Y") //Default. This value would be passed as Y very rarely when TD printing is not required.
		 {
		 write('<td>');
		 }

		 write('<input ' );
		 if(strPropNotAvailable != "Y")
		 {
			write(eval(sPrntDtGroupName + "Props." + objName + "_ENABLED") + ' ');
		 }
		 write(isReadOnly + ' id ="' + objName +'_ui" type="text" fdt= "uidate" ');
		 write('mnebl='+isMnemonicEnbld+' name="' + eleName + '_ui" size="10" ');
		 write('maxlength="10" class="text" fmnd = "' + mandatString + '" ');
		 write('onBlur="onBlurFormatDate(this);fnAssignDateOnEnter(this)'+ strOnBlurFn + '" ' + strEvent + '>');
		 if(linkNum != null && linkNum != "" &&  strEnabledFlg == "enabled" && isReadOnly == "")
		 {
			if (strAltDateSearcher =="Y") //Alternative date searcher is required.
			{
				write('<a target=_self id ="sLnk'+ linkNum + '" ');
				write('href=javascript:fnOpenDate(document.forms[0].' +objName+'_ui,"' + BODDate + '"');
				write(')>');
				write('<img class="img"  src="../images/calender.gif" width="24" height="20">');
				write('</img></a>');
			}
			else
			{
				write('<a target=_self id ="sLnk'+ linkNum + '" ');
				write('href=javascript:openDate(document.forms[0].' +objName+'_ui,"' + BODDate + '"');
				write(')>');
				write('<img class="img"  src="../images/calender.gif" width="24" height="20">');
				write('</img></a>');
			}
		 }
		 if(bMnemonic == "true" &&  strEnabledFlg == "enabled" && isReadOnly == "")
		 {
			write('<a target=_self id="msLnk' + mneLink + '" ');
			write('href=javascript:showMnemonics(document.forms[0].' + objName+'_ui)>');
			write('<img class="img" src="../Renderer/images/search2.gif" ');
			write('width="24" height="20" ></img> </a>');
		 }

		 if (strTdNotReqd != "Y")
		 {
		 write('</td>'); //Default. Only very specific instances will pass Y as tdNotReqd value.
		 }

		//creation of hidden field
	 write('<input type="hidden" id="'+objName+'" ');
	 write('fmnd = "' + mandatString + '" ');
	 write('fdt="fdate" mneb1='+isMnemonicEnbld+' name="' + eleName + '">');
    }
}
/*This function converts any date format to Standard date
  field format (i.e) "DDMMYYYY".
*/
function fnConvertToStdDate(UIDateString)
{

		var day = "";
		var month = "";
		var year="";
		var newdatestr = UIDateString;

		if(UIDateString=="")
		   return UIDateString;

		// if mnemonic , copy as it is
		if(isValidDateMneumonic(UIDateString))
		{
		   newdatestr = UIDateString;
		   return newdatestr;

		}


		if (displayDateFormat == "01")

		{
		    if(UIDateString.indexOf("/") != -1)
				var a_strDate = UIDateString.split("/");
			if(UIDateString.indexOf("-") != -1)
				var a_strDate = UIDateString.split("-");
			if(UIDateString.indexOf(".") != -1)
			var a_strDate = UIDateString.split(".");
			if(a_strDate != null)
				newdatestr = a_strDate[1] +"-"+a_strDate[0]+"-"+a_strDate[2];
			return newdatestr;

		}
		return newdatestr;

}

function fnConvertToUIDate(stdDateString)
/*Convert Date function is needed to switch between MMDDYYYY and DDMMYYYY
This would stand in use at display only sections (viz. explodes, result pages where
there is no textbox object with datatype of fdate.
The function can be enhanced with more error handling*/

{
	var day = "";
	var month = "";
	var year="";

	var displayStr = stdDateString; 	//This is default return value

	if (displayStr == "")
		return displayStr;

	// if mnemonic , copy as it is
	if(isValidDateMneumonic(displayStr))
	   return displayStr;


	//check for the delimeter and seperate date, month and year.
	if((displayDateFormat == "01"))
	{
		if(displayStr.indexOf("/") != -1)
			var	a_strDate = displayStr.split("/");
		if(displayStr.indexOf("-") != -1)
			var	a_strDate = displayStr.split("-");
		if(displayStr.indexOf(".") != -1)
			var	a_strDate = displayStr.split(".");
		displayStr = a_strDate[1]+"-"+a_strDate[0]+"-"+a_strDate[2];
		return displayStr;
	}
	return displayStr;

}
/* This function is responsible for converting format of given
   UI date field value to standard date format and assigns the
   value to corresponding hidden field.
*/
function fnAssignDateOnEnter(objElement){
	  var objName;
	  objForm = document.forms[0];
	  objName = String(objElement.name);
	  objName = objName.substring(0,(objName.length -3));
	  // Convert and assign the value to hidden field
	  element = document.getElementsByName(objName);
	if (objElement.fmult == "Y")
	{
	   var i = objElement.recNum;
       if(element[i] == null)
		return;
	   else
		element[i].value = fnConvertToStdDate(objElement.value);
	}
	else
	{
	  if(element[0] == null)
		return;
	  else
		element[0].value = fnConvertToStdDate(objElement.value);
	}
}

/*This function searches for date fields in the given form and
  assign values from hidden field to UI field after converting
  the format to UI format.
*/
function fnAssignDateOnLoad(objForm){

   i = 0;
   var itemName;
   //Enumerate the form fields.
   while(objForm.elements[i] != null) {

      //Deriving the corresponding ui field name.
      itemName = objForm.elements[i].name + "_ui";
	  element = document.getElementsByName(itemName);
      //Check for date fields.
      if (objForm.elements[i] != null && objForm.elements[i].getAttribute("fdt") == "fdate" && objForm.elements[i] != ""){
      //Assign the value to UI field.
		if (objForm.elements[i].getAttribute("fmult") == "Y")
		{
			var j = objForm.elements[i].getAttribute("recNum");
			element[j].value = fnConvertToUIDate(objForm.elements[i].value);
		}
		else
		{
      		element[0].value = fnConvertToUIDate(objForm.elements[i].value);
		}
      }
      i++;
   }

}

/*This function is responsible for setting the focus to
  corresponding UI date field for the given hidden date
  field passed as argument.
*/
function fnSetFocusForDate(objDate){

  var objName = objDate.name;
  element = document.getElementsByName(objName + "_ui");
  if(element[0] == null){
	objDate.focus();
    return;
  }
  //set the focus to corresponding ui field
  element[0].focus();

}
/*This function is responsible for assigning value to
  corresponding UI date field for the given hidden date field
  after conversion of date format.
*/
function fnAssignUIDate(objDate){

 itemName = objDate.name + "_ui";
 element = document.getElementsByName(itemName);
 if(element[0] == null)
   return;
 element[0].value = fnConvertToUIDate(objDate.value);

}
/*This function is responsible for enabling or disabling
  of corresponding UI date field for given hidden date field.
*/
function fnEnableUIField(obj,status){


 itemName = obj.name + "_ui";
 element = document.getElementsByName(itemName);

 if(element[0] == null)
   return;

 if(status != null && status != ""){
	if(status == "Y"){
		element[0].disabled = false;
	}
	else{
		element[0].disabled = true;
	}
 }
 fnAssignUIDate(obj);
}
/* This function is used to set the property value
   to UI field from corresponding hidden field
   for given hidden object, property and value.
*/
function fnSetPropertyValue(obj,property,value){

   var itemName = obj.name + "_ui";
   element = document.getElementsByName(itemName);

   if (obj.fmult == "Y")
   {
		var i = obj.recNum;
		if(element[i].name == undefined){
			element[i] = obj;
		}
		if(property != null && property !=""){
			if ( (typeof value) == "string" )
			{
    			eval("document.forms[0]." + element[i].id + "["+i+"]."  + property + "='"  + value + "'");
			}
			else
			{
				eval("document.forms[0]." + element[i].id + "["+i+"]." + property + "="  + value);
			}
		}
	}
	else
	{
			if(element[0].name == undefined){
			element[0] = obj;
			}
			if(property != null && property !=""){
				if ( (typeof value) == "string" )
				{
    				eval("document.forms[0]." + element[0].id + "." + property + "='"  + value + "'");
				}
				else
				{
					eval("document.forms[0]." + element[0].id + "." + property + "="  + value);
				}
			}
	}
}
/* This function is used to replace a label field with
   a ui label field and a hidden field for the purpose
   of date format conversion.
*/
function PRINTDATELABEL(objName,grpNameReqd,literalCode,stdDateFormatValue,strEvent){

    if(grpNameReqd != null && grpNameReqd == "Y")
        eleName = sPrntDtGroupName + "." + objName;
    else
        eleName = objName;
    if(literalCode != null && literalCode != "")
        strLiteralCode = eval("finbranchResource." + literalCode);
    if(strEvent == null)
        strEvent = "";
    with(document){
     //If literalcode is null or blank hide the literal value.
     if( literalCode != null && literalCode !="" )
        write('<td class="ctext" >&nbsp;'+ strLiteralCode + ' </td>');
     //creation of ui label field.
     write('<td><input class="label" ');
     write('name="'+ eleName + '_ui" id="'+ objName +'_ui" ');
     write('size=10 maxlength=10 ');
     write('fdt="uidate" disabled ' + strEvent + ' ></td>');
     //creation of hidden field.
     write('<input type="hidden" id="'+objName+'" ');
     write('fdt="fdate" name="' + eleName + '" ');
     write('value="' + stdDateFormatValue + '" >');
    }
}
/* This function is used to clear both hidden date field
   and ui date field values for given hidden field.
*/
function fnClearDateFields(dateObj){

    //clear the hidden field value
    dateObj.value = "";
    fnAssignUIDate(dateObj);    //Assign hidden field value to ui field.

}
/* This function is used to get property value of UI
   date field for given hidden date field object
*/
function fnGetPropertyValue(obj,property){

   itemName = obj.name + "_ui";
   element = document.getElementsByName(itemName);

   // if ui field does not exists, set value to original field.
   if( element[0].name == undefined )
		element[0] = obj;

   if( property != null && property != ""){
		return eval("document.forms[0]." + String(element[0].id) + "." + property);
   }

}
/* This function is used to set values for attribute of
   ui field if exists else set the value to original field.
*/
function fnSetAttributeValue(obj,attribName,attribVal){

   itemName = obj.name + "_ui";
   element = document.getElementsByName(itemName);

    // if ui field does not exists, set value to original field.
   if( element[0].name == undefined )
        element[0] = obj;

   if(attribName != null && attribName != "" && attribVal != null){
		eval("document.forms[0]." + String(element[0].id) + ".setAttribute(\"" + attribName + "\",\"" + attribVal + "\")");
		}
}
/* This function is used to get values for attribute of
   ui field if exists else set the value to original field.
*/
function fnGetAttributeValue(obj,attribName){

   itemName = obj.name + "_ui";
   element = document.getElementsByName(itemName);

    // if ui field does not exists, set value to original field.
   if( element[0].name == undefined )
        element[0] = obj;

   if(attribName != null && attribName != "" && attribVal != null)
        return eval("document.forms[0]." + String(element[0].id) + ".getAttribute(\"" + attribName + "\")");
}

//Functions to print Date fields in Multi Rec Modifier.
function PRINTDATEMRC(objName,grpNameReqd,recNum,linkNum,literalCode,stdDateFormatValue, isMandatoryFlg,isReadOnlyFlg,isMnecEnbld,mneLink,onBlurFn,strEvent,tdNotReqd,altDateSearcher,propNotAvailable){

	var strTdNotReqd = "";
	var strAltDateSearcher = "";
	var strPropNotAvailable = "";

	//The earlier MRC function had only 12 parameters. The expanded fn has 15 params.
	if(arguments.length > 12)
	{
		strTdNotReqd = tdNotReqd;
		strAltDateSearcher = altDateSearcher;
		strPropNotAvailable = propNotAvailable;
	}

	if(grpNameReqd != null && grpNameReqd == "Y")
		eleName = sPrntDtGroupName + "." + objName;
	else
        	eleName = objName;

	if (isMandatoryFlg == "N" && strPropNotAvailable != "Y")
	{
		mandatString = eval(sPrntDtGroupName + "Props."+objName+"_MANDATORY");
	}
	else
	{
		mandatString = isMandatoryFlg;
	}

	if (isReadOnlyFlg != null && isReadOnlyFlg == "Y")
		isReadOnly = "ReadOnly";
	else
		isReadOnly = "";

	if(isMnecEnbld != null && isMnecEnbld == "Y"){
		isMnemonicEnbld = bMnemonic;
	}
	else{
		isMnemonicEnbld = "false";
		bMnemonic = "false";
	}

	if(onBlurFn != null && onBlurFn != "")
		strOnBlurFn = ";" + onBlurFn;
	else
		strOnBlurFn = "";

	if(literalCode != null && literalCode != "")
		strLiteralCode = eval("finbranchResource." + literalCode);
	if(strEvent == null)
		strEvent = "";
	if(strPropNotAvailable != "Y")
	{
		strEnabledFlg = eval(sPrntDtGroupName + "Props." + objName + "_ENABLED") ;
	}else
	{
		strEnabledFlg = "enabled";
	}
	with(document){
	  if( literalCode != null && literalCode !="" )
	  {
		 //This creates display date field.
		 write('<td class="ctext">'+ strLiteralCode + ' ');
		 write('&nbsp;<script>setMandatory("' + mandatString + '")</script></td>');
	  }

            	 if (strTdNotReqd != "Y") //Default. This value would be passed as Y very rarely when TD printing is not required.
		 {
		 write('<td>');
		 }

		 write('<input ' );
		 if(strPropNotAvailable != "Y")
		 {
			write(eval(sPrntDtGroupName + "Props." + objName + "_ENABLED") + ' ');
		 }
		 write(isReadOnly + ' id ="' + objName +'_ui" type="text" fdt= "uidate" fmult= "Y" recNum="'+recNum+'" ');
		 write('mnebl='+isMnemonicEnbld+' name="' + eleName + '_ui" size="10" ');
		 write('maxlength="10" class="text" fmnd = "' + mandatString + '" ');
		 write('onBlur="onBlurFormatDate(this);fnAssignDateOnEnter(this)'+ strOnBlurFn + '" ' + strEvent + '>');
		 if(linkNum != null && linkNum != "" &&  strEnabledFlg == "enabled" && isReadOnly == "")
		 {
			if (strAltDateSearcher =="Y") //Alternative date searcher is required.
			{
				write('<a target=_self id ="sLnk'+ linkNum + '" ');
				write('href=javascript:fnOpenDate(document.forms[0].' +objName+'_ui['+recNum+'],"' + BODDate + '"');
				write(')>');
				write('<img class="img"  src="../images/calender.gif" width="24" height="20">');
				write('</img></a>');
			}
			else
			{
				write('<a target=_self id ="sLnk'+ linkNum + '" ');
				write('href=javascript:openDate(document.forms[0].' +objName+'_ui['+recNum+'],"' + BODDate + '"');
				write(')>');
				write('<img class="img"  src="../images/calender.gif" width="24" height="20">');
				write('</img></a>');
			}
		 }
		 if(bMnemonic == "true" &&  strEnabledFlg == "enabled" && isReadOnly == "")
		 {
			write('<a target=_self id="msLnk' + mneLink + '" ');
			write('href=javascript:showMnemonics(document.forms[0].' + objName+'_ui['+recNum+'])>');
			write('<img class="img" src="../Renderer/images/search2.gif" ');
			write('width="24" height="20" ></img> </a>');
		 }

		 if (strTdNotReqd != "Y")
		 {
		 write('</td>');
		 }

		//creation of hidden field
	 write('<input type="hidden" id="'+ objName+'" ');
	 write('fmnd = "' + mandatString + '" ');
	 write('recNum = "' + recNum + '" ');
	 write('fdt="fdate" fmult = "Y" mneb1='+isMnemonicEnbld+' name="' + eleName + '" ');
	 write('value="' + stdDateFormatValue + '" >');
    }
}
function dateDiff(dateStr1, dateStr2)
{
    var d1 = new Date(dateStr1.substring(6,10), parseInt(dateStr1.substring(3,5) - 1,10), dateStr1.substring(0,2));
    var d2 = new Date(dateStr2.substring(6,10), parseInt(dateStr2.substring(3,5) - 1,10), dateStr2.substring(0,2));
    return (d1-d2)/86400000;
}


function depPeriodDiff(date1, date2, objnmths, objndays)
{


    var maxdays1 = 0;
    var maxdays2 = 0;
    var prevmth = 0;
    var prevyear = 0;
    var temp = 0;

    var nmths = 0;
    var ndays = 0;

    nmths = 12 * (date2.substring(6,10) - date1.substring(6,10)) + (date2.substring(3,5) - date1.substring(3,5));


    /* If both dates are month ends, do not find the days' difference */
    maxdays1 = daysInMonth(date1.substring(3,5),date1.substring(6,10));
    maxdays2 = daysInMonth(date2.substring(3,5),date2.substring(6,10));

       if ((date1.substring(0,2) != maxdays1) || (date2.substring(0,2) != maxdays2) || (date1.substring(0,2) < date2.substring(0,2)))
       {

         if (date2.substring(0,2) >= date1.substring(0,2))
             ndays = date2.substring(0,2) - date1.substring(0,2);

          else
          {
                /* take carry from the months position */
                (nmths)--;

                   if (date2.substring(3,5) == 1) {
                        prevmth = 12;
                        prevyear = date2.substring(6,10) - 1;
                    }
                    else {
                        prevmth = date2.substring(3,5) - 1;
                        prevyear = date2.substring(6,10);
                    }


                     if (fnIsLeapYear(prevyear))
                          temp =  daysInMonth(prevmth,prevyear);
                     else
                          temp = parseInt(daysInMonth(prevmth,prevyear),10) + parseInt(date2.substring(0,2),10);


          if (temp < date1.substring(0,2))
          {
             /* one more carry from the months position required */
             (nmths)--;
             date2.substring(3,5)--;

             if (date2.substring(4,2) == 1) {
                prevmth = 12;
                prevyear = date2.substring(6,10) - 1;
             }
             else {
                prevmth = date2.substring(3,5) - 1;
                prevyear = date2.substring(6,10);
             }


             if (fnIsLeapYear(prevyear))
                 ndays = temp + daysInMonth(prevmth,prevyear);
             else

                ndays = daysInMonth(prevmth,prevyear) - date1.substring(0,2);
           }
           else
           {
               ndays = temp - date1.substring(0,2);
           }
       }

    } else
    {
       ndays = 0;
    }

    objnmths.value = nmths;
    objndays.value = ndays;
    return ;
}



function daysInMonth(Month, Year)
{
  var Days;
  var arrDays = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
  if ((Month==2) && (Year % 4 == 0 && (Year % 100 != 0 || Year % 400 == 0))) {
        arrDays[1] = 29;
    }
    return arrDays[Month-1];
}

//Function to show the pref_code list
function showPrefCode(obj1,inPreceedence,obj2)
{
	var prefCode = obj1.value;
	var url = "";
	var preceedence = 'B';

	if(arguments.length > 2)
    {
        preceedence = inPreceedence;
    }
    if (arguments.length < 3)
	{
		url = "../../arjspmorph/"+applangcode+"/get_pref_code.jsp?wReturn="+ obj1.id +"&wReturnDesc=NULL&prefCode="+escape(prefCode)+"&preceedence="+preceedence;
	}else
	{
	    url = "../../arjspmorph/"+applangcode+"/get_pref_code.jsp?wReturn="+ obj1.id +"&wReturnDesc="+ obj2.id +"&prefCode="+escape(prefCode)+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(url,"PrefCodeList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        obj1.value = liarrBufArray[0];
			if(obj2 != null) obj2.value = liarrBufArray[1];
		}
    }
}

function showExchgRtPrefCodeList(prefCodeObj,versionNoObj,ctrlOrMorph,inPreceedence)
{
	var sUrl = ( !fnIsNull(ctrlOrMorph) && !(ctrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";

	if(prefCodeObj != null && prefCodeObj.id != undefined)
	{
		sUrl += applangcode+"/xchg_rate_prefcodelist.jsp?prefCode="+escape(prefCodeObj.value)+"&preceedence="+inPreceedence+"&rtnVal1="+prefCodeObj.id;
	}

	if(versionNoObj != null && versionNoObj.id != undefined && versionNoObj.readOnly == false )
	{
		sUrl += "&versionNo="+escape(versionNoObj.value)+"&rtnVal2="+versionNoObj.id;
	}
	var retVal = popModalWindow(sUrl,finbranchResource.FLT003645);
	if ("Microsoft Internet Explorer" == browser_name)
	{
    	if(retVal != null && retVal != undefined)
		{
			var liarrBufArray = retVal.split("|");
			prefCodeObj.value = liarrBufArray[0];
			if(versionNoObj.readOnly == false)
				versionNoObj.value = liarrBufArray[1];
		}
    }
}
/*
	This function is called on Blur of Date field to format the date in user defined format.
	The function is responsibel for auto populating the date field with month and year as specified for BOD Date.
	If user enters two digits only e.g. 25, it will be considered as Date. Month and Year will be populated automatically as month and year of BOD Date.
	If user enters four digits e.g. 25/12, date will be considered as entered in specified user defined format(mm/dd or dd/mm).
	If all the digits are entered, date will be considered as entered in correct user defined format.
*/
function onBlurFormatDate(cStr)
{
	var HYPHEN = "-";
	var SLASH  = "/";
	var DOT    = ".";
	var sEnteredDate = cStr.value;
	var sRawDate = "";
	var sFmtdDate = "";
	var mnebl = cStr.getAttribute("mnebl");
	var dayValue   = BODDate.substring(0,2);
	var monthValue = BODDate.substring(3,5);
	var yearValue  = BODDate.substring(6,10);
	var firstSet = "";
	var secondSet = "";
	var thirdSet = "";
	var countFlg = 0;

   	if((null != mnebl )&& (mnebl) && ("$" == sEnteredDate.substring(0,1)) )
   	{
   		return;
   	}

    //This condition is for DDMMYYYY entered value without separators
	if (!fnIsNull(sEnteredDate))
	{
		if ((!isNaN(sEnteredDate)) && (sEnteredDate.length==8))
		{
			if (displayDateFormat == "00" || displayDateFormat == "01" )
			{
				sFmtdDate = sEnteredDate.substring(0,2)+HYPHEN+sEnteredDate.substring(2,4)+HYPHEN+sEnteredDate.substring(4,8);
				cStr.value = sFmtdDate;
				return;
			}
		}
		for(i=0; i<sEnteredDate.length; i++)
		{
			if((sEnteredDate.charAt(i) != HYPHEN)&&(sEnteredDate.charAt(i) != SLASH)&&(sEnteredDate.charAt(i) != DOT))
				sRawDate += sEnteredDate.charAt(i);

				if((sEnteredDate.charAt(i) == HYPHEN)||(sEnteredDate.charAt(i) == SLASH)||(sEnteredDate.charAt(i) == DOT))
				{
					countFlg++;

					if (parseInt(countFlg,10) == 1)
							firstSet = sRawDate;
					if (parseInt(countFlg,10) == 2)
							secondSet = sRawDate;

					sRawDate = "";
				}
		}
		if (parseInt(countFlg,10) == 0)
			firstSet = sRawDate;
   		else if (parseInt(countFlg,10) == 1)
	 		secondSet =  sRawDate;
		else
			thirdSet = sRawDate; //Whatever remains after last separator goes to third var.

		if (fnIsNull(secondSet))
			secondSet = monthValue;

		if (fnIsNull(thirdSet) )
		{
			if (displayDateFormat == "01")
			{
				temp = firstSet;
				firstSet = secondSet;
				secondSet = temp;
			}
			thirdSet = yearValue;
		}
		if (displayDateFormat == "00" || displayDateFormat == "01" )
		{
			if (isNaN(firstSet) || isNaN(secondSet) || isNaN(thirdSet))
			{
				return;
			}
			if (firstSet.length == 1)
					firstSet = "0" + firstSet;
			if (firstSet.length > 2)
					return;
			if (secondSet.length == 1)
					secondSet = "0" + secondSet;
			if (secondSet.length >2)
					return;
			if (thirdSet.length == 1)
					return;
			if (thirdSet.length == 2)
			{
				hYrLimit = parseInt(yearValue,10)+30;
				intYear = parseInt(thirdSet,10);
				if (intYear>=(hYrLimit%100))
					strYear=(hYrLimit-(hYrLimit%100))-100;
				else
					strYear=hYrLimit-(hYrLimit%100);
				thirdSet = strYear+intYear;
			}
			if (thirdSet.length == 3)
					return;
			if (thirdSet.length > 4)
					return;
			sFmtdDate = firstSet + HYPHEN + secondSet + HYPHEN + thirdSet;
		}
		cStr.value = sFmtdDate;
	}
}
function getSolTranStatList(objSolId,inPreceedence,objSolDesc)
{
	var preceedence = inPreceedence == null ? 'B' : inPreceedence;
	var url = "../../arjspmorph/";

    if(arguments.length > 2)
		sUrl = "../../arjspmorph/"+applangcode+"/get_soltranstat_list.jsp?wReturn="+objSolId.id+"&enteredSolId="+escape(objSolId.value)+"&wReturnDesc=objSolDesc.id&preceedence="+preceedence;
	else
		sUrl = "../../arjspmorph/"+applangcode+"/get_soltranstat_list.jsp?wReturn="+objSolId.id+"&enteredSolId="+escape(objSolId.value)+"&preceedence="+preceedence;

	var retVal = popModalWindow(sUrl,"SolTranStatList");
	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			var arrRetVal = retVal.split("|");
	        objSolId.value = arrRetVal[0];
			if(objSolDesc != null) objSolDesc.value = arrRetVal[1];
		}
    }
}

function getGspmSchemeCodeList(objSchmCode,schmType,delFlg,schmCat,inPreceedence)
{
	var preceedence = inPreceedence == null ? 'B' : inPreceedence;
	var sUrl = "../../arjspmorph/"+applangcode+"/tagspmschcodelist.jsp?wReturn="+objSchmCode.id+"&schmCode="+objSchmCode.value+"&schmType="+schmType+"&schmCat="+schmCat+"&delFlg="+delFlg+"&preceedence="+preceedence;

	var retVal = popModalWindow(sUrl,"TaGspmSchCodeList");
	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
	        objSchmCode.value = retVal;
		}
    }
}

function getDiscreteAdvanceTypeList(objDiscAdvnType, inPreceedence)
{
	var preceedence = inPreceedence == null ? 'B' : inPreceedence;
	var sUrl = "../../arjspmorph/"+applangcode+"/dartypelist.jsp?wReturn="+objDiscAdvnType.id+"&preceedence="+preceedence;

	var retVal = popModalWindow(sUrl,"DarTypeList");
	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
	        objDiscAdvnType.value = retVal;
		}
    }
}
/*

    This method will print the maximum amount value for the field on which
    it is invoked by pressing CTRL+X

    fdt = "amount" attribute needs to be defined for the field
    AmountCrncyMap  -   Object that needs to be defined in the
                        group link file. It will have name value pairs
                        for amount field ids and their currencies.

                        Eg.
                        var AmountCrncyMap = {
                            maxSlabAmount : "crncy|N"
                        }

                        where   maxSlabAmount   =   amount field id
                                crncy|N         =   crncy can be form object id or javascript variable name for
                                                    getting currency value.
                                                    if it is form object give Y, else N

    Included by Vasudevan G on November 21, 2003

*/
function writeMaximumAmount(amtObj) {
    if (this.AmountCrncyMap != undefined) {
        var temp = AmountCrncyMap[amtObj.id];
        if (temp != undefined) {
            var pipeIndex = temp.indexOf("|");
            var crncy = temp.substring(0,pipeIndex);
            var isObj = temp.substring(pipeIndex+1);
            if (isObj == "Y") {
                crncy = eval("document.forms[0]."+crncy+".value");
            } else {
                crncy = eval("this."+crncy);
            }
            /*  For the obtained crncy, get the precision value */
            var prec = getPrec(crncy);
            var actualAmt = MAX_AMOUNT.substring(0,(MAX_AMOUNT.length-prec)) + "." + MAX_AMOUNT.substring((MAX_AMOUNT.length-prec));
            amtObj.value = actualAmt;
        }
    }
}

function getBacidAcctList(bacid,ctrlOrMorph)
{
    var sUrl = (ctrlOrMorph == 'morph') ? "../" : "../../arjspmorph/";

    sUrl += applangcode + "/get_bacid_accts.jsp?bacid="+bacid+"&precedence=F";

    popModalWindow(sUrl,"bacidacctlist");
}


/**
	To display SWIFT Message Type 110 screen
*/
function showSwiftMT110Page(swiftMsg)
{
	var sUrl = "";
	var preceedence = 'F';

	sUrl = "../../arjspmorph/"+applangcode+"/viewswiftmt110.jsp?wSwiftMsg="+swiftMsg+"&preceedence="+preceedence;
	if("Netscape" == browser_name)
	{
		window.open(sUrl,"viewswiftmt110","width=500,height=300,modal=yes,left=50,top=50,scrollbars=yes,toolbar=no,menubar=0");
		return;
	}
	else
	{
		var retval = window.showModalDialog(sUrl,"viewswiftmt110","dialogWidth:60;dialogHeight:40;status=no;toolbar=no;menubar=no;resizable=yes");
		return(retval);
	}
}

function showSwiftMT111Page(swiftMsg)
{
	var sUrl = "";
	var preceedence = 'F';

	sUrl = "../../arjspmorph/"+applangcode+"/viewswiftmt111.jsp?wSwiftMsg="+swiftMsg+"&preceedence="+preceedence;
	if("Netscape" == browser_name)
	{
		window.open(sUrl,"viewswiftmt111","width=500,height=450,modal=yes,left=250,top=150,scrollbars=yes,toolbar=no,menubar=0");
		return;
	}
	else
	{
		var retval = window.showModalDialog(sUrl,"viewswiftmt111","dialogWidth:40;dialogHeight:30;status=no;toolbar=no;menubar=no;resizable=No");
		return(retval);
	}
}

function showSwiftMT112Page(swiftMsg)
{
	var sUrl = "";
	var preceedence = 'F';

	sUrl = "../../arjspmorph/"+applangcode+"/viewswiftmt112.jsp?wSwiftMsg="+swiftMsg+"&preceedence="+preceedence;
	if("Netscape" == browser_name)
	{
		window.open(sUrl,"viewswiftmt112","width=500,height=450,modal=yes,left=250,top=150,scrollbars=yes,toolbar=no,menubar=0");
		return;
	}
	else
	{
		var retval = window.showModalDialog(sUrl,"viewswiftmt112","dialogWidth:40;dialogHeight:30;status=no;toolbar=no;menubar=no;resizable=No");
		return(retval);
	}
}

function showSwiftMT192Page(swiftMsg)
{
	var sUrl = "";
	var preceedence = 'F';

	sUrl = "../../arjspmorph/"+applangcode+"/viewswiftmt192.jsp?wSwiftMsg="+swiftMsg+"&preceedence="+preceedence;
	if("Netscape" == browser_name)
	{
		window.open(sUrl,"viewswiftmt192","width=500,height=450,modal=yes,left=250,top=150,scrollbars=yes,toolbar=no,menubar=0");
		return;
	}
	else
	{
		var retval = window.showModalDialog(sUrl,"viewswiftmt192","dialogWidth:40;dialogHeight:30;status=no;toolbar=no;menubar=no;resizable=No");
		return(retval);
	}
}

function showSwiftMT196Page(swiftMsg)
{
	var sUrl = "";
	var preceedence = 'F';

	sUrl = "../../arjspmorph/"+applangcode+"/viewswiftmt196.jsp?wSwiftMsg="+swiftMsg+"&preceedence="+preceedence;
	if("Netscape" == browser_name)
	{
		window.open(sUrl,"viewswiftmt196","width=500,height=450,modal=yes,left=250,top=150,scrollbars=yes,toolbar=no,menubar=0");
		return;
	}
	else
	{
		var retval = window.showModalDialog(sUrl,"viewswiftmt196","dialogWidth:40;dialogHeight:30;status=no;toolbar=no;menubar=no;resizable=No");
		return(retval);
	}
}

function showVersionList(objIntTblCode, refRecType, objVersion, objCrncy,objBaseInd, sPreceedenceFlg)
{

    var sUrl = "";
    var url = "../../arjspmorph/";

    if(sPreceedenceFlg == "")
    sPreceedenceFlg = "F";

    sUrl = url +applangcode+"/get_version_list.jsp?wReturnCode="+objIntTblCode.id+"&wReturnInd="+objBaseInd.id+"&wReturnCrncy="+objCrncy.id+"&wReturnVer="+objVersion.id;
    sUrl = sUrl+"&intTblCode="+objIntTblCode.value+"&refRecType="+refRecType+"&baseInd="+objBaseInd.value+"&crncyCode="+objCrncy.value+"&intVersion="+objVersion.value+"&preceedence="+sPreceedenceFlg;

    var retVal = popModalWindow(sUrl,"VersionList");

    if ("Microsoft Internet Explorer" == browser_name) {
        if (retVal != null && retVal != undefined ) {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");
            objIntTblCode.value = liarrBufArray[0];
            objCrncy.value = liarrBufArray[1];
            objVersion.value = liarrBufArray[2];
            objBaseInd.value = liarrBufArray[3];
        }
    }
}

//Sets the custom data to the hidden field
function setCustomFieldValue()
{
	var sFieldValues = "";
	var strValue = document.forms[0].customData.value;
	var pagename = document.forms[0].pagename.value;
	if(strValue.indexOf(pagename) != -1)
	{
		strFirst = strValue.substring(0,(strValue.indexOf(pagename)));
		intlen = strFirst.length - 1;
		strFirst = strFirst.substring(0,intlen);
		strTemp = strValue.substring((strValue.indexOf(pagename)+1),strValue.length);
		if(strTemp.indexOf("~") != -1)
		strLast = strTemp.substring(strTemp.indexOf("~"),strTemp.length);
		else
		strLast = "";

		strValue = strFirst + strLast;

	}

	for(i=0;i<arguments.length;i++)
	{
		if(eval("document.forms[0]."+arguments[i]) != undefined)
		{
			var fieldObj = eval("document.forms[0]."+arguments[i]);
			var fieldVal = fieldObj.value;

			if(i == 0)
				sFieldValues= sFieldValues + fieldVal + "|";
			else
				sFieldValues= sFieldValues + fieldVal + "|";
		}
	}
	if(sFieldValues.length > 0)
	{
		strValue= strValue+"~"+pagename+"|";
		strValue = strValue+sFieldValues;
	}
	document.forms[0].customData.value = strValue ;
}

 //Gets the custom data to the hidden field and sets the custom value to fields.
 function getCustomFieldValue()
 {
     var strValue = document.forms[0].customData.value;
     var pagename = document.forms[0].pagename.value;
     if(strValue.indexOf(pagename) != -1)
     {
         strFirst = strValue.substring(0,(strValue.indexOf(pagename)));
         intlen = strFirst.length - pagename.length;
         strFirst = strFirst.substring(0,intlen);
         strTemp = strValue.substring((strValue.indexOf(pagename)+(pagename.length+1)),strValue.length);
         if(strTemp.indexOf("~") != -1)
         strLast = strTemp.substring(0,strTemp.indexOf("~"));
         else
         strLast = strTemp;

         strValue = strLast;
     }
     else
     {
         strValue = "";
     }

     for(i=0;i<arguments.length;i++)
     {
         if(eval("document.forms[0]."+arguments[i]) != undefined)
         {
             var fieldObj = eval("document.forms[0]."+arguments[i]);
             if(strValue.indexOf("|") != -1)
             {
                 fieldObj.value = strValue.substring(0,strValue.indexOf("|"));
                 strValue = strValue.substring((strValue.indexOf("|")+1),strValue.length);
             }
             else
             {
                 fieldObj.value = strValue;
                 strValue = "";
             }
         }
     }
}

function customDataProcess(arr,arrCol)
{
    outValue = "";
    outName = "";
    k = 1;
    for(i=0;i<arr.length;i++)
    {
        for(j=0;j<arrCol.length;j++)
        {
            obj = arr[i];
            var expr = "obj."+ arrCol[j];
            val = eval(expr);
            outValue  = outValue+val+"|";
            outName = outName+arrCol[j]+"_"+k+"|";
        }
        k++;
    }
    outName = outName.substring(0,outName.length-1);
    outValue = outValue.substring(0,outValue.length-1);
    document.forms[0].custNames.value = outName;
    document.forms[0].custValues.value = outValue;
}

function showLoanDisbVerifyPendList(acctNum,ctrlOrMorph,inPreceedence,acctCrncy,acctSol,acctName)
{
    var sUrl = ( !fnIsNull(ctrlOrMorph) && !(ctrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
    sUrl += applangcode+"/ladisb_verify_list.jsp?acctNum="+acctNum.value+"&preceedence="+inPreceedence;

    if(acctNum != null && acctNum.id != undefined)
    {
        sUrl += "&rtnVal1="+acctNum.id;
    }

    if(acctCrncy != null && acctCrncy.id != undefined)
    {
        sUrl += "&rtnVal2="+acctCrncy.id;
    }

    if(acctSol != null && acctSol.id != undefined)
    {
        sUrl += "&rtnVal3="+acctSol.id;
    }

    if(acctName != null && acctName.id != undefined)
    {
        sUrl += "&rtnVal4="+acctName.id;
    }

    var retVal = popModalWindow(sUrl,finbranchResource.FLT004039);
    if ("Microsoft Internet Explorer" == browser_name)
    {
        if(retVal != null && retVal != undefined)
        {
            var liarrBufArray = retVal.split("|");
            acctNum.value = liarrBufArray[0];
            acctCrncy.value = liarrBufArray[1];
            acctSol.value = liarrBufArray[2];
            acctName.value = liarrBufArray[3];
        }
    }
}

function showMandateIdList(objPaySysId,objAcctId,objMandateId,sDelFlg,cEntityCreFlg, sCtrlOrMorph, sPreceedenceFlg, acctObj, acctCrncyObj, acctSolIdObj, acctNameObj, objPaySysIdDesc,linkFieldName)
{

    var sUrl = ( !fnIsNull(sCtrlOrMorph) && !(sCtrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
    var sDelFlg = fnIsNull(sDelFlg) ? " " : sDelFlg;
    var cEntityCreFlg = fnIsNull(cEntityCreFlg) ? " " : cEntityCreFlg;
    var sPaySysId = objPaySysId.value;
    var sPaySysId = fnIsNull(sPaySysId) ? " " : sPaySysId;

    if (!linkFieldName==undefined)
    {
    var sLinkFieldName = linkFieldName.value;
    var sLinkFieldName = fnIsNull(sLinkFieldName) ? " " : sLinkFieldName;
    }

    if (linkFieldName==undefined)    
    {
    var sUrl = "../../arjspmorph/"+ applangcode+"/getMandateList.jsp?wReturn="+objPaySysId.id+"&wReturnDesc="+objMandateId.id+"&AcctId="+objAcctId.value+"&DelFlg="+sDelFlg+"&EntityCreFlg="+cEntityCreFlg+"&preceedence="+sPreceedenceFlg;
	sUrl +="&wCrAcctId="+acctObj.id+"&wCrAcctCrncy="+acctCrncyObj.id+"&wCrAcSolId="+acctSolIdObj.id+"&wCrAcctName="+acctNameObj.id+"&paySysIdDesc="+objPaySysIdDesc.id;
    var retVal = popModalWindowVar(sUrl, finbranchResource.FLT002884, 600, 300, 50, 30);
    }
    else
    {
    var sUrl = "../../arjspmorph/"+ applangcode+"/getMandateList.jsp?wReturn="+objPaySysId.id+"&wReturnDesc="+objMandateId.id+"&AcctId="+objAcctId.value+"&DelFlg="+sDelFlg+"&EntityCreFlg="+cEntityCreFlg+"&preceedence="+sPreceedenceFlg;
	sUrl +="&wCrAcctId="+acctObj.id+"&wCrAcctCrncy="+acctCrncyObj.id+"&wCrAcSolId="+acctSolIdObj.id+"&wCrAcctName="+acctNameObj.id+"&paySysIdDesc="+objPaySysIdDesc.id+"&linkFieldName="+linkFieldName.value;
    var retVal = popModalWindowVar(sUrl, finbranchResource.FLT004409, 600, 300, 50, 30);	
    }

  	if ("Microsoft Internet Explorer" == browser_name)
	{
		if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

			objPaySysId.value = liarrBufArray[0];
			if(objMandateId != null) objMandateId.value = liarrBufArray[1];
			if(acctObj != null) acctObj.value = liarrBufArray[2];

			if(acctCrncyObj != null) acctCrncyObj.value = liarrBufArray[3];
			if(acctSolIdObj != null) acctSolIdObj.value = liarrBufArray[4];
			if(acctNameObj != null) acctNameObj.value = liarrBufArray[5];
			if(objPaySysIdDesc != null) objPaySysIdDesc.value = liarrBufArray[6];
		}
	}

}
function showGCTLangCodes(txtObj,inPreceedence, txtObjDesc)
{
    var sUrl = "";
    var preceedence = 'B';

    if(arguments.length > 1)
    {
        preceedence = inPreceedence;
    }
    if (arguments.length < 3)
    {
        sUrl = "../../arjspmorph/"+applangcode+"/get_gctlang_list.jsp?wReturn="+txtObj.id+"&wReturnDesc=NULL&preceedence="+preceedence;
    }else
    {
        sUrl = "../../arjspmorph/"+applangcode+"/get_gctlang_list.jsp?wReturn="+txtObj.id+"&wReturnDesc="+txtObjDesc.id+"&preceedence="+preceedence;
    }

    var retVal = popModalWindow(sUrl,"GCTLangCode");

    if ("Microsoft Internet Explorer" == browser_name)
    {
        if (retVal != null && retVal != undefined )
        {
            //Array for taking the values after splitting the value with "|".
            var liarrBufArray = retVal.split("|");

            txtObj.value = liarrBufArray[0];
            if(txtObjDesc != null) txtObjDesc.value = liarrBufArray[1];
        }
    }
}

function callCRVForPTranDetails(srvrFlg,trId,trDt,pTranNo,acNo)
{
	invokeCRV(srvrFlg,crvUrl,"../arjspmorph/" + applangcode + "/trandet.jsp","TranId|"+trId+"|TranDate|"+trDt+"|PartTranSerialNum|"+pTranNo+"|Acid|"+acNo);
}

/**
	To open a Search DD Mass Operation Tran ID window.
*/
function showDdIdList(ddTranIdObj,funcCode,ddmiOrDdmp,inPrecedence,defSolId,defRemarks,defPurAcNum,defPurName,defTotDdAmt)
{

	var sUrl = "";
	var precedence = 'F';
	var strSolId = "";
	var strRemarks = "";
	var strPurAcNum = "";
	var strPurName = "";
	var strTotDdAmt = "";
	var strFuncCode = "";
/* Assigning default if passed */
	if(funcCode != undefined) { strFuncCode  	= funcCode.value;}
    if(defSolId  	!= undefined) { strSolId  	= defSolId;}
    if(defRemarks 	!= undefined) { strRemarks = defRemarks;}
    if(defPurAcNum 	!= undefined) { strPurAcNum = defPurAcNum;}
    if(defPurName  	!= undefined) { strPurName      = defPurName;}
    if(defTotDdAmt	!= undefined) { strTotDdAmt     = defTotDdAmt;}

	if(strFuncCode == "")
	{
		alert(finbranchResource.FER000134);
		funcCode.focus();
		return;
	}

	if(arguments.length > 3)
    {
        precedence = inPrecedence;
    }

	sUrl = "../../arjspmorph/"+applangcode+"/search_dd_id_list.jsp?wReturn="+ddTranIdObj.id+"&funcCode="+strFuncCode+"&ddmiOrDdmp="+ddmiOrDdmp+"&precedence="+precedence+"&defSolId="+strSolId+"&defDdMassOprRmks="+strRemarks+"&defPrchsrAcctNum="+strPurAcNum+"&defPrchsrName="+strPurName+"&defTotDdAmt="+strTotDdAmt;

	var retVal = popModalWindow(sUrl,finbranchResource.FLT004191);

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        if(ddTranIdObj !=null) ddTranIdObj.value = liarrBufArray[0];
		}
    }
}

function hideAnc(id)
{
    var obj = (document.getElementById)? document.getElementById(id): (document.all)? document.all[id]: null;
    if (obj != null && obj != undefined) {
        obj.disabled = true;
        obj.onclick = "";
    }
}
function onClickAssignRtrnPath(path)
{
       document.location.href = path;
}
function fnValidatePercent(objPcntField, precision){

    var numericPart = 0;
    var decimalPart = 0;
    var iIndex = 0;
    var bValidPercent = true;
    var sourcePcnt = objPcntField;
    var DEC_PART_LEN = 6;

    DEC_PART_LEN = DEC_PART_LEN > precision ? precision : DEC_PART_LEN;

    iIndex = sourcePcnt.indexOf(".");
    if(iIndex == -1){
        numericPart = sourcePcnt;
    } else {
            numericPart = sourcePcnt.substring(0,iIndex);
            decimalPart = sourcePcnt.substring(iIndex+1);
        }

    if(decimalPart.length > DEC_PART_LEN){
        bValidPercent = false;
        alert(finbranchResource.FAT000523+DEC_PART_LEN+finbranchResource.FAT000526);
    }

    return bValidPercent;
}

function showLoanGrcextVerifyPendList(acctNum, dmdType, inPreceedence, acctCrncy, acctSol, acctName)
{
    var sUrl = "../"+"/grcext/"; //( !fnIsNull(ctrlOrMorph) && !(ctrlOrMorph == 'morph') ) ? "../" : "../../arjspmorph/";
    sUrl += applangcode+"/grcextpendlist.jsp?acctNum="+acctNum.value+"&dmdType="+dmdType+"&preceedence="+inPreceedence;

	if(acctNum != null && acctNum.id != undefined)
	{
		sUrl += "&rtnVal1="+acctNum.id;
	}
	if(acctCrncy != null && acctCrncy.id != undefined)
	{
		sUrl += "&rtnVal2="+acctCrncy.id;
	}
	if(acctSol != null && acctSol.id != undefined)
	{
		sUrl += "&rtnVal3="+acctSol.id;
	}
	if(acctName != null && acctName.id != undefined)
	{
		sUrl += "&rtnVal4="+acctName.id;
	}
	var retVal = popModalWindow(sUrl,finbranchResource.FLT004039);
	if ("Microsoft Internet Explorer" == browser_name)
	{
		if(retVal != null && retVal != undefined)
		{
			var liarrBufArray = retVal.split("|");
			acctNum.value = liarrBufArray[0];
			acctCrncy.value = liarrBufArray[1];
			acctSol.value = liarrBufArray[2];
			acctName.value = liarrBufArray[3];
		}
	}
}
function fnShowDisbNoticeSrlList(lSrlNum,lLoanAcct,ltemp)
{
 	if(fnIsNull(lLoanAcct.value))
      {
	   alert(finbranchResource.FAT000200);
	   lLoanAcct.focus();
	  }
	else
      {
      var sUrl = "../";
	  sUrl = sUrl +"/cldn/"+ applangcode+"/cldnoticelist.jsp?&wReturn="+lSrlNum.id+"&loanAcct="+lLoanAcct.value+"&precedence=F";
      var retVal = popModalWindow(sUrl, finbranchResource.FLT001678);
		  if (retVal != null && retVal != undefined)
		  {
		  lSrlNum.value = retVal;
		  }
	}
}
function showFCList(saForwardContractNo,saFcSolId,saRateCode,saRate,saTreasuryRate,PartyCode,ClAcctId,ToCrncy,FromCrncy,ContractType)
{	
	var sUrl = "../";
	sUrl = sUrl +"/../arjspmorph/"+ applangcode+"/fclist.jsp?&wReturn="+saForwardContractNo.id+"&partyCode="+PartyCode+"&clAcctId="+ClAcctId+"&preceedence=F&fromCrncy="+FromCrncy+"&toCrncy="+ToCrncy+"&contractType="+ContractType;
	var retVal = popModalWindow(sUrl, finbranchResource.FLT004429);
	if (retVal != null && retVal != undefined)
	{
		var liarrBufArray			= retVal.split("|");
		saForwardContractNo.value 	= liarrBufArray[0];
		saFcSolId.value				= liarrBufArray[1];
		saRateCode.value			= liarrBufArray[2];
		saRate.value				= liarrBufArray[3];
		saTreasuryRate.value		= liarrBufArray[4];
	}
}
/*As directed by Srinivas
function showHelpFile(file)
{
    var sUrl = "../Renderer/helpfiles/" + file;
    var winHandle = window.open(sUrl,"HelpScreen", "height=300%, width=600%, top=50%, status=no, toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no");
    winHandle.focus();
}
*/
function validateRefCode(frame,refCodeObj,refRecTypeVal,descObj)
{
    var refCode		= "";
    var descId		= "";
	var isValidFlg	= "";
	var tmpStr		= "";
	var wReturnDesc	= "";
    var refRecType	= refRecTypeVal;
    var fetchId		= 'REFCODE';
	var precedence	= 'F';

	if (!fnIsNull(refCodeObj.value)) 
		refCode = refCodeObj.value
    if (descObj != null)
        descId = descObj.id;

	if (!fnIsNull(refCodeObj.value))
	{
		refCode = refCodeObj.value
		tmpStr		= refCode+"|"+refRecType;
    	var sUrl = "../../arjspmorph/"+applangcode+"/frm_fetch.jsp?fetchId="+fetchId+"&precedence="+precedence+"&wReturn="+tmpStr+"&wReturnDesc="+descId;

    	var xMax = screen.width, yMax = screen.height;
    	var xOffset = (xMax - 120), yOffset = (yMax - 150);
    	var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
    	params += ";status=no;toolbar=no;menubar=no;resizable=no;help=no;center=no";

    	if("Netscape" == browser_name)
        	window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
    	else
		{
    		var outData = window.showModalDialog(sUrl,document.forms[0],params);
			if (outData.toLowerCase().indexOf("|") == -1)
			{
				if(outData != "")
					alert("\""+outData+"\"");
				return false;
			}
			var retval = outData.split("|");
			eval("document.forms[0]."+descId+".value =\""+retval[0]+"\"");
		}
	}
}

function showPldtList(saPldtId,saPldtValueDate)
{	
	var sUrl = "../";
	sUrl = sUrl +"/pldt/"+ applangcode+"/pldtlist.jsp?wReturn="+saPldtId.id+"&wReturn1="+saPldtValueDate.id+"&preceedence=F";
	var retVal = popModalWindow(sUrl, finbranchResource.FLT002846);
	
	if (retVal != null && retVal != undefined)
	{
		var liarrBufArray	= retVal.split("|");
		saPldtId.value		= liarrBufArray[0];
		saPldtValueDate.value    =  liarrBufArray[1];
		
	}
}

function writeHeader(screenName)
{
	with(document) {
		write('<input type="hidden" name="actionCode">');
		write('<input type="hidden" name="screenName" value="' + screenName + '">');
	}
}

function writeFooter()
{
	try {
		if (eval(isAuditEnabled) != undefined && isAuditEnabled) {
			document.write('<input type="button" class="button" value="VIEW AUDIT" onClick="doSubmit(\'showaudit\');">');
		}
	}catch(e){}
}

function doSubmit(actionCode)
{
	var frm = document.forms[0];
	frm.actionCode.value = actionCode;
	enableFormElements();
	convertToCaps();
	hideAnchors();
	disableButtons();
	frm.submit();
}

function hideAnchors()
{
	var ancLen = document.anchors;
	var obj;
	for (var i=0; i<ancLen; i++)
	{
		obj = document.anchors[i];
		if ((obj.id).substr(0,4) == "sLnk")
			hideImage(obj.id);
	}
}

function showClpayVerifyList(ctrlOrMorph,inPreceedence,acctNum,acctCrncy,acctSol,acctName)
{
    var sUrl = (ctrlOrMorph == 'ctrl') ? "../../arjspmorph/" : "../";
    sUrl += applangcode+"/clpayverifylist.jsp?preceedence="+inPreceedence;

    if(acctNum != null)
    {
        sUrl += "&rtnVal1="+acctNum.id;
    }

    if(acctCrncy != null)
    {
        sUrl += "&rtnVal2="+acctCrncy.id;
    }

    if(acctSol != null)
    {
        sUrl += "&rtnVal3="+acctSol.id;
    }

    if(acctName != null)
    {
        sUrl += "&rtnVal4="+acctName.id;
    }

    var retVal = popModalWindow(sUrl,"cldrdnverifylist");
    if ("Microsoft Internet Explorer" == browser_name)
    {
        if(retVal != null && retVal != undefined)
        {
            var liarrBufArray = retVal.split("|");
            if(acctNum != null) acctNum.value 		= liarrBufArray[0];
            if(acctCrncy != null) acctCrncy.value 	= liarrBufArray[1];
            if(acctSol != null) acctSol.value 		= liarrBufArray[2];
            if(acctName != null) acctName.value 	= liarrBufArray[3];
        }
    }
}


/* Added in existing common_functions.js on 12th May*/
/* This file contains some common functions which can be used across modules */
/***************************************************************************************
        Function Name           :   disable_fld 
        Description             :   It disables/enables the button,text field based on 
									the parameter state .
        Input Values            : 	Function Code       
        Output Values           :               
***************************************************************************************/
function dis_enb_fields(objButton,objText,state)
{
	if(state == "Y")
	{
		//alert(state);
		objButton.disabled=true;
		objText.readOnly=true;
	}
	if(state == "N")
	{
		//alert(state);
		objButton.disabled=false;
		objText.readOnly=false;
	}
	return;
}
/**************************************************************************************
        Function Name           :     chk_invld_chr
        Description             :     Checks for invalid characters like ' in each
                                        text/text area field
        Input Values            :     None
        Output Values           :     None
***************************************************************************************/

function chk_invld_chr()
{
	var obj=document.forms[0];
	var len=obj.length;
	for(i=0;i<len;i++)
	{
		if (obj[i].type == "text"  || obj[i].type == "textarea" )
		{
			if(obj[i].value.indexOf("'") != -1)
			{
				alert("Invalid Character ( ' )");
				obj[i].focus();
				return 1;
			}
		}
	}

return 0;
}
/*********************Clear fields******************************************/
function clrFields()
{
	var obj=document.forms[0];
	var len=obj.length;
	for(i=0;i<len;i++)
	{
		if (obj[i].type != "button" )
		{
				obj[i].value = "";
		}
	}
return;
}

/**************************************************************************************
        Function Name           :     fnChngReadOnly
        Description             :     Makes  each text/text area field readOnly
        Input Values            :     None
        Output Values           :     None
***************************************************************************************/
function fnChngReadOnly()
{
//	alert("in fnChngReadOnly");
	var obj=document.forms[0];
	var len=obj.length;
	for(i=0;i<len;i++)
	{
		if (obj[i].type == "text"  || obj[i].type == "textarea" )
		{
			obj[i].readOnly=true;
		}
	}
	return;
}

function validateAsciiData(obj)
{

   var isMultByte = obj.getAttribute("fmb");
   if (!(isMultByte =='Y' ) && (!isAsciiVal(obj.value)) )
   {
       return false;
   }
   return true;
}
function isAsciiVal(str)
{
     if(fnIsNull(str)) {
             return true;
     }

    for (i=0,n=str.length;i<n;i++)
    {
      if(str.charCodeAt(i) >= 127)
      {
         return false;
      }
    }
   return true;
}
/**************************************************************************************
        Function Name           :     chk_for_mb
        Description             :     Checks for invalid multibyte character in
                                        text/text area field
        Input Values            :     None
        Output Values           :     None
***************************************************************************************/

function chk_for_mb()
{
        var obj=document.forms[0];
        var len=obj.length;
//	alert(len)
        for(j=0;j<len;j++)
        {
                if (obj[j].type == "text"  || obj[j].type == "textarea" )
                {
			if((obj[j].value != "") && (obj[j].value !=null))
			{
				if(!validateAsciiData(obj[j]))
				{
					alert("Invalid Character");
					obj[j].focus();
					return 1;
				}
			}
                }
        }

return 0;
}

function cust_showLmtLiabList(objPrefix, objSuffix, ctrlOrMorph,sCrncyCode, sDelFlg) {
        var sLimitId = "";
        var sUrl = "";
        var url = "../../arjspmorph/";
        if(arguments.length > 2) {
                if(ctrlOrMorph == 'morph')
                url = "../";
        }
        sCrncyCode = new String(sCrncyCode).toUpperCase();
sUrl=url+applangcode+"/get_lmt_liab_list.jsp?ReturnPrefix="+objPrefix.id+"&ReturnSuffix="+objSuffix.id+"&Prefix="+escape(objPrefix.value)+"&Suffix="+escape(objSuffix.value)+"&CrncyCode="+sCrncyCode+"&DelFlg="+sDelFlg;

        var retVal = popModalWindow(sUrl,"LmtLiabList");
        if (retVal != null && retVal != undefined) {
                objPrefix.value = retVal.substring(0,retVal.indexOf("/"));
                objSuffix.value = retVal.substring(retVal.indexOf("/")+1);
        }
}

function cust_showCurrencyList(currObj)
{
    var retVal = popModalWindow("../../arjspmorph/"+applangcode+"/get_currency.jsp?wReturn="+currObj.id+"&Currency="+escape(currObj.value),"CurrencyList");
    if (retVal != null)
    {
        var j = retVal.split("|");
        currObj.value = j[0];
     }
}

function cust_showCrncyConverterForTranMaint(refCrncyObj,tranCrncyObj,rateCodeObj,rateObj,refAmtObj){
//	alert("in cust");
	var frm = document.forms[0];    
    	var sUrl = "../../arjspmorph/"+applangcode+"/crncyconv.jsp?fromCrncy="+refCrncyObj.value +"&toCrncy="+tranCrncyObj.value+"&rateCode="+rateCodeObj.value+"&rate="+rateObj.value+"&fromAmt="+refAmtObj.value+"&returnReq=Y&calledMenu=tranMaint";
        var retVal = popModalWindow(sUrl,"crncyconv");
        var liarrBufArray = retVal.split("|");
        frm.acctCrncy.value = liarrBufArray[0];
        frm.refCrncy.value = liarrBufArray[1];
        frm.rateCode.value = liarrBufArray[2];
        frm.rate.value = liarrBufArray[3];
        frm.acctCrncyAmt.value = liarrBufArray[4];
        frm.refAmt.value = liarrBufArray[5];
}

function cust_getRateDetails() {
//	alert("getRateDetails");
	var frm = document.forms[0];
        convertToCaps();
	alert(document.forms[0].acctCrncy.value);
        var acctCrncy = frm.acctCrncy.value;
        var refCrncy = frm.refCrncy.value;
//        var isAcctNull = fnIsNull(frm.acctId.value);
        var isAcctNull = "";
        var isRefCrncyNull = fnIsNull(refCrncy);
        var isAcctCrncyNull = fnIsNull(acctCrncy);
        var isRateCodeNull = fnIsNull(frm.rateCode.value);
        var isRefAmtNull = fnIsNull(frm.refAmt.value);

        if (!isAcctNull && !isRefCrncyNull && !isRateCodeNull) {
                if (!isAcctCrncyNull && (acctCrncy == refCrncy)) {
                        frm.rate.value = getValInCustomFormat("1.00");
                        disableRateInfo();
                        return;
                }
                if (isRefAmtNull) return;
//                if(trRefNum != 'S') {
//                        frm.rate.value = "";
//                }
//                frm.chkdelFlg.checked = false;
//                frm.subaction.value = 'R';
                frmSubmit("COMPUTEAMT");
        }
        if (isRateCodeNull) {
                clearDescField("rate","treaRate","treaRefNum");
                if (refCrncy != acctCrncy) {
                        frm.acctCrncyAmt.value = "";
                }
        }
        return;
}


// Function for Cif If Listing
// added by SandeepSandeepMadhukar_P

function showCifId(obj,ctrlOrMorph,inPreceedence,objDesc)
{
        var cifObj = "";
        var sUrl = "";
        var preceedence = 'B';
        var url = "../../arjspmorph/";
	
	//alert("Inside");
    if(arguments.length > 1)
    {
                if(ctrlOrMorph == 'morph')
                url = "../../";
        }

    if(browser_name != "Microsoft Internet Explorer")
    {
                url = "../../arjspmorph/";
    }
    if(arguments.length > 2)
    {
        preceedence = inPreceedence;
    }

        if(obj != null) cifObj = obj.id;

        if (arguments.length < 4)
        {
                sUrl = url + applangcode+"/get_cust_id.jsp?wReturn="+cifObj+"&wReturnDesc=NULL&preceedence="+preceedence;
        }else
        {
                sUrl = url + applangcode+"/get_cust_id.jsp?wReturn="+cifObj+"&wReturnDesc="+objDesc.id+"&preceedence="+preceedence;
        }
    var retVal = popModalWindow(sUrl,"CifId");

        if ("Microsoft Internet Explorer" == browser_name)
        {
            if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");

                obj.value = liarrBufArray[0];
                        if(objDesc != null) objDesc.value = liarrBufArray[1];
                }
    }
}

/* Added by Castro - used in HDENSOL denom module */
function cust_showSolId(obj,ctrlOrMorph,inPreceedence,objDesc)
{
	var sol = "";
	var sUrl = "";
	var preceedence = 'B';
	var url = "/finbranch/arjspmorph/";

    if(arguments.length > 1)
    {
		if(ctrlOrMorph == 'morph')
		url = "../../";
    }
    if(browser_name != "Microsoft Internet Explorer")
    {
	url = "../../arjspmorph/";
    }
    if(arguments.length > 2)
    {
        preceedence = inPreceedence;
    }

	if(obj != null)
	{
		sol = obj.id;
	}

	if (arguments.length <4)
	{
		sUrl = url +applangcode+"/get_sol_list.jsp?wReturn="+sol+"&SolId="+escape(obj.value)+"&wReturnDesc=NULL&preceedence="+preceedence;
	}else
	{
		sUrl = url +applangcode+"/get_sol_list.jsp?wReturn="+sol+"&SolId="+escape(obj.value)+"&wReturnDesc="+objDesc.id+"&preceedence="+preceedence;
	}

	var retVal = popModalWindow(sUrl,"SolIdList");

	if ("Microsoft Internet Explorer" == browser_name)
	{
	    if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        obj.value = liarrBufArray[0];
			if(objDesc != null) objDesc.value = liarrBufArray[1];
		}
    }
}

// Below function cust_showCurrencyList() added by Sandeep Patil
function cust_showCurrencyList(currObj)
{
    var retVal = popModalWindow("../../arjspmorph/"+applangcode+"/get_currency.jsp?wReturn="+currObj.id+"&Currency="+escape(currObj.value),"CurrencyList");
    if (retVal != null)
    {
        var j = retVal.split("|");
        currObj.value = j[0];
     }
}

//The following function defined in common_functions.js is overwritten here
//for the 'logout' link to work for in CS custom menu options
function showConfirm(title,literalList,actionList,pWidth,pHeight,dWidth,dHeight) {
        literalList = fnTrim(literalList);
        actionList = fnTrim(actionList);
        var litBuf = literalList.split("|");
        var evtBuf = actionList.split("|");

        if (fnIsNull(title) || litBuf.length == 0 || evtBuf.length == 0 || litBuf.length != evtBuf.length) {
                alert(finbranchResArr.get("FAT001813"));
                return;
        }

        var retVal;
        var winName = "ConfirmWin";
        var url = "/finbranch/arjspmorph/"+applangcode+"/print_confirm.jsp";
        url += "?displayMsg="+title+"&buttonsList="+literalList+"&actionList="+actionList;

        if (arguments.length > 3) {
                retVal = popModalWindowVar(url,winName,pWidth,pHeight,dWidth,dHeight);
        }
        else {
                retVal = popModalWindow(url,winName);
        }

        if (retVal == null || retVal == undefined) {
                retVal = "";
        }
        return retVal;
}

//Added By manish for using the listing for non custom studio menu
function cust_fnExecuteScriptForList(inputNameValues, outputNames, scrName, pageTitle, literalNames, hyperLnkCols, isPopulationReq)
{
        var sUrl = "../custom/jsp/cust_fetch_list.jsp?";
	alert(sUrl);

        if((inputNameValues.indexOf("pageNumber") != -1) && (inputNameValues.indexOf("pageSize") == -1))
        {
                alert("Page Size is mandatory");
                return;
        }

        if((inputNameValues.indexOf("pageSize") != -1) && (inputNameValues.indexOf("pageNumber") == -1))
        {
                alert("Page Number is mandatory");
                return;
        }

        if(!cust_fnIsNull(inputNameValues))
                sUrl += "&inputs="+encodeURIComponent(inputNameValues);


        if(cust_fnIsNull(scrName))
        {
                alert("Script Name is mandatory");
                return;
        }

        sUrl += "&scrName="+scrName;


        if(cust_fnIsNull(outputNames))
        {
                alert("List ouput field names are mandatory");
                return;
        }

        sUrl += "&outputs="+outputNames;


        if(cust_fnIsNull(pageTitle))
        {
                pageTitle=finbranchResource.FHP000368;
	}

        sUrl += "&pageTitle="+encodeURIComponent(pageTitle);

        if(cust_fnIsNull(literalNames))
        {
                alert("Column Literal Names are mandatory");
                return;
        }

        sUrl += "&literalNames="+encodeURIComponent(literalNames);

        if(cust_fnIsNull(hyperLnkCols))
        {
                hyperLnkCols="1";
        }
        sUrl += "&hyperLnkCols="+hyperLnkCols;

        var retVal = cust_popModalWindow(sUrl, "Custom List");
alert(retVal);
        if (retVal == null || retVal == undefined)
                return retVal;

        if (!isPopulationReq)
                return retVal;

        if ("Microsoft Internet Explorer" == browser_name)
        {
                var frm = document.forms[0];
                var outBuff = outputNames.split("|");
                var outBuffLen = outBuff.length;
                var retBuff = retVal.split("|");

                for (var i=0; i<outBuffLen; i++)
                {
                        if ((eval("frm." + outBuff[i]) != undefined))
                        {
                                eval("frm."+outBuff[i]+".value=\""+retBuff[i]+"\"");
                        }
                }
	}
}

