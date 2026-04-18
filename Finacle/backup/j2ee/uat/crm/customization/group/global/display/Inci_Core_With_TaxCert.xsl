<?xml version="1.0"?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <!--impoting variables wich hold the jvm properties-->
     <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>

<!-- importing xml files InciDDReq.xml -->
     <xsl:variable name="configFile" select="document(concat('../Renderer/customization/resource/Inci_Core_With_TaxCert.xml', ''))"/>	
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
<!-- 404 changes -->
<!--		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup.css"/> -->
<!--		<link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu.css"/> -->
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay.css"/> -->
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate.css"/> -->
	 <link rel="stylesheet" type="text/css" href="../Branding/css/common/MultiTabs.css"/>	

    <script type="text/javascript" language="javascript">



    </script>

    </head>

	<body  class="popup" bottommargin="0" topmargin="0" style="padding-top=10px; padding-left=5px; padding-right=5px" onload="populateAcNo()" >


        <script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
        <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
        <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
        <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        <script type="text/javascript" src="../Renderer/wizards/html/ShowButtons.html"></script>

        <xsl:choose>
		<xsl:when test="normalize-space($readMode)='Y'">
	    <xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');</xsl:attribute>
	    </xsl:when>
        </xsl:choose>  

        <script type="text/javascript" language="javascript">

			var readonly_var = "<xsl:value-of select ='$isReadOnly' />";
            var mode="<xsl:value-of select ='$Mode' />";

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
		var anyAC = setHiddenvalue();
		if (anyAC == "TRUE")
		{
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
		else
		{
			alert("Atleast one A/c No should be added");
		}
	}

/* Function to change Address Details if Update Flag is Y */

	function ChangeAc()
	{
		<![CDATA[
		for(var i = 0; i < 5; i ++)
		{
			
			var addrUpd = document.getElementsByName('AcUpdate')[i].value;
			if (addrUpd == "Y")
			{
				document.getElementsByName('AccountNo')[i].IsMandatory = "true";
				document.getElementsByName('3_FromDate')[i].IsMandatory = "true";
				document.getElementsByName('3_ToDate')[i].IsMandatory = "true";
		
			}
			else
			{
				document.getElementsByName('AccountNo')[i].IsMandatory = "false";
				document.getElementsByName('3_FromDate')[i].IsMandatory = "false";
				document.getElementsByName('3_ToDate')[i].IsMandatory = "false";
			}
		}
		]]>
	}
/*end**/


/*end**/
/*Set one-to-many values Function**/

			function setHiddenvalue()
			{
				var addCounter=0;
				var type="ACCOUNTNO";
				<![CDATA[
				for(var i=0; i<5; i ++)
				{
					var acnum = document.getElementsByName('AccountNo')[i].value;
					var addrUpd = document.getElementsByName('AcUpdate')[i].value;
					var sDate	= document.getElementsByName('3_FromDate')[i].value;
					var eDate	= document.getElementsByName('3_ToDate')[i].value;

					if (addrUpd=="Y")
					{
						if(addCounter==0)
						{
							document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value=acnum;
							document.getElementsByName('RequestBO.RequestGenInfo.userStrField2')[0].value=addrUpd;

							document.getElementsByName('RequestBO.RequestGenInfo.userDateField1')[0].value=sDate;
							
							document.getElementsByName('RequestBO.RequestGenInfo.userDateField2')[0].value=eDate;
							
							document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value=type;
							
							addCounter=1;
						}
						else
						{
							document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value+"$"+acnum;
							document.getElementsByName('RequestBO.RequestGenInfo.userStrField2')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField2')[0].value+"$"+addrUpd;

							document.getElementsByName('RequestBO.RequestGenInfo.userDateField1')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userDateField1')[0].value+"$"+sDate;							
							document.getElementsByName('RequestBO.RequestGenInfo.userDateField2')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userDateField2')[0].value+"$"+eDate;							
							document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value+"$"+type;

							addCounter=addCounter+1;
						}

					}
				}
				]]>
				
				document.getElementsByName('listSize')[0].value=addCounter;
				if (addCounter == 0)
				{
					return "FALSE";
				}
				else
				{
					return "TRUE";
				}

			}

/*end**/
/*Populate A/c No Function**/

				function populateAcNo()
				{

					try {

						var iCount = 0;
						var AccountNo;
						var AcUpd;
						var sdate;
						var edate;

						var tempnum;
						<![CDATA[
						for(var i=0; i<5; i++)
						{
							document.getElementsByName('AccountNo')[i].value="";
							document.getElementsByName('AcUpdate')[i].value="";
							document.getElementsByName('3_FromDate')[i].value="";
							document.getElementsByName('3_ToDate')[i].value="";
						}
						]]>

						
						'<xsl:for-each select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n='RecordSet']/SRMRow">'

						AccountNo	= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField1']"/>';

						AcUpd		= '<xsl:value-of 
						select="./Z[@n='RequestBO.RequestGenInfo.userStrField2']"/>';
						
						sdate						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userDateField1']"/>';
						
						edate						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userDateField2']"/>';
						
						document.getElementsByName("AcUpdate")[iCount].options.value=AcUpd;
						
						if(AcUpd == "Y")
						{
							ChangeAc();		
							
						}
						document.getElementsByName("AccountNo")[iCount].value=AccountNo;
						document.getElementsByName('3_FromDate')[iCount].value=sdate;
						document.getElementsByName('3_ToDate')[iCount].value=edate;
						
						iCount=iCount+1;
						

						'</xsl:for-each>'
					}
					catch(e)
					{
						alert('inside populateAcNo '+e.message);
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

<!--template for Mode of Delivery  -->
	<xsl:template name="RequestBO.userStrField3">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField3']"/>
	<xsl:with-param name="search_type">RequestBO.userStrField3</xsl:with-param>
	<xsl:with-param name="selectdisp">RequestBO.userStrField3</xsl:with-param>
	<xsl:with-param name="selectname">RequestBO.userStrField3</xsl:with-param>
	</xsl:call-template>
	</xsl:template>


<!--template for Address Line 1 -->
	<xsl:template name="RequestBO.userStrField23">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField23']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField23</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField23</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Address Line 2 -->
	<xsl:template name="RequestBO.userStrField24">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField24']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField24</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField24</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Address Line 3 -->
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

<!--template for Country -->
	<xsl:template name="RequestBO.userStrField28">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField28']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField28</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField28</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Zip -->
	<xsl:template name="RequestBO.userStrField29">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField29']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField29</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField29</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Despatch Details -->
	<xsl:template name="RequestBO.userTextField1">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userTextField1']"/>
	<xsl:with-param name="ele_name">RequestBO.userTextField1</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userTextField1</xsl:with-param>
	</xsl:call-template>
	</xsl:template>
	
<!--template for Account No -->
	<xsl:template name="AccountNo">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField1']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField1</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	

<!--template for AcUpdate -->
	<xsl:template name="AcUpdate">
		<xsl:param name="selectname"/>
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField2']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">AcUpdate</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select ="$selectname"/></xsl:with-param> 
		<xsl:with-param name="onchangefn">ChangeAc()</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--template for From Date -->
	<xsl:template name="FromDate">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userDateField1']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userDateField1</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--template for To Date -->
	<xsl:template name="ToDate">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userDateField2']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userDateField2</xsl:with-param>
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
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userDateField1"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userDateField2"/>
		<input type="hidden" value="" name="listSize"/>
	       
<table width="100%" bgcolor='E5E5E5' cellspacing="0" vspace="0" hspace="0" border="0">


<xsl:call-template name="BeginTabView">
	<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
	<xsl:with-param name="tabPageHeight">100</xsl:with-param>
	<xsl:with-param name="colSpan">20</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="BeginTabPage">
	<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
	<xsl:with-param name="tabPageName">tpageCertificateDetails</xsl:with-param>
	<xsl:with-param name="tabPageDisplayNameRes" select="'Certificate Details'"/>
	<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
	<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField3"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
	<xsl:with-param name="drawLine">true</xsl:with-param>
	<xsl:with-param name="lineColor">gray</xsl:with-param>
	<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountNo">
	<xsl:with-param name="ele_name">AccountNo</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="AcUpdate">
	<xsl:with-param name="selectname">AcUpdate</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="FromDate">
	<xsl:with-param name="ele_name">FromDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="ToDate">
	<xsl:with-param name="ele_name">ToDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
	<xsl:with-param name="drawLine">true</xsl:with-param>
	<xsl:with-param name="lineColor">gray</xsl:with-param>
	<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountNo">
	<xsl:with-param name="ele_name">AccountNo</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="AcUpdate">
	<xsl:with-param name="selectname">AcUpdate</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="FromDate">
	<xsl:with-param name="ele_name">FromDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="ToDate">
	<xsl:with-param name="ele_name">ToDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
	<xsl:with-param name="drawLine">true</xsl:with-param>
	<xsl:with-param name="lineColor">gray</xsl:with-param>
	<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountNo">
	<xsl:with-param name="ele_name">AccountNo</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="AcUpdate">
	<xsl:with-param name="selectname">AcUpdate</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="FromDate">
	<xsl:with-param name="ele_name">FromDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="ToDate">
	<xsl:with-param name="ele_name">ToDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
	<xsl:with-param name="drawLine">true</xsl:with-param>
	<xsl:with-param name="lineColor">gray</xsl:with-param>
	<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountNo">
	<xsl:with-param name="ele_name">AccountNo</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="AcUpdate">
	<xsl:with-param name="selectname">AcUpdate</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="FromDate">
	<xsl:with-param name="ele_name">FromDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="ToDate">
	<xsl:with-param name="ele_name">ToDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
	<xsl:with-param name="drawLine">true</xsl:with-param>
	<xsl:with-param name="lineColor">gray</xsl:with-param>
	<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountNo">
	<xsl:with-param name="ele_name">AccountNo</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="AcUpdate">
	<xsl:with-param name="selectname">AcUpdate</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="FromDate">
	<xsl:with-param name="ele_name">FromDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="ToDate">
	<xsl:with-param name="ele_name">ToDate</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>
	
<xsl:call-template name="EndTabPage"/>

<xsl:call-template name="BeginTabPage">
	<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
	<xsl:with-param name="tabPageName">tpageDispatchDetails</xsl:with-param>
	<xsl:with-param name="tabPageDisplayNameRes" select="'Dispatch Details'"/>
	<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
	<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
</xsl:call-template>

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
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>
	
<xsl:call-template name="EndTabPage"/>

<xsl:call-template name="EndTabView">
	<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
	<xsl:with-param name="selectedTabPageName">tpageCertificateDetails</xsl:with-param>
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
