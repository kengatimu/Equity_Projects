	/*************************************************************************************************************
	* Source Name           :   hblrgdtl_custom.js 
	* Title                 :   This custom js file gets called from filemntdtl_custom.jsp  
	*			    It adds seacher besides A/c Id  & Bank Id field and also changes the literal
	* Module                :   TD
	* Menu Option           :   HBLRG
	* Calling Script/JSP    :   None
	* Called Script/Jsp     :   hblrgdtl_custom.jsp
	* Author                :   Swati_Ganjoo
	* Date                  :   25-Mar-2013
	* <Serial No.>      <Date>         <Author Name>        <Description>
	*  ------------    -------------   --------------      ---------------
	*    1.0          25-Mar-2013      Swati_Ganjoo         Original Version
	*	  2.0			  18-Oct-2013		Vijaya V					to change free_text3 value to uppercase
	**************************************************************************************************************/

	/*************************************************************************************
	Calling Pre Onload function for changing the literal Free Text 1 to A/c. ID.
	**************************************************************************************/
	function hblrgdtl_pre_ONLOAD(obj)
	{
		/*************************************************************************************
		Change the Free Text 1 to A/c. ID.
		**************************************************************************************/
		/*Define variable input and assign it the value of literal to be changed*/ 
		var input2=jspResArr.get("FLT000145");
		/*Define variable output and assigne the value of new literal to it*/
		 var output2=jspResArr.get("FLT000265");
		/*Change the value of literal using inbuilt replace function of HTML*/
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace(input2,output2);
		
		/*************************************************************************************
		Change the Free Text 2 to Bank ID.
		**************************************************************************************/
		/*Define variable input and assign it the value of literal to be changed*/ 
		var input2=jspResArr.get("FLT000146");
		/*Define variable output and assigne the value of new literal to it*/
		 var output2=jspResArr.get("FLT018812");
		/*Change the value of literal using inbuilt replace function of HTML*/
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace(input2,output2);

		/*************************************************************************************
		Change the Free Text 3 to Charge Event Id.
		**************************************************************************************/
		/*Define variable input and assign it the value of literal to be changed*/ 
		var input2=jspResArr.get("FLT000147");
		/*Define variable output and assigne the value of new literal to it*/
		 var output2=jspResArr.get("FLT000729");
		/*Change the value of literal using inbuilt replace function of HTML*/
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace(input2,output2);
		
		/*************************************************************************************
		Change the Free Text 4 to Type of Validation.
		**************************************************************************************/
		/*Define variable input and assign it the value of literal to be changed*/ 
		var input2=jspResArr.get("FLT000148");
		/*Define variable output and assigne the value of new literal to it*/
		 var output2=jspResArr.get("FLT009674");
		/*Change the value of literal using inbuilt replace function of HTML*/
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace(input2,output2);
		
		//Change Added
		/*************************************************************************************
		Change the Free Text 5 to Type of Validation.
		**************************************************************************************/
		/*Define variable input and assign it the value of literal to be changed*/ 
		var input2=jspResArr.get("FLT000149");
		/*Define variable output and assigne the value of new literal to it*/
		 var output2=jspResArr.get("FLT000150");
		/*Change the value of literal using inbuilt replace function of HTML*/
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace(input2,output2);
		/*************************************************************************************
		Adding searchers in A/C ID and Bank Id field
		**************************************************************************************/
		
		if((fnCode=="A")||(fnCode=="M"))
		{	
		var fullHtml = document.forms[0].all('free_text1').parentNode.innerHTML;
		var newHtml = "&nbsp;<A id=\"sLnk6\" href=\"javascript:getAcctIdList()\" ><img  src=\"../Renderer/images/INFENG/search_icon.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search6\"></a>";
		document.forms[0].all('free_text1').parentNode.innerHTML = fullHtml + newHtml;
		document.forms[0].all('free_text1').hotKeyId ="search6";


		var fullHtml = document.forms[0].all('free_text2').parentNode.innerHTML;
		var newHtml = "&nbsp;<A id=\"sLnk7\" href=\"javascript:showEntityList()\" ><img  src=\"../Renderer/images/INFENG/search_icon.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search6\"></a>";
		document.forms[0].all('free_text2').parentNode.innerHTML = fullHtml + newHtml;
		document.forms[0].all('free_text2').hotKeyId ="search7";
		
		var fullHtml = document.forms[0].all('free_text3').parentNode.innerHTML;
		var newHtml = "&nbsp;<A id=\"sLnk8\" href=\"javascript:fnChrEventId()\" ><img  src=\"../Renderer/images/INFENG/search_icon.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search6\"></a>";
		document.forms[0].all('free_text3').parentNode.innerHTML = fullHtml + newHtml;
		document.forms[0].all('free_text3').hotKeyId ="search8";
		
		
		var fullHtml = document.forms[0].all('free_text4').parentNode.innerHTML;
		var newHtml = "&nbsp;<A id=\"sLnk9\" href=\"javascript:fnGetValType()\" ><img  src=\"../Renderer/images/INFENG/search_icon.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search6\"></a>";
		document.forms[0].all('free_text4').parentNode.innerHTML = fullHtml + newHtml;
		document.forms[0].all('free_text4').hotKeyId ="search9";
		

		}
	}
	
	function postEventCall(page,obj, event) 
	{
		if((fnCode=="A")||(fnCode=="M"))
		{
			var ObjForm = document.forms[0];
			var BankId = ObjForm.free_text2.value;
			var acctId = ObjForm.free_text1.value;
			var valType = ObjForm.free_text4.value;
			var cifId = ObjForm.cif_id.value.toUpperCase();
			if(obj.id =="free_text1" && event == "ONBLUR" && acctId !="")
			{
				var ObjForm = document.forms[0];
				var BankId = ObjForm.free_text2.value;
				if(fnIsNull(BankId))
				{
					alert("Enter the Bank ID");
					ObjForm.free_text2.focus();
					return false;
				}

			}
			if(obj.id =="free_text2" && event == "ONBLUR" && BankId !="")
			{
				if(fnIsNull(acctId))
				{
					alert("Enter the A/c. ID");
					ObjForm.free_text1.focus();
					return false;
				}

			}
			
			
			if(obj.id =="cif_id" && event == "ONCHANGE" && cifId !="")
			{

				var inputNameValues = "cifId|"+cifId;
				var outputNames = "errorFlg|errorMsg|billerName";
				//var scriptName = "getBillerName.scr"
				var scriptName = "ubpdp045.scr"
				var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
				var token = retVal.split("|");
				if(token != undefined)
				{
					var errorFlg	= token[1];
					var errorMsg	= token[3];
					var billerName	= token[5];
			
					if(errorFlg == "Y")
					{
						alert(errorMsg);
						ObjForm.cif_id.focus();
						return false;
					}
					else
					{
						ObjForm.biller_name.value = billerName;
					}

				}
			
			}
			if(obj.id =="cif_id" && event == "ONCHANGE" && cifId =="")
			{
				ObjForm.biller_name.value = "";
			}
		}

	}
	function hblrgdtl_pre_ONCLICK(obj)
	{
		if((fnCode=="A")||(fnCode=="M"))
		{
			var ObjForm = document.forms[0];
			var valType = ObjForm.free_text4.value;
			var billerCode = ObjForm.free_text5.value;

//change Added by vijaya to change free_text3 value to uppercase

			if(obj.id =="Envoyer  (soumettre) ")
			{
				if(ObjForm.free_text3.value!= "")
				{
					ObjForm.free_text3.value = ObjForm.free_text3.value.toUpperCase()
				}

				if(valType =="")
				{
					alert("Enter the Validation Type");
					ObjForm.free_text4.focus();
					return false;
				}

				if(billerCode ==""  && ((valType==" R") || (valType=="LR")))
				{
					alert("Enter the Biller Code");
					ObjForm.free_text5.focus();
					return false;
				}
			}
		}
	}
	
	/*************************************************************************************
	Calling getAcctIdList on click of A/C ID searcher
	**************************************************************************************/
	function getAcctIdList() 
	{
		var ObjForm = document.forms[0];
		var BankId = ObjForm.free_text2.value;
		if(fnIsNull(BankId))
		{
			alert("Enter the Bank ID to search corresponding accounts");
			ObjForm.free_text2.focus();
		}
		else
		{
			cust_showAccountIdList(ObjForm.free_text1,null,null,'F');
		}

	}
	
	/*************************************************************************************
	Show Account Id list js function
	**************************************************************************************/
	function cust_showAccountIdList(acctObj,solId,acctName,inPreceedence,currDesc,defCrncyCode,defSchemeCode,defSchemeType,defSolId,defCifId,defGLSubHead,defOwnership,defShortName,defAcctLbl,defPartn,doAutoSubmit,defMasterAcctId,searchLang,targetBankId,dispBankIDFldFlg)
	{
	/*************************************************************************************
	 Function modified to add input parameters to default in Account Id Criteria.
	If these are not supplied, the list would continue working as before.
	Note that the arguments.length <5 should be modified with care. 
	**************************************************************************************/
			var sUrl = "";
			var preceedence = 'B';
			var strCrncyCode = "";
			var strSchemeCode = "";
			var strSchemeType = "";
			var strSolId = "";
			var strCifId = "";
			var strsearchLang = "";
			var strGLSubHead = "";
			var strOwnership = "";
			var strShortName = "";
			var strAcctLbl = "";
			var strPartn = "";
			var strSubmit = "";
			var strTargetBankId = "";
			var acctIdVal = "";

	/* Assigning default if passed */
			if(acctObj.value != ""){acctIdVal = acctObj.value;}
			//if(targetBankId  == undefined){ strTargetBankId  = "";} else {strTargetBankId  = targetBankId.value;}
		strTargetBankId = document.forms[0].free_text2.value;
		if(defCrncyCode  == undefined){ strCrncyCode  = "";} else { strCrncyCode  = defCrncyCode;}
		if(defSchemeCode == undefined){ strSchemeCode = "";} else { strSchemeCode = defSchemeCode;}
		if(defSchemeType == undefined){ strSchemeType = "";} else { strSchemeType = defSchemeType;}
		if(defSolId      == undefined){ strSolId      = "";} else { strSolId      = defSolId;}
		if(defCifId     == undefined){ strCifId     = "";} else { strCifId     = defCifId;}
		if(searchLang     == undefined){ strsearchLang = "";} else { strsearchLang = searchLang;}
		if(defGLSubHead  == undefined){ strGLSubHead  = "";} else { strGLSubHead  = defGLSubHead;}
		if(defOwnership  == undefined){ strOwnership  = "";} else { strOwnership  = defOwnership;}
	//    if(defShortName  != undefined){ strShortName  = defShortName;}
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
					sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy=NULL&wReturnSol=NULL&wReturnAcct=NULL&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+strAcctLbl+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
			}else
			{
					sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy="+currDesc.id+"&wReturnSol="+solId.id+"&wReturnAcct="+acctName.id+"&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+escape(strAcctLbl)+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
			}

					if ("Microsoft Internet Explorer" == browser_name)
					{
						 var retVal = popModalWindow(sUrl,"");
					if (retVal != null && retVal != undefined )
					{
							//Array for taking the values after splitting the value with "|".
							var liarrBufArray = retVal.split("|");

					if(acctObj!=null) acctObj.value = liarrBufArray[0];
							if(currDesc!=null) currDesc.value = liarrBufArray[1];
							if(solId!=null) solId.value = liarrBufArray[2];
							if(acctName!=null) acctName.value = liarrBufArray[3];
					}
					}else{
								popModalWindowMozillaFrame(sUrl,"");
					}

	}
	/*************************************************************************************
	Calling function to list Bank id
	**************************************************************************************/
	function showEntityList()
		{
			var inputNameValues = "targetEntity| "
			var outputNameValues = "targetEntity|targetEntityDesc|targetEntityHomeCcy";
			//var scriptName = "cietxndp019.scr";
			var scriptName = "ubpdp048.scr";
			var listHeading = "FLT018812: ID de la banque";
			var colHeader = "Bank ID|Bank ID Description|Home Currency Code";
			var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",false);
			if(retVal != undefined){
				var ObjForm = document.forms[0];
				var token = retVal.split("|");
				ObjForm.free_text2.value = token[0];
				//ObjForm.free_text2.value
				var bankId = ObjForm.free_text2.value;
				if(!fnIsNull(bankId))
				{
					ObjForm.free_text1.focus();
				}
			}
			
		}

	function fnChrEventId()
	{
		var ObjForm = document.forms[0];
		var BankId = ObjForm.free_text2.value;
		if(fnIsNull(BankId))
		{
			alert("Enter the Bank ID");
			ObjForm.free_text2.focus();
			
		}
		else
		{
			var inputNameValues = "BankId|"+BankId;
			var outputNameValues = "chgEvetId";
			//var scriptName = "chrgEventId_HBLRG.scr";
			var scriptName = "ubpdp047.scr";
			var listHeading = "FLT000729: ID dévénement de la facturation";
			var colHeader = "FLT031294: Identifiant de lévénement de facturation";
			var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",false);
			if(retVal != undefined){
			var token = retVal.split("|");
			ObjForm.free_text3.value = token[0];
			}
			else
			{
				ObjForm.free_text3.focus();
			}
			
		}
	}
	
	function fnGetValType()
	{
		
		var ObjForm = document.forms[0];
		var valType = ObjForm.free_text4.value;
		var BankId = ObjForm.free_text2.value;
		if(fnIsNull(BankId))
		{
			alert("Enter the Bank ID");
			ObjForm.free_text2.focus();
		}
		else
		{
			var inputNameValues = "BankId|"+BankId;
			var outputNameValues = "valType|valDesc";
			var scriptName = "ubpdp051.scr";
			var listHeading = "Validation Types";
			var colHeader = "Validation Types|Validation Desc";
			var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",false);
			
			if(retVal != undefined)
			{
				var token = retVal.split("|");
				ObjForm.free_text4.value = token[0];
		
			}
			else
			{
				ObjForm.free_text4.focus();
			}

		}
	
	}
