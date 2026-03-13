package com.equitybankgroup.payments.b2c.fi;

import lombok.Setter;
import lombok.ToString;

import jakarta.xml.bind.annotation.XmlElement;
import java.util.List;

@ToString
@Setter
public class ExecuteFinacleScriptResponse {
    private ExecuteFinacleScriptOutputVO executeFinacleScriptOutputVO;
    private ExecuteFinacleScriptCustomData executeFinacleScriptCustomData;


    @ToString
    @Setter
    public static class ExecuteFinacleScriptOutputVO{}

    @Setter
    @ToString
    public static class ExecuteFinacleScriptCustomData{
        private List<TransactionRES> transactions;
        @Setter
        @ToString
        public static class TransactionRES{
            private String tranDate;
            private String tranID;
            private String foracid;
            private String tranCrncyCode;
            private String tranAmt;
            private String tranParticular;
            private String refNum;
            private String tranParticular2;
            private String tranRmks;

            @XmlElement(name = "tranDate",namespace = "http://www.finacle.com/fixml")
            public String getTranDate() {
                return tranDate;
            }

            @XmlElement(name = "tranID",namespace = "http://www.finacle.com/fixml")
            public String getTranID() {
                return tranID;
            }

            @XmlElement(name = "foracid",namespace = "http://www.finacle.com/fixml")
            public String getForacid() {
                return foracid;
            }

            @XmlElement(name = "tranCrncyCode",namespace = "http://www.finacle.com/fixml")
            public String getTranCrncyCode() {
                return tranCrncyCode;
            }

            @XmlElement(name = "tranAmt",namespace = "http://www.finacle.com/fixml")
            public String getTranAmt() {
                return tranAmt;
            }

            @XmlElement(name = "tranParticular",namespace = "http://www.finacle.com/fixml")
            public String getTranParticular() {
                return tranParticular;
            }

            @XmlElement(name = "refNum",namespace = "http://www.finacle.com/fixml")
            public String getRefNum() {
                return refNum;
            }

            @XmlElement(name = "tranParticular2",namespace = "http://www.finacle.com/fixml")
            public String getTranParticular2() {
                return tranParticular2;
            }
            @XmlElement(name = "tranRmks",namespace = "http://www.finacle.com/fixml")
            public String getTranRmks() {
                return tranRmks;
            }

        }
        @XmlElement(name = "Transaction_RES",namespace = "http://www.finacle.com/fixml")
        public List<TransactionRES> getTransactions() {
            return transactions;
        }
    }
    @XmlElement(name = "executeFinacleScriptResponse",namespace = "http://www.finacle.com/fixml")
    public ExecuteFinacleScriptOutputVO getExecuteFinacleScriptOutputVO() {
        return executeFinacleScriptOutputVO;
    }
    @XmlElement(name = "executeFinacleScript_CustomData",namespace = "http://www.finacle.com/fixml")
    public ExecuteFinacleScriptCustomData getExecuteFinacleScriptCustomData() {
        return executeFinacleScriptCustomData;
    }
}
