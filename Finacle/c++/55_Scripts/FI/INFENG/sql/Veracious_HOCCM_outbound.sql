
/*please check before executing the following 2 statements. If the entries with these values are already there, then there is no need to execute them again*/
insert into FIMASTER.port_type values (port_type_seq.nextval, 'Webservice', 'webservice call', 'SYSTEM', sysdate, 1, 'processed', 'Dummy Class')
   
insert into FIMASTER.port_type_parameters values ((select port_type_id from FIMASTER.port_type where port_type = 'Webservice'),'URL', 'processed', PORT_TYPE_PARAM_SEQ.nextval, 'Y', 'String', '')


/*The following entry will be common for all the veracious related outbound calls*/
Insert into FIMASTER.HOST_INTERFACE_NODE_TABLE(HOST_INTERFACE_NODE_ID, HOST_INTERFACE_CODE, HOST_INTERFACE_DESC, REQUEST_PORT_ID, RESPONSE_PORT_ID, PORT_STATUS, USER_GROUP_ID, USER_GROUP_STATUS,HOST_TYPE)
Values(FIMASTER.HOST_INTERFACE_NODE_SEQ.nextval, 'Veracious', 'Veracious', NULL, NULL,'processed', 1001, 'processed','EXTERNAL')


/*the sql's after these need to be executed for DeleteChq*/
insert into FIMASTER.ports_master values (fimaster.ports_master_seq.nextval, 'DELETECHQ', 'DEL chq outbound','SYSTEM', sysdate, 'processed', 1, 
    (select port_type_id from FIMASTER.port_type where port_type='Webservice'), 'processed','no','')
        
insert into FIMASTER.PORT_PARAM_MAPPING values ((select port_id from FIMASTER.ports_master where port_name = 'DELETECHQ'), (select port_parameter_id from FIMASTER.port_type_parameters where parameter_name = 'URL'), 'http://veraciousdev.ebsafrica.com /RDAPI/RDService.svc/DeleteCheque/{0}', 'processed')
 
INSERT INTO FIMASTER.FIUSB_SERVICE_PROVIDER_TABLE ( FIUSB_SRV_PROV_ID, FIUSB_SRV_PROV_NAME, FIUSB_SRV_PROV_DESC, HOST_INTERFACE_NODE_ID, HOST_INTERFACE_NODE_STATUS, FIUSB_SRV_PROV_LMU, FIUSB_SRV_PROV_LMD, FIUSB_SRV_PROV_VER_NO, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_PROV_CLASS_NAME ) 
VALUES(FIMASTER.FIUSB_SRV_PROV_ID_SEQ.nextval, 'DeleteChq', 'DeleteChq', (select HOST_INTERFACE_NODE_ID from FIMASTER.HOST_INTERFACE_NODE_TABLE where HOST_INTERFACE_CODE = 'Veracious'), 'processed', 'SYSTEM' ,sysdate, 1, 'processed', 'com.infosys.ci.custom.fioutbound.DeleteChq')
         
INSERT INTO FIMASTER.FIUSB_SERVICE_REQUESTOR_TABLE ( FIUSB_SRV_REQ_ID, FIUSB_SRV_REQ_TYPE, FIUSB_SRV_INVOC_MODE, FIUSB_SRV_REQ_LMU, FIUSB_SRV_REQ_LMD, FIUSB_SRV_REQ_VER_NO, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_REQ_TYPE_VERSION, FIUSB_SRV_REQ_NAME, FIUSB_SRV_REQ_DESC, FIUSB_NOT_SRV_REQ_ID, FIUSB_NOT_SRV_REQ_STATUS, FIUSB_SRV_INTERACTION_TYPE)
VALUES(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.NEXTVAL,'DeleteChq', 'SYNCHRONOUS', 'SYSTEM',  sysdate, 1, 'processed', '10.2','DeleteChq','DeleteChq', NULL, NULL, 'Invoker')
        
INSERT INTO FIMASTER.FIUSB_SERVICE_INTERFACE_TABLE ( FIUSB_SRV_INT_ID, FIUSB_SRV_PROV_ID, FIUSB_REVERSAL_SRV_INT_ID, FIUSB_SRV_INT_LMU, FIUSB_SRV_INT_LMD, FIUSB_SRV_INT_VER_NO, FIUSB_SRV_INT_STATUS, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_INT_NAME, FIUSB_SRV_INT_DESC, FIUSB_REVERSAL_SRV_INT_STATUS, FIUSB_REQ_MAPPER, FIUSB_RESP_MAPPER, FIUSB_SRV_INT_VERSION, FIUSB_MAPPER_STATUS,message_type,message_sub_type) 
VALUES(FIMASTER.FIUSB_SRV_INTER_ID_SEQ.NEXTVAL,  FIMASTER.FIUSB_SRV_PROV_ID_SEQ.CURRVAL, NULL, 'SYSTEM',sysdate, 1, 'processed', 'processed', 'DeleteChq','DeleteChq', NULL, NULL,NULL, '10.2', 'processed','NVPSTR','FINVP')
       
Insert into FIMASTER.FIUSB_SRV_REQ_MAPPING_TABLE(FIUSB_SRV_REQ_ID, FIUSB_SRV_INT_ID, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_INT_STATUS, FIUSB_PROV_INVOC_MODE, FIUSB_PROV_TIMEOUT)
Values(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.currval, FIMASTER.FIUSB_SRV_INTER_ID_SEQ.currval, 'processed', 'processed', 'S', NULL)


/*the sql's after these need to be executed for ReleaseCheque*/
insert into FIMASTER.ports_master values (fimaster.ports_master_seq.nextval, 'RELEASECHEQUE', 'RELEASECHEQUE','SYSTEM', sysdate, 'processed', 1, (select port_type_id from FIMASTER.port_type where port_type='Webservice'), 'processed','no','')
        
insert into FIMASTER.PORT_PARAM_MAPPING values ((select port_id from FIMASTER.ports_master where port_name = 'RELEASECHEQUE'), (select port_parameter_id from FIMASTER.port_type_parameters where parameter_name = 'URL'), 'http://veraciousdev.ebsafrica.com /RDAPI/RDService.svc/ReleaseCheque/{0}', 'processed')
 
INSERT INTO FIMASTER.FIUSB_SERVICE_PROVIDER_TABLE ( FIUSB_SRV_PROV_ID, FIUSB_SRV_PROV_NAME, FIUSB_SRV_PROV_DESC, HOST_INTERFACE_NODE_ID, HOST_INTERFACE_NODE_STATUS, FIUSB_SRV_PROV_LMU, FIUSB_SRV_PROV_LMD, FIUSB_SRV_PROV_VER_NO, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_PROV_CLASS_NAME ) 
VALUES(FIMASTER.FIUSB_SRV_PROV_ID_SEQ.nextval, 'ReleaseCheque', 'ReleaseCheque', (select HOST_INTERFACE_NODE_ID from FIMASTER.HOST_INTERFACE_NODE_TABLE where HOST_INTERFACE_CODE = 'DeleteChq'), 'processed', 'SYSTEM' ,sysdate, 1, 'processed', 'com.infosys.ci.custom.fioutbound.ReleaseCheque')
         
INSERT INTO FIMASTER.FIUSB_SERVICE_REQUESTOR_TABLE ( FIUSB_SRV_REQ_ID, FIUSB_SRV_REQ_TYPE, FIUSB_SRV_INVOC_MODE, FIUSB_SRV_REQ_LMU, FIUSB_SRV_REQ_LMD, FIUSB_SRV_REQ_VER_NO, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_REQ_TYPE_VERSION, FIUSB_SRV_REQ_NAME, FIUSB_SRV_REQ_DESC, FIUSB_NOT_SRV_REQ_ID, FIUSB_NOT_SRV_REQ_STATUS, FIUSB_SRV_INTERACTION_TYPE)
VALUES(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.NEXTVAL,'ReleaseCheque', 'SYNCHRONOUS', 'SYSTEM',  sysdate, 1, 'processed', '10.2','ReleaseCheque','ReleaseCheque', NULL, NULL, 'Invoker')
        
INSERT INTO FIMASTER.FIUSB_SERVICE_INTERFACE_TABLE ( FIUSB_SRV_INT_ID, FIUSB_SRV_PROV_ID, FIUSB_REVERSAL_SRV_INT_ID, FIUSB_SRV_INT_LMU, FIUSB_SRV_INT_LMD, FIUSB_SRV_INT_VER_NO, FIUSB_SRV_INT_STATUS, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_INT_NAME, FIUSB_SRV_INT_DESC, FIUSB_REVERSAL_SRV_INT_STATUS, FIUSB_REQ_MAPPER, FIUSB_RESP_MAPPER, FIUSB_SRV_INT_VERSION, FIUSB_MAPPER_STATUS,message_type,message_sub_type) 
VALUES(FIMASTER.FIUSB_SRV_INTER_ID_SEQ.NEXTVAL, FIMASTER.FIUSB_SRV_PROV_ID_SEQ.CURRVAL, NULL, 'SYSTEM',sysdate, 1, 'processed', 'processed', 'ReleaseCheque','ReleaseCheque', NULL, NULL,NULL, '10.2', 'processed','NVPSTR','FINVP')
       
Insert into FIMASTER.FIUSB_SRV_REQ_MAPPING_TABLE(FIUSB_SRV_REQ_ID, FIUSB_SRV_INT_ID, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_INT_STATUS, FIUSB_PROV_INVOC_MODE, FIUSB_PROV_TIMEOUT)
Values(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.currval, FIMASTER.FIUSB_SRV_INTER_ID_SEQ.currval, 'processed', 'processed', 'S', NULL)


/*the sql's after these need to be executed for GetRepresentment*/
insert into FIMASTER.ports_master values (fimaster.ports_master_seq.nextval, 'GETREPRESENTMENT', 'GETREPRESENTMENT','SYSTEM', sysdate, 'processed', 1, (select port_type_id from FIMASTER.port_type where port_type='Webservice'), 'processed','no','')
        
insert into FIMASTER.PORT_PARAM_MAPPING values ((select port_id from FIMASTER.ports_master where port_name = 'GETREPRESENTMENT'), (select port_parameter_id from FIMASTER.port_type_parameters where parameter_name = 'URL'), 'http://veraciousdev.ebsafrica.com /RDAPI/RDService.svc/RepresentCheque/{0}', 'processed')

INSERT INTO FIMASTER.FIUSB_SERVICE_PROVIDER_TABLE ( FIUSB_SRV_PROV_ID, FIUSB_SRV_PROV_NAME, FIUSB_SRV_PROV_DESC, HOST_INTERFACE_NODE_ID, HOST_INTERFACE_NODE_STATUS, FIUSB_SRV_PROV_LMU, FIUSB_SRV_PROV_LMD, FIUSB_SRV_PROV_VER_NO, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_PROV_CLASS_NAME ) 
VALUES(FIMASTER.FIUSB_SRV_PROV_ID_SEQ.nextval, 'GetRepresentment', 'GetRepresentment', (select HOST_INTERFACE_NODE_ID from FIMASTER.HOST_INTERFACE_NODE_TABLE where HOST_INTERFACE_CODE = 'Veracious'), 'processed', 'SYSTEM' ,sysdate, 1, 'processed', 'com.infosys.ci.custom.fioutbound.GetRepresentment');

INSERT INTO FIMASTER.FIUSB_SERVICE_REQUESTOR_TABLE ( FIUSB_SRV_REQ_ID, FIUSB_SRV_REQ_TYPE, FIUSB_SRV_INVOC_MODE, FIUSB_SRV_REQ_LMU, FIUSB_SRV_REQ_LMD, FIUSB_SRV_REQ_VER_NO, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_REQ_TYPE_VERSION, FIUSB_SRV_REQ_NAME, FIUSB_SRV_REQ_DESC, FIUSB_NOT_SRV_REQ_ID, FIUSB_NOT_SRV_REQ_STATUS, FIUSB_SRV_INTERACTION_TYPE)
VALUES(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.NEXTVAL,'GetRepresentment', 'SYNCHRONOUS', 'SYSTEM',  sysdate, 1, 'processed', '10.2','GetRepresentment','GetRepresentment', NULL, NULL, 'Invoker');

INSERT INTO FIMASTER.FIUSB_SERVICE_INTERFACE_TABLE ( FIUSB_SRV_INT_ID, FIUSB_SRV_PROV_ID, FIUSB_REVERSAL_SRV_INT_ID, FIUSB_SRV_INT_LMU, FIUSB_SRV_INT_LMD, FIUSB_SRV_INT_VER_NO, FIUSB_SRV_INT_STATUS, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_INT_NAME, FIUSB_SRV_INT_DESC, FIUSB_REVERSAL_SRV_INT_STATUS, FIUSB_REQ_MAPPER, FIUSB_RESP_MAPPER, FIUSB_SRV_INT_VERSION, FIUSB_MAPPER_STATUS,message_type,message_sub_type) 
VALUES(FIMASTER.FIUSB_SRV_INTER_ID_SEQ.NEXTVAL, FIMASTER.FIUSB_SRV_PROV_ID_SEQ.CURRVAL, NULL, 'SYSTEM',sysdate, 1, 'processed', 'processed', 'GetRepresentment','GetRepresentment', NULL, NULL,NULL, '10.2', 'processed','NVPSTR','FINVP')

Insert into FIMASTER.FIUSB_SRV_REQ_MAPPING_TABLE(FIUSB_SRV_REQ_ID, FIUSB_SRV_INT_ID, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_INT_STATUS, FIUSB_PROV_INVOC_MODE, FIUSB_PROV_TIMEOUT)
Values(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.currval, FIMASTER.FIUSB_SRV_INTER_ID_SEQ.currval, 'processed', 'processed', 'S', NULL);

