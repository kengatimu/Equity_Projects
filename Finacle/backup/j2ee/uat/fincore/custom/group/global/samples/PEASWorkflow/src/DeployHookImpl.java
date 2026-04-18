package com.infy.finacle.workflow.deployHook;

import java.util.ArrayList;
import java.util.StringTokenizer;

import peas.client.api.intf.exception.PEASAPIDeployException;
import peas.api.intf.hooks.deploy.*;

/*
 * This Class is used to call a FIservice call  when a process is
 * deployed in the ADMIN portal.
 * This will send the processname and entity id's as a seperate
 * parameters to the FIService  callAddMenuFIService method by parsing
 * the concatinated processname and entiyid
 */

public class DeployHookImpl implements DeployIF {

	public DeployHookImpl() {

	}

	public Object onDeploy(String sprocessName) throws PEASAPIDeployException {

		String[] a_entity = new String[2];
		String app_entity = new String();
		String processName = null;
		StringTokenizer Token = new StringTokenizer(sprocessName, "$");
		int count = 0;
		while (Token.hasMoreTokens()) {
			a_entity[count] = Token.nextToken();

			count++;
			if (count == 2) {
				break;
			}

		}


		processName = a_entity[0];
		System.out.println("processName : "+processName);

		int indexAppEnt = a_entity[1].indexOf("applicableEntity=");

		String applicableEntity = a_entity[1].substring(indexAppEnt + 17,
				a_entity[1].length());

		if (applicableEntity.indexOf("\n") != -1) {
			Token = new StringTokenizer(applicableEntity, "\n");
			while (Token.hasMoreTokens()) {
				app_entity = Token.nextToken();

				break;
			}
		} else
			app_entity = applicableEntity;

		String newEntity = app_entity;

		ArrayList s2 = new ArrayList();

		Token = new StringTokenizer(newEntity, ",");
		count = 0;
		while (Token.hasMoreTokens()) {
			s2.add(count, Token.nextToken());
			count++;
		}
		for (count = 0; count < s2.size(); count++) {
			System.out.println("The entites are:" + s2.get(count));

			// CALL TO  FISERVICE

			FIService fi = new FIService();
			fi.callAddMenuFIService(processName, s2.get(count));
			if (fi.callAddMenuFIService(processName, s2.get(count)) == true) {
				System.out.println("Successfully Inserted into entity Id==>"
						+ s2.get(count));
			} else {
				throw new PEASAPIDeployException(
						"Process deployment failed for entity id==>"
								+ s2.get(count));

			}

		}

		return null;

	}

}
