
--The following entry will be common for all the Biometric related outbound calls
Insert into FIMASTER.HOST_INTERFACE_NODE_TABLE(HOST_INTERFACE_NODE_ID, HOST_INTERFACE_CODE, HOST_INTERFACE_DESC, REQUEST_PORT_ID, RESPONSE_PORT_ID, PORT_STATUS, USER_GROUP_ID, USER_GROUP_STATUS,HOST_TYPE)
Values(FIMASTER.HOST_INTERFACE_NODE_SEQ.nextval, 'Biometric', 'Biometric', NULL, NULL,'processed', 1001, 'processed','EXTERNAL')
/

--the sql's after these need to be executed for BioValidation
insert into FIMASTER.ports_master values (fimaster.ports_master_seq.nextval, 'BioValidation', 'DEL chq outbound','SYSTEM', sysdate, 'processed', 1, 
    (select port_type_id from FIMASTER.port_type where port_type='Webservice'), 'processed','no','')
/

insert into FIMASTER.PORT_PARAM_MAPPING values ((select port_id from FIMASTER.ports_master where port_name = 'BioValidation'), (select port_parameter_id from FIMASTER.port_type_parameters where parameter_name = 'URL'), 'https://biotest.ebsafrica.com:8443/bioapi/customer/inquiry/', 'processed')
/
 
INSERT INTO FIMASTER.FIUSB_SERVICE_PROVIDER_TABLE ( FIUSB_SRV_PROV_ID, FIUSB_SRV_PROV_NAME, FIUSB_SRV_PROV_DESC, HOST_INTERFACE_NODE_ID, HOST_INTERFACE_NODE_STATUS, FIUSB_SRV_PROV_LMU, FIUSB_SRV_PROV_LMD, FIUSB_SRV_PROV_VER_NO, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_PROV_CLASS_NAME ) 
VALUES(FIMASTER.FIUSB_SRV_PROV_ID_SEQ.nextval, 'BioValidation', 'BioValidation', (select HOST_INTERFACE_NODE_ID from FIMASTER.HOST_INTERFACE_NODE_TABLE where HOST_INTERFACE_CODE = 'Biometric'), 'processed', 'SYSTEM' ,sysdate, 1, 'processed', 'com.infosys.ci.custom.fioutbound.BIOValidation')
/
         
INSERT INTO FIMASTER.FIUSB_SERVICE_REQUESTOR_TABLE ( FIUSB_SRV_REQ_ID, FIUSB_SRV_REQ_TYPE, FIUSB_SRV_INVOC_MODE, FIUSB_SRV_REQ_LMU, FIUSB_SRV_REQ_LMD, FIUSB_SRV_REQ_VER_NO, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_REQ_TYPE_VERSION, FIUSB_SRV_REQ_NAME, FIUSB_SRV_REQ_DESC, FIUSB_NOT_SRV_REQ_ID, FIUSB_NOT_SRV_REQ_STATUS, FIUSB_SRV_INTERACTION_TYPE)
VALUES(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.NEXTVAL,'BioValidation', 'SYNCHRONOUS', 'SYSTEM',  sysdate, 1, 'processed', '10.2','BioValidation','BioValidation', NULL, NULL, 'Invoker')
/
        
INSERT INTO FIMASTER.FIUSB_SERVICE_INTERFACE_TABLE ( FIUSB_SRV_INT_ID, FIUSB_SRV_PROV_ID, FIUSB_REVERSAL_SRV_INT_ID, FIUSB_SRV_INT_LMU, FIUSB_SRV_INT_LMD, FIUSB_SRV_INT_VER_NO, FIUSB_SRV_INT_STATUS, FIUSB_SRV_PROV_STATUS, FIUSB_SRV_INT_NAME, FIUSB_SRV_INT_DESC, FIUSB_REVERSAL_SRV_INT_STATUS, FIUSB_REQ_MAPPER, FIUSB_RESP_MAPPER, FIUSB_SRV_INT_VERSION, FIUSB_MAPPER_STATUS,message_type,message_sub_type) 
VALUES(FIMASTER.FIUSB_SRV_INTER_ID_SEQ.NEXTVAL,  FIMASTER.FIUSB_SRV_PROV_ID_SEQ.CURRVAL, NULL, 'SYSTEM',sysdate, 1, 'processed', 'processed', 'BioValidation','BioValidation', NULL, NULL,NULL, '10.2', 'processed','NVPSTR','FINVP')
/

Insert into FIMASTER.FIUSB_SRV_REQ_MAPPING_TABLE(FIUSB_SRV_REQ_ID, FIUSB_SRV_INT_ID, FIUSB_SRV_REQ_STATUS, FIUSB_SRV_INT_STATUS, FIUSB_PROV_INVOC_MODE, FIUSB_PROV_TIMEOUT)
Values(FIMASTER.FIUSB_SRV_REQ_ID_SEQ.currval, FIMASTER.FIUSB_SRV_INTER_ID_SEQ.currval, 'processed', 'processed', 'S', NULL)
/
