/*
	* This class generates the consolidated workflow.xml which contains all the
	* menus and their corresponding fields that can be a part of a workflow
	* process.This class is called from workflowxmlgen.sh and has the following
	* scenarios
	
	1) A roles.lst that contains all the roles in the production DB is given as
	   a argument.Then the java class the following as arguments
		
		LANG_CODE 			-- This is INFENG by Default.Else other lang code
							   is leyed in by the user.
		RESOURCE_PATH       -- This is the path where finbranchResource file
							   exists
		XML_PATH_FINBRANCH 	-- The path where all the fieldxmls for finbranch
							   exists
		SCREENSOFMENUS_PATH -- This is the path where the updated
							   WFScreensOfMenu.wspc is located.
		ROLES_PATH          -- The list of all roles in the Bank
		XML_PATH_FINCRV     -- The path of all fieldxmls of fincrv
    
	2) This is when there is no role.lst file.Then only 5 arguments exists for
	   the class 
	   
	   LANG_CODE 			-- This is INFENG by Default.Else other lang code
							   is leyed in by the user.
	   RESOURCE_PATH        -- This is the path where finbranchResource file
							   exists
	   XML_PATH_FINBRANCH 	-- The path where all the fieldxmls for finbranch
							   exists
	   SCREENSOFMENUS_PATH  -- This is the path where the updated
							   WFScreensOfMenu.wspc is located.
	   XML_PATH_FINCRV      -- The path of all fieldxmls of fincrv
*/
//This comment line is added related to javamake optimization
import org.apache.xerces.parsers.DOMParser;
import org.xml.sax.InputSource;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.*;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;
import java.util.*;
import java.io.*;

public class WorkflowXmlGen{
	
	private static FileWriter fXmlOut; 
	private static String sFileName = "workflow.xml";
	private static HashMap literalsMap = new HashMap();
	static final String NEWLINE = System.getProperty("line.separator"); 
	static final String FSP = (String)System.getProperty("file.separator");
    static final String TAB = "\t";

	public static void main(String[] args) {
        if(args.length < 1)
        {
            printUsage();
            System.exit(1403);
        }

		try{
			fXmlOut = new FileWriter(sFileName);
			loadResourceFiles(args[1]);
			writeXmlInitialContent();
			/*
			* If the rolse.lst file is provided then the number of arguments
			* would be 6.So we first write the roles into workflow.xml and then
			* write the menu related info.If there is no roles.lst file then the
			* else block is executed. 
			*/
			if(args.length == 6)
			{
				writeRolesDataToXml(args[4]);
				writeActivitiesDataToXml(args[2],args[3],args[5]);
			}
			else
			{
				writeActivitiesDataToXml(args[2],args[3],args[4]);
			}
			writeXmlFinalContent();
			fXmlOut.close();
		}	
		catch(FileNotFoundException fnfe){
			System.out.println("Error::This file is not present" + fnfe.getMessage());
			System.exit(1402);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	/* 
		* This loads the finbranchResource file from the path specified by the
		* user.
	*/

	private static void loadResourceFiles(String resourcePath)
		throws Exception {
		String line = "";
		BufferedReader bf = new BufferedReader(new FileReader(resourcePath));

		while((line = bf.readLine())!= null)
		{
			String literalcode = null;
			String displayName = null;
			if(line.indexOf("=")!=-1)
			{
				literalcode = line.substring(0,line.indexOf("="));
				displayName = line.substring(line.indexOf("=")+1,line.length());
				literalsMap.put(literalcode.trim(),displayName.trim());
			}
		}
	}
	
	/* This method reads the FLT codes from the corresponding <pagename>_wf.xml and 
	 * checks for the literalValue for the code.The mapping of literalcodes
	 * and their values is maintained in a hashmap after reading the
	 *  finbranchResource_Infeng file 
	*/

	private static String getLiteralValue(String literalCode){
		if(literalsMap.containsKey(literalCode)) {
			return (String)literalsMap.get(literalCode);
		}
		else{
			System.out.println("Warning::Value for literal code"+ literalCode +" not found in resource file");
			return "";
		}
	}
	
	private static void writeXmlInitialContent()
		throws Exception {
		fXmlOut.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");	
		fXmlOut.write(NEWLINE);
		fXmlOut.write("<Influx-MetaData>");
	}

	/* If the roles.lst file is supplied as an argument to the generator then
	 * the same is read and written into the workflow.xml
	*/

	private static void writeRolesDataToXml(String rolespath)
		throws Exception{
		try
		{
			BufferedReader	bf 		= new BufferedReader(new FileReader(rolespath));
			String 			line 	= bf.readLine() ;
			fXmlOut.write(NEWLINE);
			fXmlOut.write(TAB);
			fXmlOut.write("<UserGroups>");
			fXmlOut.write(NEWLINE);
			fXmlOut.write(TAB+TAB);
			fXmlOut.write("<Category Name=\"ROLE\">");
			while(line!=null)
			{
				if(!line.equals("")){
					fXmlOut.write(NEWLINE);
					fXmlOut.write(TAB + TAB + TAB);
					fXmlOut.write("<UserGroup Name=\"" + line.trim() + "\"/>");
				}
				line= bf.readLine();
			}
			fXmlOut.write(NEWLINE);
			fXmlOut.write(TAB + TAB);
			fXmlOut.write("</Category>");
			fXmlOut.write(NEWLINE);
			fXmlOut.write(TAB);
			fXmlOut.write("</UserGroups>");
		}catch(FileNotFoundException e) {
			System.out.println("Warning::The roles.lst file is not present in the directory given.Please give thecomplete path where the file is present");
			return;		
		}	
	}
	
	/*
	* This is the method that is callled from main and which calls the
	* readWspcAndWriteMenuData .Its writes the initial content of the
	* workflow.xml and then parses through the wspc and writes the menu data
	*/

	private static void writeActivitiesDataToXml(String fieldxlmPathOns,String serverRootPath,String fieldxmlPathCrv) throws Exception{
		fXmlOut.write(NEWLINE);
		fXmlOut.write(TAB + TAB);
		fXmlOut.write("<Activity-List>");

		readWspcAndWriteMenuData(fieldxlmPathOns,serverRootPath,fieldxmlPathCrv);

		fXmlOut.write(NEWLINE);
        fXmlOut.write(TAB + TAB);
        fXmlOut.write("</Activity-List>");
	}

	/*
	* This method reads the wspc file.The shell scripts converts the wspc file
	* as ScreensOfMenu.xml and passes to main method of Java.So this file is
	* read and the call to writeactivityinputs and to write the outputs is
	* called
	*/
	
	private static void readWspcAndWriteMenuData(String fieldxmlPathOns,String serverRootPath,String fieldxmlPathCrv) throws Exception {

		NodeList menuList = read(serverRootPath + "ScreensOfMenus.xml","menu");
		int numberOfMenus = (menuList == null ? 0 : menuList.getLength());
		for(int i=0; i<numberOfMenus; i++)
		{
			String menuName = ((Element)menuList.item(i)).getAttribute("name");
			String menuUrl  = ((Element)menuList.item(i)).getAttribute("url");
			String
			menuDescription = ((Element)menuList.item(i)).getAttribute("description");
			fXmlOut.write(NEWLINE);
			fXmlOut.write(TAB + TAB + TAB);
			fXmlOut.write("<Activity Name=\"" + menuName + "\" type=\"WebUIActivity\" url=\"" + menuUrl + "\" description=\"" + menuDescription + "\">");
			writeActivityInputs(fieldxmlPathOns,menuList.item(i),menuName,fieldxmlPathCrv);
			writeActivityOutputs(fieldxmlPathOns,menuList.item(i),menuName);
			fXmlOut.write(NEWLINE);
			fXmlOut.write(TAB + TAB + TAB);
			fXmlOut.write("</Activity>");
		}
	}

	/*
		This method reads the wspc file by the tagname of page.The page
		attribute signifies that this is a page foreach page we read the
		corresponding _wf.xml and write the contents to workflow.xml
	*/
	
	private static void writeActivityInputs(String fieldxmlPathOns,Object item,String menuName,String fieldxmlPathCrv) throws Exception {
		fXmlOut.write(NEWLINE);
		fXmlOut.write(TAB + TAB + TAB +TAB);
		fXmlOut.write("<Input>");
		
		NodeList fieldsList = null;
		NodeList jspList = ((Element)(item)).getElementsByTagName("page");
		int numberOfJsps = (jspList == null ? 0 : jspList.getLength());
		for(int i=0; i<numberOfJsps; i++)
		{
			String jspName = ((Element)jspList.item(i)).getAttribute("name");
			jspName = jspName.trim();
			if(null == jspName || jspName.equals("")) continue;
			try
			{
				fieldsList = read(fieldxmlPathOns + jspName+"_wf.xml","field");
			}catch(FileNotFoundException fnfex){
				fieldsList = read(fieldxmlPathCrv + jspName+"_wf.xml","field");	
			}
			int numberOfFields = (fieldsList == null ? 0 : fieldsList.getLength());
			for(int j=0; j<numberOfFields; j++)
			{
				String literalValue="";
				String fieldName = ((Element)fieldsList.item(j)).getAttribute("name");
				String literalCode = ((Element)fieldsList.item(j)).getAttribute("literal");
				if(!fieldName.equals("nextAction"))
				{
					literalValue = getLiteralValue(literalCode);
					literalValue = removeEscChars(literalValue);	
				}
				fXmlOut.write(NEWLINE);
				fXmlOut.write(TAB + TAB + TAB +TAB);
				fXmlOut.write("<Attribute DataType=\"xsd:string\" DisplayName=\"" + literalValue + "\"");
				fXmlOut.write(NEWLINE);
				fXmlOut.write(TAB + TAB + TAB + TAB +TAB);
				fXmlOut.write("Mandatory=\"yes\" Name=\"" + jspName+ "." +fieldName.trim() + "\"/>");
			}
		}
		fXmlOut.write(NEWLINE);
		fXmlOut.write(TAB + TAB + TAB +TAB);
		fXmlOut.write("</Input>");
	}
	
	/* 	
	* Some of the escape characters are present in the literal code
	* description.So the description is not written properly to xml and there
	* could be problem importing the workflow.xml file to the Modeller.So this
	* method is called for each literal value descritpion
	*/

	private static String removeEscChars(String literalValue)
    {
        return literalValue.replaceAll("&","&amp;");
    }	

	/*
	* This method reads the wspc file and finds pages with attribute as
	* resultpage and then writes the output data for each menu in the <output>
	* </output> tags
	*/

	private static void writeActivityOutputs(String fieldxmlPath,Object item,String menuName)
		throws Exception {
	
		NodeList jspList = ((Element)(item)).getElementsByTagName("resultpage");
		int numberOfJsps = (jspList == null ? 0 : jspList.getLength());
		for(int i=0; i<numberOfJsps; i++)
		{
			String jspName = ((Element)jspList.item(i)).getAttribute("name");
			jspName = jspName.trim();
			if(null == jspName || jspName.equals("")) continue;
			fXmlOut.write(NEWLINE);
			fXmlOut.write(TAB + TAB + TAB +TAB);
			fXmlOut.write("<Output>");

			NodeList fieldsList = read(fieldxmlPath+jspName+"_wf.xml","field");
			int numberOfFields = (fieldsList == null ? 0 : fieldsList.getLength());
			for(int j=0; j<numberOfFields; j++)
			{
				String literalValue="";
				String fieldName = ((Element)fieldsList.item(j)).getAttribute("name");
				String literalCode = ((Element)fieldsList.item(j)).getAttribute("literal");
				
				if(!fieldName.equals("nextAction"))
				{
					literalValue = getLiteralValue(literalCode);
				}
				if(null != fieldName && !fieldName.equals("nextAction")){
					fXmlOut.write(NEWLINE);
					fXmlOut.write(TAB + TAB + TAB +TAB);
					fXmlOut.write("<Attribute DataType=\"xsd:string\" DisplayName=\"" + literalValue + "\"");
					fXmlOut.write(NEWLINE);
					fXmlOut.write(TAB + TAB + TAB + TAB +TAB);
					fXmlOut.write("Mandatory=\"yes\" Name=\"" + jspName+ "." +fieldName.trim() + "\"/>");
				}
			}
		    fXmlOut.write(NEWLINE);
			fXmlOut.write(TAB + TAB + TAB +TAB);
			fXmlOut.write("</Output>");
		}
	}

	/*
	* This method is called to know what the the pages that form a part of the
	* Input fields and what pages form a part as the output fields.The
	* fields in the pagenames with attribute as page in wspc form the input
	* fields and the pagenames with tag as result page form the output fields
	*/
	
	private static NodeList read(String xmlPath,String field) 
		throws Exception {
		Document doc;
		Element activityElement ;
		NodeList actList = null;
		DOMParser parser = new DOMParser();
		File fMetaDataXML = new File(xmlPath);
		FileInputStream fis = new FileInputStream(fMetaDataXML);
		InputSource iSource = new InputSource(fis);
		parser.parse(iSource);
		doc = parser.getDocument(); 
		actList = doc.getElementsByTagName(field); //Get all the XML nodes with given tag
		return actList;
	}

	private static void writeXmlFinalContent()
		throws Exception {
		fXmlOut.write(NEWLINE);
		fXmlOut.write("</Influx-MetaData>"); 
	}
	
	/*
	The following method gives the usage of this java method.This java class takes
	the path of ScreensofMenu.xml,Roles.lst,Languge,Resource file that contains
	the literals and fieldxmls.It passes through the valid fieldxml files and
	picks the literals for the same from the resource file ,parses through the
	roles.lst file and generates a workflow.xml
	*/
	private static void printUsage() {
        System.out.println("Usage: java NewXmlGenerator <menu name to work on>");
        System.out.println("    This utility parses through  valid xml files ");
        System.out.println("    which is been generated from the JSGEN and python script");
        System.out.println("   and  outputs an Workflow.xml file that can paint");
    }
}
