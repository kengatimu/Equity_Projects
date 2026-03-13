package com.papss.middleware.service;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.models.Participant;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.hc.client5.http.config.RequestConfig;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManagerBuilder;
import org.apache.hc.client5.http.io.HttpClientConnectionManager;
import org.apache.hc.client5.http.ssl.NoopHostnameVerifier;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactory;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactoryBuilder;
import org.apache.hc.core5.http.ssl.TLS;
import org.apache.hc.core5.ssl.SSLContextBuilder;
import org.apache.hc.core5.util.Timeout;
import org.apache.hc.core5.util.TimeValue;
import org.javatuples.Pair;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.net.ssl.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.*;
import java.security.cert.CertificateException;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Component
@RequiredArgsConstructor
public class KeyStoreService {

	private final ParticipantsConfig participantsConfig;

	// HTTP client pool properties; can be overridden via Spring config/env (non-timeout)
	@Value("${papss.http.max-conn-total:50}")
	private int maxConnTotal;

	@Value("${papss.http.max-conn-per-route:20}")
	private int maxConnPerRoute;

	// Timeout properties (milliseconds).
	// Set sensible non-blocking defaults so the client does not hang for 10 minutes when the config is missing.
	@Value("${papss.http.connection-request-timeout-ms:30000}")
	private long connectionRequestTimeoutMs; // time to wait for a connection from pool (default 30s)

	@Value("${papss.http.connect-timeout-ms:15000}")
	private long connectTimeoutMs; // time to establish TCP/TLS connection (default 15s)

	@Value("${papss.http.response-timeout-ms:120000}")
	private long responseTimeoutMs; // time to wait for server response data (default 120s)

	private final Map<String, Pair<RestTemplate, KeyStore>> restTemplateContext = new ConcurrentHashMap<>();

	private synchronized KeyStore loadKeystore(String providerProperty, String path, char[] password, String keystoreType) {
		try {
			Provider provider = Security.getProvider(providerProperty);
			KeyStore.ProtectionParameter protection = new KeyStore.PasswordProtection(password);
			KeyStore.Builder builder;

			if (path == null) {
				builder = KeyStore.Builder.newInstance(keystoreType, provider, protection);
			} else {
				log.info("Loading keystore from: {}. Type: {}", path, keystoreType);
				File keystoreFile = new File(path);

				if (!keystoreFile.exists()) {
					throw new FileNotFoundException("Keystore not found at " + path);
				}

				builder = KeyStore.Builder.newInstance(keystoreType, null, keystoreFile, protection);
			}

			return builder.getKeyStore();
		} catch (FileNotFoundException ex) {
			log.error("Keystore file not found: {}", path, ex);
		} catch (Exception ex) {
			log.error("Could not load the keystore from: {}", path, ex);
		}
		return null;
	}

	public RestTemplate getRestTemplate(String sslKeyAlias) {
		Pair<RestTemplate, KeyStore> pair = restTemplateContext.get(sslKeyAlias);
		return pair != null ? pair.getValue0() : null;
	}

	public KeyStore getKeyStore(String sslKeyAlias) {
		Pair<RestTemplate, KeyStore> pair = restTemplateContext.get(sslKeyAlias);
		return pair != null ? pair.getValue1() : null;
	}

	@PostConstruct
	private void init() {
		for (Participant participant : participantsConfig.getParticipants()) {
			try {
				KeyStore participantKeyStore = loadKeystore(
						participant.getProvider(),
						participant.getKeyStorePath(),
						participant.getKeyPass().toCharArray(),
						participant.getKeyStoreType()
				);

				if (participantKeyStore == null) {
					log.warn("Skipping participant {} due to keystore load failure", participant.getSslKeyAlias());
					continue;
				}

				SSLContext sslContext = buildSSLContext(participant, participantKeyStore);

				// TODO: SSLConnectionSocketFactory is deprecated in HttpClient 5.4.3
				// A future update should replace this with a TlsStrategy implementation
				@SuppressWarnings("deprecation")
				SSLConnectionSocketFactory sslConFactory = SSLConnectionSocketFactoryBuilder.create()
						.setSslContext(sslContext)
						.setHostnameVerifier(NoopHostnameVerifier.INSTANCE)
						.setTlsVersions(TLS.V_1_3, TLS.V_1_2)
						.build();

				// Configure connection pooling with increased max connections
				// TODO: Both SSLConnectionSocketFactory and setSSLSocketFactory are deprecated in HttpClient 5.4.3
				// A future update should replace both with a TlsStrategy implementation
				@SuppressWarnings("deprecation")
				HttpClientConnectionManager cm = PoolingHttpClientConnectionManagerBuilder.create()
					.setSSLSocketFactory(sslConFactory)
					.setMaxConnTotal(maxConnTotal)
					.setMaxConnPerRoute(maxConnPerRoute)
					.build();

				// Configurable request timeouts. For connection-request, avoid DISABLED because some stacks interpret it as 0ms.
				// Use a large positive default (10 minutes) when value <= 0.
				long effectiveConnReqMs = connectionRequestTimeoutMs <= 0 ? 600000L : connectionRequestTimeoutMs;
				Timeout connectTimeout = connectTimeoutMs < 0 ? Timeout.DISABLED : Timeout.ofMilliseconds(connectTimeoutMs);
				Timeout responseTimeout = responseTimeoutMs < 0 ? Timeout.DISABLED : Timeout.ofMilliseconds(responseTimeoutMs);
				Timeout connReqTimeout = Timeout.ofMilliseconds(effectiveConnReqMs);
				RequestConfig requestConfig = RequestConfig.custom()
					.setConnectTimeout(connectTimeout)
					.setResponseTimeout(responseTimeout)
					.setConnectionRequestTimeout(connReqTimeout)
					.build();

				CloseableHttpClient httpClient = HttpClients.custom()
					.setConnectionManager(cm)
					.setDefaultRequestConfig(requestConfig)
					.evictExpiredConnections()
					.evictIdleConnections(TimeValue.ofMinutes(2))
					.build();

				ClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory(httpClient);
				restTemplateContext.put(participant.getSslKeyAlias(), Pair.with(new RestTemplate(requestFactory), participantKeyStore));
			} catch (Exception e) {
				log.error("Failed to initialize RestTemplate for participant: {}", participant.getSslKeyAlias(), e);
			}
		}
	}

	private SSLContext buildSSLContext(Participant participant, KeyStore participantKeyStore)
			throws KeyStoreException, NoSuchAlgorithmException, CertificateException, IOException, KeyManagementException, UnrecoverableKeyException {

		KeyManager[] keyManagers = buildKeyManagers(participantKeyStore, participant.getKeyPass().toCharArray());

		// Create a trust manager that does not validate certificate chains
		TrustManager[] trustAllCerts = new TrustManager[] {
			new X509TrustManager() {
				public java.security.cert.X509Certificate[] getAcceptedIssuers() {
					return null;
				}
				public void checkClientTrusted(java.security.cert.X509Certificate[] certs, String authType) {
				}
				public void checkServerTrusted(java.security.cert.X509Certificate[] certs, String authType) {
				}
			}
		};

		log.debug("Using trust-all certificate manager for SSL connections");

		SelectableAliasKeyManager sakm = new SelectableAliasKeyManager(
				(X509ExtendedKeyManager) keyManagers[0], participant.getSslKeyAlias());

		SSLContext sslContext = new SSLContextBuilder()
				.loadTrustMaterial(new File(participant.getKeyStorePath()), participant.getKeyPass().toCharArray(), 
					(chain, authType) -> true) // Trust all certificates
				.loadKeyMaterial(participantKeyStore, participant.getKeyPass().toCharArray())
				.build();

		sslContext.init(new KeyManager[]{sakm}, trustAllCerts, new SecureRandom());
		return sslContext;
	}

	private KeyManager[] buildKeyManagers(KeyStore store, char[] password)
			throws NoSuchAlgorithmException, UnrecoverableKeyException, KeyStoreException {
		Objects.requireNonNull(store, "Keystore cannot be null");
		KeyManagerFactory keyManagerFactory = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
		keyManagerFactory.init(store, password);
		return keyManagerFactory.getKeyManagers();
	}

	private TrustManager[] buildTrustManagers(KeyStore store) throws NoSuchAlgorithmException, KeyStoreException {
		Objects.requireNonNull(store, "Keystore cannot be null");
		TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
		trustManagerFactory.init(store);
		return trustManagerFactory.getTrustManagers();
	}
}
