<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : gecmcrit_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 27-11-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HGECM
<!--Modification History:
<!--    Version No.     Date            Author          Description
<!--    -----------     ------          ----------      ---------------------------
<!--    0.1             27-11-2013      jane            Original version
<!--    0.2             29-08-2020      Irungu          Add TELLER5
<!---------------------------------------------------------------------------------------------------------------->
<script>
function gecmcrit_pre_ONCLICK(obj)
        {
        if(mopId == "HGECM")
                {
                if (obj.id == "Accept")
                {
                        var     dco=document.forms[0].empId.value;
                        var input      = "dco|"+dco;
                        var outputNames    = "output|outVal";
                        var scrName     =   "b_gecmdet.scr";
                        var retVal = appFnExecuteScript(input,outputNames,scrName,false);
                        var retBuff = retVal.split("|");
                        var output = retBuff[0];
                        var value = retBuff[1];
                        var a = value;

                        if(profileId ==56)
                        {
                                if ((a!="ICT") && (a!="NTL") && (a!="RTL") && (a!="CTL") && (a!="TELLER4") && (a!="TELLER5") && (a!="N") && (a!="STL") )
                                {
                                        alert("Role id not allowed");
                                        document.forms[0].empId.focus();
                                        return false;
                                }
                        }else
                        {
                              if ((a!="ICT") && (a!="NTL") && (a!="RTL") && (a!="CTL") && (a!="TELLER4") && (a!="TELLER5") && (a!="N"))
                                {
                                        alert("Role id not allowed");
                                        document.forms[0].empId.focus();
                                        return false;
                                }  
                        }

                }

                }

        }



</script>
