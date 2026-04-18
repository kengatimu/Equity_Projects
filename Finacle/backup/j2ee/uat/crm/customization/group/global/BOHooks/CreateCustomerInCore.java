/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: CreateCustomerInCore.java $
 *
 * Author: Jayanthi$
 *
 * $Archive: /FCRM62BASE/com/infy/cis/custom/BOHooks/CreateCustomerInCore.java $
 *
 * $History: CreateCustomerInCore.java $
 *
 * *****************  Version 8  *****************
 * User: Nixon        Date: 5/12/04    Time: 3:30p
 * Updated in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Tracker : 64434
 * Modified by  :  Jayanthi
 * REviewed by  :  Nixon
 * Comments : Introducer's Name truncated to 40 chars.
 *
 * *****************  Version 8  *****************
 * User: Nixon        Date: 5/07/04    Time: 6:00p
 * Updated in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Modified by: Nixon
 * Comments : The introducer's name size is checked to 40 chars.
 *
 * *****************  Version 7  *****************
 * User: Nixon        Date: 5/07/04    Time: 2:48p
 * Updated in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Modified by : Nixon.
 * Comments:SYSTEM.out.println removed
 *
 * *****************  Version 6  *****************
 * User: 210598       Date: 5/06/04    Time: 7:13p
 * Updated in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Tracker No: 64109 & Tracker No : 64065
 * Modified by : Jayanthi
 * Reviewed by : Nixon
 * Comments:
 * 1. Guardian Address Details are populated if customer is minor
 * 2. Work & Home Address will be populated as "." if any one value is
 * entered in the corresponding field.
 *
 * *****************  Version 5  *****************
 * User: 210598       Date: 4/15/04    Time: 3:35p
 * Updated in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Tracker : 63490
 * Modified by : Jayanthi
 * Reviewed by : Nixon
 * Comments : Modifed to check for special characters or blank in address
 * details during online customer creation
 *
 * *****************  Version 4  *****************
 * User: 210574       Date: 4/06/04    Time: 5:26p
 * Updated in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * getCustId method is made Public
 *
 * Done By
 * Abhinav
 *
 * reviewed By
 * Nixon
 *
 * *****************  Version 3  *****************
 * User: 210598       Date: 3/22/04    Time: 7:25p
 * Updated in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Tracker Id: 60682
 * Modified by : Jayanthi
 * Reviewed by : Nixon
 * Comments : Changes in setting Custid
 *
 * *****************  Version 2  *****************
 * User: 210598       Date: 3/08/04    Time: 8:36a
 * Updated in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * Tracker Id : 60682
 * Modified by : Jayanthi
 * Reviewed by : Nixon
 *
 * *****************  Version 1  *****************
 * User: Nixon        Date: 2/26/04    Time: 11:09a
 * Created in $/FCRM62BASE/com/infy/cis/custom/BOHooks
 * TRacker Id :60682
 * Added by :Jayanthi
 * Reviewed by :Nixon
 *
 * *****************  Version 2  *****************
 * User: Raghavendren_b Date: 12/29/03   Time: 4:38p
 * Updated in $/FCRM62BASE/com/infy/cis/ui/sales
 * TrackerID: 60106
 * Changes:
 * Modified the code to avoid run time exception and removed unwanted
 * codes.
 *
 * Modified By:
 * Raghavendren
 *
 * Reviewed By:
 * Nixon.
 *
 * *****************  Version 1  *****************
 * User: Raghavendren_b Date: 12/23/03   Time: 10:03a
 * Created in $/FCRM62BASE/com/infy/cis/ui/sales
 * TrackerID: 60106
 * Added a new file for calling the ONS method call by providing the
 * information.
 *
 * Added By:
 * Jayanthi
 *
 * Reviewed By:
 * Nixon
 *
 ******************************************************************************/
package com.infy.cis.custom;


public class CreateCustomerInCore
{

}
