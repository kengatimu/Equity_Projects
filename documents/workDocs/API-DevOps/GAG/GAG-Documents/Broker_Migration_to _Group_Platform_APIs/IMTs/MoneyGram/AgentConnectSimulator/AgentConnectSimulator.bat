@echo off
set LCP=build
set LCP=%LCP%;lib/AgentConnectSimulator.jar
set LCP=%LCP%;lib/Base64-2.0.2.zip
set LCP=%LCP%;lib/java-getopt-1.0.9.jar
set LCP=%LCP%;lib/LoggingClient.jar
set LCP=%LCP%;lib/commons-httpclient-2.0.jar
set LCP=%LCP%;lib/commons-logging.jar
set LCP=%LCP%;lib/jakarta-regexp.jar
set LCP=%LCP%;lib/jax-1_1-fr-qname-class.jar
set LCP=%LCP%;lib/jdom.jar;lib/log4j-1.2.8.jar
set LCP=%LCP%;lib/wsdl4j.jar;lib/xalan.jar
set LCP=%LCP%;lib/xercesImpl.jar;
set LCP=%LCP%lib/xml-apis.jar;
set LCP=%LCP%lib/sfc.jar
rem echo %LCP%
jre6\bin\java -Xss1M -Dsun.java2d.noddraw=true -cp %LCP% com.moneygram.agentconnect.simulator.AgentConnectSimulator %1 %2 %3 %4 %5 %6 %7 %8 %9
rem pause
