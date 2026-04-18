function fnClearFields()
{
    var b = document.forms[0];
    var a = b.length;
    for (i = 0; i < a; i++)
    {
        if (b[i].type == "text" || b[i].type == "textarea")
        {
            var c = b[i].value;
            b[i].value = ""
        }
        else
        {
            if (b[i].type == "select-one")
            {
                b[i].options[0].selected = "true"
            }
            else
            {
                if (b[i].type == "radio")
                {
                    b[i].checked = "false"
                }
            }
        }
    }
    b.actionCode.value = "Clear";
    b.submit()
}

function fnDisableFormControls(c)
{
    var b = document.forms[0];
    var a = b.length;
    for (i = 0; i < a; i++)
    {
        if ((b[i].type == "text") || (b[i].type == "textarea"))
        {
            b[i].readOnly = true
        }
        else
        {
            if (b[i].type == "select-one")
            {
                b[i].disabled = true
            }
            else
            {
                if (b[i].type == "checkbox" || b[i].type == "radio")
                {
                    b[i].disabled = true
                }
            }
        }
    }
    if ((c.Validate != undefined) && (c.Validate != null))
    {
        c.Validate.disabled = true
    }
}

function fnValAndSubmit(a)
{
    if (fnValidateData())
    {
        doSubmit(a.id)
    }
}

function fnGotoTab(a)
{
    var b = document.forms[0];
    if (funcCode == "A" || funcCode == "M")
    {
        if (fnValidateData())
        {
            b.tabName.value = a;
            doSubmit("gotoTab")
        }
    }
    else
    {
        b.tabName.value = a;
        doSubmit("gotoTab")
    }
}

function writeCustomHeader(pagename)
{
    writeRefData();
    with(document)
    {
        write('<input type="hidden" name="actionCode" id="actionCode">');
        write('<input type="hidden" name="tabName">');
        write('<input type="hidden" name="callMode"   id="callMode"  value="E">');
        write('<input type="hidden" name="pagename" value="' + pagename + '">');
        write('<input type="hidden" name="listCtrlName" id="listCtrlName">');
        write('<input type="hidden" name="screenName" value="' + pagename + '">');
        write('<input type="hidden" name="rtId" id="rtId" value="' + rtId + '">');
        write('<input type="hidden" name="reqId" id="reqId" value="' + reqId + '">');
        write('<input type="hidden" name="srvType" id="srvType" value="">');
        write('<input type="hidden" name="fiSrvObject" id="fiSrvObject" value="">');
        write('<input type="hidden" name="fiAPIPreScriptName" id="fiAPIPreScriptName" value="">');
        write('<input type="hidden" name="fiAPIPostScriptName" id="fiAPIPostScriptName" value="">')
    }
}

function fnSubmitForm(a)
{
    doSubmit(a.id)
}

function fnCancel(a)
{
    if (confirm(finbranchResArr.get("FAT000925")))
    {
        document.location.href = jsUtil.formatUrl("../Customize/Customize_ctrl.jsp?actionCode=" + a.id);
        return true
    }
}

function doJsPrint(h, l, g, k)
{
    var a = "../custom/jsp/cust_rpt_print.jsp?";
    if (!cust_fnIsNull(h))
    {
        a += "&rptFileName=" + h
    }
    if (!cust_fnIsNull(l))
    {
        a += "&printFunctionName=" + l
    }
    if (!cust_fnIsNull(g))
    {
        a += "&duplicatePrintAllowed=" + g
    }
    if (!cust_fnIsNull(k))
    {
        a += "&printOnLoad=" + k
    }
    a += "&retPage=Y";
    var f = screen.width,
        c = screen.height;
    var j = (f - 120),
        d = (c - 150);
    var e = "dialogWidth=500px;dialogHeight=500px;dialogLeft=" + j + "px;dialogTop=" + d + "px";
    e += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";
    var b = "";
    if (window.showModalDialog)
    {
        b = popModalWindow(a, "", e)
    }
    else
    {
        window.open(a, "title", "width=10px,height=10px,modal=yes,top=" + d + "px,left=" + j + "px,scrollbars=yes,toolbar=no,menubar=no,help=no")
    }
    if (b == null || b == undefined)
    {
        return b
    }
}

function cust_fnIsNull(a)
{
    a = cust_fnTrim(a);
    if (a == null || a == "")
    {
        return true
    }
    return false
}

function cust_fnTrim(b)
{
    var a;
    len = b.length;
    var b = b;
    begin = -1;
    for (a = 0; a < len; a++)
    {
        if (b.charAt(a) == " ")
        {
            begin = a
        }
        else
        {
            break
        }
    }
    b = b.slice(begin + 1, len);
    len = b.length;
    end = len;
    for (a = len - 1; a >= 0; a--)
    {
        if (b.charAt(a) == " ")
        {
            end = a
        }
        else
        {
            break
        }
    }
    b = b.slice(0, end);
    return b
}

function writeRefData()
{
    with(document)
    {
        write('<input type="hidden" name="entity_id" id="entity_id" value=" ">');
        write('<input type="hidden" name="entity_details" id="entity_details" value=" ">');
        write('<input type="hidden" name="financial_tran_flg" id="financial_tran_flg" value="N">')
    }
}

function setRefData(a, d, b)
{
    var c = document.forms[0];
    c.entity_id.value = a;
    c.entity_details.value = d;
    c.financial_tran_flg.value = b
}

function fnExecuteInterface(inputNameValues, outputNames, classname, isPopulationReq)
{
    var sUrl = "../custom/jsp/cust_frm_fetch_fi.jsp?";
    if (!cust_fnIsNull(inputNameValues))
    {
        sUrl += "&inputs=" + encodeURIComponent(inputNameValues)
    }
    if (cust_fnIsNull(classname))
    {
        alert("Class Name is mandatory");
        return
    }
    sUrl += "&classname=" + encodeURIComponent(classname);
    if (isPopulationReq && cust_fnIsNull(outputNames))
    {
        alert("Output Names are mandatory");
        return
    }
    var xMax = screen.width,
        yMax = screen.height;
    var xOffset = (xMax - 120),
        yOffset = (yMax - 150);
    var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft=" + xOffset + "px;dialogTop=" + yOffset + "px";
    params += ";status=no;toolbar=no;menubar=no;resizable=yes;help=no;center=no";
    var retVal = "";
    retVal = popModalWindowForProcessing(sUrl, "title", params);
    if (retVal == null || retVal == undefined)
    {
        return retVal
    }
    var retBuff = retVal.split("|");
    var retBuffLen = retBuff.length;
    if (retBuff[0] == "Err")
    {
        var str = "";
        for (var i = 1; i < retBuffLen; i++)
        {
            str += retBuff[i] + "\n"
        }
        alert(str);
        return
    }
    if (!isPopulationReq)
    {
        return retVal
    }
    var frm = document.forms[0];
    var outBuff = outputNames.split("|");
    var outBuffLen = outBuff.length;
    for (var i = 0; i < outBuffLen; i++)
    {
        for (var j = 0; j < retBuffLen; j++)
        {
            if (outBuff[i] == retBuff[j])
            {
                if ((eval("frm." + outBuff[i]) != undefined))
                {
                    eval("frm." + outBuff[i] + '.value="' + retBuff[j + 1] + '"');
                    break
                }
            }
        }
    }
}

function makeFISRVCalls(b, c, a, d)
{
    var e = document.forms[0];
    e.srvType.value = "FI";
    e.fiSrvObject.value = c;
    if (!cust_fnIsNull(a))
    {
        e.fiAPIPreScriptName.value = a
    }
    if (!cust_fnIsNull(d))
    {
        e.fiAPIPostScriptName.value = d
    }
    doSubmit(b)
}

function fnDisableFormDataControls(k, c, m)
{
    var b = "A";
    var n = "C";
    var g = "M";
    var f = "V";
    var h = "I";
    var e = "D";
    var l = "U";
    var d = "X";
    if (k == f || k == h || k == e || k == l || k == d)
    {
        var a = c.elements;
        var j = a.length;
        if (Number(m) > 0)
        {
            disableHyperLnks(Number(m))
        }
        for (i = 0; i < j; i++)
        {
            if ((a[i].type == "text") || (a[i].type == "textarea"))
            {
                a[i].readOnly = true;
                if (a[i].getAttribute("hotKeyId") == "LowLimit")
                {
                    a[i].readOnly = false
                }
            }
            else
            {
                if (a[i].type == "select-one")
                {
                    a[i].disabled = true
                }
                else
                {
                    if (a[i].type == "checkbox" || a[i].type == "radio")
                    {
                        a[i].disabled = true;
                        a[i].setAttribute("fds", "Y")
                    }
                }
            }
            if (c.menuName != undefined)
            {
                c.menuName.readOnly = false
            }
        }
        if ((c.Validate != undefined) && (c.Validate != null))
        {
            c.Validate.disabled = true
        }
        if ((c.Clear != undefined) && (c.Clear != null))
        {
            c.Clear.disabled = true
        }
    }
    if (k == h)
    {
        if ((c.Submit != undefined) && (c.Submit != null))
        {
            c.Submit.disabled = true
        }
    }
    if (k != b && k != g && k != n)
    {
        if ((c.AddNew != undefined) && (c.AddNew != null))
        {
            c.AddNew.disabled = true
        }
        if ((c.AddNewPage != undefined) && (c.AddNewPage != null))
        {
            c.AddNewPage.disabled = true
        }
    }
};