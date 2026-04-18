function fnOnLoad() {
	if(mopId == "HCAACVTD"){

if(intAdjTranId !="")
{
 var inputValues = "acctId|" + acctId +"|DTTtranId|"+ intAdjTranId;
                var outputValues = "";
                var scriptName = "postTDEnteredTranFE.scr";
                //var retVal = appFnExecuteScript(inputValues ,outputValues ,scriptName ,true);
                var retVal = appFnExecuteScript(inputValues, outputValues, scriptName, false);
}

if(bookAdjTranId !="")
{
 var inputValues = "acctId|" + acctId +"|DTTtranId|"+ bookAdjTranId;
                var outputValues = "";
                var scriptName = "postTDEnteredTranFE.scr";
                //var retVal = appFnExecuteScript(inputValues ,outputValues ,scriptName ,true);
                var retVal = appFnExecuteScript(inputValues, outputValues, scriptName, false);
}

if(clsTranId !="")
{
 var inputValues = "acctId|" + acctId +"|DTTtranId|"+ clsTranId;
                var outputValues = "";
                var scriptName = "postTDEnteredTranFE.scr";
                //var retVal = appFnExecuteScript(inputValues ,outputValues ,scriptName ,true);
                var retVal = appFnExecuteScript(inputValues, outputValues, scriptName, false);
}



		var inputValues = "acctId|" + acctId;
		var outputValues = "";
		var scriptName = "postTDEnteredTran.scr";
		//var retVal = appFnExecuteScript(inputValues ,outputValues ,scriptName ,true);
		var retVal = appFnExecuteScript(inputValues, outputValues, scriptName, false);
	}
}
