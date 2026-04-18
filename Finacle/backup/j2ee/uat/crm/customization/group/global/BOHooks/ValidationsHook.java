/******************************************************************************
 * Copyright (c) 2000-2006 Infosys Ltd.  All rights reserved.
 *
 * $Workfile: ValidationsHook.java $
 *
 * Author: Viswanathan_Ramasamy$
 *
 * $Archive: CRM100/com/infy/cis/custom/BOHooks/ValidationsHook.java $
 *
 * $History: ValidationsHook.java $
 *
 * $Description: This file is used for customizing the data defaulting for
 *
 * $TrackerId:
 ********************  Version 1  *********************/
package com.infy.cis.validations;

import com.infy.cis.validatorFrmk.Validations;
import com.infy.cis.srmbo.security.user.SRMBusinessContext;


public class ValidationsHook extends Validations{
    private SRMBusinessContext bc = null;

        public ValidationsHook(Object bCntxt){
            this.bc = (SRMBusinessContext)bCntxt;
        }

}
