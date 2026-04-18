#!/bin/bash

LCP=build
LCP=$LCP:lib/AgentConnectSimulator.jar
LCP=$LCP:lib/Base64-2.0.2.zip
LCP=$LCP:lib/java-getopt-1.0.9.jar
LCP=$LCP:lib/LoggingClient.jar
LCP=$LCP:lib/commons-httpclient-2.0.jar
LCP=$LCP:lib/commons-logging.jar
LCP=$LCP:lib/jakarta-regexp.jar
LCP=$LCP:lib/jax-1_1-fr-qname-class.jar
LCP=$LCP:lib/jdom.jar:lib/log4j-1.2.8.jar
LCP=$LCP:lib/wsdl4j.jar:lib/xalan.jar
LCP=$LCP:lib/xercesImpl.jar
LCP=$LCP:lib/xml-apis.jar
LCP=$LCP:lib/sfc.jar

# Uncomment the following line to see the full classpath
# echo $LCP

jre6/bin/java -Xss1M -Dsun.java2d.noddraw=true -cp "$LCP" com.moneygram.agentconnect.simulator.AgentConnectSimulator "$@"