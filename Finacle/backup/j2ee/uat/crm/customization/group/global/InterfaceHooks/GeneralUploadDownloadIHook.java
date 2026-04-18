
package com.infy.intl.custom;

import com.infosys.insulate.util.Vector;
import java.util.Hashtable;
import java.sql.Connection;

import com.infy.intl.exception.IntlBypassException;

public interface GeneralUploadDownloadIHook {

    public void preUpload() throws IntlBypassException;

    public void postUpload() throws IntlBypassException;

    public void preDownload() throws IntlBypassException;

    public void postDownload() throws IntlBypassException;
}



