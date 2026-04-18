-------------------------------------------------------------------------------------------------------
-- Name                 : FI_UBP_Remote.sql
-- Date                 : 08-Aug-2013
-- Description          : This script is used for creating FI entries for remote calls from CUBP.
-- Author               : Manasi Kalkundri
-------------------------------------------------------------------------------------------------------

/*common inserts for service provider, service interface and service requestor*?
Insert into FIMASTER.HOST_INTERFACE_NODE_TABLE(HOST_INTERFACE_NODE_ID, HOST_INTERFACE_CODE, HOST_INTERFACE_DESC, REQUEST_PORT_ID, RESPONSE_PORT_ID, PORT_STATUS, USER_GROUP_ID, USER_GROUP_STATUS,HOST_TYPE)
Values(FIMASTER.HOST_INTERFACE_NODE_SEQ.nextval, 'Remote_call', 'Remote Call', NULL, NULL,'processed', 1001, 'processed','EXTERNAL')
  
INSERT INTO FIMASTER.FIUSB_SERVICE_PROVIDER_TABLE ( FIUSB_SRV_PROV_ID, FIUSB_SRV_PROV_NAME, FIUSB_SRV_PROV_DESC, HOST_INTERFACE_NODE_ID, HOST_INTERFACE_NODE_STATUS, FIUSB_SRV_PROV_LMU, FIUSB_SRV_PROV_LMD, FIUSB_SRV_PROV_VER_NO, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_PROV_CLASS_NAME ) 
VALUES(FIMASTER.FIUSB_SRV_PROV_ID_SEQ.nextval, 'Remote_call', 'Remote call', FIMASTER.HOST_INTERFACE_NODE_SEQ.currval, 'processed', 'SYSTEM' ,sysdate, 1, 'processed', 'com.infosys.ci.custom.fioutbound.CommonServiceProvider')
         
INSERT INTO FIMASTER.FIUSB_SERVICE_REQUESTOR_TABLE ( FIUSB_SRV_REQ_ID, FIUSB_SRV_REQ_TYPE, FIUSB_SRV_INVOC_MODE, FIUSB_SRV_REQ_LMU, FIUSB_SRV_REQ_LMD, FIUSB_SRV_REQ_VER_NO, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_REQ_TYPE_VERSION, FIUSB_SRV_REQ_NAME, FIUSB_SRV_REQ_DESC, FIUSB_NOT_SRV_REQ_ID, FIUSB_NOT_SRV_REQ_STATUS, FIUSB_SRV_INTERACTION_TYPE)
VALUES(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.NEXTVAL,'Remote_call', 'SYNCHRONOUS', 'SYSTEM',  sysdate, 1, 'processed', '10.2','Remote_call','Interface for Finacle and payments third party', NULL, NULL, 'Invoker')
        
INSERT INTO FIMASTER.FIUSB_SERVICE_INTERFACE_TABLE ( FIUSB_SRV_INT_ID, FIUSB_SRV_PROV_ID, FIUSB_REVERSAL_SRV_INT_ID, FIUSB_SRV_INT_LMU, FIUSB_SRV_INT_LMD, FIUSB_SRV_INT_VER_NO, FIUSB_SRV_INT_STATUS, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_INT_NAME, FIUSB_SRV_INT_DESC, FIUSB_REVERSAL_SRV_INT_STATUS, FIUSB_REQ_MAPPER, FIUSB_RESP_MAPPER, FIUSB_SRV_INT_VERSION, FIUSB_MAPPER_STATUS,message_type,message_sub_type) 
VALUES(FIMASTER.FIUSB_SRV_INTER_ID_SEQ.NEXTVAL, FIMASTER.FIUSB_SRV_PROV_ID_SEQ.CURRVAL, NULL, 'SYSTEM',sysdate, 1, 'processed', 'processed', 'Remote_call','Interface for Finacle and payments third party-WS', NULL, NULL,NULL, '10.2', 'processed','NVPSTR','FINVP')
       
Insert into FIMASTER.FIUSB_SRV_REQ_MAPPING_TABLE(FIUSB_SRV_REQ_ID, FIUSB_SRV_INT_ID, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_INT_STATUS, FIUSB_PROV_INVOC_MODE, FIUSB_PROV_TIMEOUT)
Values(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.currval, FIMASTER.FIUSB_SRV_INTER_ID_SEQ.currval, 'processed', 'processed', 'S', NULL)

/*Entries for port details*/    
    
insert into FIMASTER.port_type values (port_type_seq.nextval, 'Webservice', 'webservice call', 'SYSTEM', sysdate, 1, 'processed', 'Dummy Class')
   
insert into FIMASTER.port_type_parameters values ((select port_type_id from FIMASTER.port_type where port_type = 'Webservice'),'URL', 'processed', PORT_TYPE_PARAM_SEQ.nextval, 'Y', 'String', '')   

/*The following entries will be third party specific.*/
--MARA 
insert into FIMASTER.ports_master values (ports_master_seq.nextval, 'MARA', 'MARAOutbound_PORT','SYSTEM', sysdate, 'processed', 1, 
    (select port_type_id from FIMASTER.port_type where port_type='Webservice'), 'processed','no','')
        
insert into FIMASTER.PORT_PARAM_MAPPING values ((select port_id from FIMASTER.ports_master where port_name = 'MARA'), (select port_parameter_id from FIMASTER.port_type_parameters where parameter_name = 'URL'), 'http://HOST-IP-ADDRESS/maraf10/MaraF10', 'processed')
--KRA
insert into FIMASTER.ports_master values (ports_master_seq.nextval, 'KRA', 'KRAOutbound_PORT','SYSTEM', sysdate, 'processed', 1, 
    (select port_type_id from FIMASTER.port_type where port_type='Webservice'), 'processed','no','')
    
insert into FIMASTER.PORT_PARAM_MAPPING values ((select port_id from FIMASTER.ports_master where port_name = 'KRA'), (select port_parameter_id from FIMASTER.port_type_parameters where parameter_name = 'URL'), 'http://10.1.9.100:7001/billvalidation-Client-context-root/ValidationCallerService', 'processed')
--FDSA
insert into FIMASTER.ports_master values (ports_master_seq.nextval, 'FDSA', 'FDSAOutbound_PORT','SYSTEM', sysdate, 'processed', 1, 
    (select port_type_id from FIMASTER.port_type where port_type='Webservice'), 'processed','no','')
    
insert into FIMASTER.PORT_PARAM_MAPPING values ((select port_id from FIMASTER.ports_master where port_name = 'FDSA'), (select port_parameter_id from FIMASTER.port_type_parameters where parameter_name = 'URL'), 'http://HOST-IP-ADDRESS/fdsaf10/FDSAF10', 'processed')
