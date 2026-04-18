package com.infy.finbranch.groups;

public class tab2Bean extends customBean
{
	public String getNextPage()
	{
        String actionCode = httpRequest.getParameter("submitform");
		actionCode = (actionCode == null) ? "" : actionCode;

		if (!actionCode.equals("CTAB_tab2"))
		{
			try
			{
				returnToParent("/custom/custom_ctrl.jsp");
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}

		return sApplLangCode + "/tab2det.jsp";
	}
}
