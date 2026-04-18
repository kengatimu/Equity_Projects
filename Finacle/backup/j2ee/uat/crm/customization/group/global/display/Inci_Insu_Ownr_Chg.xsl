<?xml version="1.0"?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <!--impoting variables wich hold the jvm properties-->
     <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>

<!-- importing xml files InciDDReq.xml -->
     <xsl:variable name="configFile" select="document(concat('../Renderer/customization/resource/Inci_Insu_Ownr_Chg.xml', ''))"/>	
     <xsl:variable name="configLabels" select="$configFile/SRMBO/*"/>
     

     <xsl:variable name="allfields" select="//SRMData//Z"/>
     <xsl:variable name="requestURL" select="//SRMData//Z[@n='RequestBO.url_']"></xsl:variable>
     <xsl:variable name="concurDetectX" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RequestBO.ConcurDetect_X']"></xsl:variable>
     <xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGenKey']"></xsl:variable>
     
    <xsl:variable name="SRMTips" select="$configLabels[@name='Tips']/@value"/>
	<xsl:variable name="CustomFields" select="/SRM/SRMData[@SRMDataSpace='CustomData']"/>
	<xsl:variable name="readMode" select="$CustomFields/Z[@n='IsReadOnly']"/>
	<xsl:variable name="Mode" select="$CustomFields/Z[@n='mode']"/>
    <xsl:param name="locale"/>
	<xsl:template match="/">

    <html>

	<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>

    <head>
		<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
		<script>var locale = '<xsl:value-of select="$locale"/>';</script>
<!--404 changes-->
<!--		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup.css"/>-->
<!--		<link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu.css"/>-->
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay.css"/>-->
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate.css"/>-->
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/MultiTabs.css"/>-->

    </head>

        <script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
        <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
        <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
        <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        <script type="text/javascript" src="../Renderer/wizards/html/ShowButtons.html"></script>

    <body  class="popup" bottommargin="0" topmargin="0" style="padding-top=10px; padding-left=5px; padding-right=5px" onload="populateEntity()">		
		
		<xsl:choose>
	    <xsl:when test="normalize-space($readMode)='Y'">
	    <xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');</xsl:attribute>
	    </xsl:when>
        </xsl:choose>  
         
        <script type="text/javascript" language="javascript">

	
		var readonly_var = "<xsl:value-of select ='$isReadOnly' />";
        var mode="<xsl:value-of select ='$Mode' />";

/* Function to change Owner Name if Update Flag is Y */

	function ChangeOwner()
	{
		
		<![CDATA[
		for(var i=0; i<3; i ++)
		{
			
			var nameUpd = document.getElementsByName('NameUpdate')[i].value;
			if (nameUpd == "Y")
			{
				document.getElementsByName('FirstName')[i].IsMandatory = "true";
				document.getElementsByName('LastName')[i].IsMandatory = "true";
				document.getElementsByName('NameTitle')[i].IsMandatory = "true";
				document.getElementsByName('3_StartDate')[i].IsMandatory = "true";
				
			}
		}
		]]>
	}
/*end**/


/*Function to Validate values*/				  

	function validateForm()
	{
		retStat = parent.parent.parent.parent.parent.parent.parent.parent.ValidateFormContents(document.frm2,true);
		return retStat;
	}

/*end**/	


                
/*Save Template Function**/

	function save(incidentID) 
    {	
		setHiddenvalue();
       	try{	
			
			if(readonly_var!="Y")
			{
				if(mode=="Edit")
				{
					document.frm2.action = "../servlet/com.infy.cis.ui.support.RequestWriter?mode=Edit&amp;incidentid=" + incidentID;
				}
				else
				{
					document.frm2.action = "../servlet/com.infy.cis.ui.support.RequestWriter?mode=New&amp;incidentid=" + incidentID;
				}
				document.frm2.target="inciSaveFrame";
				document.frm2.submit();
				return "true";
			}
		}catch(e){alert(e.message);}
	}

/*end**/

/*Set one-to-many values Function**/

				function setHiddenvalue()
				{
										
					
					var addCounter=0;
					var type;

					<![CDATA[
					for(var i=0; i<3; i ++)
					{
						var nameUpd = document.getElementsByName('NameUpdate')[i].value;
						var nameTit = document.getElementsByName('NameTitle')[i].value;
						var firstname =document.getElementsByName('FirstName')[i].value;
						var middlename = document.getElementsByName('MiddleName')[i].value;
						var lastname =document.getElementsByName('LastName')[i].value;
						var sdate =document.getElementsByName('3_StartDate')[i].value;

						if (nameUpd=="Y")
						{
							type = getType(i);
							alert(type);
							if(addCounter==0)
							{
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value=nameUpd;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField2')[0].value=firstname;	
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField3')[0].value=middlename;						
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField4')[0].value=lastname;	
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField5')[0].value=nameTit;
								document.getElementsByName('RequestBO.RequestGenInfo.userDateField1')[0].value=sdate;
								document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value=type;
								addCounter=1;
							}
							else
							{
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value+"$"+nameUpd;	
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField2')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField2')[0].value+"$"+firstname;							
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField3')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField3')[0].value+"$"+middlename;							
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField4')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField4')[0].value+"$"+lastname;							
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField5')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField5')[0].value+"$"+nameTit;
								document.getElementsByName('RequestBO.RequestGenInfo.userDateField1')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userDateField1')[0].value+"$"+sdate;								
								document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value+"$"+type;
								addCounter=addCounter+1;
							}
						}
					}
					]]>

					
					document.getElementsByName('listSize')[0].value=addCounter;
				}

/*end**/

/*Return TYPE Function**/

		function getType(count)
		{
			<![CDATA[
			if(count < 3)
			{
				return "OWNER";
			}
			]]>

		}

/*end**/

/*Populate A/c No Function**/

		function populateEntity()
		{
		try {

		var iCount = 0;
		var type1;
		var nameTit;
		var nameUpd;
		var firstname;
		var middlename;
		var lastname;
		var sdate;

		<![CDATA[
		for(var i=0; i<3; i ++)
		{
			document.getElementsByName('NameUpdate')[i].value="";
			document.getElementsByName('FirstName')[i].value="";
			document.getElementsByName('MiddleName')[i].value="";
			document.getElementsByName('LastName')[i].value="";
			document.getElementsByName('NameTitle')[i].value="";
			document.getElementsByName('3_StartDate')[i].value="";
		}
		]]>

		'<xsl:for-each select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n='RecordSet']/SRMRow">'

			type1		= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.requestInfoType']"/>';
			nameUpd		= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField1']"/>';
			firstname	= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField2']"/>';
			middlename	= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField3']"/>';
			lastname	= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField4']"/>';
			nameTit		= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField5']"/>';
			sdate		= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userDateField1']"/>';
			<![CDATA[	
			if (type1=="OWNER")
			{
				alert("O" + iCount);
				document.getElementsByName('NameUpdate')[iCount].options.value=nameUpd;
				document.getElementsByName('FirstName')[iCount].value=firstname;
				document.getElementsByName('MiddleName')[iCount].value=middlename;
				document.getElementsByName('LastName')[iCount].value=lastname;
				document.getElementsByName('NameTitle')[iCount].options.value=nameTit;
				document.getElementsByName('3_StartDate')[i].value=sdate;

				iCount=iCount+1;	
			}

			]]>
		'</xsl:for-each>'

		}
		catch(e)
		{
		alert('inside populateAddr'+e.message);
		}
		}

		/*end**/


</script>

                 <!--javascript ends here-->


                 <table width="100%" border="0" cellpadding="0" cellspacing="0" vspace="0" hspace="0">
                     <xsl:apply-templates select="SRM"/>
                 </table>



      </body>
      </html>
      </xsl:template>

<xsl:attribute-set name="cellstyle1">
	  <xsl:attribute name="font-family">Times New Roman</xsl:attribute>
	  <xsl:attribute name="align">center</xsl:attribute>
	  <xsl:attribute name="colspan">7</xsl:attribute>
	  <xsl:attribute name="class">header</xsl:attribute>
</xsl:attribute-set>

<xsl:template name="apply1">
	<xsl:param name="apply_head">blank</xsl:param>
		<td xsl:use-attribute-sets="cellstyle1">
	        <xsl:value-of select="$apply_head"/>
	        </td>
</xsl:template>

<!--template for Form Mode Delivery -->
	<xsl:template name="RequestBO.userStrField1">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField1']"/>
	<xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="selectdisp">RequestBO.userStrField1</xsl:with-param>
	<xsl:with-param name="selectname">RequestBO.userStrField1</xsl:with-param> 
	</xsl:call-template>
	</xsl:template>

<!--template for Form Received Confirmation Mode -->
	<xsl:template name="RequestBO.userStrField2">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField2']"/>
	<xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="selectdisp">RequestBO.userStrField2</xsl:with-param>
	<xsl:with-param name="selectname">RequestBO.userStrField2</xsl:with-param> 
	</xsl:call-template>
	</xsl:template>

<!--template for Form Despatch Details -->	         
	<xsl:template name="RequestBO.userStrField3">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField3']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField3</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField3</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Form Received Details -->
	<xsl:template name="RequestBO.userStrField4">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField4']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField4</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField4</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Docs sent to HO Details -->
	<xsl:template name="RequestBO.userStrField5">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField5']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField5</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField5</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Docs Received at HO Details -->
	<xsl:template name="RequestBO.userStrField6">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField6']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField6</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField6</xsl:with-param>
	</xsl:call-template>
	</xsl:template>


<!--template for Docs sent to branch Details -->
	<xsl:template name="RequestBO.userStrField9">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField9']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField9</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField9</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Docs recd at branch details -->
	<xsl:template name="RequestBO.userStrField10">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField10']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField10</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField10</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Request confirmation to Customer details -->
	<xsl:template name="RequestBO.userStrField11">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField11']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField11</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField11</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Document Flag -->
	<xsl:template name="RequestBO.userStrField12">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField12']"/>
	<xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="selectdisp">RequestBO.userStrField12</xsl:with-param>
	<xsl:with-param name="selectname">RequestBO.userStrField12</xsl:with-param> 
	</xsl:call-template>
	</xsl:template>

 
<!--template for Default Mailing Address1 -->
	<xsl:template name="RequestBO.userStrField23">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField23']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField23</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField23</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

	
<!--template for Default Mailing Address2 -->
	<xsl:template name="RequestBO.userStrField24">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField24']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField24</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField24</xsl:with-param>
	</xsl:call-template>
	</xsl:template>


<!--template for Default Mailing Address3 -->
	<xsl:template name="RequestBO.userStrField25">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField25']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField25</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField25</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for City -->
	<xsl:template name="RequestBO.userStrField26">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField26']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField26</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField26</xsl:with-param>
	</xsl:call-template>
	</xsl:template>


<!--template for State -->
	<xsl:template name="RequestBO.userStrField27">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField27']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField27</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField27</xsl:with-param>
	</xsl:call-template>
	</xsl:template>


<!--template for Zip -->
	<xsl:template name="RequestBO.userStrField28">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField28']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField28</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField28</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Country -->
	<xsl:template name="RequestBO.userStrField29">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField29']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField29</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField29</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Special Instruction to Despatch -->
	<xsl:template name="RequestBO.userTextField1">
    <xsl:call-template name="mtextarea">
    <xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userTextField1']"/>
    <xsl:with-param name="mname">RequestBO.userTextField1</xsl:with-param>
    <xsl:with-param name="mvalue">RequestBO.userTextField1</xsl:with-param>
    <xsl:with-param name="mwrap">on</xsl:with-param>
    <xsl:with-param name="mrows">3</xsl:with-param>
    <xsl:with-param name="mcols">60</xsl:with-param>
    <xsl:with-param name="mcolspan">5</xsl:with-param>
    </xsl:call-template>
    </xsl:template>

<!--template for Confirmation Collection Details -->
	<xsl:template name="RequestBO.userTextField2">
    <xsl:call-template name="mtextarea">
    <xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userTextField2']"/>
    <xsl:with-param name="mname">RequestBO.userTextField2</xsl:with-param>
    <xsl:with-param name="mvalue">RequestBO.userTextField2</xsl:with-param>
    <xsl:with-param name="mwrap">on</xsl:with-param>
    <xsl:with-param name="mrows">3</xsl:with-param>
    <xsl:with-param name="mcols">60</xsl:with-param>
    <xsl:with-param name="mcolspan">5</xsl:with-param>
    </xsl:call-template>
    </xsl:template>
   
 

<!--template for Update Flag -->
	<xsl:template name="NameUpdate">
	<xsl:param name="selectname"/>
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField1']"/>
	<xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="selectdisp">NameUpdate</xsl:with-param>
	<xsl:with-param name="selectname"><xsl:value-of select ="$selectname"/></xsl:with-param>
	
	</xsl:call-template>
	</xsl:template>

<!--template for Owner First Name -->
	<xsl:template name="FirstName">
	<xsl:param name="ele_name"/>
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField2']"/>
	<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField2</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Owner Middle Name -->
	<xsl:template name="MiddleName">
	<xsl:param name="ele_name"/>
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField3']"/>
	<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField3</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Owner Last Name -->
	<xsl:template name="LastName">
	<xsl:param name="ele_name"/>
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField4']"/>
	<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField4</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Title -->
	<xsl:template name="NameTitle">
	<xsl:param name="selectname"/>
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField5']"/>
	<xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="selectdisp">RequestBO.RequestGenInfo.userStrField5</xsl:with-param>
	<xsl:with-param name="selectname"><xsl:value-of select ="$selectname"/></xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Start Date -->
	<xsl:template name="StartDate">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userDateField1']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userDateField1</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--test end -->

	<xsl:template match="*" mode="mode1">
	<xsl:call-template name="Begin"/>

	    

<td>
		<form name="frm2" method="post">

		<input type="hidden" name="hid_requestURL" value="{$requestURL}"/>
		<input type="hidden" name="hid_concurDetectX" value="{$concurDetectX}"/>
		<input type="hidden" value="{$isAutoGenKey}" name="isAutoGenKey"/>
		
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.requestInfoType"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField1"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField2"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField3"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField4"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField5"/>
		<input type="hidden" value="" name="listSize"/>
				
<table width="100%" bgcolor='E5E5E5' cellspacing="0" vspace="0" hspace="0" border="0">


<xsl:call-template name="BeginTabView">
	<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
	<xsl:with-param name="tabPageHeight">100</xsl:with-param>
	<xsl:with-param name="colSpan">20</xsl:with-param>
</xsl:call-template>

		<xsl:call-template name="BeginTabPage">
			<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
			<xsl:with-param name="tabPageName">tpageDespatchDetails</xsl:with-param>
			<xsl:with-param name="tabPageDisplayNameRes" select="'Despatch Details'"/>
			<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
			<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
		</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField1"/>
	<xsl:call-template name="RequestBO.userStrField3"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
    <xsl:call-template name="RequestBO.userStrField23"/>
	<xsl:call-template name="RequestBO.userStrField24"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField25"/>
	<xsl:call-template name="RequestBO.userStrField26"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField27"/>
	<xsl:call-template name="RequestBO.userStrField28"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField29"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userTextField1"/>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
		<xsl:with-param name="drawLine">true</xsl:with-param>
		<xsl:with-param name="lineColor">gray</xsl:with-param>
		<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField2"/>
	<xsl:call-template name="RequestBO.userStrField4"/>
<xsl:call-template name="End"/>

<xsl:call-template name="EndTabPage"/>

			<xsl:call-template name="BeginTabPage">
					<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
					<xsl:with-param name="tabPageName">tpageHODetails</xsl:with-param>
					<xsl:with-param name="tabPageDisplayNameRes" select="'HO Details'"/>
					<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
					<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
			</xsl:call-template>


<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField5"/>
	<xsl:call-template name="RequestBO.userStrField6"/>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
		<xsl:with-param name="drawLine">true</xsl:with-param>
		<xsl:with-param name="lineColor">gray</xsl:with-param>
		<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField9"/>
	<xsl:call-template name="RequestBO.userStrField10"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField11"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userTextField2"/>
<xsl:call-template name="End"/>


<xsl:call-template name="EndTabPage"/>

<xsl:call-template name="BeginTabPage">
		<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
		<xsl:with-param name="tabPageName">tpageOwnChangeDetails</xsl:with-param>
		<xsl:with-param name="tabPageDisplayNameRes" select="'Owner Details'"/>
		<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
		<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
</xsl:call-template>


<xsl:call-template name="Begin"/>
	<xsl:call-template name="NameTitle">
	<xsl:with-param name="selectname">NameTitle</xsl:with-param>
	</xsl:call-template>				
	<xsl:call-template name="FirstName">
	<xsl:with-param name="ele_name">FirstName</xsl:with-param>
	</xsl:call-template>				
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="MiddleName">
	<xsl:with-param name="ele_name">MiddleName</xsl:with-param>
	</xsl:call-template>				
	<xsl:call-template name="LastName">
	<xsl:with-param name="ele_name">LastName</xsl:with-param>
	</xsl:call-template>				
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="NameUpdate">
	<xsl:with-param name="selectname">NameUpdate</xsl:with-param>
	</xsl:call-template>				
	<xsl:call-template name="StartDate">
	<xsl:with-param name="ele_name">StartDate</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
		<xsl:with-param name="drawLine">true</xsl:with-param>
		<xsl:with-param name="lineColor">gray</xsl:with-param>
		<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="NameTitle">
	<xsl:with-param name="selectname">NameTitle</xsl:with-param>
	</xsl:call-template>				
	<xsl:call-template name="FirstName">
	<xsl:with-param name="ele_name">FirstName</xsl:with-param>
	</xsl:call-template>				
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="MiddleName">
	<xsl:with-param name="ele_name">MiddleName</xsl:with-param>
	</xsl:call-template>				
	<xsl:call-template name="LastName">
	<xsl:with-param name="ele_name">LastName</xsl:with-param>
	</xsl:call-template>				
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="NameUpdate">
	<xsl:with-param name="selectname">NameUpdate</xsl:with-param>
	</xsl:call-template>				
	<xsl:call-template name="StartDate">
	<xsl:with-param name="ele_name">StartDate</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
		<xsl:with-param name="drawLine">true</xsl:with-param>
		<xsl:with-param name="lineColor">gray</xsl:with-param>
		<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="NameTitle">
	<xsl:with-param name="selectname">NameTitle</xsl:with-param>
	</xsl:call-template>				
	<xsl:call-template name="FirstName">
	<xsl:with-param name="ele_name">FirstName</xsl:with-param>
	</xsl:call-template>				
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="MiddleName">
	<xsl:with-param name="ele_name">MiddleName</xsl:with-param>
	</xsl:call-template>				
	<xsl:call-template name="LastName">
	<xsl:with-param name="ele_name">LastName</xsl:with-param>
	</xsl:call-template>				
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="NameUpdate">
	<xsl:with-param name="selectname">NameUpdate</xsl:with-param>
	</xsl:call-template>				
	<xsl:call-template name="StartDate">
	<xsl:with-param name="ele_name">StartDate</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="EndTabPage"/>


<xsl:call-template name="EndTabView">
	<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
	<xsl:with-param name="selectedTabPageName">tpageDespatchDetails</xsl:with-param>
</xsl:call-template>



	</table>
       </form>
      </td>
      <xsl:call-template name="End"/>

       </xsl:template>
        <xsl:template match="SRM">
        <xsl:for-each select=".">
             <xsl:call-template name="startTable"/>
                <table bgcolor='E5E5E5' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
                   <tr>
                     <xsl:call-template name="apply">
                     <xsl:with-param name="apply_head">
                     <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                     </xsl:with-param>
                     </xsl:call-template>
                 </tr>
              </table>

                <table bgcolor='E5E5E5' width="100%" border="0" cellspacing="0" cellpadding="2">
                  <xsl:apply-templates select="." mode="mode1"/>
                </table>
             <xsl:call-template name="endTable"/>
         </xsl:for-each>
        </xsl:template>

</xsl:stylesheet>
