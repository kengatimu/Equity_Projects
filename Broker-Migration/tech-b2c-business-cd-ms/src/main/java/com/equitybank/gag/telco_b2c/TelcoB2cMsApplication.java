package com.equitybank.gag.telco_b2c;

import com.equitybank.gag.telco_b2c.config.formatter.CRLFLogConverter;
import com.equitybank.gag.telco_b2c.config.formatter.DefaultProfileUtil;
import io.micrometer.common.util.StringUtils;
import org.jpos.q2.Q2;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Optional;

@SpringBootApplication
@EnableScheduling
public class TelcoB2cMsApplication {

	private static final Logger log = LoggerFactory.getLogger(TelcoB2cMsApplication.class);
	private static Q2 q2;

	public static void main(String[] args) {
		SpringApplication app = new SpringApplication(TelcoB2cMsApplication.class);
		DefaultProfileUtil.addDefaultProfile(app);
		Environment env = app.run(args).getEnvironment();

		// Start Q2 engine (loads startQBean and all MUX/channel configs)
		try {
			log.info("Initializing jPOS Q2 engine for ISO8583 MUX/Channel layer...");
			q2 = new Q2();
			q2.start();
			log.info("Q2 engine started successfully.");
		} catch (Exception e) {
			log.error("Failed to start Q2 engine: {}", e.getMessage(), e);
			System.exit(1); // Fail fast if ISO layer can't start
		}

		logApplicationStartup(env);
	}

	private static void logApplicationStartup(Environment env) {
		String protocol = Optional.ofNullable(env.getProperty("server.ssl.key-store")).map(key -> "https").orElse("http");
		String httpsServerPort = env.getProperty("https.port");
		String httpServerPort = env.getProperty("http.port");
		String contextPath = Optional
				.ofNullable(env.getProperty("server.servlet.context-path"))
				.filter(StringUtils::isNotBlank)
				.orElse("/");
		String hostAddress = "localhost";
		try {
			hostAddress = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			log.warn("The host name could not be determined, using `localhost` as fallback");
		}
		log.info(
				CRLFLogConverter.CRLF_SAFE_MARKER,
				"\n----------------------------------------------------------\n\t" +
						"Application '{}' is running! Access URLs:\n\t" +
						"Local-Https: \t\t{}://localhost:{}{}\n\t" +
						"External-Https: \t{}://{}:{}{}\n\t" +
						"And:\n\t" +
						"Local-Http: \t\thttp://localhost:{}{}\n\t" +
						"External-Http: \t\thttp://{}:{}{}\n\t" +
						"Profile(s): \t\t{}\n----------------------------------------------------------",
				env.getProperty("spring.application.name"),
				protocol,
				httpsServerPort,
				contextPath,
				protocol,
				hostAddress,
				httpsServerPort,
				contextPath,
				httpServerPort,
				contextPath,
				hostAddress,
				httpServerPort,
				contextPath,
				env.getActiveProfiles().length == 0 ? env.getDefaultProfiles() : env.getActiveProfiles()
		);

		String configServerStatus = env.getProperty("configserver.status", "Not found or not setup for this application");
		log.info(CRLFLogConverter.CRLF_SAFE_MARKER,
				"\n----------------------------------------------------------\n\t" +
						"Config Server: \t{}\n----------------------------------------------------------",
				configServerStatus
		);
	}
}
