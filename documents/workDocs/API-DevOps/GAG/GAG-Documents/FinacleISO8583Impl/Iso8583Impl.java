

These are my files structure:

ISO8583
	|- configs
		|- AppQBean
		|- FinaclePackager
		|- FinChannel
	|- Scheduler
		|- EchoService
	|- Service
		|- impl
			|- FinacleCallerServiceImpl
			|- ISOMessageCreatorServiceImpl
			|- ISOMsgSerializerAndDeserializerServiceImpl
			
StaticFiles
	|- drc_channel.xml
	|- drc_mux.xml
	|- startPBQB.xml
	
A. Static Files
	1. drc_channel.xml
		<?xml version="1.0" encoding="UTF-8"?>
		<!-- DRC Channel Adaptor Configuration -->
		<channel-adaptor name='drc-fin-adaptor'
				class="org.jpos.q2.iso.ChannelAdaptor" logger="Q2">
			<channel class="com.equitybank.gag.telco_b2c.ISO8583.configs.FinChannel" logger="Q2"
						 packager="com.equitybank.gag.telco_b2c.ISO8583.configs.FinaclePackager" header="495379303036303030303430">
				<property name="host" value="10.17.1.46" />
				<property name="port" value="37000" />
			</channel>
			<in>drc-fin-send</in>
			<out>drc-fin-receive</out>
			<reconnect-delay>10000</reconnect-delay>
		</channel-adaptor>
		
	2. drc_mux.xml
		<?xml version="1.0" encoding="UTF-8"?>
		<!-- DRC MUX Configuration -->
		<mux class="org.jpos.q2.iso.QMUX" logger="Q2" name="drc-mux">
			<in>drc-fin-receive</in>
			<out>drc-fin-send</out>
			<key>11,37</key>
			<unhandled>drc-unhandled</unhandled>
		</mux>
	
	3. startPBQB.xml
		<?xml version="1.0" encoding="UTF-8"?>
		<appQBean class="com.equitybank.gag.telco_b2c.ISO8583.configs.AppQBean" logger="Q2">
		 <property name="drc-mux" value="drc-mux" />
		</appQBean>

B. ISO8583 Files
	i. Configs
		1. AppQBean
				package com.equitybank.gag.telco_b2c.ISO8583.configs;

				import org.jpos.iso.MUX;
				import org.jpos.q2.QBeanSupport;
				import org.jpos.util.NameRegistrar;

				public class AppQBean extends QBeanSupport {


					public static MUX drMux;

					public void init() {
						System.out.println("ISO8583AppQBean initialization...");
					}

					public void start() {
						System.out.println("Starting ISO8583AppQBean...");

						try {
							String mx = "mux." + this.cfg.get("drc-mux");
							drMux = (MUX) NameRegistrar.get(mx);

							if (drMux != null && drMux.isConnected()) {
								System.out.println("FIN DRC Mux FOUND and connected: " + mx);
							} else {
								System.out.println("FIN DRC Mux found but not connected: " + mx);
							}
						} catch (NameRegistrar.NotFoundException ex) {
							System.out.println("FIN DRC MUX NOT Found!!" + ex.getMessage());
							ex.printStackTrace(System.out);
						} catch (Exception ex) {
							System.out.println("Unexpected error during MUX initialization: " + ex.getMessage());
							ex.printStackTrace(System.out);
						}
					}

					public void stop() {
						System.out.println("Stopping ISO8583AppQBean...");
					}
				}
			
			2. FinaclePackager
				package com.equitybank.gag.telco_b2c.ISO8583.configs;

				import org.jpos.iso.*;

				/**
				 * FinPackagersFinacle is a custom ISO 8583 packager for handling ISO 8583 messages
				 * specific to the Finacle system. It extends the ISOBasePackager and defines
				 * a comprehensive set of ISO 8583 fields with appropriate field types and lengths.
				 */
				public class FinaclePackager extends ISOBasePackager {
					private static final boolean pad = false;
					protected ISOFieldPackager fld[] = {
							/*000*/ new IFA_NUMERIC(4, "Message Type Indicator"),
							/*001*/ new IFB_BITMAP(16, "Bitmap"),
							/*002*/ new IFA_LLNUM(19, "Primary Account number"),
							/*003*/ new IFA_NUMERIC(6, "Processing Code"),
							/*004*/ new IFA_NUMERIC(12, "Amount, Transaction"),
							/*005*/ new IFB_NUMERIC(12, "Amount, Reconciliation", pad),
							/*006*/ new IFB_NUMERIC(3, "Amount, Cardholder billing", pad),
							/*007*/ new IFA_NUMERIC(10, "Date and time, transmission"),
							/*008*/ new IFB_NUMERIC(8, "Amount, Cardholder billing fee", pad),
							/*009*/ new IFB_NUMERIC(8, "Conversion rate, Reconciliation", pad),
							/*010*/ new IFB_NUMERIC(8, "Conversion rate, Cardholder billing", pad),
							/*011*/ new IFA_NUMERIC(6, "Systems trace audit number"),
							/*012*/ new IFA_NUMERIC(12, "Date and time, Local transaction"),
							/*013*/ new IFB_NUMERIC(2, "Date, Effective", pad),
							/*014*/ new IFB_NUMERIC(2, "Date, Expiration", pad),
							/*015*/ new IFB_NUMERIC(4, "Date, Settlement", pad),
							/*016*/ new IFB_NUMERIC(4, "Date, Conversion", pad),
							/*017*/ new IFA_NUMERIC(4, "Date, Capture"),
							/*018*/ new IFB_NUMERIC(4, "Merchant type", pad),
							/*019*/ new IFB_NUMERIC(3, "Country code, Acquiring institution", pad),
							/*020*/ new IFB_NUMERIC(3, "Country code, Primary account number", pad),
							/*021*/ new IFB_NUMERIC(3, "Country code, Forwarding institution", pad),
							/*022*/ new IFB_NUMERIC(4, "Point of service data code", pad),
							/*023*/ new IFB_NUMERIC(2, "Card sequence number", pad),
							/*024*/ new IFA_NUMERIC(3, "Function code"),
							/*025*/ new IFB_NUMERIC(2, "Message reason code", pad),
							/*026*/ new IFB_NUMERIC(2, "Card acceptor business code", pad),
							/*027*/ new IFB_NUMERIC(1, "Approval code length", pad),
							/*028*/ new IFB_NUMERIC(9, "Date, Reconciliation", pad),
							/*029*/ new IFB_NUMERIC(9, "Reconciliation indicator", pad),
							/*030*/ new IFB_NUMERIC(9, "Amounts, original", pad),
							/*031*/ new IFB_NUMERIC(9, "Acquirer reference data", pad),
							/*032*/ new IFA_LLNUM(12, "Acquirer institution ident code"),
							/*033*/ new IFB_LLNUM(99, "Forwarding institution ident code", pad),
							/*034*/ new IFB_LLNUM(99, "Primary account number, extended", pad),
							/*035*/ new IFA_LLNUM(37, "Track 2 data"),
							/*036*/ new IFB_LLLNUM(104, "Track 3 data", pad),
							/*037*/ new IF_CHAR(12, "Retrieval reference number"),
							/*038*/ new IF_CHAR(6, "Approval code"),
							/*039*/ new IF_CHAR(3, "Action code"),
							/*040*/ new IF_CHAR(3, "Service code"),
							/*041*/ new IF_CHAR(8, "Card acceptor terminal identification"),
							/*042*/ new IF_CHAR(15, "Card acceptor identification code"),
							/*043*/ new IFA_LLCHAR(40, "Card acceptor name/location"),
							/*044*/ new IFA_LLCHAR(20, "Additional response data"),
							/*045*/ new IFA_LLCHAR(76, "Track 1 data"),
							/*046*/ new IFA_LLLCHAR(204, "Amounts, Fees"),
							/*047*/ new IFA_LLLCHAR(999, "Additional data - national"),
							/*048*/ new IFA_LLLCHAR(999, "Additional data - private"),
							/*049*/ new IF_CHAR(3, "Currency code, Transaction"),
							/*050*/ new IF_CHAR(3, "Currency code, Reconciliation"),
							/*051*/ new IF_CHAR(3, "Currency code, Cardholder billing"),
							/*052*/ new IFB_NUMERIC(8, "Personal identification number (PIN) data", pad),
							/*053*/ new IFB_NUMERIC(10, "Security related control information", pad),
							/*054*/ new IFB_LLCHAR(99, "Amounts, additional"),
							/*055*/ new IFA_LLLBINARY(255, "IC card system related data"),
							/*056*/ new IFA_LLNUM(36, "Original data elements"),//2011-06-16 Changed from 35 to 36
							/*057*/ new IFA_NUMERIC(3, "Authorization life cycle code"),
							/*058*/ new IFA_LLNUM(11, "Authorizing agent institution Id Code"),
							/*059*/ new IFA_LLLCHAR(999, "Transport data"),
							/*060*/ new IFB_LLLCHAR(999, "Reserved for national use"),
							/*061*/ new IFA_LLLCHAR(999, "Reserved for national use"),
							/*062*/ new IFA_LLLCHAR(999, "Reserved for private use"),
							/*063*/ new IFB_LLNUM(25, "Reserved for private use", pad),
							/*064*/ new IFA_BINARY(8, "Message authentication code field"),
							/*065*/ new IFA_BINARY(8, "Reserved for ISO use"),
							/*066*/ new IFA_LLLCHAR(204, "Amounts, original fees"),
							/*067*/ new IFA_NUMERIC(2, "Extended payment data"),
							/*068*/ new IFA_NUMERIC(3, "Country code, receiving institution"),
							/*069*/ new IFA_NUMERIC(3, "Country code, settlement institution"),
							/*070*/ new IFA_NUMERIC(3, "Country code, authorizing agent Inst."),
							/*071*/ new IFA_NUMERIC(8, "Message number"),
							/*072*/ new IFA_LLLCHAR(999, "Data record"),
							/*073*/ new IFA_NUMERIC(6, "Date, action"),
							/*074*/ new IFA_NUMERIC(10, "Credits, number"),
							/*075*/ new IFA_NUMERIC(10, "Credits, reversal number"),
							/*076*/ new IFA_NUMERIC(10, "Debits, number"),
							/*077*/ new IFA_NUMERIC(10, "Debits, reversal number"),
							/*078*/ new IFA_NUMERIC(10, "Transfer, number"),
							/*079*/ new IFA_NUMERIC(10, "Transfer, reversal number"),
							/*080*/ new IFA_NUMERIC(10, "Inquiries, number"),
							/*081*/ new IFA_NUMERIC(10, "Authorizations, number"),
							/*082*/ new IFA_NUMERIC(10, "Inquiries, reversal number"),
							/*083*/ new IFA_NUMERIC(10, "Payments, number"),
							/*084*/ new IFA_NUMERIC(10, "Payments, reversal number"),
							/*085*/ new IFA_NUMERIC(10, "Fee collections, number"),
							/*086*/ new IFA_NUMERIC(16, "Credits, amount"),
							/*087*/ new IFA_NUMERIC(16, "Credits, reversal amount"),
							/*088*/ new IFA_NUMERIC(16, "Debits, amount"),
							/*089*/ new IFA_NUMERIC(16, "Debits, reversal amount"),
							/*090*/ new IFA_NUMERIC(10, "Authorizations, reversal number"),
							/*091*/ new IFA_NUMERIC(3, "Country code, transaction Dest. Inst."),
							/*092*/ new IFA_NUMERIC(3, "Country code, transaction Orig. Inst."),
							/*093*/ new IFA_LLNUM(11, "Transaction Dest. Inst. Id code"),
							/*094*/ new IFA_LLNUM(11, "Transaction Orig. Inst. Id code"),
							/*095*/ new IFA_LLCHAR(99, "Card issuer reference data"),
							/*096*/ new IFA_LLLBINARY(999, "Key management data"),
							/*097*/ new IFA_AMOUNT(1 + 16, "Amount, Net reconciliation"),
							/*098*/ new IF_CHAR(25, "Payee"),
							/*099*/ new IFA_LLCHAR(11, "Settlement institution Id code"),
							/*100*/ new IFA_LLNUM(11, "Receiving institution Id code"),
							/*101*/ new IFA_LLCHAR(17, "File name"),
							/*102*/ new IFA_LLCHAR(20, "Account identification 1"),
							/*103*/ new IFA_LLCHAR(28, "Account identification 2"),
							/*104*/ new IFA_LLLCHAR(100, "Transaction description"),
							/*105*/ new IFA_NUMERIC(16, "Credits, Chargeback amount"),
							/*106*/ new IFA_NUMERIC(16, "Debits, Chargeback amount"),
							/*107*/ new IFA_NUMERIC(10, "Credits, Chargeback number"),
							/*108*/ new IFA_NUMERIC(10, "Debits, Chargeback number"),
							/*109*/ new IFA_LLCHAR(84, "Credits, Fee amounts"),
							/*110*/ new IFA_LLCHAR(84, "Debits, Fee amounts"),
							/*111*/ new IFA_LLLCHAR(999, "Reserved for ISO use"),
							/*112*/ new IFA_LLLCHAR(999, "Reserved for ISO use"),
							/*113*/ new IFA_LLLCHAR(999, "Reserved for ISO use"),
							/*114*/ new IFA_LLLCHAR(999, "Reserved for ISO use"),
							/*115*/ new IFA_LLLCHAR(999, "Reserved for ISO use"),
							/*116*/ new IFA_LLLCHAR(999, "Reserved for national use"),
							/*117*/ new IFA_LLLCHAR(999, "Reserved for national use"),
							/*118*/ new IFA_LLLCHAR(999, "Reserved for national use"),
							/*119*/ new IFB_LLLCHAR(999, "Reserved for national use"),
							/*120*/ new IFB_LLLCHAR(999, "Reserved for national use"),
							/*121*/ new IFB_LLLCHAR(999, "Reserved for national use"),
							/*122*/ new IFB_LLLCHAR(999, "Reserved for national use"),
							/*123*/ new IFA_LLLCHAR(999, "Reserved for private use"),
							/*124*/ new IFA_LLLCHAR(999, "Reserved for private use"),
							/*125*/ new IFA_LLLCHAR(999, "Reserved for private use"),
							/*126*/ new IFA_LLLCHAR(999, "Reserved for private use"),
							/*127*/ new IFA_LLLCHAR(999, "Reserved for private use"),
							/*128*/ new IFB_BINARY(8, "Message authentication code field")
					};

					public FinaclePackager() {
						super();
						setFieldPackager(fld);
					}
				}
		
		3. FinChannel
			package com.equitybank.gag.telco_b2c.ISO8583.configs;

			import org.jpos.iso.*;

			import java.io.IOException;
			import java.net.ServerSocket;


			public class FinChannel extends BaseChannel {
				public FinChannel() {
				}

				public FinChannel(String host, int port, ISOPackager p, byte[] TPDU) {
					super(host, port, p);
					this.header = TPDU;
				}


				public FinChannel(ISOPackager p, byte[] TPDU) throws IOException {
					super(p);
					this.header = TPDU;
				}


				public FinChannel(ISOPackager p, byte[] TPDU, ServerSocket serverSocket) throws IOException {
					super(p, serverSocket);
					this.header = TPDU;
				}

				protected void sendMessageLength(int len) throws IOException {
					this.serverOut.write(len >> 8);
					this.serverOut.write(len);
				}

				protected int getMessageLength() throws IOException, ISOException {
					byte[] b = new byte[2];
					this.serverIn.readFully(b, 0, 2);
					return (b[0] & 0xFF) << 8 | b[1] & 0xFF;
				}


				protected void sendMessageHeader(ISOMsg m, int len) throws IOException {
					byte[] h = m.getHeader();
					if (h != null) {
						if (h.length == 5) {

							byte[] tmp = new byte[2];
							System.arraycopy(h, 1, tmp, 0, 2);
							System.arraycopy(h, 3, h, 1, 2);
							System.arraycopy(tmp, 0, h, 3, 2);
						}
					} else {

						h = this.header;
					}
					if (h != null) {
						this.serverOut.write(h);
					}
				}
				public void setHeader(String header) {
					setHeader(ISOUtil.str2bcd(header, false));
				}
			}
	
	ii. Scheduler
		1. EchoService
			package com.equitybank.gag.telco_b2c.ISO8583.scheduler;

			import com.equitybank.gag.telco_b2c.ISO8583.configs.AppQBean;
			import jakarta.annotation.PreDestroy;
			import org.jpos.iso.ISOException;
			import org.jpos.iso.ISOMsg;
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

				@Value("${echo.timeout}")
				private long echoTimeout;

				@Scheduled(fixedRate = 10000L)
				public void echo() {
					if (AppQBean.drMux == null || !AppQBean.drMux.isConnected()) {
						logger.warn("drMux is not connected. Retrying after delay...");
						return;
					}

					try {
						echoFinDRC();
					} catch (Exception e) {
						logger.error("Error during echo operation", e);
					}
				}

				public ISOMsg sendRequest(ISOMsg req) {
					ISOMsg resp = null;
					try {
						resp = AppQBean.drMux.request(req, echoTimeout);
						if (resp != null) {
							logger.info("Received response: MTI={}, STAN={}", resp.getMTI(), resp.getString(11));
						} else {
							logger.warn("No response received within timeout");
						}
					} catch (ISOException e) {
						logger.error("Error sending request: {}", e.getMessage(), e);
					}
					return resp;
				}

				public void echoFinDRC() {
					logger.info("Initiating echo to DRC at {}", dateFormat.format(new Date()));

					if (AppQBean.drMux.isConnected()) {
						logger.info("Channel is connected and idle. Sending echo message...");

						ISOMsg isoMsg = getEchoMsg("DRC");
						ISOMsg resp = sendRequest(isoMsg);

						if (resp == null) {
							logger.warn("No response received for the echo message. Possible issue with the channel or endpoint.");
						} else {
							logger.info("Received response for echo message: {}", resp);
						}
					} else {
						logger.warn("drMux is not connected. Cannot send echo message.");
					}
				}

				private ISOMsg getEchoMsg(String countryCode) {
					if ("DRC".equalsIgnoreCase(countryCode)) {
						try {
							ISOMsg message = new ISOMsg();
							Random random = new Random();
							String stan = leftPad(random.nextInt(1000000), 6);

							logger.info("Creating FIN echo message for country: {}", countryCode);

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

						} catch (ISOException e) {
							logger.error("Error creating FIN echo message for country: {}", countryCode, e);
							return null;
						} catch (Exception e) {
							logger.error("Unexpected error while creating FIN echo message for country: {}", countryCode, e);
							return null;
						}
					}

					return null;
				}

				public String leftPad(long n, int padding) {
					return String.format("%0" + padding + "d", n);
				}

				@PreDestroy
				public void destroy() {
					logger.info("Shutdown in progress...");
					logger.info("Sign Out...");
				}
			}

	
	iii. Service impl
		1. FinacleCallerServiceImpl
			package com.equitybank.gag.telco_b2c.ISO8583.service.impl;

			import com.equitybank.gag.telco_b2c.ISO8583.configs.AppQBean;
			import com.equitybank.gag.telco_b2c.ISO8583.service.FinacleCallerService;
			import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
			import com.equitybank.gag.telco_b2c.exception.CustomException;
			import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
			import com.equitybank.gag.telco_b2c.service.DatabaseService;
			import org.jpos.iso.ISOException;
			import org.jpos.iso.ISOMsg;
			import org.slf4j.Logger;
			import org.slf4j.LoggerFactory;
			import org.springframework.beans.factory.annotation.Autowired;
			import org.springframework.beans.factory.annotation.Qualifier;
			import org.springframework.core.task.TaskExecutor;
			import org.springframework.stereotype.Service;

			import static com.equitybank.gag.telco_b2c.ISO8583.configs.Constants.*;
			import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

			import com.equitybank.gag.telco_b2c.enums.*;

			@Service
			public class FinacleCallerServiceImpl implements FinacleCallerService {
				private static final Logger log = LoggerFactory.getLogger(FinacleCallerServiceImpl.class);

				private final CustomMapperService customMapperService;
				private final DatabaseService databaseService;
				private final TaskExecutor taskExecutor;

				@Autowired
				public FinacleCallerServiceImpl(CustomMapperService customMapperService,
												DatabaseService databaseService,
												@Qualifier("taskExecutor") TaskExecutor taskExecutor) {
					this.customMapperService = customMapperService;
					this.databaseService = databaseService;
					this.taskExecutor = taskExecutor;
				}

				@Override
				public ISOMsg sendFinacleISORequest(ISOMsg finacleIsoRequest, String bankId, String rrn, String type, String leg) throws CustomException {
					// Validate input parameters
					validateISORequest(finacleIsoRequest, bankId, rrn);

					// Check MUX connection and bank ID validity
					if (!isMuxConnected(bankId)) {
						log.warn("{}: MUX is not connected or invalid bank ID '{}'.", rrn, bankId);
						throw new CustomException(String.format("%sDRC MUX is not connected or invalid bank ID.", DEFAULT_PROCESSING_FAILURE));
					}

					// Send ISO message to Finacle and handle response
					try {
						ISOMsg response = AppQBean.drMux.request(finacleIsoRequest, FINACLE_TRANSACTION_REQUEST_TIMEOUT);
						if (response == null) {
							handleTimeout(rrn, type, leg, finacleIsoRequest);
						}
						log.info("{}: Received response from Finacle: \n{}", rrn, response);
						return response;
					} catch (ISOException e) {
						handleISOException(e, rrn, type, finacleIsoRequest);
						throw new CustomException(String.format("%sFailed to send ISO request to Finacle. %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
					}
				}

				@Override
				public ISOMsg sendFinacleInquireISORequest(ISOMsg statusReq, String bankId, String rrn) throws CustomException {
					if (statusReq == null) {
						log.error("{}: Status request message is null.", rrn);
						throw new CustomException(String.format("%sFinacle get status ISO request message cannot be null.", DEFAULT_PROCESSING_FAILURE));
					}

					if (AppQBean.drMux.isConnected()) {
						try {
							ISOMsg response = AppQBean.drMux.request(statusReq, FINACLE_STATUS_CHECK_INQUIRE_TIMEOUT);
							log.info("{}: Received inquiry response from Finacle: \n{}", rrn, response);
							return response;
						} catch (ISOException e) {
							log.error("{}: ISOException occurred while sending Finacle inquiry ISO request: {}", rrn, e.getMessage());
							throw new CustomException(String.format("%sFailed to send inquiry ISO request to Finacle. %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
						}
					} else {
						log.warn("DRC MUX is not connected.");
						throw new CustomException(String.format("%sDRC MUX is not connected.", DEFAULT_PROCESSING_FAILURE));
					}
				}

				private boolean isMuxConnected(String bankId) {
					return ("43".equalsIgnoreCase(bankId) || "CD".equalsIgnoreCase(bankId)) && AppQBean.drMux.isConnected();
				}

				private void validateISORequest(ISOMsg finacleIsoRequest, String bankId, String rrn) throws CustomException {
					if (finacleIsoRequest == null) {
						log.error("{}: Finacle ISO request is null.", rrn);
						throw new CustomException(String.format("%sFinacle ISO request cannot be null.", DEFAULT_PROCESSING_FAILURE));
					}
					if (bankId == null) {
						log.error("{}: Bank ID cannot be null.", rrn);
						throw new CustomException(String.format("%sInvalid BankId.", DEFAULT_PROCESSING_FAILURE));
					}
				}

				private void handleTimeout(String rrn, String type, String leg, ISOMsg request) throws CustomException {
					String messageDesc = switch (leg) {
						case "transactionLeg" -> "Did not receive response from Finacle. Possible timeout occurred.";
						case "reversalLeg" -> "Timeout occurred during reversal leg.";
						default -> "Finacle timeout occurred.";
					};
					log.error("{}: {}", rrn, messageDesc);
					updateDbWithFinacleStatus(rrn, type, messageDesc);
					throw new CustomException(String.format("%s%s", ISO8583_FINACLE_TIMEOUT, messageDesc));
				}

				private void handleISOException(ISOException e, String rrn, String type, ISOMsg request) {
					String messageDesc = "ISOException while sending ISO request: " + e.getMessage();
					log.error("{}: {}", rrn, messageDesc, e);
					updateDbWithFinacleStatus(rrn, type, messageDesc);
				}

				private void updateDbWithFinacleStatus(String rrn, String type, String messageDesc) {
					CbsStatus status = CbsStatus.TIMEOUT;
					String responseCode = "999";
					TransactionDetails entity = customMapperService.composeFinacleStatusEntity(rrn, type, status, messageDesc, responseCode);
					updateDatabase(entity, rrn, status);
				}

				// This will update the database in async (background thread). Therefore, not need for @Transaction annotation
				private void updateDatabase(TransactionDetails entity, String rrn, CbsStatus status) {
					taskExecutor.execute(() -> {
						if (entity != null) {
							log.info("{}: Saving Finacle {} status in database", rrn, status);
							databaseService.updateTransactionRecord(entity);
						} else {
							log.warn("{}: Could not save Finacle {} status. Entity is null", rrn, status);
						}
					});
				}
			}

		2. ISOMessageCreatorServiceImpl
			package com.equitybank.gag.telco_b2c.ISO8583.service.impl;

			import com.equitybank.gag.telco_b2c.ISO8583.service.ISOMessageCreatorService;
			import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
			import com.equitybank.gag.telco_b2c.dto.request;
			import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
			import com.equitybank.gag.telco_b2c.exception.CustomException;
			import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
			import com.equitybank.gag.telco_b2c.service.ChargeCalculationService;
			import com.equitybank.gag.telco_b2c.service.DatabaseService;
			import org.jpos.iso.ISOMsg;
			import org.slf4j.Logger;
			import org.slf4j.LoggerFactory;
			import org.springframework.beans.factory.annotation.Autowired;
			import org.springframework.beans.factory.annotation.Qualifier;
			import org.springframework.beans.factory.annotation.Value;
			import org.springframework.core.task.TaskExecutor;
			import org.springframework.stereotype.Service;

			import java.math.BigDecimal;
			import java.util.Date;
			import java.util.HashMap;
			import java.util.Map;
			import java.util.concurrent.atomic.AtomicInteger;

			import static com.equitybank.gag.telco_b2c.ISO8583.configs.Constants.*;
			import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.MONEY_GRAM;
			import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

			@Service
			public class ISOMessageCreatorServiceImpl implements ISOMessageCreatorService {
				private static final Logger log = LoggerFactory.getLogger(ISOMessageCreatorServiceImpl.class);
				private static final AtomicInteger counter = new AtomicInteger(0); // Thread-safe counter for STAN

				private final String drcImtCreditGl;
				private final String drcB2cCreditGl;
				private final String drcB2cCommissionGl;
				private final String drcImtCommissionGl;
				private final String drcAirtelFloatPurchaseCreditGlCDF;
				private final String drcAirtelFloatPurchaseCreditGlUSD;
				private final String drcAirtelFloatPurchaseCommissionGl;
				private final String drcVodacomFloatPurchaseCreditGlCDF;
				private final String drcVodacomFloatPurchaseCreditGlUSD;
				private final String drcVodacomFloatPurchaseCommissionGl;

				private final TaskExecutor taskExecutor;
				private final DatabaseService databaseService;
				private final CustomMapperService customMapperService;
				private final ChargeCalculationService chargeCalculationService;

				@Autowired
				public ISOMessageCreatorServiceImpl(@Value("${finacle.gls.drc.imt.credit}") String drcImtCreditGl,
													@Value("${finacle.gls.drc.b2c.credit}") String drcB2cCreditGl,
													@Value("${finacle.gls.drc.b2c.commission}") String drcB2cCommissionGl,
													@Value("${finacle.gls.drc.imt.commission}") String drcImtCommissionGl,
													@Value("${finacle.gls.drc.float-purchase.airtel.credit-CDF}") String drcAirtelFloatPurchaseCreditGlCDF,
													@Value("${finacle.gls.drc.float-purchase.airtel.credit-USD}") String drcAirtelFloatPurchaseCreditGlUSD,
													@Value("${finacle.gls.drc.float-purchase.airtel.commission}") String drcAirtelFloatPurchaseCommissionGl,
													@Value("${finacle.gls.drc.float-purchase.vodacom.credit-CDF}") String drcVodacomFloatPurchaseCreditGlCDF,
													@Value("${finacle.gls.drc.float-purchase.vodacom.credit-USD}") String drcVodacomFloatPurchaseCreditGlUSD,
													@Value("${finacle.gls.drc.float-purchase.vodacom.commission}") String drcVodacomFloatPurchaseCommissionGl,
													@Qualifier("taskExecutor") TaskExecutor taskExecutor,
													DatabaseService databaseService,
													CustomMapperService customMapperService,
													ChargeCalculationService chargeCalculationService) {
					this.drcImtCreditGl = drcImtCreditGl;
					this.drcB2cCreditGl = drcB2cCreditGl;
					this.drcB2cCommissionGl = drcB2cCommissionGl;
					this.drcImtCommissionGl = drcImtCommissionGl;
					this.drcAirtelFloatPurchaseCreditGlCDF = drcAirtelFloatPurchaseCreditGlCDF;
					this.drcAirtelFloatPurchaseCreditGlUSD = drcAirtelFloatPurchaseCreditGlUSD;
					this.drcAirtelFloatPurchaseCommissionGl = drcAirtelFloatPurchaseCommissionGl;
					this.drcVodacomFloatPurchaseCreditGlCDF = drcVodacomFloatPurchaseCreditGlCDF;
					this.drcVodacomFloatPurchaseCreditGlUSD = drcVodacomFloatPurchaseCreditGlUSD;
					this.drcVodacomFloatPurchaseCommissionGl = drcVodacomFloatPurchaseCommissionGl;
					this.taskExecutor = taskExecutor;
					this.databaseService = databaseService;
					this.customMapperService = customMapperService;
					this.chargeCalculationService = chargeCalculationService;
				}

				@Override
				public ISOMsg createMainTransactionIsoMsg(TransactionDetails transactionDetails, request request, Envelope airtimeRequest, Map<String, String> xmlTagsMap, String type) throws CustomException {
					try {
						log.info("Starting to create ISO message for type: {}", type);
						Map<String, String> params = extractParameters(transactionDetails, request, xmlTagsMap, type);
						log.info("Extracted Details For Debit/Credit: " + params);

						String chargeCode = DEFAULT_CHARGE_CODE;
						String channelCode = DEFAULT_IMT_CHANNEL_CODE;
						String cardAcceptorName = getField43(params.get("rrn"), params.get("telco"), params.get("beneficiary"));
						if ("floatPurchase".equals(type)) {
							chargeCode = FLOAT_CHARGE_CODE;
							channelCode = DEFAULT_GAG_CHANNEL_CODE;
							String fullNameCardAcceptorName = params.get("beneficiary") + " " + request.getEazzycash().getName();
							cardAcceptorName = fullNameCardAcceptorName.length() > 49
									? fullNameCardAcceptorName.substring(0, 49)
									: fullNameCardAcceptorName;
						}

						String stan = generateSTAN();
						String rrn = getRrn(request, xmlTagsMap, type);
						String tranDateTime = getFormattedDateTime(7);
						String transmissionDate = getFormattedDateTime(17);
						String localTranDateTime = getFormattedDateTime(12);
						String formattedRRN = formatRrn(params.get("rrn"), stan);
						String tranAmount = getTranAmountStr(new BigDecimal(params.get("tranAmount")));
						String narration = getField125(params.get("narration"), rrn, params.get("imtReferenceNumber"), params.get("receiverName"), params.get("telco"), type);
						narration = narration.length() > 50 ? narration.substring(0, 50) : narration;

						ISOMsg isoMsg = new ISOMsg();
						isoMsg.setMTI(DEFAULT_MESSAGE_TYPE_INDICATOR_MTI);
						isoMsg.set(2, DEFAULT_PRIMARY_ACCOUNT_NUMBER_PAN);
						isoMsg.set(3, DEFAULT_PROCESSING_CODE);
						isoMsg.set(4, tranAmount);
			//            isoMsg.set(7, tranDateTime);
						isoMsg.set(11, stan);
						isoMsg.set(12, localTranDateTime);
						isoMsg.set(17, transmissionDate);
						isoMsg.set(24, DEFAULT_NETWORK_INTERNATIONAL_IDENTIFIER_NII);
						isoMsg.set(32, DEFAULT_ACQUIRING_INSTITUTION_IDENTIFICATION_CODE);
						isoMsg.set(37, formattedRRN);
						isoMsg.set(41, DEFAULT_RATE_CODE);
						isoMsg.set(43, cardAcceptorName);
						isoMsg.set(46, params.get("formattedIsoCharges"));
						isoMsg.set(49, params.get("currency"));
			//            isoMsg.set(63, params.get("commissionGl"));
						isoMsg.set(102, params.get("debitAccount"));
						isoMsg.set(103, params.get("creditGl"));
						isoMsg.set(123, channelCode);
						isoMsg.set(125, narration);
						isoMsg.set(126, chargeCode);
						log.info("ISO Message created successfully for type: {}", type);
						return isoMsg;
					} catch (Exception e) {
						throw new CustomException(String.format("%sIsoMsg request generation failed. %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
					}
				}

				private String getRrn(request request, Map<String, String> xmlTagsMap, String type) {
					return switch (type) {
						case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" -> xmlTagsMap.get("rrn");
						case "transaction", "floatPurchase" -> request.getEazzycash().getRrn();
						default -> "";
					};
				}

				private Map<String, String> extractParameters(TransactionDetails transactionDetails, request request, Map<String, String> xmlTagsMap, String type) throws CustomException {
					// Extracts and maps values to be used in the ISO message based on the transaction type
					String rrn = "";
					Map<String, String> params = new HashMap<>();
					Map<String, String> chargeMap = new HashMap<>();
					switch (type) {
						case "transaction" -> {
							rrn = request.getEazzycash().getRrn();
							chargeMap = chargeCalculationService.calculateCharges(transactionDetails, request, new HashMap<>(), type);
							params.put("chargeAmount", chargeMap.get("chargeAmount"));
							params.put("formattedIsoCharges", chargeMap.get("formattedIsoCharges"));
							params.put("bankId", request.getEazzycash().getBankId() != null ? request.getEazzycash().getBankId() : DEFAULT_BANK_ID);
							params.put("creditGl", drcB2cCreditGl);
							params.put("commissionGl", drcB2cCommissionGl);
							params.put("rrn", rrn);
							params.put("tranAmount", request.getEazzycash().getAmount().toString());
							params.put("telco", request.getEazzycash().getTelco());
							params.put("currency", request.getEazzycash().getCurrency());
							params.put("beneficiary", request.getEazzycash().getNumber());
							params.put("debitAccount", request.getEazzycash().getDebitAccount());
							params.put("narration", "");

						}
						case "floatPurchase" -> {
							String creditGl = "";
							String commissionGl = "";
							rrn = request.getEazzycash().getRrn();
							String currency = request.getEazzycash().getAmountCurrency();
							String telco = request.getEazzycash().getTelco();

							if (telco.toLowerCase().contains("vodacom")) {
								creditGl = "USD".equalsIgnoreCase(currency) ? drcVodacomFloatPurchaseCreditGlUSD : drcVodacomFloatPurchaseCreditGlCDF;
							} else if (telco.toLowerCase().contains("airtel")) {
								creditGl = "USD".equalsIgnoreCase(currency) ? drcAirtelFloatPurchaseCreditGlUSD : drcAirtelFloatPurchaseCreditGlCDF;
							}

							if (creditGl.isEmpty()) {
								log.warn("{}: No matching credit GL found for telco: {}", rrn, telco);
							}

							chargeMap = chargeCalculationService.calculateCharges(transactionDetails, request, new HashMap<>(), type);
							params.put("chargeAmount", chargeMap.get("chargeAmount"));
							params.put("formattedIsoCharges", chargeMap.get("formattedIsoCharges"));
							params.put("bankId", request.getEazzycash().getBankId() != null ? request.getEazzycash().getBankId() : DEFAULT_BANK_ID);
							params.put("creditGl", creditGl);
							params.put("commissionGl", commissionGl);
							params.put("rrn", rrn);
							params.put("tranAmount", request.getEazzycash().getAmount().toString());
							params.put("telco", telco);
							params.put("currency", currency);
							params.put("beneficiary", request.getEazzycash().getNumber());
							params.put("debitAccount", request.getEazzycash().getSourceAccount());
							params.put("narration", request.getEazzycash().getNarration());
						}

						case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" -> {
							String creditAccount = "moneygram-commit-transaction".equals(type) ? drcImtCreditGl : xmlTagsMap.get("receiverAccountNumber");
							String debitAccount = "moneygram-commit-transaction".equals(type) ? xmlTagsMap.get("senderAccountNumber") : drcImtCreditGl;

							rrn = xmlTagsMap.get("rrn");
							chargeMap = chargeCalculationService.calculateCharges(transactionDetails, new request(), xmlTagsMap, type);
							params.put("chargeAmount", chargeMap.get("chargeAmount"));
							params.put("formattedIsoCharges", chargeMap.get("formattedIsoCharges"));
							params.put("bankId", xmlTagsMap.get("bankId") != null ? xmlTagsMap.get("bankId") : DEFAULT_BANK_ID);
							params.put("creditGl", creditAccount);
							params.put("commissionGl", drcImtCommissionGl);
							params.put("telco", MONEY_GRAM);
							params.put("rrn", rrn);
							params.put("tranAmount", xmlTagsMap.get("amount"));
							params.put("currency", xmlTagsMap.get("transactionCurrency"));
							params.put("debitAccount", debitAccount);
							params.put("imtReferenceNumber", xmlTagsMap.get("imtReferenceNumber"));
							params.put("receiverName", xmlTagsMap.get("receiverName"));
							params.put("narration", "");
						}
						default -> log.warn("Unknown transaction type: {}", type);
					}

					// Update total fees to DB
					updateDatabaseWithCharges(chargeMap.get("chargeAmount"), rrn, type);
					return params;
				}

				// Generate System Trace Audit Number - STAN value
				private String generateSTAN() {
					// Get the last 4 digits of the timestamp
					long timestamp = System.currentTimeMillis() % 10000;

					// Increment the counter and ensure it's always in the range 00 to 99
					int counterValue = counter.incrementAndGet() % 100;

					// Combine timestamp and counter to create a 6-digit STAN
					// Use the last 4 digits of timestamp(left pad if needed) and ensure counterValue is 2 digits (left pad if needed).
					return String.format("%04d%02d", timestamp, counterValue);
				}

				// Generate ISO date format
				private String getFormattedDateTime(int field) {
					Date today = new Date();

					if (field == 7) {
						// Field 7: Transmission Date & Time (MMDDhhmmss)
						return String.format("%1$tm%1$td%1$tH%1$tM%1$tS", today);
					} else if (field == 12) {
						// Field 12: Local Transaction Time (yyMMddhhmmss)
						return String.format("%1$ty%1$tm%1$td%1$tH%1$tM%1$tS", today);
					} else if (field == 17) {
						// Field 17: Transaction Date (MMDD)
						return String.format("%1$tm%1$td", today);
					} else {
						log.error("Invalid field number. getFormattedDateTime only supports fields: 7, 12 and 17");
						return "";
					}
				}

				private String getTranAmountStr(BigDecimal amount) {
					// Convert to float and multiply by 100 to shift the decimal point inorder to express amounts in smaller units
					float tranAmountFloat = amount.floatValue();
					tranAmountFloat = tranAmountFloat * 100.0F;

					// Convert to long for ISO8583 field 4
					long tranAmount = (long) tranAmountFloat;

					// Left-pad the amount to ensure it's 12 digits long
					return String.format("%012d", tranAmount);
				}

				// Format rrn
				private static String formatRrn(String rrn, String stan) {
					// Concatenate RRN and STAN
					String concatenated = rrn + stan;

					// Truncate to 12 digits if longer
					if (concatenated.length() > 12) {
						concatenated = concatenated.substring(0, 12);
					}

					// Pad with leading zeros if shorter than 12 digits
					return leftPad(concatenated, 12);
				}

				// Method to left pad a string to a specific length with zeros
				public static String leftPad(String str, int length) {
					return String.format("%1$" + length + "s", str).replace(' ', '0');
				}

				// Generate values for field 43 (Card acceptor name)
				private String getField43(String rrn, String telco, String beneficiary) {
					// Use default empty strings if any of the inputs are null
					String rrnValue = rrn == null ? "" : rrn;
					String telcoValue = telco == null ? "" : telco;
					String beneficiaryValue = beneficiary == null ? "" : beneficiary;

					// Format the field value
					String field43 = String.format("%s %s %s", rrnValue, telcoValue, beneficiaryValue);

					// Truncate to 39 characters if longer
					if (field43.length() > 39) {
						field43 = field43.substring(0, 39);
					}
					return field43;
				}

				private String getField125(String narration, String rrn, String imtReferenceNumber, String receiverName, String telco, String type) {
					String imtTranName = telco.equalsIgnoreCase("moneygram") ? "MGTran" : telco;

					//MG IMT Narration should look like:::: rrn/mtcn/MGTran/FULL_NAME
					return switch (type) {
						case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" ->
								String.format("%s/%s/%s/%s", rrn, imtReferenceNumber, imtTranName, receiverName);
			//            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" ->
			//                    String.format("%s/%s/%s", rrn, DEFAULT_CHARGE_CODE, DEFAULT_IMT_NARRATION_MSG);
						case "transaction" -> String.format("%s/%s/%s", rrn, telco, DEFAULT_B2C_NARRATION_MSG);
						case "floatPurchase" -> String.format("%s/%s/%s", rrn, telco, narration);
						default -> String.format("%s/%s/%s", rrn, telco, DEFAULT_AIRTIME_NARRATION_MSG);
					};
				}

				private void updateDatabaseWithCharges(String charge, String rrn, String type) {
					TransactionDetails entity = customMapperService.composeChargeEntity(charge, rrn, type);
					updateDatabase(entity, rrn);
				}

				// This will update the database in async (background thread). Therefore, not need for @Transaction annotation
				private void updateDatabase(TransactionDetails entity, String rrn) {
					taskExecutor.execute(() -> {
						if (entity != null) {
							log.info("{}: Saving updated total charges entity record", rrn);
							databaseService.updateTransactionRecord(entity);
						} else {
							log.warn("{}: Could not save updated total charges entity record in database. Entity is null", rrn);
						}
					});
				}
			}

			
		3. ISOMsgSerializerAndDeserializerServiceImpl
			package com.equitybank.gag.telco_b2c.ISO8583.service.impl;

			import com.equitybank.gag.telco_b2c.ISO8583.service.ISOMsgSerializerAndDeserializerService;
			import org.jpos.iso.ISOMsg;
			import org.slf4j.Logger;
			import org.slf4j.LoggerFactory;
			import org.springframework.stereotype.Service;

			import java.io.*;

			@Service
			public class ISOMsgSerializerAndDeserializerServiceImpl implements ISOMsgSerializerAndDeserializerService {
				private static final Logger log = LoggerFactory.getLogger(ISOMsgSerializerAndDeserializerServiceImpl.class);

				@Override
				public byte[] serializeISOMsg(ISOMsg isoMsg) {
					ByteArrayOutputStream baos = null;
					ObjectOutputStream oos = null;
					try {
						baos = new ByteArrayOutputStream();
						oos = new ObjectOutputStream(baos);
						oos.writeObject(isoMsg);
						return baos.toByteArray();
					} catch (IOException e) {
						log.error("Could not serialize ISOMsg: {}", e.getMessage());
						return new byte[0];
					} finally {
						if (oos != null) {
							try {
								oos.close();
							} catch (IOException e) {
								log.error("IOException occurred when trying to close ObjectOutputStream: {}", e.getMessage());
							}
						}
						if (baos != null) {
							try {
								baos.close();
							} catch (IOException e) {
								log.error("IOException occurred when trying to close ByteArrayOutputStream: {}", e.getMessage());
							}
						}
					}
				}

				@Override
				public ISOMsg deserializeISOMsg(byte[] data) {
					ByteArrayInputStream bais = null;
					ObjectInputStream ois = null;
					try {
						bais = new ByteArrayInputStream(data);
						ois = new ObjectInputStream(bais);
						return (ISOMsg) ois.readObject();
					} catch (IOException | ClassNotFoundException e) {
						log.error("Could not de-serialize ISOMsg: {}", e.getMessage());
						return new ISOMsg();
					} finally {
						if (ois != null) {
							try {
								ois.close();
							} catch (IOException e) {
								log.error("IOException occurred when trying to close ObjectInputStream: {}", e.getMessage());
							}
						}
						if (bais != null) {
							try {
								bais.close();
							} catch (IOException e) {
								log.error("IOException occurred when trying to close ByteArrayInputStream: {}", e.getMessage());
							}
						}
					}
				}

				@Override
				public String convertIsoMessageToString(ISOMsg isoMsg, String rrn) {
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					PrintStream ps = new PrintStream(baos);
					try {
						isoMsg.dump(ps, ""); // Dumps the ISO message details into the PrintStream
						return baos.toString(); // Converts the byte array to a string
					} catch (Exception e) {
						log.error("{}: Exception occurred. Failed to convert ISO Message to string: {}", rrn, e.getMessage());
						return null;
					} finally {
						try {
							ps.close(); // Closes the PrintStream
							baos.close(); // Closes the ByteArrayOutputStream
						} catch (IOException e) {
							log.error("{}: IOException occurred. Failed to close stream: {}", rrn, e.getMessage());
						}
					}
				}
			}




