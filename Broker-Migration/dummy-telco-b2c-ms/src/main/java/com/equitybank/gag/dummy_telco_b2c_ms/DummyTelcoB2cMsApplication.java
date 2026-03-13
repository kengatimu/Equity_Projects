package com.equitybank.gag.dummy_telco_b2c_ms;

import com.equitybank.gag.dummy_telco_b2c_ms.config.CRLFLogConverter;
import com.equitybank.gag.dummy_telco_b2c_ms.config.DefaultProfileUtil;
import io.micrometer.common.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Optional;

@SpringBootApplication
public class DummyTelcoB2cMsApplication {
	public static final Logger log = LoggerFactory.getLogger(DummyTelcoB2cMsApplication.class);

	public static void main(String[] args) {
		SpringApplication app = new SpringApplication(DummyTelcoB2cMsApplication.class);
		DefaultProfileUtil.addDefaultProfile(app);
		Environment env = app.run(args).getEnvironment();
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

		String configServerStatus = env.getProperty("configserver.status");
		if (configServerStatus == null) {
			configServerStatus = "Not found or not setup for this application";
		}
		log.info(
				CRLFLogConverter.CRLF_SAFE_MARKER,
				"\n----------------------------------------------------------\n\t" +
						"Config Server: \t{}\n----------------------------------------------------------",
				configServerStatus
		);
	}
}
