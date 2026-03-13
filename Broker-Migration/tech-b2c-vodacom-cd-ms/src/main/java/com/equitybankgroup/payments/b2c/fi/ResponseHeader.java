package com.equitybankgroup.payments.b2c.fi;

import lombok.Data;
import lombok.Setter;
import lombok.ToString;

import javax.xml.bind.annotation.XmlElement;

@Setter
@ToString
public class ResponseHeader {
    private RequestMessageKey requestMessageKey;
    private ResponseMessageInfo responseMessageInfo;
    private UBUSTransaction uBUStransaction;
    private HostTransaction hostTransaction;
    private HostParentTransaction hostParentTransaction;
    private CustomInfo customInfo;

    @ToString
    @Setter
    public static class RequestMessageKey{
        private String requestUUID;
        private String serviceRequestId;
        private String serviceRequestVersion;
        private String channelId;

        @XmlElement(name = "RequestUUID",namespace = "http://www.finacle.com/fixml")
        public String getRequestUUID() {
            return requestUUID;
        }
        @XmlElement(name = "ServiceRequestId",namespace = "http://www.finacle.com/fixml")
        public String getServiceRequestId() {
            return serviceRequestId;
        }

        @XmlElement(name = "ServiceRequestVersion",namespace = "http://www.finacle.com/fixml")
        public String getServiceRequestVersion() {
            return serviceRequestVersion;
        }
        @XmlElement(name = "CustomInfo",namespace = "http://www.finacle.com/fixml")
        public String getChannelId() {
            return channelId;
        }
    }
    @Setter
    @ToString
    public static class ResponseMessageInfo{
        private String bankId;
        private String timeZone;
        private String messageDateTime;

        @XmlElement(name = "BankId",namespace = "http://www.finacle.com/fixml")
        public String getBankId() {
            return bankId;
        }
        @XmlElement(name = "TimeZone",namespace = "http://www.finacle.com/fixml")
        public String getTimeZone() {
            return timeZone;
        }
        @XmlElement(name = "MessageDateTime",namespace = "http://www.finacle.com/fixml")
        public String getMessageDateTime() {
            return messageDateTime;
        }
    }

    @ToString
    @Setter
    public static class UBUSTransaction{
        private String id;
        private String status;

        @XmlElement(name = "Id",namespace = "http://www.finacle.com/fixml")
        public String getId(){
            return id;
        }
        @XmlElement(name = "Status",namespace = "http://www.finacle.com/fixml")
        public String getStatus(){
            return status;
        }
    }

    @ToString
    @Setter
    public static class HostTransaction{
        private String id;
        private String status;

        @XmlElement(name = "Id",namespace = "http://www.finacle.com/fixml")
        public String getId(){
            return id;
        }
        @XmlElement(name = "Status",namespace = "http://www.finacle.com/fixml")
        public String getStatus(){
            return status;
        }
    }
    @ToString
    @Setter
    public static class HostParentTransaction{
        private String id;
        private String status;

        @XmlElement(name = "Id",namespace = "http://www.finacle.com/fixml")
        public String getId(){
            return id;
        }
        @XmlElement(name = "Status",namespace = "http://www.finacle.com/fixml")
        public String getStatus(){
            return status;
        }
    }
    @ToString
    public static class CustomInfo{}
    @XmlElement(name = "RequestMessageKey",namespace = "http://www.finacle.com/fixml")
    public RequestMessageKey getRequestMessageKey() {
        return requestMessageKey;
    }

    @XmlElement(name = "ResponseMessageInfo",namespace = "http://www.finacle.com/fixml")
    public ResponseMessageInfo getResponseMessageInfo() {
        return responseMessageInfo;
    }

    @XmlElement(name = "UBUSTransaction",namespace = "http://www.finacle.com/fixml")
    public UBUSTransaction getUBUSTransaction() {
        return uBUStransaction;
    }

    @XmlElement(name = "HostTransaction",namespace = "http://www.finacle.com/fixml")
    public HostTransaction getHostTransaction() {
        return hostTransaction;
    }


    @XmlElement(name = "HostParentTransaction",namespace = "http://www.finacle.com/fixml")
    public HostParentTransaction getHostParentTransaction() {
        return hostParentTransaction;
    }

    @XmlElement(name = "CustomInfo",namespace = "http://www.finacle.com/fixml")
    public CustomInfo getCustomInfo() {
        return customInfo;
    }
}
