package com.equitybank.gag.papss.ots.jpos.iso8583.scheduler;

import com.equitybank.gag.papss.ots.jpos.space.configs.AppQBean;
import jakarta.annotation.PreDestroy;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.jpos.iso.MUX;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

@Service
public class EchoService {
    private static final Logger logger = LoggerFactory.getLogger(EchoService.class);
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

    @Value("${finacle.iso.echo.timeout}")
    private long echoTimeout;

    @Scheduled(fixedRate = 60000L)
    public void echoAll() {
//        echoMux("DRC", AppQBean.drcMux);
//        echoMux("SS", AppQBean.suMux);
        echoMux("KE", AppQBean.keMux);

    }

    private void echoMux(String country, MUX mux) {
        if (mux == null || !mux.isConnected()) {
            logger.warn("{} MUX not connected. Skipping echo.", country);
            return;
        }

        try {
            logger.info("Initiating echo to {} at {}", country, dateFormat.format(new Date()));
            ISOMsg req = buildEchoMsg(country);
            ISOMsg resp = mux.request(req, echoTimeout);

            if (resp != null) {
                logger.info("{} echo response received: MTI={}, STAN={}", country, resp.getMTI(), resp.getString(11));
            } else {
                logger.warn("{} echo timeout: no response received", country);
            }
        } catch (Exception e) {
            logger.error("Echo failed for {}: {}", country, e.getMessage(), e);
        }
    }

    private ISOMsg buildEchoMsg(String countryCode) throws ISOException {
        ISOMsg message = new ISOMsg();
        Random random = new Random();
        String stan = leftPad(random.nextInt(1000000), 6);

        Date now = new Date();
        String tranDateTime = String.format("%tm%td%tH%tM%tS", now, now, now, now, now);
        String localTranDateTime = String.format("%ty%tm%td%tH%tM%tS", now, now, now, now, now, now);

        message.setMTI("1804");
        message.set(7, tranDateTime);
        message.set(11, stan);
        message.set(12, localTranDateTime);
        message.set(24, "831");
        message.set(123, "SMS");
        message.set(126, "CAMPAIGN");

        return message;
    }

    private String leftPad(long n, int padding) {
        return String.format("%0" + padding + "d", n);
    }

    @PreDestroy
    public void destroy() {
        logger.info("Shutdown in progress... EchoService terminating.");
    }
}
