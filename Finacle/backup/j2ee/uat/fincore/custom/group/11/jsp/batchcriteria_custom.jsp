<!---------------------------------------------------------------------------------------------------------------->

<!--Name              : batchcriteria_custom.jsp

<!--Description       : This file should reside in finbranch/custom/jsp folder.

<!--Date              : 18-01-2013

<!--Author            : Farhan

<!--Called By         : Menu

<!--Calling jsp       : None

<!--Menu Option       : HREJREP,HEGOC

<!--Modification History:

<!--	Version No.	Date		Author		Description

<!-- 	-----------	------		----------	---------------------------

<!--	0.1		18-01-2013	Farhan		Original version

<!--	0.2		31-01-2013	Chandrasekhar	Added Population of BODDate to HEGOC Menu

<!--	0.3		21-02-2013	Chandrasekhar	Reductant code has removed
<!--	0.4		11-09-2013	Priyansh	Porting 2
<!---------------------------------------------------------------------------------------------------------------->

<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*,finbranchUtil.*"%>

<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %> 



<%@ include file="../../../javascripts/core_signature.js" %>

<%

        FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");

        if(null == securityInfo)

        {

                securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");

        }



        String sBODDate = (String)((securityInfo.bodDate).substring(0,10));

        String homeSol  = (String)((securityInfo.homeSolId));

%>

<script type="text/javascript">

var bodDate = '<%=sBODDate%>';



function batchcriteria_pre_ONLOAD(btn)

{

	// bank start

	if(mopId == "HLADSP")

	{

		//alert("am in");

		var radioButtons= document.getElementsByName("recovery_mode");

                radioButtons[0].checked = true;

                radioButtons[1].checked = false;

				radioButtons[1].checked = false;



	}

// bank end

		if(mopId == "HREJREP")

		{

			element = document.getElementsByName("cust_flg");

			element[1].checked=true;

			return true;

		}

        else if(mopId == "HEGOC")

        {

                var boddate = '<%=sBODDate%>'

                var bod = boddate.split("-");



                var bodday = bod[0];

                var bodmonth = bod[1];

                var bodyear = bod[2];

                var ref = bodday+bodmonth+bodyear;

                document.forms[0].file.value = ref;

                return true;

        }

	if(mopId =="HPSP"){

		signfunction1();

		signfunction2();

	}

}

function post_ONLOAD() {

if(mopId == 'HPSP') {

		//ebl start

	var radioButtons= document.getElementsByName("adhoc_flg");

                radioButtons[0].checked = false;

                radioButtons[1].checked = true;

	//ebl end

element = document.forms[0].low_acct_num;

element.onchange = function() { fnOnChangeAcct() };

	//Added by Sruthi for call id : 390110
	
	document.forms[0].high_tran_date_ui.value = bodDate;


}



if(mopId == "HBGPRINT") 

	{

	document.forms[0].mrt_name.value="bgprint.mrt";

	}



}



function fnOnChangeAcct(){

        retValue = txtSrh_ONCHANGE(this,"postChangeSearch('ACCT','F','low_acct_num','low_acct_crncy|low_acct_sol|low_acct_name')");

        if(retValue) {

                var inputNameValues = "acctNum|"+document.forms[0].low_acct_num.value;

        var outputNames     = "";

        var scrName         = "formatacctdp001.scr";

        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);

        var ret1 = retVal.split("|");

        if(ret1[0] == "MSG" )

        {

                alert(ret1[1]);

        }

        }

}

function signfunction1(){

var a = document.getElementsByTagName("td");

var acctLabel = "From A/c. ID";

var tmpSignStr = '<a id="sigLnk" href="javascript:fnCustShowSignature1();">';

tmpSignStr = tmpSignStr + '<img class="img" title="Signature" src="../Renderer/images/INFENG/sig_new1.gif" width="16" height="18" border="0"></img></a>&nbsp;'



for(i=0;i<a.length;i++)

{

	if(a[i].innerHTML.indexOf(acctLabel) != -1)

	{

		if(a[i+1].innerHTML.indexOf('<INPUT') != -1 && a[i+1].innerHTML.indexOf('<INPUT') == 0) {

			var str = a[i+1].innerHTML;

			var indx = str.indexOf('</A>') + 4;

			a[i+1].innerHTML = str.substr(0,indx) + tmpSignStr + str.substr(indx);

		}

	}

}



}

function fnCustShowSignature1() {

	var acctIdStr = "low_acct_num";

	var solIdStr = "";

	var tmpAcctObj = document.getElementById(acctIdStr);

	if('X'+solIdStr != 'X') {

	var tmpSolObj = document.getElementById(solIdStr).value;

	}

	else

	{

	tmpSolObj = ""

	}

	if (fnIsNull(tmpAcctObj.value)) {

		alert("Enter the field.");

		tmpAcctObj.focus();

		return ;

	}

	var data = '?sAcctId='+escape(tmpAcctObj.value)+'&sSolId='+escape(tmpSolObj)+'&sActiveDate='+escape(bodDate)+'&fromAppId='+escape(fromAppId)+'&toMenu='+ mopId.toLowerCase() +'&contextSwitch=Y';

	displaySVSWindow(data);

}



function signfunction2(){

var a = document.getElementsByTagName("td");

var acctLabel = "To A/c. ID";

var tmpSignStr = '<a id="sigLnk" href="javascript:fnCustShowSignature2();">';

tmpSignStr = tmpSignStr + '<img class="img" title="Signature" src="../Renderer/images/INFENG/sig_new1.gif" width="16" height="18" border="0"></img></a>&nbsp;'



for(i=0;i<a.length;i++)

{

	if(a[i].innerHTML.indexOf(acctLabel) != -1)

	{

		if(a[i+1].innerHTML.indexOf('<INPUT') != -1 && a[i+1].innerHTML.indexOf('<INPUT') == 0) {

			var str = a[i+1].innerHTML;

			var indx = str.indexOf('</A>') + 4;

			a[i+1].innerHTML = str.substr(0,indx) + tmpSignStr + str.substr(indx);

		}

	}

}



}

function fnCustShowSignature2() {

	var acctIdStr = "high_acct_num";

	var solIdStr = "";

	var tmpAcctObj = document.getElementById(acctIdStr);

	if('X'+solIdStr != 'X') {

	var tmpSolObj = document.getElementById(solIdStr).value;

	}

	else

	{

	tmpSolObj = ""

	}

	if (fnIsNull(tmpAcctObj.value)) {

		alert("Enter the field.");

		tmpAcctObj.focus();

		return ;

	}

	var data = '?sAcctId='+escape(tmpAcctObj.value)+'&sSolId='+escape(tmpSolObj)+'&sActiveDate='+escape(bodDate)+'&fromAppId='+escape(fromAppId)+'&toMenu='+ mopId.toLowerCase() +'&contextSwitch=Y';

	displaySVSWindow(data);

}

function callbackSVS(data,menu)

{

// for SSO Context Switching

}
function batchcriteria_pre_ONCLICK(obj)
{
	if(mopId == "HSCOD")
	{
			if(obj.id=="Submit")
			{
					var setId = document.forms[0].set_id.value;
					var inputNameValues = "setId" + "|" + setId;
					var outputNames = "paramV1";
					var scrName = "setIdForScodValidate.scr"
					var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					var ret = retVal.split("|");
					if(ret[1] == "PASS")
					{
							return true;
					}
					if(ret[1] == "FAIL")
					{
							alert("Inter Sol Scod Not Allowed");
							return false;
					}
					if(ret[0] == "err")
					{
							alert("Enter a valid SetId");
					}
			}
	}
	if (obj.id == "Submit"){
        if (mopId=="HPPT"){
	      //alert(obj.id);
	      //alert(document.forms[0].sol_id.value);
            if (document.forms[0].sol_id.value != ""){
				//alert(document.forms[0].sol_id.value);
				var dcco = document.forms[0].sol_id.value;
				var input = "dcco|" + dcco;
				var outputNames = "output|outVal";
				var scrName = "PPT_Validate_custom.scr";
				var retVal = appFnExecuteScript(input, outputNames, scrName, false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
				var retBuff = retVal.split("|");
				var output1 = retBuff[2];
				var value1 = retBuff[3];
				var b = value1;
				//alert(a);
				//alert(b);
				//var ab =  a + b + "Pending posting.";
				//alert(ab);
				if (a > 0)
		        { 
					alert("Pending ISO transactions exist with the Sol");
				        document.forms[0].sol_id.focus();
					//alert(ab);
					return false;
				 }
	        }
        }
    }
	if((obj.id == 'Submit') || (obj.id == 'Validate'))
	{
		if(mopId == "HPSP") 
		{
		 //alert(document.forms[0].crncy_code.value);
			if(document.forms[0].crncy_code.value =="")
				 {
				 alert ("Period Enter Account Currency Code");
				 return false;
				 }
			 if(document.forms[0].crncy_code.value !="SSP")
				 {	
							//alert(document.forms[0].low_tran_date.value);

								var	dcco=document.forms[0].low_tran_date.value;
								var input      = "dcco|"+dcco;
								var outputNames    = "output|outVal";
								var outputNames    = "output2|outVal";
								var scrName     =   "b_date.scr";
				
							var retVal = appFnExecuteScript(input,outputNames,scrName,false);
						
								var retBuff = retVal.split("|");
								var output = retBuff[0];
								var value = retBuff[1];
								var a = value;
								var retBuff = retVal.split("|");
								var output = retBuff[2];
								var value = retBuff[3];
								var b = value;
								//alert(a);
								//alert(b);
							 if ((a<"1") || (b<"1"))
							 {
								alert ("Not Able to Print");
								return false;
							 }
				 }
		}
		if(mopId == "HATOR")
		{
			if (document.forms[0].acct_num_beg.value!=document.forms[0].acct_num_end.value)
				{
					alert("AC from and AC To should be the same..");
					return false;
				}

		}
	}


}
</script>

