package com.infy.cis.ui.reports;

import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

import com.infosys.insulate.util.HashMap;
import com.infosys.insulate.util.Vector;
import com.infosys.insulate.util.ArrayList;
import com.infosys.insulate.util.HashSet;
import com.infosys.insulate.util.TreeSet;
import com.infosys.insulate.util.IdentityHashMap;
import com.infosys.insulate.util.LinkedHashMap;
import com.infosys.insulate.util.LinkedHashSet;
import com.infosys.insulate.util.LinkedList;
import com.infosys.insulate.util.Stack;
import com.infosys.insulate.util.TreeMap;
import com.infosys.insulate.util.WeakHashMap;
import com.infosys.insulate.util.PriorityQueue;
import java.io.*;
import java.net.URLConnection;
import java.net.URL;
import java.net.URLEncoder;

import com.infy.cis.servletruntime.*;
import com.infy.cis.srmbo.*;
import com.infy.cis.srmbo.security.user.*;
import com.infy.cis.exception.*;
import com.infy.cis.ui.common.*;
import com.infy.cis.common.*;

// TRACKER#66340 **BEGIN CHANGES** //
// Removed the imports for crystal sdk packages
// TRACKER#66340 **END   CHANGES** //


public class ViewCrystalReport extends CISHttpServlet {

	private static Hashtable table = null;

	public static String strCRImplementationType = null;
	public static String strCRServerLocation = null;
	public static String strServerURLOrHostName = null;
	public static String strDBUserName = null;
	public static String strDBPassword = null;
	public static String strAPSUsername = null;
	public static String strAPSPassword = null;
	public static String strIsNamedLicence = null;
	public static String strRepDirName = null;

	protected void serviceRequest(HttpServletRequest request, HttpServletResponse response)
	throws IOException, ServletException , Exception {

		PrintWriter out = null;

		String reportName = request.getParameter("filename");
		boolean isRASConfigured = true;

		if(table == null) {
			table = new Hashtable();
			table = EditorUtil.getCrystalConfigInfo();

			Properties prop = (Properties) table.get(EditorUtil.getCrystalPath());

			if(prop != null) {
				String strURL = null;

				if((strURL = prop.getProperty("CRImplementationType")) != null){
					strCRImplementationType = strURL;
				}

				if(strCRImplementationType.equalsIgnoreCase("RAS")) {
					isRASConfigured = true;
				} else if(strCRImplementationType.equalsIgnoreCase("CR8")) {
					isRASConfigured = false;
				}

				if((strURL = prop.getProperty("CRServerLocation")) != null){
					strCRServerLocation = strURL;
				}


				if((strURL = prop.getProperty("ReportsURL")) != null){
					strServerURLOrHostName = strURL;
				}

				if((strURL = prop.getProperty("UserID")) != null) {
					strDBUserName = strURL;
				}

				if((strURL = prop.getProperty("Password")) != null) {
					strDBPassword = strURL;
				}

				if((strURL = prop.getProperty("APSUsername")) != null) {
					strAPSUsername = strURL;
				}

				if((strURL = prop.getProperty("RepDirName")) != null) {
					strRepDirName = strURL;
				}

				if((strURL = prop.getProperty("APSPassword")) != null) {
					strAPSPassword = strURL;
				}

				if((strURL = prop.getProperty("IsNamedLicence")) != null) {
					strIsNamedLicence = strURL;
				}
			}
		}

		if(strCRImplementationType.equalsIgnoreCase("RAS")) {

/*			ReportClientDocument document = null;

			CISSessionContext sc = context.getSessionContext(request);
			ICacheService systemCache = context.getCacheService();

			boolean isCached = true;

			String cachedReportClientDocName = (String) systemCache.get("ReportClientDocumentName", sc.getSessionId());

			if(reportName != null) {

				if(cachedReportClientDocName != null) {
					systemCache.remove("ReportClientDocumentName", sc.getSessionId());
					systemCache.remove("ReportClientDocument", sc.getSessionId());
				}

				isCached = false;

			} else {
				document = (ReportClientDocument) systemCache.get("ReportClientDocumentObject", sc.getSessionId());
				isCached = true;
			}
*/
			try	{
/*				if(document == null) {
					document = new ReportClientDocument();
					document.setReportAppServer(strServerURLOrHostName);

					if(strCRServerLocation.equalsIgnoreCase("Remote")) {
						document.open("rassdk://" + System.getProperty("SIMPLERM_ROOT") + "/Report/" + reportName, OpenReportOptions._openAsReadOnly);
					} else {
						document.open(System.getProperty("SIMPLERM_ROOT") + "/Report/" + reportName, OpenReportOptions._openAsReadOnly);
					}

					document.getDatabaseController().logon(strDBUserName,strDBPassword);
				}

				if(!isCached) {
					systemCache.put("ReportClientDocumentName", sc.getSessionId(), reportName.trim());
					systemCache.put("ReportClientDocumentObject", sc.getSessionId(), document);
				}

				String CrystalEventArgument = request.getParameter("CrystalEventArgument");
				String tbParam = request.getParameter("tb");

				Enumeration enum1 = request.getParameterNames();
*/

				/*//System.out.println("-------------------------");

				while (enum1.hasMoreElements()) {
					String t = (String)enum1.nextElement();
					System.out.print(t);
					//System.out.println(" = " + request.getParameter(t));
				}

				//System.out.println("-------------------------");
				*/

/*
				if (tbParam == null) {
					tbParam = "";
				}

				if (CrystalEventArgument != null) {

					ArrayList l1 = (ArrayList) Utils.parseString(CrystalEventArgument, '&');

					Hashtable htb = new Hashtable();

					for (int i = 0; i < l1.size(); i++) {
						StringBuffer sb = (StringBuffer)l1.get(i);

						ArrayList l2 = (ArrayList) Utils.parseString(sb.toString(), '=');
						StringBuffer sbval = (StringBuffer)l2.get(1);

						if (sbval == null) {
							htb.put(((StringBuffer)l2.get(0)).toString(), "");
						} else {
							htb.put(((StringBuffer)l2.get(0)).toString(), sbval.toString());
						}
					}

					String tb = (String)htb.get("tb");
	//				String crprompt = (String)htb.get("crprompt");

					// EXPORT OPTION HAS BEEN SELECTED.
					if(tb != null) {
						if(tb.equalsIgnoreCase("crexport")) {

							String sExportFormat = (String)htb.get("text");

							PrintOutputController pcon = document.getPrintOutputController();
							ReportExportFormat repExportFormat = null;
							String ContentType = null;
							String Extn = null;

							if(sExportFormat.equalsIgnoreCase("PDF")) {
								repExportFormat = ReportExportFormat.PDF;
								ContentType = "application/pdf";
								Extn = ".pdf";

							} else if (sExportFormat.equalsIgnoreCase("CrystalReports")) {
								repExportFormat = ReportExportFormat.MSWord;
								ContentType = "application/x-rpt";
								Extn = ".rpt";

							} else if (sExportFormat.equalsIgnoreCase("MSWord")) {
								repExportFormat = ReportExportFormat.MSWord;
								ContentType = "application/msword";
								Extn = ".doc";

							} else if (sExportFormat.equalsIgnoreCase("MSExcel")) {
								repExportFormat = ReportExportFormat.MSExcel;
								ContentType = "application/vnd.ms-excel";
								Extn = ".xls";

							} else if (sExportFormat.equalsIgnoreCase("RecordToMSExcel")) {
								repExportFormat = ReportExportFormat.MSExcel;
								ContentType = "application/vnd.ms-excel";
								Extn = ".xls";

							} else if (sExportFormat.equalsIgnoreCase("RTF")) {
								repExportFormat = ReportExportFormat.RTF;
								ContentType = "application/msword";
								Extn = ".doc";
							}

							ByteArrayInputStream byteIS = (ByteArrayInputStream)pcon.export(repExportFormat);
							byte b[] = new byte[byteIS.available()];
							int i = byteIS.read(b, 0, byteIS.available());

							setContentType(ContentType, response);
							response.addHeader("Content-disposition", "attachment; filename=exported" + Extn);

							response.getOutputStream().write(b);

						} else if(tb.equalsIgnoreCase("refresh")) {
							ActivateViewer(request, response, document, true);

						} else if(tb.equalsIgnoreCase("zoom") || tb.equalsIgnoreCase("gotopage") || tb.equalsIgnoreCase("tglgrptree") || tb.equalsIgnoreCase("search") || tb.equalsIgnoreCase("searchtext")) {
							ActivateViewer(request, response, document, false);
						}

					} else {
						ActivateViewer(request, response, document, false);
					}

				} else {
					ActivateViewer(request, response, document, true);
				}
*/
				//crystalURL = "https://blrkec12255.ad.infosys.com/rassamples/en/asp/rPortfolio/rptServer/Start.asp?ReportName=FetchData.rpt&Viewer=3";
				String tempURL = strRepDirName + "/" + reportName;
				tempURL = URLEncoder.encode(tempURL);

				// TRACKER#66340 **BEGIN CHANGES** //
				//String crystalURL = strServerURLOrHostName + "/rassamples/en/asp/rPortfolio/rptServer/Start.asp?ReportName=" + tempURL + "&Viewer=3";
				String crystalURL = strServerURLOrHostName + "/rassamples/en/asp/rPortfolio/HTMLViewers/interactiveViewer.asp?ReportName=" + tempURL ;
				// TRACKER#66340 **END   CHANGES** //
				//System.out.println(crystalURL);
	            response.sendRedirect(crystalURL);


			} catch(Exception ex) {

				ex.printStackTrace();

				if(out == null) {
					out = response.getWriter();
				}

				out.println("<html>");
				out.println("<head>");
				out.println("<title>" + this.getSystemString("Default", "Title") + "</title>");
				out.println("<SCRIPT language='javascript' SRC='../common/js/SSOParameter.js'></SCRIPT>");
				out.println("</head>");
				out.println("<body>");
				out.println("<font color=red>");
				out.println(Utils.localeCorrect(request, "<center><h2 color = red>{0}</h2></center>",
												new int[]{I18N_MsgTags.MSG_CRYSTAL_ENTERPRISE_LOGIN_NEEDED},
												I18N_MsgTags.PACKAGE_NAME));

				out.println(ex.getMessage());
				out.println("</font>");
				out.println("</body>");
				out.println("</html>");
				out.flush();
			}

		} else if (strCRImplementationType.equalsIgnoreCase("CR8")) {
			setContentType("text/html", response);
			out = response.getWriter();

			//String crystalURL = strServerURLOrHostName + "/" + reportName + "?init=java&user0=" + strDBUserName + "&password0=" + strDBPassword + "&promptonrefresh=1";
			/******* NILESH - REMOVE init=java *********/
			String crystalURL = strServerURLOrHostName + "/" + reportName + "?user0=" + strDBUserName + "&password0=" + strDBPassword + "&promptonrefresh=1";

			try	{

				if(strIsNamedLicence.equalsIgnoreCase("Y")) {
					if(!strAPSUsername.equals("")) {
						crystalURL += "&apsuser=" + strAPSUsername
									+ "&apspassword=" + strAPSPassword
									+ "&apsauthtype=secEnterprise";
					}else{
						throw new FCRMGenericException("MSGEXC0136",new Exception("APSUserName is not provided for named license."));
					}
				}

				response.sendRedirect(crystalURL);

			} catch(Exception ex) {
				out.println("Crystal URL is :"+crystalURL);

				out.println("<html>");
				out.println("<head>");
				out.println("<title>" + this.getSystemString("Default", "Title") + "</title>");
				out.println("<SCRIPT language='javascript' SRC='../common/js/SSOParameter.js'></SCRIPT>");
				out.println("</head>");
				out.println("<body>");
				out.println("<font color=red>");
				out.println(Utils.localeCorrect(request, "<center><h2 color = red>{0}</h2></center>",
												new int[]{I18N_MsgTags.MSG_CRYSTAL_ENTERPRISE_LOGIN_NEEDED},
												I18N_MsgTags.PACKAGE_NAME));
				out.println(ex.getMessage());
				out.println("</font>");
				out.println("</body>");
				out.println("</html>");
				out.flush();
			}


		}
	}

}


