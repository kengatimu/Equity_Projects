var comm1 = 0.0212;
var comm2 = 0.0182;
var testStamp = 2;
var shareMinimum="0.05";
var lineNumber=0;


//< !-- This is getting executing on click of submit and validate button -- >


function fnValidateData()
{
    if (!fnCheckMandatoryFields())
    {
        return false;
    }
    return true;
}
function Tester(amtValue)
{



}




//< !-- This function is added for formatting a particular MRH Row -- >
function formatRowValue(Obj, colNumber) {

    return Obj;

}


//< !-- This function is added for formatting a particular MRH Row -- >
function fnValidateForm(obj) {
    objForm = document.forms[0];   


    if (obj == window[sMultiRecName1].addNewAction)
    {

        //validation for adding a record
        //all the fields which require validation before adding will be checked here

        var depositAmountObj = objForm.txtfldname313;
        var orderAmountObj = objForm.txtfldname418;
        var orderDateObj = objForm.txtfldname733;
        var askingPriceObj = objForm.txtfldname310;
        var quantityObj = objForm.txtfldname415;


        //check for nulls and empty strings
        if (cust_fnIsNull(depositAmountObj.value) || !isNumber(depositAmountObj.value))
        {
            //alert("Validation for fields Deposit Amount failed");
            //customClearAndFocus(depositAmountObj);
            //return false;

        }
        if (cust_fnIsNull(orderAmountObj.value))
        {
            alert("Validation for fields Order Amount failed");
            orderAmountObj.focus();
            customClearField(depositAmountObj);
            return false;
        }
        if (cust_fnIsNull(orderDateObj.value))
        {
            alert("Validation for Order Date Failed");
            orderDateObj.focus();
            return false;

        }


        //Do other on click of the add button

        //alert("setting value for the hidden Totals");

        var t = parseFloat(document.getElementById("txtfldname628").value) + testStamp;
        sethTotals(t);

		//setting the new value for new line number

		

		//alert("The new line number is "+lineNumber);

		var lineNumber=document.getElementById("txtfldname13");                    

        lineNumber.value=0;
        
        //var hTotalObj = document.getElementById("Totamt");


    }
    if (obj == window[sMultiRecName1].nextAction)
    {
        if ((objForm.txtfldname13.value == "") && (objForm.txtfldname25.value == "") && (objForm.txtfldname28.value == "") && (objForm.txtfldname310.value == "") && (objForm.txtfldname313.value == "") && (objForm.txtfldname415.value == "") && (objForm.txtfldname418.value == "") && (objForm.txtfldname520.value == "") && (objForm.txtfldname523.value == "") && (objForm.txtfldname625.value == "") && (objForm.txtfldname628.value == "") && (objForm.txtfldname730.value == "") && (objForm.txtfldname733.value == "") && (objForm.name835.value == ""))
        {
            alert(finbranchResArr.get("FAT000924"));
            return false;
        }
    }

    return true;

}
//function to set the client names

function setClientCDSCNames()
{

	

    if (funcCode == 'A'||funcCode=='H')
    {
        

        var names = document.getElementById('clientCdscDetails');		
		

        names.innerHTML = clientname;

    }

    //If the function code is Inquire
    //populate the client details screen using customscriptY
    if (funcCode == 'I')
    {

        alert("Function code is I");


    }

    //If the function is V or H
    //populate the client details screen using customscriptY

    if (funcCode == 'V'||funcCode=='H')
    {
        //alert("Inside setClientCDSCNames with funcCode V");
        
		var l=document.getElementsByTagName("label");
		l[1].innerHTML="T";

		//setting the total amount
		
		var dc = tranid;
        var inputNameValues = "dcNumber" + "|" + tranid;		

        var outputNames1 = "RESULTS";
        var scrName1 = "trading003.scr";
        var retVal = "";
        var retVal = appFnExecuteScript(inputNameValues, outputNames1, scrName1, false);
        if (retVal != "")
        {
            var ret1 = retVal.split("|");
            var customernames = ret1[1];
			//alert(customernames);
			var details2      = customernames.split("@");
			var dispTotal = document.getElementById("DispTotal");
			     
            dispTotal.value=details2[0];

			var compFieldsLabels=document.getElementsByTagName("label");
			//account number
            compFieldsLabels[2].innerHTML=details2[2];
			//cdsc number
		    compFieldsLabels[3].innerHTML=details2[1];
			
            var cNames=document.getElementById("sclientnames");
			
			var scurrency=document.getElementById("scurrency");
			
			var sbranch=document.getElementById("sbranch");

			//client names
             cNames.innerHTML=details2[3];

			//currency
			 scurrency.innerHTML=details2[4];
			 
			//branch
			 sbranch.innerHTML=details2[5];			

			 //CDSC account name
			 var names = document.getElementById('clientCdscDetails');
			 names.innerHTML=details2[6];
        }



    }

}

function setAccountDetails()

{

    //alert("Inside set client CDSC details");


    if (funcCode == 'A')
    {		

        objForm = document.forms[0];
		var acctnumber;
		if(funcCode=='A')
		{
          acctnumber = accountnumber;
		}
		else
		{			

		}
        var inputNameValues = "foracid" + "|" + acctnumber;
        var outputNames1 = "RESULTS";
        var scrName1 = "tradingdp004.scr";
        var retVal = "";
        var retVal = appFnExecuteScript(inputNameValues, outputNames1, scrName1, false);
        if (retVal != "" && retVal != undefined)
        {
            var ret1 = retVal.split("|");
            var custDetails = ret1[1];

            var details = custDetails.split("!");

            document.getElementById("sclientnames").innerHTML = details[1];	
            document.getElementById("scurrency").innerHTML = details[2];			
            document.getElementById("sbranch").innerHTML = details[3];
			

        }
        else
        {
            alert("There was an error retrieving the Account details for the customer");

            return false;

        }
    }


}
//show account details
function showAcctDetails(acct_num) {
    if (fnIsNull(acct_num)) {
        alert(finbranchResArr.get("FAT000200"));
        return;
    }
    var sUrl = "../arjspmorph/" + applangcode + "/acctdtls.jsp?acctId=" + acct_num;
    popModalWindow(sUrl, "Acct Details");
}

//Show a list

function fnCustSearcher1()
{
    var inputNameValues = "Originator|OriginatorVal";
    var outputNames = "txtfldname25|txtfldname28";
    var scrName = "trading002.scr";
    var title = "LIST OF SECURITIES";
    var literalNames = "SECURITY CODE|SECURITY NAME";
    var hyperLnks = "1";
    var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
    var retVal = "";
}


function disableHeader()
{

    var tranRemarks = document.getElementById("tranremarks");
    var referenceNumber = document.getElementById("referencenumber");
    var serialnumber = document.getElementById("serialnumber");
    var transactiondate = document.getElementById("transactiondate");
    var transactionid = document.getElementById("transactionid");
    var placeLienFlag = document.getElementsByName("placeLienFlg");


    tranRemarks.value = "-SHARE PURCHASE TRANSACTION-";

    tranRemarks.disabled = true;
    transactionid.disabled = true;
    referenceNumber.value = "REFERENCE NUMBER";
    referenceNumber.disabled = true;
    serialnumber.value = "SERIAL NUMBER";
    serialnumber.disabled = true;
    transactiondate.disabled = true;

    placeLienFlag[1].checked = true;
    placeLienFlag[0].disabled = true;
    placeLienFlag[1].diabled = true;


    //disable disp total amount field
    var totalAmount = document.getElementById("DispTotal");

    totalAmount.disabled = true;


}
//Disable the security code and security name fields

function disableMultiRecControls()
{
    var securityCode = document.getElementById("txtfldname25");
    var securityName = document.getElementById("txtfldname28");
	var lineNumber=document.getElementById("txtfldname13");
     
	 if(funcCode=='A')
	{
	lineNumber.disabled=true;	
    lineNumber.value=0;
	}
	//setting the line number/record number
    
	/////////////////////

    //To check on incrementing the line number

	///////////////////////
	//setLineNumber(lineNumber);

    var orderAmount = document.getElementById("txtfldname418");
    var commAmount = document.getElementById("txtfldname523");
    var commPercentage = document.getElementById("txtfldname520");
	var deposit=document.getElementById("txtfldname313");
    var totalAmount = document.getElementById("txtfldname628");
    var orderDate = document.getElementById("txtfldname733");
	var residue = document.getElementById("txtfldname730");
     

   if(funcCode=='A')
	{
	
    orderDate.value = BODDate;
    orderDate.disabled = true;
   
     
    securityCode.disabled = true;
	residue.disabled=true;
	deposit.disabled=true;
    securityName.disabled = true;
    orderAmount.readOnly = true;
    commAmount.readOnly = true;
    commPercentage.readOnly = true;
    totalAmount.readOnly = true;
	}


}

function validateLineNumber(linenumber)
{

    if (linenumber == "")
    {


        alert("The line number can't be blank");

        return false;

    }

}
function validateAskingPrice(price)
{


    var y=removeCommas(price);

	if(!isValidAmount(y)||price==null)
	{
		askingPriceMessage();
		//alert("At validation 1");
		return false;

	}
	if(!isValideqtyprice(y))
	{
		askingPriceMessage();
		alert("At validation 2");
		return false;
 
	}

    //ensure that the price has only digits and a dot seperator   

    return true;


}

/*
 function validateShareQuantity(quantity)
 {
 if(quantity==null)
 
 return false;
 
 var quantity=removeCommas(quantity);
 
 var rem=quantity%100;
 
 if(rem!=0)
 {
 alert("Enter the number in denominations of 100");
 
 objForm.txtfldname415.value="";
 objForm.txtfldname415.focus();
 
 return false;
 
 }
 
 
 return true;
 
 }
 
 */

function validateShareQuantity(quantity)
{
    if (quantity == null)
	{
        return false;
	}
	if(cust_fnIsNull(quantity))
	{
		
		 alert("The share quantity can't be empty");
		 return false;

	}


    var quantity = removeCommas(quantity);


    if(!isNumber(quantity))
	{
       alert("Enter the quantity in valid format");
	   return false;
	}

    var rem = quantity % 100;

    if (rem != 0)
    {
        alert("Enter the number in denominations of 100");

        objForm.txtfldname415.value = "";
        objForm.txtfldname415.focus();

        return false;

    }


    var quantity = document.getElementById("txtfldname415");
    var askingPrice = document.getElementById("txtfldname310");
    var depositAmount = document.getElementById("txtfldname313");


    //check the price is already there

    if ((askingPrice.value !== "") && (askingPrice.value != undefined))
    {

        //if the price is present, disable the total deposit field

        //depositAmount.disabled=true;

        var qnty = quantity.value;
        var price = askingPrice.value;

        var totalAmt = qnty * price;

        var chargeComm;

        if (totalAmt <= 100000)
        {
            chargeComm = comm1;


        }
        else
        {
            chargeComm = comm2;

        }

        var commPercentage = document.getElementById("txtfldname520");
        var orderAmounnt = document.getElementById("txtfldname418");
        var commAmount = document.getElementById("txtfldname523");
        var totalAmount = document.getElementById("txtfldname628");
        var stamp = document.getElementById("txtfldname625");
        var dispTotal = document.getElementById("DispTotal");
        var hTotalAmount = document.getElementById("Totamt");

        commPercentage.value = chargeComm;
        orderAmounnt.value = totalAmt;
        //alert(chargeComm);
       // alert(totalAmt);
        var cCommAmount = chargeComm * totalAmt;
        //alert(cCommAmount);
        commAmount.value = cCommAmount;
        totalAmount.value = totalAmt + cCommAmount;


        //TODO use custom Data

        stamp.value = testStamp;


        var hTotalObj = document.getElementById("Totamt");

        //do computations
        if (parseInt(dispTotal.value) == 0)
        {


            //alert("Inside validate quantity if");

            var computedAmount = totalAmt + cCommAmount + testStamp;


            //set disp total using a function               

            setDisplayedTotal(computedAmount);




        }
        else
        {

			//alert("Inside validate quantity else");

            //alert("Ending .." + totalAmt + " " + cCommAmount + " " + testStamp);

            var y = parseInt(totalAmt) + parseInt(cCommAmount) + parseInt(testStamp);
            //alert("Computed " + y);
            var calculatedAmount = parseInt(computedAmount) + y;

            //set the new value of computedAmount
            var computedAmount = calculatedAmount;
            //alert("Just before formatting");
            //set the displayed total
            setDisplayedTotal(computedAmount);


        }
 
	}
    
    else
    {
        alert("Enter the price first");
        objForm.txtfldname415.value = "";
        askingPrice.focus();

    }


    return true;

}

function askingPriceMessage(msg)
{
	   
	    objForm = document.forms[0];

        alert("Enter asking price in the correct format\n "+msg);

        objForm.txtfldname310.value = "";

        objForm.txtfldname310.focus();


}

function validateAskingPrice(price)
{
   

   //check whether the security code is entered
   objForm = document.forms[0];

   var secCode=objForm.txtfldname25.value;
   var priceObj=objForm.txtfldname310;

   if(cust_fnIsNull(secCode))
	{

       priceObj.value="";
	   alert("Please select security code");
	   return false;

	}
   
    //check for null,blank or undefined

	//alert("Inside asking price validation "+price);

    if (price == null)
    {
        
		askingPriceMessage();
		return false;
    }
    //checking whether the amount is valid
	if(!isValideqtyprice(price))
	{
		priceObj.value="";
		askingPriceMessage("The entered price is invalid");
		return false;

	}
    

	//checking whether the entered price is greater than minimum allowed
	if(!fnCompareEqtyPriceFlds(price,shareMinimum))
	{
		priceObj.value="";
        askingPriceMessage("The price can't be lower than "+shareMinimum);
		return false;
     
	}
	
	priceObj.value=removeCommas(price);    

    return true;


}
function handleDepositChange(obj)
{

    // this function handles change of the deposit amount field
    //1.The first point will be to validate the amount entered


    //2. If the price field already exists

    var aPrice = document.forms[0].txtfldname310;

    if (aPrice)
    {
        if (aPrice.value != "" && aPrice.value != undefined)
        {
            //calculate the number of shares
            var noOfShares = parseFloat(obj.value) / parseFloat(aPrice.value);

            var noOfSharesR = Math.round(noOfShares / 100) * 100;


            alert(noOfSharesR);
        }

    }



}

function customClearAndFocus(ObjId)
{
    objId.value = "";
    objId.focus();

}

function setDisplayedTotal()
{
    var dispTotal = document.getElementById("DispTotal");
    var hTotalObj = document.getElementById("Totamt");
    var dispValues=0.0;

    if (parseFloat(hTotalObj.value)!= 0)
    {
        dispValues = formatToMillion1(String(hTotalObj.value));
        
        //alert("Inside setDisplayedTotal "+dispValues);

    }

    dispTotal.value = dispValues;

}

function  sethTotals(newAmount)
{
    
	var firstTotal;
	var newTotal;
    
	//alert("The value of customData2 is "+customData);
    
    var totalAmtObj = document.getElementById("Totamt");

	if(cust_fnIsNull(totalAmtObj.value))
	{
         firstTotal=0;

	}
	else
	{
         firstTotal=parseFloat(totalAmtObj.value);

	}


 
    newTotal = firstTotal + newAmount;

	var x=Math.round(newTotal * 100) / 100

    totalAmtObj.value = x;

    //alert("Exiting New sethTotals");
   

    //alert("Exiting New dispTotals");

}

function setLineNumber(lineNumberObj)
{
	if(cust_fnIsNull(lineNumberObj.value))
	{
      lineNumberObj.value=lineNumber;
	}


}
function fnOutboundShareList()
{

	

	var secCodeObj = document.getElementById("txtfldname25");

	var secNameObj = document.getElementById("txtfldname28");

	var inputNameValues = "securitiesList|6";
    var outputNames = "txtfldname25|txtfldname28";
    var scrName = "trading014.scr";
    var title = "LIST OF SECURITIES";
    var literalNames = "SECURITY CODE|SECURITY NAME";
    var hyperLnks = "1";
    var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
    var retVal = "";

      
	if(secCodeObj.onchange)
	{
         secCodeObj.onchange();
          
	}
	
}
