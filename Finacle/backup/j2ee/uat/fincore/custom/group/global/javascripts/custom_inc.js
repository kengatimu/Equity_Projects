<%
int iNumOutColumn = sColumnNames.length;
String sAmtFromat = ProfileProperties.getProperty(sProfileId,"amountFormat");
String  sMaxDispRec = AppProperties.getProperty("listMaxDisplay");
if(sMaxDispRec == null && sMaxDispRec.equals(""))sMaxDispRec = "0";
int iPropDisp = Integer.parseInt(sMaxDispRec);
if(iNumOutColumn > 0)
{
	iPropDisp =  iPropDisp / iNumOutColumn	;
	iPropDisp = iPropDisp * iNumOutColumn;
	ListingBean.getMaxSize(String.valueOf(iPropDisp));
}
else
{
	ListingBean.getMaxSize(sMaxDispRec);
}
if(null!= request.getParameter("txtaction") && !("").equals(request.getParameter("txtaction")))
{
	String Action = request.getParameter("txtaction");
	if(Action.equals("Next"))
	{
	    vTemp=ListingBean.getNextSet();
	}else if(Action.equals("Back"))
	{
	    vTemp=ListingBean.getPreviousSet();
	}
}else
{
	Vector vAcctId = (Vector)ARJspCurr.getInputWithGroup("custOutLL", new Vector());
	if ((vAcctId.size() > 0) && (!(vAcctId.elementAt(0) instanceof FABInquiry.Err)))
	{
	    String sCriteria = "";
	    ListingBean.setList(vAcctId,sCriteria);
	    vTemp = ListingBean.getNextSet();
	}else
	{
	    vTemp = vAcctId;
	}
}
  if ((vTemp.size() > 0) && (vTemp.elementAt(0) instanceof FABInquiry.Err))
    {
        Err err = (FABInquiry.Err)vTemp.elementAt(0);
%>
    <tr><td  class="ctext" colspan="5"
	align="center"><%=ParseValue.checkString(err.errDesc)%></td>
    </tr>
<%
    }
else
{
	for(int iCnt =0;iCnt < vTemp.size(); iCnt++)
	{
	%>
	<tr>
	<%
		for(int iColumn = 0; iColumn < sColumnNames.length; iColumn++)
		{
			CustomList obj = (CustomList)vTemp.elementAt(iCnt+iColumn);
			if(-1 != (obj.name).indexOf( sColumnNames[iColumn]))
			{			
				if(sColumnFormat[iColumn].equals("Amt"))
				{
				%>
				<td nowrap align="right"><script>newformatAmt("<%=ParseValue.checkString(sAmtFromat)%>", "<%=ParseValue.checkString(obj.value)%>", "", "Y");</script></td>
				<%
				}
				else if(sColumnFormat[iColumn].equals("Flg"))
				{
					if((obj.value).equals("Y"))					
					{
				%>
					<td nowrap align="center">Yes</td>
				<%
					}
					else if((obj.value).equals("N"))
					{
				%>
					<td nowrap align="center">No</td>
				<%
					}
					else
					{					
				%>
					<td nowrap align="center"><%=ParseValue.checkString(obj.value)%></td>
				<%	}
				}
				else if(sColumnFormat[iColumn].equals("String"))
				{
				%>
					<td nowrap align="left"><%=ParseValue.checkString(obj.value)%></td>
				<%}
				else
				{%>
					<td nowrap align="center"><%=ParseValue.checkString(obj.value)%></td>
				<%}
			}
		}
		iCnt = iCnt+(iNumOutColumn -1);
		%>
	</tr>
	<%}	
}%>
<tr>
<td colspan="4" align="center">
<%
if(ListingBean.isbuttonsreq_prev())
{
%>
<font color="blue" >
<a onclick='fnPreviousList()' id="anc_prev" onmouseover="this.style.cursor='hand'"; onmouseout="this.style.cursor='default'"><b>Prev<b></a>&nbsp;&nbsp;
<%
}
if(ListingBean.isbuttonsreq_next())
{
%>
<font color="blue" >
<a onclick='fnNextList()' id="anc_next" onmouseover="this.style.cursor='hand'"; onmouseout="this.style.cursor='default'"><b>Next<b></a></font>
<%
}
%>
</td>
</tr>
