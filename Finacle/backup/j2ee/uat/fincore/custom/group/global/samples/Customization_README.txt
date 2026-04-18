                      README File for Customization Features
                      --------------------------------------


This README.TXT explains how to make use of sample files and javascript functions for 
customization 

These files are available in $RESIN_ROOT/webapps/finbranch/custom/samples. One can make 
use of these sample files at site by putting them in finbranch/custom/jsp and 
finbranch/custom/javascripts directories accordingly.


Points to be remember 
--------------------

	1. Customization SHOULD NOT IMPLEMENT any of the core application routines and files.
	   In any case, if the same functionality defined in the core application is required,
	   then re-define the same in the customization files, by changing the routine/file 
	   names.
	 
Contents
--------
   * CUSTOMIZATION SPECIFIC FILES
   * CUSTOM SCRIPT EXECUTION
   * CUSTOM LIST GENERATION
   * REPOSITORY MANAGER
   * MULTI-REC FUCNTIONALITY
   * CUSTOM TAB FUNCTIONALITY
   * BATCH INVOCATION
   * FILES LOCATION
   * DESCRIPTION OF FILES AND ROUTINES


CUSTOMIZATION SPECIFIC FILES :-
____________________________

custom_functions.js:
--------------------

This file contains some generic routines, which can be used for customization purposes. All 
customization related generic routines should be defined in this file. To re-define a
common functionality defined in core application sources, implement the same in this file by renaming the routine names or by adding the "cust_" prefix to the routine names.

To implement the functionalities, include this file to your custom jsp file as specified 
below, after moving the file to the below specified path.

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js">
</script>

PATH : $RESIN_ROOT/webapps/finbranch/custom/javascripts/
	
cust_fetch_list.js:
-------------------

This file contains some generic custom list specific routines,which incorporates displaying
custlist,displaying error message in case of error and some utility routines. 

Routines in this file can be re-used only when your custom list jsp file incorportes the 
same implementation as done in cust_fetch_list.jsp.

To implement the functionalities, include this file to your custom list jsp file as specified below, after moving the file to the below specified path.

<script language="javascript" src="../Renderer/custom/javascripts/cust_fetch_list.js">
</script>

PATH : $RESIN_ROOT/webapps/finbranch/custom/javascripts/


CUSTOM SCRIPT EXECUTION :-
_______________________

Custom script execution is a mechanism to raise a backend script call to do some custom processing and to fetch results from the backend. This functionality can be implemented by calling the fnExecuteScript routine in custom_functions.js.


Routine Name		:	fnExecuteScript(inputNameValues, outputNames, scrName, 
										isPopulationReq)

Description			:	To execute a user defined backend script and to fetch some results 							and	populate in the parent form
			  		  
Implementation		:	To execute a custom script from an existing menu, write a custom 
						jsp for the page name and implement this routine in any event based 						routines or in any common routine of that menu.

			  Ex: 	<pagename>_pre_ONCLICK()
					<pagename>_pre_ONBLUR()
					<pagename>_post_ONLOAD() ..etc.

Prerequisites		: 	1. Link the custom_functions.js to the <pageName>_custom.jsp
			  			2. Backend custom script name is mandatory.

Parameter description	:


	@inputNameValues =	It specifies "|" separated Name value pairs to fetch the records 
						from the backend.  It is not a mandatory parameter.
			   
			   	Ex: 1. "CUSTID|0001|CUSTNAME|TESTNAME"
			   	    2. "" -(incase to fetch only output from backend).

	@outputs	 = 	It specifies "|" separated field id's to populate the values 
			   	fetched from the backend. It is a mandatory parameter when 
			   	isPopulationReq flag is set to true.
			   	
			   	Ex: 1. "ADDRESS|AGE|PHONENUM";
		           	    2. "" -(incase to send only input to backend).
		             

	@scrName	 = 	Backend Script file name.It is a mandatory parameter.
			   	Ex: "populatedata.scr"

	@isPopulationReq = 	To populate the output field values directly onto parent form, set 							isPopulationReq flag to true, else set it to false to get the 
						output values through retVal.

	RETURN VALUE	 = 	If isPopulationReq flag is true retVal will be undefined,
		           	if isPopulationReq flag is false retval will contain the pipe(|) 
					separated output values.
		           
Files Required		: 

      cust_frm_fetch.jsp   = fnExecuteScript() will internally call this file.It is the 
							base page for hidden frame mechanism implemented for making 
							backend call through customBean.  It specifies the frame for 
							cust_dummy_frm_fetch.jsp and cust_fetch.jsp.
	  cust_dummy_fetch.jsp = This file shows the processing bar display in the modal 
							window, when the cust_fetch.jsp fetches the data from the 
							backend.
      cust_fetch.jsp	   = This file calls the executeScript method of the customBean 
							to execute the backend script, and returns back the pipe (|) 
							separated values back to the parent page. 
		
CUSTOM LIST GENERATION:-
_______________________

Custom List Generation is a functionality to pop up a custom list from an existing menu. This can be implemented by calling the function fnExecuteScriptForList.


Routine Name		: fnExecuteScriptForList(inputNameValues, outputNames, scrName, pageTitle, literalNames, hyperLnkCols, isPopulationReq)

Description		: To execute a user defined backend script and to pop up a custom List for an existing ONS MENU.
		  
Implementation		: To pop up a custom list from an existing menu, write a custom jsp 
for the page name and implement this function call in any event based fucntion call of 
that menu.

Prerequisites		: 
				1. Link the custom_functions.js to the <pageName>_custom.jsp
			  	2. Backend custom script name is mandatory.
			  	3. List column names are mandatory.
			  	4. Backend script should always send the number of records as 
			     the first Name-Value pair in the customOutLL.
			  	5. Parameters "literalNames" and "hyperLnkCols" are dependent
			     on the "outputs" parameter. literalNames should not be more than
			     the output column names specified, and hyperLnkCols referrence
			     should be confined within the number of columns specified.

Parameter description	:


	@inputNameValues = This specifies "|" separated input name value pairs
			   to fetch the records from the backend
			   Ex: "CUSTID|0001|CUSTNAME|TESTNAME"

	@outputs	 = This specifies "|" separated field id's to 
			   populate the values fetched from the backend.
			   Ex: "custName|desigCode"

	@scrName	 = Backend Script file name.
			   Ex: "showlist.scr"

	@pageTitle	 = This specifies the title literal for the custom list.
			   Ex: a) finbranchResource.FHP000368
			       b) "Account List"

	@literalNames	 = This specifies the literals for the column name of the 
			   custom list, the number of literals specified should be 
			   same and should correspond to the number of output fields 
			   specified in the "outputs" parameter.
			   Ex: a) finbranchResource.FLT001034 + "|" + finbranchResource.FLT000163
			       b) "Account Name|Designation Code"

	@hyperLnkCols	 = This specifies the column number, where hyperlinks need to 
			   be placed to select a record in the custom list. More than 
			   one column number can be specified by using pipe's(|).
			   Ex: If there are three columns and if you wish to set hyperlink 
			   for column 1 and 3, then specify as "1|3"

	@isPopulationReq = To populate the selected record values to the fields specified in 
"outputs" parameter directly set isPopulationReq flag to true,	else set it to false to get the output values through retVal.


	RETURN VALUE	 = It will return the record selected in the customlist, if more than 
	one column exist, it will return the records with pipe separated.

Files Required		: 

      cust_fetch_list.jsp  = fnExecuteScriptForList() will internally call this file.
This file implements the executeScript method of the customBean and pop's up a custom list.
      			     
      cust_fetch_list.js   = This file has some generic routines for custom list generation.


REPOSITORY MANAGER :-
__________________

	The repository manager as the name itself states is a repository to store the customization data in the frontend.
This repository will be available with name "ARJspRep" in all the extended custom java beans and as well in 
all custom jsp files.

	The scope of the repository varies whenever the menu option is changed.

	The repository stores the data in the form of name-value pairs. The repository manager will have utility methods to store and retrieve the data from the repository. The prototype of these methods are given below.


	public void setVal(String name, Object value);
	public Object getVal(String name);

	The setVal method will set the value in the repository for the specified name. if the value is passed as null,
then the entry for the given name will be remvoed from the repository.
	
	The getVal method will return the value stored in the repository for the given name. It returns null, if the
entry is not available in the repository. Remember getVal returns a Object, hence do the casting for the appropriate type.

USAGE: 

	//To store a value in the RepositoryManager 

	String Value = "Test Data";
	ARJspRep.setVal("NAME",Value); 
				       
	//To fetch a value in the RepositoryManager 
	
	String retVal = '';
	retVal = ARJspRep.getVal("NAME"); 	//It will return "Test Data".
	System.out.println("retVal "+retVal);   //It prints "Test Data"

	retVal = ARJspRep.getVal("DUMMY");	//It will return null, since no such key present 
					  	//in the RepositoryManager.
	
	//To remove a key in the RepositoryManager
	ARJspRep.setVal("NAME",null);  	//It will remove the Key "NAME" from the RepositoryManager.
	
Referring of ARJspRep:
---------------------

	1. All extended custom beans can refer the repository manager directly with the name "ARJspRep".
	2. All included custom jsp files (Eg: <pagename>_custom.jsp), the repository manager will be available
		by putting the following code.

	<%@ taglib uri="custom.tld" prefix="custom" %>
	<custom:getRepository/>

	3. The repository manager will be available in all custom menu jsp files, by calling following code after 
		Refresh of the customBean Instance.

	<custom:getRepository/>

	Eg: 

	...
	...
	customBeanInst.Refresh(pageContext,ARJspCurr,ARJspRet);
	customBeanInst.populateFields(finbranch,PropertyBeanInst.getProperties(),
		ResourceBeanInst.getResourceBundle(pageContext,"finbranch"));
	customBeanInst.setPageName(sNextPage);
	%>
	
	<custom:getRepository/>

MULTI-REC FUCNTIONALITY :-
_______________________

	The multi-rec functionality can be implemented by using either custom beans or custom jsp files or both. 
In order to achieve this functionality, one should put multi-rec navigation and processing logic in either of the above said files according to his requirements. The user can make use of repository manager and sample utility methods provided in customFunctions.java which is shipped along with the application. The sample utility methods available in customFunctions.java can be modified according to the customer requirements. Anyhow, the details of the utility methods in customFucntions.java is explained briefly in this file below.

	Also, a sample implementation of the multi-rec functionality is shipped along with the application. The sample files are available in $RESIN_ROOT/webapps/finbranch/custom/samples/multi-rec/

CUSTOM TAB FUNCTIONALITY :-
________________________

	The customTab functionality can be achieved by making use of extended custom beans and reposmgr. The custom tabs can only be added to the already existing tabs.

To achieve this functionality, follow the below mentioned steps:

	1. Identify the parent group bean name for the menu option, where the customTab functionality needs to be implemented. 
	
	Eg: For HCUMM menu option, the parent group name is cumm.

	2. Write a extended bean for the parent bean by overriding the getNextPage method.

	Eg: For HCUMM menu option, the parent bean is cummBean.java, write a extended bean, say cummCustomBean.java.
	    Override getNextPage method in cummCustomBean.java.
	Note: For extending a bean, you need to put a entry in custom-map file. 

	3. Define a two-dimensional string array, in the extended bean, which specified the custom tab details. The details are explained below.

	Eg :

    	String[][] tabArr = {
                            {"CTAB_tab1","Custom Tab 1","N","1","2","N"},
                            {"CTAB_tab2","Custom Tab 2","Y","2","2","N"}
                        };

	Here, we are trying to add two tabs, Custom Tab 1 and Custom Tab 2. The meaning of each component in each array element is mentioned below.
	
		{"CTAB_tab1","Custom Tab 1","N","1","2","N"}

	        Element 0 = TAB NAME
        	Element 1 = TAB DESCRIPTION
	        Element 2 = CHECKBOX REQUIRED
	        Element 3 = HOT KEY
	        Element 4 = WHICH LINE, TAB NEEDS TO BE PUT.
	        Element 5 = CHECKBOX CHECKED

	One needs to put CTAB_ for TAB NAME as a standard for custom tabs.

	4. Set the above defined two-dimensional array into repmgr, in the following format, in getNextPage().

	        ARJspRep.setVal("<parent_group_name>_CTABARR", <array_name>);

	Eg: 

	        ARJspRep.setVal("cumm_CTABARR", tabArr);

	5. The processing logic needs to be handled in the getNextPage() of extended bean. The processing logic may include validations, forwarding to custom tabs if any custom tab is clicked, or calling the parent's getNextPage method.

	6. If the user clicks on custom tab, then the control goes to the extended parent group, with action as TAB NAME. Then in getNextPage(), make a call forwardToCustomGroup().

	The forwardToCustomGroup() method expects two parameters, Tab name and the bean name which needs to be loaded for handling of the Custom Tab details. The details of this method is explianed below with examples.

	Eg:

	public String getNextPage()
    	{
        	String actionCode = httpRequest.getParameter("submitform");
        	actionCode = (actionCode == null) ? "" : actionCode;

	        /*
        	    Set the Tab Array into Repository Manager.
	        */
        	ARJspRep.setVal("cumm_CTABARR", tabArr);

	        try
        	{
	            if (("CTAB_tab1").equals(actionCode))
        	    {
                	/*
	                    Coming here means, the user has clicked the Custom Tab 1.
        	            So, go to that Tab.

	                    Pass Tab Name and the Class name which needs to be loaded.
        	        */
                	return forwardToCustomGroup("CTAB_tab1", "com.infy.finbranch.groups.tab1Bean");
	            }
        	    else if (("CTAB_tab2").equals(actionCode))
	            {
        	        return forwardToCustomGroup("CTAB_tab2", "com.infy.finbranch.groups.tab2Bean");
	            }
        	}
	        catch(Exception e) {
        	    e.printStackTrace();
		    return error_page;
	        }

		.............
	}

	The bean name passed to the method, forwardToCustomGroup(), if the first tab is clicked, for eg. com.infy.finbranch.groups.tab1Bean, is a class file, which needs to be written by the customer, in package com.infy.finbranch.groups. This class must extend customBean class. The custom tab class files should consist of the getNextPage method, which consists of all processing logic related to custom tab pages.

	Eg :

	package com.infy.finbranch.groups;

	public class tab1Bean extends customBean
	{
	
		............
		
		public String getNextPage()
		{
			................
		}

		................
	}

	Whenever all the processing in the custom tab is through, one should call the method - returnToParent("/custom/custom_ctrl.jsp"). This will return from custom tab to the extended parent group for handling further actions.

	Eg :

	package com.infy.finbranch.groups;

	public class tab1Bean extends customBean
	{
	
		............
		
		public String getNextPage()
		{
			................
	
	        	if (!actionCode.equals("CTAB_tab1"))
			{
		            try
		            {
                		returnToParent("/custom/custom_ctrl.jsp");
		            }
		            catch(Exception e) {
                		e.printStackTrace();
				return error_page;
		            }
			}
		}
		.............
	}


	7. In Custom Jsp's, which are referred from custom tab beans, one should implement the Javsacript function fnValidateForm().


The sample implementation of custom tab is shipped along with the application. The sample files are avilable in the directory  <RESIN_ROOT>....../samples/customtab.


customFunctions.java:
--------------------

This file contains sample utility methods for handling multi-rec processings.

To implement the functionalities, place this file in the below specified path.

PATH : $RESIN_ROOT/webapps/finbranch/WEB-INF/classes/customUtil/

To implement the multi-rec processing the below specified sample format is used for
sending and receiving the data from the backend.


FORMAT:

"~<pagename>|staticFields|LLName|No. of Records|No. of Fields|LLvalues|"

where 	pagename 	= Name of the page
	staticFields	= If any static custom fields exist in the page.
	LLName		= Name of the Multi-Rec
	No. of Records	= Number of the records present in the multi-rec
	No. of Fields	= Number of fields existing for the multi-rec
	LLvalues	= Pipe seperated values of the multi-rec, the total
			  value length will be determined by the No. of Records 
			  and No. of Fields.

Ex:
	"~custper|STVAL1|STVAL2|SOLIDLIST|2|2|R1F1|R1F2|R2F1|R2F2|"

BATCH INVOCATION  :-
_____________________

	Batch Invocation is a functionality, through which user can invoke a batch job from anyONS Menu. This functionality can be achieved by calling the userhooks CallShellScript() and putEnvForCallShellScript() from a finacle script.The user needs to provide the requiredinformation for invoking a batch job, before calling the above mentioned userhooks.A sampleimplementation for invoking  DN menu has been shipped with the finbranch application in the below specified directory.

PATH : $RESIN_ROOT/webapps/finbranch/custom/samples/batchInvoke/
This folder contains a jsp file, a finacle script and a com script.

Steps to implement the sample code:

	1. Place the dn.jsp file in c:\resin <version>\webapps\finbranch\custom\ folder.

	2. Place the dn.com and dn.scr in cdci_logs\ directory.
   		( If an input file is being used to get account numbers, then place the input file
   	 	also in cdci_logs\ directory).

	3. DN can be invoked as a menu option by making appropriate entries in MOD table 
		and menulist.java .

	NOTE: 
		This functionality has been implemented using a custom menu. 
		The finacle script (dn.scr) name is passed as a hidden field and the com script 
		name is specified inside the finacle script. If the names of these two files are 
		changed care has to be taken to change the names in jsp and finacle script.

		The detailed explanation of these userhooks is given 
		Batch_Invocation_Infrastructure_in_ONS.doc in VSS. Path of the document is as 
		follows.

PATH : VSSFinacle/Finacle Ver7.0/Ideas-N-Issues/ICICI/Batch_Invocation_Infrastructure_in_ONS.doc


FILES LOCATION

These files need to be placed in the following directories

	custFetch files:
		1. custom_functions.js 		- ../finbranch/custom/javascripts
		2. cust_fetch_list.js		- ../finbranch/custom/javascripts
		3. cust_frm_fetch.jsp  		- ../finbranch/custom/jsp
		4. cust_dummy_frm_fetch.jsp	- ../finbranch/custom/jsp
		5. cust_fetch.jsp		- ../finbranch/custom/jsp
		6. cust_fetch_list.jsp		- ../finbranch/custom/jsp

	multirec files:

		1. cust_per_custom.jsp 		- ../finbranch/custom/jsp/
		2. custperBean_custom.java	- ../finbranch/WEB-INF/classes/com/infy/finbranch/groups/
		3. customFunctions.java		- ../finbranch/WEB-INF/classes/customUtil/

	customtab files:

		1. tab1det.jsp			- ../finbranch/custom/jsp/
		2. tab2det.jsp			- ../finbranch/custom/jsp/
		3. customtab.js			- ../finbranch/custom/javascripts
		4. cummCustomBean.java 		- ../finbranch/WEB-INF/classes/com/infy/finbranch/groups/
		5. tab1Bean.java		- ../finbranch/WEB-INF/classes/com/infy/finbranch/groups/
		6. tab2Bean.java		- ../finbranch/WEB-INF/classes/com/infy/finbranch/groups/

	batchInvoke files:

		1. dn.jsp				- ../finbranch/custom/
		2. dn.scr				- Place the file in CDCI directory
		3. dn.com				- Place the file in CDCI directory
	
DESCRIPTION OF FILES

	1. custom_functions.js:
	
	It defines generic functions used for customization purpose. They are as follows.
		
	a) cust_fnTrim()		- To the values passed
	b) cust_fnIsNull()		- To check the field values for NULL.
	c) fnExecuteScript()		- To execute a user defined backend script and to 
					  populate the parent screen with the values fetched 
					  from the backend. This function call can be called
					  from any event of the jsp page.
	d) fnExecuteScriptForList()	- To pop up a custom list screen on any event of the 
					  jsp page.
	
	2. cust_fetch_list.js:
	
	a) printHTML()			- This provides the basic template for the custom list table.
	b) showList()			- It populates the column and row values in the custom list.
	c) getReturnValues()	- It formats a pipe separeted string containing values of 
	all the columns for a selected row in the custom list.
	d) isHyperLink()		- To check whether hyperlink need to be set for the column.
	e) fnClose()			- To close the custom list window.
	g) fnSetValue()			- To return the selected record values to the parent window.
	f) showErrors()			- To pop up the error details in case of error.
	
		
	3. cust_frm_fetch.jsp:
	
	It is the base page for hidden frame mechanism implemented for making backend call 
through customBean. It specifies the frame for cust_dummy_frm_fetch.jsp and cust_fetch.jsp.
	
	4. cust_dummy_frm_fetch.jsp:
	
	This file shows the processing bar display in the modal window, when the cust_fetch.jsp fetches the data from the backend.
	
	5. cust_fetch.jsp:
	
	This file calls the executeScript method of the customBean to execute the backend 
script, and returns back the pipe (|) separated values back to the parent page.
	
	6. cust_fetch_list.jsp:
	
	This file implements the executeScript method of the customBean and pop's up a custom 
list, this file returns the field value selected in the custom List.

	7. customFunctions.java:
	a) getListFromCustData()
		prototype    - public static HashMap getListFromCustData(String llName, String customData)
		descripttion - To convert multi-rec data in customData string to a HashMap.
	b) fetchRecFromRequest()
		prototype    - public static String fetchRecFromRequest(HttpServletRequest httpRequest, String[] fieldArray)
		descripttion - To fetch the field values for the passed field Id, and returns a pipe seperated string.
	c) ProcessMultiRec()
		prototype    - public static void ProcessMultiRec(RepositoryManager ARJspRep, 
				HttpServletRequest httpRequest, String llName, 
				String[] fieldArray) throws Exception
		descripttion - Process the custom multi-rec data, It updates the current record 
				and current record number in the Repository Manager, Calling method
				need to catch the exception.
	d) formatHashMapToStr()
		prototype    - public static String formatHashMapToStr(HashMap hm,String llName,int fieldLen)
		descripttion - To convert a HashMap to a pipe seperated string containing 
				llName,total number of records and total number of fields.
	e) SerializeMultiRec()
		prototype    - public static String SerializeMultiRec(HashMap hm, String llName, 
				String pageName, String custData, int fieldLen)
		descripttion - Serialize's the passed hashmap data for the given llName and updates 
				the same in the passed customData by altering the llName contents alone.
	f) split()
		prototype    - public static String[] split(String sStr, String sdelim)
		descripttion - To convert a delimiter seperated string into a array.

NOTE: 	1. See the custmis_details_custom.jsp(customization file for mis details of HCUMM) for 
	the above features sample implementation.
	2. See the cust_per_custom.jsp(customization file for personal details of HCUMM) for 
	the above features sample implementation.

