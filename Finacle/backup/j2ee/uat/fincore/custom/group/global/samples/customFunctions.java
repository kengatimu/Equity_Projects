/*
	Points to be remember
	--------------------

	1. Customization SHOULD NOT IMPLEMENT any of the core application routines and files.
	   In any case, if the same functionality defined in the core application is required,
	   then re-define the same in the customization files, by changing the routine/file
	   names.

	2. This is sample code. The functions can be modified according to customization
	   requirements.

	3. Please note that this is only a sample file, it will not be maintained by ENGG team.

*/

package customUtil;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.StringTokenizer;
import applcommon.RepositoryManager;
import javax.servlet.http.*;

public class customFunctions
{
	/* Converts custom multi-rec data in customData string to a HashMap */
	public static HashMap getListFromCustData(String llName, String customData)
	{
		if (customData == null)
			return null;

		int index = customData.indexOf("|" + llName + "|");
		if (index == -1)
			return null;

		String llStr = customData.substring(index+1);

		String[] llBuff = split(llStr, "\\|");
		int totRecs = Integer.parseInt(llBuff[1]);

		if (totRecs == 0)
			return null;

		int totFields = Integer.parseInt(llBuff[2]);
		StringBuffer sb = null;
		HashMap hm = new HashMap();

		int maxLen = totRecs*totFields + 3;
		for (int i=3, j=1; i<maxLen; j++)
		{
			sb = new StringBuffer();
			for (int k=0; k<totFields; k++)
			{
				sb.append(llBuff[i]);
				if (k != totFields-1)
					sb.append("|");
				i++;
			}
			hm.put(String.valueOf(j),sb.toString());
		}
		return hm;
	}

	/* Fetches the field values for the passed field Id, and returns a pipe seperated string */
	public static String fetchRecFromRequest(HttpServletRequest httpRequest, String[] fieldArray)
	{
		int fieldArrLen = fieldArray.length;
		StringBuffer sb = new StringBuffer();
		String val = "";
		boolean isValEntered = false;

		for (int i=0; i<fieldArrLen; i++)
		{
			val = httpRequest.getParameter(fieldArray[i]);
			if (val == null) val = "";
			if (!val.equals(""))
				isValEntered = true;

			sb.append(val);
			if (i != fieldArrLen-1)
				sb.append("|");
		}

		if (!isValEntered)
			return "";

		return sb.toString();
	}

	/*
		Process the custom multi-rec data, It updates the current record and
		current record number in the Repository Manager
	*/
	public static void ProcessMultiRec(RepositoryManager ARJspRep, HttpServletRequest httpRequest, String llName, String[] fieldArray) throws Exception
	{
		String 		llDirection	= null;
		String 		recVal		= "";
		int			recNum 		= 0;
		boolean 	isNewRec 	= false;
		HashMap		hm;

		/* Fetch the field values */
		recVal = fetchRecFromRequest(httpRequest, fieldArray);

		if (("").equals(recVal))
			return;

		/* Fetch the multi-rec navigation */
		llDirection = httpRequest.getParameter(llName + "_DIRECTION");
		if (llDirection == null) llDirection = "";

		/*
			Fetcht the LL from Repository Manager
			if does not exist, create a new LL
		*/
		hm = (HashMap)ARJspRep.getVal(llName);
		if (hm == null)
		{
			hm = new HashMap();
			recNum = 1;
		}
		else
			recNum = Integer.parseInt((String)ARJspRep.getVal(llName + "_RecNum"));

		/* Record updation */
			hm.put(String.valueOf(recNum),recVal);

		/* Manupulation of current record number for the passed LL */
		if (llDirection.equals("next"))
			recNum++;
		else if (llDirection.equals("prev"))
			recNum--;

		if (recNum <= 0)
			recNum = 1;

		/* update the LL and current record number in ReposManager */
		ARJspRep.setVal(llName, hm);
		ARJspRep.setVal(llName + "_RecNum", String.valueOf(recNum));
	}

	/*
		This method will return a string containing llName,total number of
		records and total number of fields separated by pipe ("|").
	*/
	public static String formatHashMapToStr(HashMap hm,String llName,int fieldLen)
	{
		if (hm == null)
			return null;

		int hmSize = hm.size();

		if (hmSize == 0)
			return null;

		StringBuffer sb = new StringBuffer(llName);
		sb.append("|");
		sb.append(hmSize);
		sb.append("|");
		sb.append(fieldLen);
		sb.append("|");

		for (int i=1;i<=hmSize;i++)
		{
			sb.append(hm.get(String.valueOf(i)));
			sb.append("|");
		}
		return sb.toString();
	}

	/*	serialize's the passed hashmap data for the given llName and updates the
		same in the customData field
	*/
	public static String SerializeMultiRec(HashMap hm, String llName, String pageName, String custData, int fieldLen)
	{
		/* Get the LL contents in serialized format */
		String listData = formatHashMapToStr(hm,llName,fieldLen);
		if (listData == null)
			return custData;

		if (custData == null) custData = "";

		StringBuffer sb = new StringBuffer();

		/* customData is empty */
		if (("").equals(custData))
		{
			sb.append("~");
			sb.append(pageName);
			sb.append("|");
			sb.append(listData);
		}
		else
		{
			int index = custData.indexOf("~" + pageName);
			if (index == -1)
			{
				sb.append(custData);
				sb.append("|");
				sb.append("~");
				sb.append(pageName);
				sb.append("|");
				sb.append(listData);
			}
			else
			{
				/* pagename is present in the string */
				sb.append(custData.substring(0,index));
				custData = custData.substring(index);
				index = custData.indexOf("~", 1);
				if (index != -1)
				{
					/* someother pagename is also present */
					sb.append(custData.substring(index));
					custData = custData.substring(0,index);
				}

				/*	Now the custData contains the actual string for formating.
					Remove the current LL content from the custData
					possible cases here are...
					"~custper|C|D|E|solIdList|....|acctIdList|....|thinksoft|....|"
					"~custper|C|D|E|"
					"~custper|C|D|E|acctIdList|....|"
				*/
				index = custData.indexOf("|" + llName + "|");
				if (index == -1)
				{
					sb.append(custData);
					sb.append(listData);
				}
				else
				{
					/* here means custrec data is avaliable */
					sb.append(custData.substring(0,index));
					custData = custData.substring(index+1);
					String[] buff = split(custData, "\\|");
					int totLen = 0;
					int noOfTokens = Integer.parseInt(buff[1]) * Integer.parseInt(buff[2]) + 3;
					for (int i=0; i<noOfTokens; i++)
					{
						totLen += buff[i].length();
					}
					totLen += noOfTokens;

					StringBuffer sbTemp = new StringBuffer(custData);
					sbTemp.delete(0,totLen);
					sb.append("|");
					sb.append(listData);
					custData = sbTemp.toString();
					sb.append(sbTemp.toString());
				}
			}
		}
		return (sb.toString());
	}

    public static String[] split(String sStr, String sdelim)
    {
        StringTokenizer st = new StringTokenizer(sStr, sdelim);
        ArrayList aArr = new ArrayList();

        while (st.hasMoreTokens())
        {
            aArr.add(st.nextToken());
        }

        String[] srArr = new String[aArr.size()];

        for (int i=0;i<srArr.length;i++)
        {
            srArr[i] = (String)aArr.get(i);
        }

        return srArr;
    }
}
