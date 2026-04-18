<?xml version="1.0"?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <!--impoting variables wich hold the jvm properties-->
     <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>

<!-- importing xml files InciDDReq.xml -->
     <xsl:variable name="configFile" select="document(concat('../Renderer/customization/resource/Inci_Crdt_High_Lim.xml', ''))"/>	
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
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/MultiTabs.css"/> -->
	
	</head>

        <script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
        <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
        <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
        <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        <script type="text/javascript" src="../Renderer/wizards/html/ShowButtons.html"></script>

    <body  class="popup" bottommargin="0" topmargin="0" style="padding-top=10px; padding-left=5px; padding-right=5px">
		
		
		
		<xsl:choose>
	    <xsl:when test="normalize-space($readMode)='Y'">
	    <xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');</xsl:attribute>
	    </xsl:when>
        </xsl:choose>  
         
        <script type="text/javascript" language="javascript">

	
		var readonly_var = "<xsl:value-of select ='$isReadOnly' />";
        var mode="<xsl:value-of select ='$Mode' />";

/*Function to make the field "Date up to which Credit Limit Increase is Requested" mandatory */

	function TempCreditLimit()
	{
		
		if(document.getElementsByName("RequestBO.userStrField10")[0].value == 'Temporary')
		{
			
			document.getElementsByName("3_RequestBO.userDateField1")[0].IsMandatory = "true";
			
		}
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

<!--template for Docs sent to CC Details -->
	<xsl:template name="RequestBO.userStrField5">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField5']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField5</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField5</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Docs Received at CC Details -->
	<xsl:template name="RequestBO.userStrField6">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField6']"/>
	<xsl:with-param name="ele_name">RequestBO.userStrField6</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userStrField6</xsl:with-param>
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


	
	<!--template for Credit Limit -->

	<xsl:template name="RequestBO.userStrField10">
	<xsl:call-template name="mdrpdown">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField10']"/>
	<xsl:with-param name="selectname">RequestBO.userStrField10</xsl:with-param> 
	<xsl:with-param name="search_type">value</xsl:with-param>
	<xsl:with-param name="selectdisp">RequestBO.userStrField10</xsl:with-param>
	<xsl:with-param name="onchangefn">TempCreditLimit()</xsl:with-param>
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

<!--template for Date for Temporary increase in limit -->
	<xsl:template name="RequestBO.userDateField1">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userDateField1']"/>
	<xsl:with-param name="ele_name">RequestBO.userDateField1</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userDateField1</xsl:with-param>
	</xsl:call-template>
	</xsl:template>


<!--template for Proposed limit amount -->
	<xsl:template name="RequestBO.userAmountField1">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userAmountField1']"/>
	<xsl:with-param name="ele_name">RequestBO.userAmountField1</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userAmountField1</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Approved credit limit amount -->
	<xsl:template name="RequestBO.userAmountField2">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userAmountField2']"/>
	<xsl:with-param name="ele_name">RequestBO.userAmountField2</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userAmountField2</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Approved cash limit amount -->
	<xsl:template name="RequestBO.userAmountField3">
	<xsl:call-template name="label">
	<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userAmountField3']"/>
	<xsl:with-param name="ele_name">RequestBO.userAmountField3</xsl:with-param>
	<xsl:with-param name="ele_val">RequestBO.userAmountField3</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

<!--template for Special Instructions for Despatch (Free text) -->
	<xsl:template name="RequestBO.userTextField1">
	    <xsl:call-template name="mtextarea">
	    <xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userTextField1']"/>
	    <xsl:with-param name="mname">RequestBO.userTextField1</xsl:with-param>
	    <xsl:with-param name="mvalue">RequestBO.userTextField1</xsl:with-param>
	    <xsl:with-param name="mwrap">on</xsl:with-param>
	    <xsl:with-param name="mrows">4</xsl:with-param>
	    <xsl:with-param name="mcols">60</xsl:with-param>
        <xsl:with-param name="mcolspan">5</xsl:with-param>
	    </xsl:call-template>
	    </xsl:template>

<!--template for Confirmation collection details (Free text) -->
    	<xsl:template name="RequestBO.userTextField2">
	    <xsl:call-template name="mtextarea">
	    <xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userTextField2']"/>
	    <xsl:with-param name="mname">RequestBO.userTextField2</xsl:with-param>
	    <xsl:with-param name="mvalue">RequestBO.userTextField2</xsl:with-param>
	    <xsl:with-param name="mwrap">on</xsl:with-param>
	    <xsl:with-param name="mrows">4</xsl:with-param>
	    <xsl:with-param name="mcols">60</xsl:with-param>
        <xsl:with-param name="mcolspan">5</xsl:with-param>
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
	       
<table width="100%" bgcolor='E5E5E5' cellspacing="0" vspace="0" hspace="0" border="0">

<xsl:call-template name="BeginTabView">
		<xsl:with-param name="tabViewName">tabSRHighLim</xsl:with-param>
		<xsl:with-param name="tabPageHeight">100</xsl:with-param>
		<xsl:with-param name="colSpan">20</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="BeginTabPage">
		<xsl:with-param name="tabViewName">tabSRHighLim</xsl:with-param>
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
		<xsl:call-template name="RequestBO.userStrField29"/>
	<xsl:call-template name="End"/>

	<xsl:call-template name="Begin"/>
		<xsl:call-template name="RequestBO.userStrField28"/>
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
	<xsl:with-param name="tabViewName">tabSRHighLim</xsl:with-param>
	<xsl:with-param name="tabPageName">tpageCardCenterDetails</xsl:with-param>
	<xsl:with-param name="tabPageDisplayNameRes" select="'Card Center Details'"/>
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
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userTextField2"/>
<xsl:call-template name="End"/>

		<xsl:call-template name="EndTabPage"/>	
		
<xsl:call-template name="BeginTabPage">
		<xsl:with-param name="tabViewName">tabSRHighLim</xsl:with-param>
		<xsl:with-param name="tabPageName">tpageCreditLimitDetails</xsl:with-param>
		<xsl:with-param name="tabPageDisplayNameRes" select="'Credit Limit Details'"/>
		<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
		<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
	</xsl:call-template>



<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userStrField10"/>
	<xsl:call-template name="addemptycell"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userDateField1"/>
	<xsl:call-template name="RequestBO.userAmountField1"/>
<xsl:call-template name="End"/>

<xsl:call-template name="Begin"/>
	<xsl:call-template name="RequestBO.userAmountField2"/>
	<xsl:call-template name="RequestBO.userAmountField3"/>
<xsl:call-template name="End"/>

<xsl:call-template name="EndTabPage"/>

<xsl:call-template name="EndTabView">
	<xsl:with-param name="tabViewName">tabSRHighLim</xsl:with-param>
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
