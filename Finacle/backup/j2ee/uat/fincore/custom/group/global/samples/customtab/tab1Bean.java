package com.infy.finbranch.groups;

import java.util.HashMap;
import customUtil.customFunctions;

public class tab1Bean extends customBean
{
	String actionCode;
    String sNextPage;
    String llName;
    String pageName;
    String customData;

    String[] fieldArray = {"customerName", "desigCode"};

    HashMap hm;

	public String getNextPage()
	{
        actionCode = httpRequest.getParameter("submitform");
		actionCode = (actionCode == null) ? "" : actionCode;

		sNextPage = sApplLangCode + "/tab1det.jsp";

        pageName = httpRequest.getParameter("pagename");

        llName = httpRequest.getParameter("CUST_LLNAME");

        if (llName != null)
        {
            /*
                The CUST_LLNAME is a hidden field in the screen.
                This field represents the LinkList name to be used to hold the
                data in Repository. All the processing will happen based on
                this LinkList name.

                Coming here means.... the user has pressed the navigation
                buttons (next, prev) or Submit/Validate. So, simply call
                ProcessMultiRec() which updates the current record and the
                next record number in repository. Assumption here is all
                validations are handled prior to calling of ProcessMultiRec().
            */
            try{
                customFunctions.ProcessMultiRec(ARJspRep, httpRequest, llName, fieldArray);
            }catch(Exception e)
            {
                System.out.println("Exception "+e);
            }

            if (actionCode.equals("MULTIRECNAVIGATION"))
            {
				setDataInContext();
                return sNextPage;
            }
        }

        /*
            Coming here means...the user has pressed Submit/Cancel/Any other
            Tab. So, serialize the LinkList stored in Repository so that the
            data will be passed to the NAPI service.

            Remember! We already taken care of the updating LinkList in the
            Repository in the previous code.
        */

		if (!actionCode.equals("CTAB_tab1") && !actionCode.equals("MULTIRECNAVIGATION"))
		{
            /*  Call this method to serialize the multi-rec Data
                after this method call value in custdata will be
                custdata="~paganame|Staticfields|MultiRecName|NumOfRecords|NumOfFields|data|..|"
                eg:"~custper|ABC|DEF|SOLID|3|2|vr1f1|vr1f2|vr2f1|vr2f2|vr3f1|vr3f2|"
            */

            hm = (HashMap)ARJspRep.getVal(llName);

            customData = getCustomData();

            customData = customFunctions.SerializeMultiRec(hm, llName, pageName, customData, fieldArray.length);

			setCustomData(customData);

			try
			{
				returnToParent("/custom/custom_ctrl.jsp");
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}

		return sNextPage;
	}
}
