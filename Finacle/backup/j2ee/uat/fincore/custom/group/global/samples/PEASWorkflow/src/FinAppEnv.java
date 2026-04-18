package appenv;

import peas.api.intf.hooks.appenv.ApplicationEnvironment;
import peas.api.intf.hooks.appenv.ApplicationGlobalContext;
import peas.api.intf.javacompif.GlobalException;
import com.peas.SystemContext;
import FABCommon.SecurityInfo70;

/**
 * This will set Application Environment to PEAS. 
 * This will go to appEnvHookDir in PEAS_HOME
 **/

public class FinAppEnv implements ApplicationEnvironment {

    public FinAppEnv() {
        super();
    }

    public ApplicationGlobalContext fetchApplicationContext()
            throws GlobalException {
		//Create the global context object

        ApplicationGlobalContext appContext = new ApplicationGlobalContext();

		//Create an instance of SystemContext class that has details of virtual user 
		//login to Finacle
		/*SystemContext finAppContext = new SystemContext();	
		finAppContext.getServiceRoutines();

		if(null != finAppContext){
			appContext.addParam("ServiceRoutines",finAppContext.getServiceRoutines());
			appContext.addParam("SecurityInfo",finAppContext.getSecurityInfo());
		}
		if(null == finAppContext ||
			null == appContext.getParam("ServiceRoutines") ||
			null == appContext.getParam("SecurityInfo")||
			null == ((SecurityInfo70)appContext.getParam("SecurityInfo")).sessionId ||
			("").equals(((SecurityInfo70)appContext.getParam("SecurityInfo")).sessionId)){
			throw new GlobalException("GLB","Global Error occured");
		}*/
        
        return appContext;
		
    }

}
