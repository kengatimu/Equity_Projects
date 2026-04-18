package com.infy.finbranch.groups;

import finbranchUtil.MenuMiscInfo;
import gcode.iface.ImenuDtl;
import com.infy.bbu.context.IServiceContext;
import com.infy.bbu.ons.common.CommonConstants;
import fabclasses.CommonFunctions;
import fabclasses.ServiceRoutines;

public class customlagspmBean extends lagspmBean
{
	ImenuDtl        menuDtl         = null;
	String			sSubString		= "";
	private char cLiteralContext;
	public String getNextPage()
	{
		IServiceContext context 	= getContext();
		srvcRoutines=(ServiceRoutines)session.getAttribute("SrvcRoutines");
		if (context != null) {
			srvcRoutines.init(context);
		}

		String sNextPage = super.getNextPage();
		char cLiteralContext =' ';

		String customData 			= context.getCustomData();


		if(customData != null)
		{
			//Logic to extract LITERALCONTEXT from customData


			int iIndex1 = customData.indexOf("LITERALCONTEXT");
			if(-1 != iIndex1)
			{
				String sSubString = customData.substring(iIndex1);

				int iIndex2 = sSubString.indexOf("=");
				String sSubString2 = sSubString.substring(iIndex2);
				cLiteralContext = sSubString2.charAt(1);
			}

			if(cLiteralContext != CommonConstants.CONVENTIONAL && cLiteralContext != CommonConstants.ALTERNATE)
			{
				cLiteralContext = CommonFunctions.getDefaultLiteralContext();
			}
			MenuMiscInfo menuMiscInfo = (MenuMiscInfo)ARJspCurr.getInput(MenuMiscInfo.getObjectName (),null);

			menuMiscInfo.setLiteralContext(cLiteralContext);
			ARJspCurr.setInput(MenuMiscInfo.getObjectName (),menuMiscInfo);
		}
		return sNextPage;
	}
}
