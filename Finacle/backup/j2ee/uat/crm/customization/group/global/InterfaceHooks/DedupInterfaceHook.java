/******************************************************************************
 * Copyright (c) 2000-2005 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: DedupInterfaceHook.java $
 *
 * Author: Jamuna G
 *
 * $Archive: $
 *
 *
 * $History: DedupInterfaceHook.java $
 *
 */

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **BEGIN  CHANGES** */

package com.infy.intl.custom;

import com.infy.intl.exception.IntlBypassException;

public interface DedupInterfaceHook {

    public void precheckCID(String strCIDType, String strCIDValue) throws IntlBypassException;
    public String[] postcheckCID (String strCIDType, String strCIDValue, String[] strRetVal);

    public void precheckCIDAcc(String  strCIDType, String strCIDValue) throws IntlBypassException;
    public String[] postcheckCIDAcc(String strCIDType, String strCIDValue, String[] strRetVal);

    public void precheckCIDSus(String strCIDType, String strCIDValue) throws IntlBypassException;
    public String[] postcheckCIDSus(String strCIDType, String strCIDValue, String[] strRetVal);

    public void precheckCIDCon(String strCIDType, String strCIDValue) throws IntlBypassException;
    public String[] postcheckCIDCon(String strCIDType, String strCIDValue, String[] strRetVal);


}

/* CRM61SR:SRCIUHIN:TRACKER# 44232 **END OF CHANGES** */
