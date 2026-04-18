<?xml version="1.0"?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <!--impoting variables wich hold the jvm properties-->
     <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>

<!-- importing xml files InciDDReq.xml -->
     <xsl:variable name="configFile" select="document(concat('../Renderer/customization/resource/Inci_EdGa_Dup_Stmt.xml', ''))"/>	
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
<!--		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup.css"/> -->
<!--		<link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu.css"/> -->
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay.css"/> -->
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate.css"/> -->

		<script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
		<script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
		<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
		<script type="text/javascript" src="../common/js/PopupMenu.js"></script>
		<script type="text/javascript" src="../Renderer/wizards/html/ShowButtons.html"></script>


     </head>

    <body  class="popup" bottommargin="0" topmargin="0" style="padding-top=10px; padding-left=5px; padding-right=5px">
			
      



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
					var type="ACCOUNTNO";
					<![CDATA[
					for(var i=0; i<4; i ++)
					{
						var acnum = document.getElementsByName('AccountNo')[i].value;
						if (acnum!="")
						{
							if(addCounter==0)
							{
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value=acnum;
								document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value=type;
								addCounter=1;
							}
							else
							{
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value+"$"+acnum;
								document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value+"$"+type;
								addCounter=addCounter+1;
							}
						}
					}
					]]>

					document.getElementsByName('listSize')[0].value=addCounter;

				}

/*end**/

/*Populate A/c No Function**/

				function populateAcNo()
				{
					try {

						var iCount = 0;
						var AccountNo;
						var tempnum;
						<![CDATA[
						for(var i=0; i<4; i ++)
						{
							document.getElementsByName('AccountNo')[i].value="";
						}
						]]>

						'<xsl:for-each select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n='RecordSet']/SRMRow">'

						AccountNo					= document.getElementsByName("AccountNo")[iCount];
						tempnum						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField1']"/>';
						AccountNo.value 			= tempnum;
						iCount=iCount+1;

						'</xsl:for-each>'
					}
					catch(e)
					{
						alert('inside populateAcNo'+e.message);
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


<!--template for Authentication Result -->
	<xsl:template name="RequestBO.userStrField7">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField7']"/>
	<xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="selectdisp">RequestBO.userStrField7</xsl:with-param>
	<xsl:with-param name="selectname">RequestBO.userStrField7</xsl:with-param> 
	</xsl:call-template>
	</xsl:template>

<!--template for Auth Decision Details -->
	<xsl:template name="RequestBO.userStrField8">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField8']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField8</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField8</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Request Confirmation to Customer Details -->
	<xsl:template name="RequestBO.userStrField9">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField9']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField9</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField9</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Documents sent to EdGa details -->
	<xsl:template name="RequestBO.userStrField10">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField10']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField10</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField10</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Mode of Delivery -->
	<xsl:template name="RequestBO.userStrField11">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField11']"/>
	<xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="selectdisp">RequestBO.userStrField11</xsl:with-param>
	<xsl:with-param name="selectname">RequestBO.userStrField11</xsl:with-param> 
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

<!--template for From Date -->
	<xsl:template name="RequestBO.userDateField1">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userDateField1']"/>
	<xsl:with-param name="ele_name">RequestBO.userDateField1</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userDateField1</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for To Date -->
	<xsl:template name="RequestBO.userDateField2">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userDateField2']"/>
	<xsl:with-param name="ele_name">RequestBO.userDateField2</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userDateField2</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Value of Transaction -->
	<xsl:template name="RequestBO.userAmountField1">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userAmountField1']"/>
	<xsl:with-param name="ele_name">RequestBO.userAmountField1</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userAmountField1</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Special Instructions for Despatch -->
	<xsl:template name="RequestBO.userTextField1">
	<xsl:call-template name="mtextarea">
        <xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userTextField1']"/>
	<xsl:with-param name="ele_name">RequestBO.userTextField1</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userTextField1</xsl:with-param>
	<xsl:with-param name="mrows">4</xsl:with-param>
        <xsl:with-param name="mcols">60</xsl:with-param>
        <xsl:with-param name="mcolspan">4</xsl:with-param>    
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
		<input type="hidden" value="" name="listSize"/>

<table width="100%" bgcolor='E5E5E5' cellspacing="0" vspace="0" hspace="0" border="0">

<xsl:call-template name="BeginTabView">
	<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
	<xsl:with-param name="tabPageHeight">100</xsl:with-param>
	<xsl:with-param name="colSpan">20</xsl:with-param>
</xsl:call-template>

		<xsl:call-template name="BeginTabPage">
			<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
			<xsl:with-param name="tabPageName">tpageDispatchDetails</xsl:with-param>
			<xsl:with-param name="tabPageDisplayNameRes" select="'Dispatch Details'"/>
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
	<xsl:call-template name="RequestBO.userDateField1"/>
	<xsl:call-template name="RequestBO.userDateField2"/>
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
	<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

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

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField7"/>
	<xsl:call-template name="RequestBO.userStrField8"/>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
	<xsl:with-param name="drawLine">true</xsl:with-param>
	<xsl:with-param name="lineColor">gray</xsl:with-param>
	<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="addemptycell"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField10"/>
	<xsl:call-template name="RequestBO.userStrField9"/>   
<xsl:call-template name="End"/>

		<xsl:call-template name="EndTabPage"/>

		<xsl:call-template name="BeginTabPage">
				<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
				<xsl:with-param name="tabPageName">tpageStatementDetails</xsl:with-param>
				<xsl:with-param name="tabPageDisplayNameRes" select="'Statement Details'"/>
				<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
				<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
		</xsl:call-template>


<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userAmountField1"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="LineBreak">
	<xsl:with-param name="drawLine">true</xsl:with-param>
	<xsl:with-param name="lineColor">gray</xsl:with-param>
	<xsl:with-param name="width">95%</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="Begin"/>
					<xsl:call-template name="addemptycell"/>
					<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>


<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountNo">
	<xsl:with-param name="ele_name">AccountNo</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="AccountNo">
	<xsl:with-param name="ele_name">AccountNo</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="AccountNo">
	<xsl:with-param name="ele_name">AccountNo</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="AccountNo">
	<xsl:with-param name="ele_name">AccountNo</xsl:with-param>
	</xsl:call-template>
<xsl:call-template name="End"/>

		<xsl:call-template name="EndTabPage"/>

		<xsl:call-template name="EndTabView">
					<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
					<xsl:with-param name="selectedTabPageName">tpageDispatchDetails</xsl:with-param>
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
