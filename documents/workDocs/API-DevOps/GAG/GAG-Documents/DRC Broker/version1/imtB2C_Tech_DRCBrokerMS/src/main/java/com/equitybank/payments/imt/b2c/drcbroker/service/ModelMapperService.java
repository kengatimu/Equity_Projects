package com.equitybank.payments.imt.b2c.drcbroker.service;


import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;

public interface ModelMapperService {
     <T> Object mapObjects(Object sourceObject, String returnType, String beneficiaryAccount, String rrn, ErrorStatus errorStatus);
}
