package com.equitybank.gag.papss.ips.web.controller.inbound;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.atomic.AtomicBoolean;

@RestController
@RequestMapping(path = "/papss/MessageAck")
public class InboundACKController {

    private static final Logger log = LoggerFactory.getLogger(InboundACKController.class);

    @PostMapping(produces = MediaType.TEXT_XML_VALUE)
    public ResponseEntity<String> simulatePapssInboundAck() {
            return ResponseEntity.status(200).body("ACK Successful");
        }
    }
