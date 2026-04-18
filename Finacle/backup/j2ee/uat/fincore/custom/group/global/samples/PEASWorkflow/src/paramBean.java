package com.infy.finbranch.groups;

import com.infy.bbu.jsputil.ContextManager;
import java.io.PrintStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;
import java.io.*;
import java.util.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.infy.COTP.*;
import com.infy.bbu.*;
import com.infy.bbu.jsputil.*;
import FABInquiry.*;
import FABProcess.*;
import FABCommon.*;
/**
  *	Referenced classes of package com.infy.finbranch.groups.customBeanBase
  * This is a small bean being used by paramacceptance.jsp present in the
  * custom jsp folder. This is used to mainly implement genextPage as the jsp
  * has to call procRequest for workflow. This bean just returns the
  * paramacceptance.jsp name. It can access the fields present in the jsp from
  * the request object. The fields belong to custom group.
  **/

public class paramBean extends customBeanBase
{

    public paramBean()
    {
    }

    public String getNextPage()
    {
        HttpServletRequest httpservletrequest = (HttpServletRequest)pageContext.getRequest();
        String s = (String)session.getAttribute("applangcode");
        String s1 = ARJspCurr.getCurrentGroup();
        String s2 = httpRequest.getParameter("actionCode");
        String s3 = "/param/INFENG/paramacceptance.jsp";
    	if(s2.equals("setValues"))
		{
			ARJspCurr.setInput("values","yes");
			Enumeration names = httpRequest.getParameterNames();
		    while(names.hasMoreElements())
		    {
		        String sName = (String)names.nextElement();
		      	String sValue = httpRequest.getParameter(sName);
		       	ARJspCurr.setInput(sName,sValue);
		    }
		}
		return s3;
     }
}
