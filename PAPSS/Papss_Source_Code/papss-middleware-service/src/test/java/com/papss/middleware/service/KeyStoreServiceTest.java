package com.papss.middleware.service;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.models.Participant;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.web.client.RestTemplate;

import java.lang.reflect.Field;
import java.nio.file.Paths;
import java.security.KeyStore;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class KeyStoreServiceTest {

    private ParticipantsConfig participantsConfig;

    @BeforeEach
    void setUp() {
        participantsConfig = new ParticipantsConfig();
        participantsConfig.setParticipants(new ArrayList<>());
    }

    private static void setField(Object target, String fieldName, Object value) throws Exception {
        Field f = target.getClass().getDeclaredField(fieldName);
        f.setAccessible(true);
        f.set(target, value);
    }

    private static void invokeInit(KeyStoreService service) throws Exception {
        Field m = KeyStoreService.class.getDeclaredField("restTemplateContext");
        // touch the field to ensure class is loaded; then call private init
        var initMethod = KeyStoreService.class.getDeclaredMethod("init");
        initMethod.setAccessible(true);
        initMethod.invoke(service);
    }

    @Test
    void initializesRestTemplateAndKeyStoreForValidParticipant() throws Exception {
        // given a valid participant using an existing keystore in the repo
        String ksPath = Paths.get("src/main/resources/keystore/client.jks").toAbsolutePath().toString();
        Participant p = new Participant();
        p.setInstId("DJ1009");
        p.setInstBic("OMGGDJCK");
        p.setCountry("DJ");
        p.setSslKeyAlias("tesb");
        p.setKeyStorePath(ksPath);
        p.setKeyPass("secure");
        p.setKeyStoreType("JKS");
        p.setProvider("SunJCE");

        List<Participant> list = new ArrayList<>();
        list.add(p);
        participantsConfig.setParticipants(list);

        KeyStoreService service = new KeyStoreService(participantsConfig);
        // set pool sizes to safe small values to avoid 0 defaults
        setField(service, "maxConnTotal", 2);
        setField(service, "maxConnPerRoute", 1);

        // when
        invokeInit(service);

        // then
        RestTemplate rt = service.getRestTemplate("tesb");
        assertNotNull(rt, "RestTemplate should be initialized for alias 'tesb'");
        KeyStore ks = service.getKeyStore("tesb");
        assertNotNull(ks, "KeyStore should be available for alias 'tesb'");
    }

    @Test
    void skipsParticipantWhenKeystoreMissing() throws Exception {
        Participant bad = new Participant();
        bad.setInstId("XX0000");
        bad.setSslKeyAlias("missing");
        bad.setKeyStorePath("/path/does/not/exist/keystore.jks");
        bad.setKeyPass("whatever");
        bad.setKeyStoreType("JKS");
        bad.setProvider("SunJCE");

        participantsConfig.getParticipants().add(bad);

        KeyStoreService service = new KeyStoreService(participantsConfig);
        setField(service, "maxConnTotal", 2);
        setField(service, "maxConnPerRoute", 1);

        invokeInit(service);

        assertNull(service.getRestTemplate("missing"), "RestTemplate must be null when keystore cannot be loaded");
        assertNull(service.getKeyStore("missing"), "KeyStore must be null when keystore cannot be loaded");
    }

    @Test
    void getRestTemplateAndKeyStoreReturnNullForUnknownAlias() {
        KeyStoreService service = new KeyStoreService(participantsConfig);
        assertNull(service.getRestTemplate("unknown"));
        assertNull(service.getKeyStore("unknown"));
    }
}
