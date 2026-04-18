<?xml version='1.0'?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>
  <xsl:param name="locale"/>
	<xsl:param name="resfilename"/>
  <xsl:param name="pageIndex" select="0"/>
	<xsl:param name="NumPages"/>
	<xsl:variable name="numrows" select="count(/SRM/SRMData/SRMComposite[@n='RecordSet']/SRMRow)"/>
<xsl:template match="/">
	<xsl:if test="$pageIndex &lt;=1">
	<xsl:call-template name="htmlstart"/>
      <head>
<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<script>
var locale = '<xsl:value-of select="$locale"/>';
var NumPages = '<xsl:value-of select="$NumPages"/>';
</script>
        <link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu_{$locale}.css"/>
        <link rel="stylesheet" Type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
        <script type="text/javascript" id="TableRowColor" src="../common/js/SRMTableRowColor.js"></script>
        <script type="text/javascript" src="../common/js/MessageFunctions.js"></script>
         <script type="text/javascript" language="javascript" src="../cif/js/CrossEntityCopyValidation.js"></script>
        <script>
        var corpID ;
        var numrows ='<xsl:value-of select="$numrows"/>';
	function identifyme()  {
					if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '') {
							corpID = event.srcElement.parentElement.parentElement.parentElement.getAttribute('CorporateBO.corp_ID');
					}else{
							corpID = event.srcElement.parentElement.getAttribute('CorporateBO.corp_ID');
        	}
        	setCookie("entityType","Customer");
	}
	<![CDATA[
	function sortMe(col,order) {
				var expirationdate = new Date ();
				expirationdate.setTime(expirationdate.getTime() + ( 160 * 60 * 60 * 1000));
				setCookie('SORT_ORDER_ListofAccounts', order,expirationdate);
				setCookie('SORT_COLUMN_ListofAccounts', col,expirationdate);
				savePersistData();
				var doc = parent.frames(0).document;
				doc.all.SortColumn.value = col;
				doc.all.SortOrder.value = order;
				doc.FindForm.submit();
                   }]]>
        </script>
  </head>
        <xsl:call-template name="bodystart"/>
	</xsl:if>
	       <xsl:call-template name="mainbody">
	         <xsl:with-param name="tablename">RecordSet</xsl:with-param>
	         <xsl:with-param name="pageIndex"><xsl:value-of select="$pageIndex"/></xsl:with-param>
	         <xsl:with-param name="NumPages"><xsl:value-of select="$NumPages"/></xsl:with-param>
	         <xsl:with-param name="showNext">true</xsl:with-param>
	         <xsl:with-param name="rowhighlight">true</xsl:with-param>
	         <xsl:with-param name="usabilityChange">true</xsl:with-param>
	         <xsl:with-param name="imgValueName">CorporateBO.segment,CorporateBO.record_Status,CorporateBO.suspend_Flag,CorporateBO.negative_Flag,CorporateBO.blacklist_Flag,</xsl:with-param>
				   <xsl:with-param name="rsfilenm"><xsl:value-of select="$resfilename"/></xsl:with-param>
		       <xsl:with-param name="jscriptfnc">,identifyme()</xsl:with-param>
	         <xsl:with-param name="colhrefname">CorporateBO.corp_Key</xsl:with-param>
			 <xsl:with-param name="colhref_function">populateCorpcifEntityDetails(corpID,'CorpCustSearch')</xsl:with-param>
	       </xsl:call-template>
  </xsl:template>
 </xsl:stylesheet>








