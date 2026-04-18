 package com.infy.finacle.workflow.crypto;

import java.io.File;
import java.util.HashMap;

import peas.api.intf.hooks.passwordmgmt.PwdMgIF;
import peas.init.PEASClassLoader;
import peas.common.intf.logging.PEASLoggerIF;
import peas.common.util.CommonUtils;
import peas.common.util.PropertiesFileReader;

import com.infy.finacle.finjinfra.*;

//import org.apache.log4j.Logger;

public class getPwdForDB extends PropertiesFileReader implements PwdMgIF {

	private static String configpath = null;

	public getPwdForDB() {
	}

	public byte[] getPwd() {
		PEASLoggerIF loggerObj = null;
		String sPwdForPeas = "";
		try {
			loggerObj = PEASClassLoader.GetPEASClassLoader().getPEASLoggerIF(
					getPwdForDB.class);
			configpath = CommonUtils.getPEASHome() + File.separator + "config"
					+ File.separator + "config.properties";
			HashMap props = PropertiesFileReader.getProperties(configpath);
			String value = (String) props.get("state_storage_user_name");
			sPwdForPeas = FinSeedUtil.getPwdforApp("PEAS", value);

		} catch (SeedException se) {
			loggerObj.error(se.getMessage());

		} catch (Exception pe) {
			loggerObj.error(pe.getMessage());
		}
		return (sPwdForPeas.getBytes());
	}

	public void changeDBPassword(String currPwd, char[] get, String newPwd,
			char[] set) {
	}

	public byte[] encrypt(char[] encryptString, byte[] key) {
		return (new byte[1]);
	}

	public char[] decrypt(byte[] encrtdData, byte[] key) {
		String str = new String(encrtdData);
		return str.toCharArray();
	}

	public byte[] genKey() {
		return (new byte[10]);
	}

	public byte[] getPwdKey() {
		return (new byte[1]);
	}

	public void storePwd(byte[] pwd) {
	}

	public void storePwdKey(byte[] key) {
	}
}