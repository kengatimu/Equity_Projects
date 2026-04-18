<%--
/*
<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : prtinq_exp_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 18-01-2013
<!--Author              : BABU 
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : 
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                18-01-2013             BABU               Original version
<!---------------------------------------------------------------------------------------------------------------->
*/
--%>

<%-- importing java package to read the file in bytes --%>
<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.infy.finbranch.groups.FileOpertn" %>
<%@ page import="FABCommon.SecurityInfo70" %>
<%@ page import="com.infy.COTP.LinkList" %>
<%@ page import="com.infy.bbu.context.IServiceContext" %>
<%@ page import="com.infy.bbu.context.ContextAdapter" %>
<%@ page import="com.infy.bbu.jsputil.ContextManager" %>
<%@ page import="fabclasses.*" %>
<%@ page import="finbranchUtil.MenuMiscInfo" %>
<%@ page import="gcode.iface.IreportData" %>
<%@ page import="gcode.utils.ONSClassFactory" %>
<%@ page import="gcode.utils.ONSRaw" %>
<%@ page import="java.util.ResourceBundle" %>

<%@include file="../commonInclude.jsp"%>
<arjsp:init groupName="prtinq" isEntryPoint="false" />
<%
FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
PrintQueueListLL printQueueListLL = (PrintQueueListLL)ARJspCurr.getInputWithGroup("printQueueListLL_exp",null);
String printFileName   = printQueueListLL.printFileName;
IServiceContext context  = new ContextAdapter(ARJspCurr);
FinErrException fex=new FinErrException(new LinkList("FABInquiry.Err"));

//Creating the file object to read the file in bytes
String flNm =  printFileName;
String data = "";
String[] fileCont = null;
try {
	IreportData ireportdata = null;
	FileOpertn fileopertn = new FileOpertn();
	ireportdata = (IreportData)ONSClassFactory.getValueObject(securityInfo.userId, "gcode.dataobjects.reportData");
	fileopertn.init(context, fex);
	ireportdata = fileopertn.getFileData(flNm);
	data = new String(ireportdata.getreportData().data);
	fileCont = data.split("\\n");
	int len = fileCont.length;
%>
<script type="text/javascript">
var fileContjs = new Array("<%=len%>");
var sourceFile = printFileName.substr(printFileName.lastIndexOf("/")+1);
var objForm = null;
var data = null;
var ret = null;
var DELIMITER = "~EOL~";
<% for (int Cnt=0;Cnt<len;Cnt++) { %>
	fileContjs[<%=Cnt%>] = "<%=ParseValue.checkString(fileCont[Cnt].toString())%>";
<% } %>

function writeToFile(file, data, path)
{
	alert("Inside writeFile");
	var dataAsString = (data) ? data.join(DELIMITER) : null;
	alert(dataAsString);
	alert(finConst.COREAPPLET);
	alert([finConst.COREAPPLET]);
	alert(parent.frames[finConst.COREAPPLET]);
	return parent.frames[finConst.COREAPPLET].coreapplet.writeToFile(file , dataAsString, path, DELIMITER);
}

function writeFileContToDisk(destDir)
{
	alert("Inside writeFileContToDisk");
	data=fileContjs;
    try{
	alert("Inside writeFile try");
	alert(sourceFile);
	alert(data);
	alert(destDir);
        ret = writeToFile(sourceFile, data, destDir);
    }
    catch (e) {
    	var msg = (typeof(e.length) == "undefined") ? e.message : e;
   		alert("Error Occured (handleWindowDisplay) : " + msg);
    	alert("File transfer not successful")
    }
    switch (ret)
    {
    	case 0:
       		alert("File transferred successfully")
            break
        case 1:
        	alert("File transferred and It has been overwritten")
            break
        case 2:
        	alert("Destination directory not entered ")
            break
        case 3:
        	alert("Filename to be transferred not entered")
            break
        case 4:
        	alert("Insufficient data")
            break
        case 5:
            alert("Destination directory does not exist")
            break
        case 6:
        	alert("File to be transferred does not exist")
            break
	}
}

function post_ONLOAD() {
	// As of now harded value is used for testing . Same need to be taken from CPARAM
	var     inputNameValues    = "";
    var     outputNames        = "";
    var     scrName            = "sendfiletopcdp001.scr";
    var     retVal   = appFnExecuteScript(inputNameValues, outputNames,scrName, false);
    var ret = retVal.split("|");
    if( ret[0] == "Error") {
        alert(ret[1]);
        return false;
    }
	var Dir = ret[1];
	writeFileContToDisk(Dir);
}
</script>
<% } catch (FinErrException e){ %>
<script type="text/javascript">
	alert("File not present in server.");
</script>
<% //System.out.println("The exeception is "); 
} %>
