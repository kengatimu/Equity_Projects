<%@include file="formatAcct.jsp" %>
<script language="javascript">

<function fnAccountIDList(funcCode){
	       if(funcCode.value  == "V" || funcCode.value  == "X"){
	        var funcCode = funcCode.value;
	        showVerfyPendList("GAM",funcCode,"Z","","","F",objForm.acctId,"","");
	     }else{
	          showAccountIdList(objForm.acctId,objForm.acctSol,objForm.acctName,'F',objForm.acctCrncy);
	      }
	          memoPad();
	  }

	  function memoPad(){
	          var acctNumber = document.forms[0].acctId.value ;
	          var inputNameValues = "acctNum|"+acctNumber;
	          var outputNames     = "";
	          var scrName         = "formatacctdp001.scr";
	          var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	          var ret1 = retVal.split("|");
	          if(ret1[0] == "MSG" ){
	                  alert(ret1[1]);
	          }
	  }
</script>


