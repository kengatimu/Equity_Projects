package com.equitybankgroup.vas.hostemulator.emulator.service;

import com.equitybankgroup.vas.hostemulator.emulator.fin.AppQBean;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class EchoService {

    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
    
//    @Scheduled(fixedRate = 9000L)
    public void echo() {
        echoFin();
    }
    

    public ISOMsg sendRequest(ISOMsg req, String channel) {
        ISOMsg resp = null;
        try {
            if (channel.equals("FIN-KE")) {
                resp = AppQBean.kemux.request(req, 10000L);
            }
        } catch (ISOException e) {
            System.out.println("sendRequest=" + e.getMessage());
        }
        return resp;
    }

    public void echoFin() {
        ISOMsg resp = null;
        if (AppQBean.kemux != null && AppQBean.kemux.isConnected() && !AppQBean.keMuxBusy) {
            long diffMinutes = 0L;
            if (AppQBean.keLastPosted != null) {
                long diff = (new Date()).getTime() - AppQBean.keLastPosted.getTime();
                diffMinutes = diff / 60000L % 60L;
            } else {
                diffMinutes = 10L;
            }
            if (diffMinutes >= 5L) {
                System.out.println("KE Channel Idle for mor than 5 Minutes");
                try {
                    ISOMsg isoMsg = getLogOnMsg("FIN");
                    resp = AppQBean.kemux.request(isoMsg, 5000L);
                } catch (ISOException ex) {
                    System.out.println("KE echo ISOException: " + ex.getMessage());
                } catch (Exception ex) {
                    System.out.println("KE echo Exception: " + ex.getMessage());
                }
            } else {
                System.out.println("KE Channel Busy..");
            }
        } else System.out.println("KE Mux not found!!");

    }
    
    public String leftpad(long n, int padding) {
        return String.format("%0" + padding + "d", new Object[] { Long.valueOf(n) });
    }
    


    private ISOMsg getLogOnMsg(String countryCode) {
        if (countryCode.equals("FIN")) try {
            ISOMsg m = new ISOMsg();
            Random random = new Random();
            String stan = (new Integer(random.nextInt(1000000))).toString();
            System.out.println("create FIN echo Msg Method: " + countryCode);
            Date today = new Date();
            String tranDateTime = String.format("%tm%td%tH%tM%tS", new Object[] { today, today, today, today, today });
            String localTranDateTime = String.format("%ty%tm%td%tH%tM%tS", new Object[] { today, today, today, today, today, today });
            m.setMTI("1804");
            m.set(7, tranDateTime);
            m.set(11, stan);
            m.set(12, localTranDateTime);
            m.set(24, "831");
            m.set(123, "SMS");
            m.set(126, "CAMPAIGN");
            return m;
        } catch (ISOException ex) {
            System.out.println(countryCode + " echo ISOException: " + ex.getMessage());
            return null;
        } catch (Exception ex) {
            System.out.println(countryCode + " echo Exception: " + ex.getMessage());
            return null;
        }
        return null;
    }

}
