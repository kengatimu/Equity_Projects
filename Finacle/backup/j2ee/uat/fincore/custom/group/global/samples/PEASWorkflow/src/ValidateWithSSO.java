// Source File Name:   ValidateWithSSO.java

package com.infy.finacle.workflow.sso;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.*;
import java.lang.*;
import javax.servlet.http.HttpServletRequest;
import peas.api.intf.hooks.authentication.ValidateUserIF;
import peas.api.intf.hooks.authentication.ValidationResult;
import javax.servlet.http.Cookie;

public class ValidateWithSSO
    implements ValidateUserIF
{
	public ValidateWithSSO()
    {
		try
		{
			String path = System.getProperty("PEAS_HOME"); 
	  		FileInputStream serverPath = new FileInputStream(path+File.separator+"Applications"+File.separator +"defaultApp"+File.separator+"ApplicationConfig"+File.separator+"conf.properties");
			Properties getUrl = new Properties();
	  		getUrl.load(serverPath);
	  		app=getUrl.getProperty("APP_NAME");
			if( (app != null && app.equals("")) || (app == null) )
		    	app="AdminWorkFlow";
		}
		catch (Exception e)
		{
	             	app="AdminWorkFlow"; 
		}
	}

    public ValidationResult validate(HttpServletRequest req)
    {
        String ssoUrl = null;
		URL urlSSO = null;
		String server_home = null;
        HttpURLConnection con = null;
        BufferedReader reader = null;
        BufferedWriter writer = null;
        String reqString = null;
        String urlAddition = null;
		
		StringBuffer cookies = new StringBuffer();
		Cookie[] cookieArr 	 = req.getCookies();
		for(int index=0; index < cookieArr.length; index++)
		{
			if( index != 0) cookies.append(";");
			cookies.append(cookieArr[index].getName()).append("=").append(cookieArr[index].getValue());
		}
		String clientIP 	= req.getRemoteAddr();
        String serviceToken = req.getParameter("SERVICE_TOKEN");
        String sessionID 	= req.getParameter("SESSION_ID");
        String callType 	= req.getParameter("CALLTYPE");
        String langCode 	= req.getParameter("LCLANG");
        String userID 		= req.getParameter("USER_ID");

        urlAddition = urlAddition + "SERVICE_TOKEN=" + serviceToken + "&SESSION_ID=" + sessionID + "&CALLTYPE=" + callType + "&USER_ID=" + userID + "&LCLANG=" + langCode + "&extLogin=true";
		HashMap data = new HashMap();
        boolean flag = false;

		try
        {
         	if(sessionID != null)
            {
	       	  	String path = System.getProperty("PEAS_HOME");
			  	FileInputStream serverPath = new FileInputStream(path+File.separator+"Applications"+File.separator +"defaultApp"+File.separator+"ApplicationConfig"+File.separator+"conf.properties");
				Properties getUrl = new Properties();
			  	getUrl.load(serverPath);
			  	server_home=getUrl.getProperty("SSO_URL");
			  	ssoUrl = server_home + "?CALLTYPE=CHK_SRVC_TOK";
				urlSSO = new URL(ssoUrl);
        	  	reqString = "SESSION_ID=" + sessionID;
				reqString = reqString + "&SERVICE_TOKEN=" + serviceToken;
				reqString = reqString + "&SERVICE_NAME=" + app;
        	  	reqString = reqString + "&CLIENT_IP=" + clientIP;
        	  	reqString = reqString + "&USER_ID=" + userID;
				con = (HttpURLConnection)urlSSO.openConnection();
				con.setRequestProperty("Cookie",cookies.toString());
				con.setUseCaches(false);
        	  	con.setDoOutput(true);
        	  	con.setDoInput(true);
        	  	writer = new BufferedWriter(new OutputStreamWriter(con.getOutputStream(), "UTF-8"));
				writer.write(reqString);
				writer.flush();
				reader = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				data = parseResponse(reader.readLine());
				int error = Integer.parseInt(data.get("ERROR_CODE").toString());

        	  	if(error == 0)
        	  	{
            		flag = true;
        	  	} else
        	  	{
        	  	}
         	  	con.disconnect();
          	  	con = null;
        	}
        	ValidationResult result = new ValidationResult();
        	result.setSuccess(flag);
        	result.setUrlAddition(urlAddition);
        	return result;
        }catch(Exception e)
        {
            ValidationResult result = new ValidationResult();
            result.setSuccess(flag);
            return result;
        }
    }

    public static final HashMap parseResponse(String message)
        throws Exception
    {
		if(message == null || message.equals(""))
            return null;
		HashMap ht = new HashMap();
        int equalIndex = -1;
        StringTokenizer tokens = new StringTokenizer(message, "&", false);
        int count = tokens.countTokens();
        String token = null;
        for(int curToken = 0; curToken != count;)
        {
            token = tokens.nextToken();
			curToken++;
            equalIndex = token.indexOf('=');
            if(equalIndex == -1)
                throw new Exception("ParseException: Invalid query string");
            ht.put(token.substring(0, equalIndex).trim(), token.substring(equalIndex + 1).trim());
        }
		return ht;
    }
    private String app;
}
