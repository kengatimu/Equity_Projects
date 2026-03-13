
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.huawei.cps.cpsinterface.request package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {


    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.huawei.cps.cpsinterface.request
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link AdditionalCardInfos }
     * 
     */
    public AdditionalCardInfos createAdditionalCardInfos() {
        return new AdditionalCardInfos();
    }

    /**
     * Create an instance of {@link Request }
     * 
     */
    public Request createRequest() {
        return new Request();
    }

    /**
     * Create an instance of {@link Request.Body }
     * 
     */
    public Request.Body createRequestBody() {
        return new Request.Body();
    }

    /**
     * Create an instance of {@link Request.Body.TransactionRequest }
     * 
     */
    public Request.Body.TransactionRequest createRequestBodyTransactionRequest() {
        return new Request.Body.TransactionRequest();
    }

    /**
     * Create an instance of {@link Request.Body.Identity }
     * 
     */
    public Request.Body.Identity createRequestBodyIdentity() {
        return new Request.Body.Identity();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.ReceiverParty }
     * 
     */
    public Request.Body.Identity.ReceiverParty createRequestBodyIdentityReceiverParty() {
        return new Request.Body.Identity.ReceiverParty();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.ReceiverParty.ReceiverKYC }
     * 
     */
    public Request.Body.Identity.ReceiverParty.ReceiverKYC createRequestBodyIdentityReceiverPartyReceiverKYC() {
        return new Request.Body.Identity.ReceiverParty.ReceiverKYC();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.PrimaryParty }
     * 
     */
    public Request.Body.Identity.PrimaryParty createRequestBodyIdentityPrimaryParty() {
        return new Request.Body.Identity.PrimaryParty();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC }
     * 
     */
    public Request.Body.Identity.PrimaryParty.PrimaryPartyKYC createRequestBodyIdentityPrimaryPartyPrimaryPartyKYC() {
        return new Request.Body.Identity.PrimaryParty.PrimaryPartyKYC();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.Initiator }
     * 
     */
    public Request.Body.Identity.Initiator createRequestBodyIdentityInitiator() {
        return new Request.Body.Identity.Initiator();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.Initiator.InitiatorKYC }
     * 
     */
    public Request.Body.Identity.Initiator.InitiatorKYC createRequestBodyIdentityInitiatorInitiatorKYC() {
        return new Request.Body.Identity.Initiator.InitiatorKYC();
    }

    /**
     * Create an instance of {@link Request.Header }
     * 
     */
    public Request.Header createRequestHeader() {
        return new Request.Header();
    }

    /**
     * Create an instance of {@link PreValidationRequest }
     * 
     */
    public PreValidationRequest createPreValidationRequest() {
        return new PreValidationRequest();
    }

    /**
     * Create an instance of {@link UnlinkIdentitiesRequest }
     * 
     */
    public UnlinkIdentitiesRequest createUnlinkIdentitiesRequest() {
        return new UnlinkIdentitiesRequest();
    }

    /**
     * Create an instance of {@link LinkingIdentitiesRequest }
     * 
     */
    public LinkingIdentitiesRequest createLinkingIdentitiesRequest() {
        return new LinkingIdentitiesRequest();
    }

    /**
     * Create an instance of {@link AdjustOrganizationPointsRequest }
     * 
     */
    public AdjustOrganizationPointsRequest createAdjustOrganizationPointsRequest() {
        return new AdjustOrganizationPointsRequest();
    }

    /**
     * Create an instance of {@link AdjustOrganizationPointsRequest.PointList }
     * 
     */
    public AdjustOrganizationPointsRequest.PointList createAdjustOrganizationPointsRequestPointList() {
        return new AdjustOrganizationPointsRequest.PointList();
    }

    /**
     * Create an instance of {@link AdjustCustomerPointsRequest }
     * 
     */
    public AdjustCustomerPointsRequest createAdjustCustomerPointsRequest() {
        return new AdjustCustomerPointsRequest();
    }

    /**
     * Create an instance of {@link AdjustCustomerPointsRequest.PointList }
     * 
     */
    public AdjustCustomerPointsRequest.PointList createAdjustCustomerPointsRequestPointList() {
        return new AdjustCustomerPointsRequest.PointList();
    }

    /**
     * Create an instance of {@link QueryOrganizationPointsLogRequest }
     * 
     */
    public QueryOrganizationPointsLogRequest createQueryOrganizationPointsLogRequest() {
        return new QueryOrganizationPointsLogRequest();
    }

    /**
     * Create an instance of {@link QueryCustomerPointsLogRequest }
     * 
     */
    public QueryCustomerPointsLogRequest createQueryCustomerPointsLogRequest() {
        return new QueryCustomerPointsLogRequest();
    }

    /**
     * Create an instance of {@link CustomerGetStartPINRequest }
     * 
     */
    public CustomerGetStartPINRequest createCustomerGetStartPINRequest() {
        return new CustomerGetStartPINRequest();
    }

    /**
     * Create an instance of {@link BulkTaskRequest }
     * 
     */
    public BulkTaskRequest createBulkTaskRequest() {
        return new BulkTaskRequest();
    }

    /**
     * Create an instance of {@link CustomerCertificationRequest }
     * 
     */
    public CustomerCertificationRequest createCustomerCertificationRequest() {
        return new CustomerCertificationRequest();
    }

    /**
     * Create an instance of {@link CustomerSelfRegistration4PINRequest }
     * 
     */
    public CustomerSelfRegistration4PINRequest createCustomerSelfRegistration4PINRequest() {
        return new CustomerSelfRegistration4PINRequest();
    }

    /**
     * Create an instance of {@link VerifyCCCallerRequest }
     * 
     */
    public VerifyCCCallerRequest createVerifyCCCallerRequest() {
        return new VerifyCCCallerRequest();
    }

    /**
     * Create an instance of {@link AddO2CLinkRequest }
     * 
     */
    public AddO2CLinkRequest createAddO2CLinkRequest() {
        return new AddO2CLinkRequest();
    }

    /**
     * Create an instance of {@link RegisterCustomerRequest }
     * 
     */
    public RegisterCustomerRequest createRegisterCustomerRequest() {
        return new RegisterCustomerRequest();
    }

    /**
     * Create an instance of {@link UpdateTillProductsRequest }
     * 
     */
    public UpdateTillProductsRequest createUpdateTillProductsRequest() {
        return new UpdateTillProductsRequest();
    }

    /**
     * Create an instance of {@link UpdateTillProductsRequest.ProductUpdateData }
     * 
     */
    public UpdateTillProductsRequest.ProductUpdateData createUpdateTillProductsRequestProductUpdateData() {
        return new UpdateTillProductsRequest.ProductUpdateData();
    }

    /**
     * Create an instance of {@link QuestionAnswerType }
     * 
     */
    public QuestionAnswerType createQuestionAnswerType() {
        return new QuestionAnswerType();
    }

    /**
     * Create an instance of {@link QuestionAnswerType.TransactionCreditParty }
     * 
     */
    public QuestionAnswerType.TransactionCreditParty createQuestionAnswerTypeTransactionCreditParty() {
        return new QuestionAnswerType.TransactionCreditParty();
    }

    /**
     * Create an instance of {@link O2CLinkDeleteDataType }
     * 
     */
    public O2CLinkDeleteDataType createO2CLinkDeleteDataType() {
        return new O2CLinkDeleteDataType();
    }

    /**
     * Create an instance of {@link TaxExemptionDataType }
     * 
     */
    public TaxExemptionDataType createTaxExemptionDataType() {
        return new TaxExemptionDataType();
    }

    /**
     * Create an instance of {@link RoleUpdateDataType }
     * 
     */
    public RoleUpdateDataType createRoleUpdateDataType() {
        return new RoleUpdateDataType();
    }

    /**
     * Create an instance of {@link ProductUpdateDataType }
     * 
     */
    public ProductUpdateDataType createProductUpdateDataType() {
        return new ProductUpdateDataType();
    }

    /**
     * Create an instance of {@link ContactRecordConditionType }
     * 
     */
    public ContactRecordConditionType createContactRecordConditionType() {
        return new ContactRecordConditionType();
    }

    /**
     * Create an instance of {@link AdditionalCardInfos.AdditionalCardInfo }
     * 
     */
    public AdditionalCardInfos.AdditionalCardInfo createAdditionalCardInfosAdditionalCardInfo() {
        return new AdditionalCardInfos.AdditionalCardInfo();
    }

    /**
     * Create an instance of {@link SimpleKYCUpdateDataType }
     * 
     */
    public SimpleKYCUpdateDataType createSimpleKYCUpdateDataType() {
        return new SimpleKYCUpdateDataType();
    }

    /**
     * Create an instance of {@link IDRecordConditionType }
     * 
     */
    public IDRecordConditionType createIDRecordConditionType() {
        return new IDRecordConditionType();
    }

    /**
     * Create an instance of {@link IDDetailsUpdateDataType }
     * 
     */
    public IDDetailsUpdateDataType createIDDetailsUpdateDataType() {
        return new IDDetailsUpdateDataType();
    }

    /**
     * Create an instance of {@link ContactDetailsUpdateDataType }
     * 
     */
    public ContactDetailsUpdateDataType createContactDetailsUpdateDataType() {
        return new ContactDetailsUpdateDataType();
    }

    /**
     * Create an instance of {@link CertificateRecordConditionType }
     * 
     */
    public CertificateRecordConditionType createCertificateRecordConditionType() {
        return new CertificateRecordConditionType();
    }

    /**
     * Create an instance of {@link CertificateDetailsUpdateDataType }
     * 
     */
    public CertificateDetailsUpdateDataType createCertificateDetailsUpdateDataType() {
        return new CertificateDetailsUpdateDataType();
    }

    /**
     * Create an instance of {@link BankAccountRecordConditionType }
     * 
     */
    public BankAccountRecordConditionType createBankAccountRecordConditionType() {
        return new BankAccountRecordConditionType();
    }

    /**
     * Create an instance of {@link BankAccountDetailsUpdateDataType }
     * 
     */
    public BankAccountDetailsUpdateDataType createBankAccountDetailsUpdateDataType() {
        return new BankAccountDetailsUpdateDataType();
    }

    /**
     * Create an instance of {@link SIMDeviceUpdateType }
     * 
     */
    public SIMDeviceUpdateType createSIMDeviceUpdateType() {
        return new SIMDeviceUpdateType();
    }

    /**
     * Create an instance of {@link ChangeCustomerMSISDNRequest }
     * 
     */
    public ChangeCustomerMSISDNRequest createChangeCustomerMSISDNRequest() {
        return new ChangeCustomerMSISDNRequest();
    }

    /**
     * Create an instance of {@link ChangeTillMSISDNRequest }
     * 
     */
    public ChangeTillMSISDNRequest createChangeTillMSISDNRequest() {
        return new ChangeTillMSISDNRequest();
    }

    /**
     * Create an instance of {@link ChangeTillLanguageRequest }
     * 
     */
    public ChangeTillLanguageRequest createChangeTillLanguageRequest() {
        return new ChangeTillLanguageRequest();
    }

    /**
     * Create an instance of {@link ChangeAccountStatusRequest }
     * 
     */
    public ChangeAccountStatusRequest createChangeAccountStatusRequest() {
        return new ChangeAccountStatusRequest();
    }

    /**
     * Create an instance of {@link UpdateCustomerKYCRequest }
     * 
     */
    public UpdateCustomerKYCRequest createUpdateCustomerKYCRequest() {
        return new UpdateCustomerKYCRequest();
    }

    /**
     * Create an instance of {@link UpdateOrganizationKYCRequest }
     * 
     */
    public UpdateOrganizationKYCRequest createUpdateOrganizationKYCRequest() {
        return new UpdateOrganizationKYCRequest();
    }

    /**
     * Create an instance of {@link QueryCustomerKYCRequest }
     * 
     */
    public QueryCustomerKYCRequest createQueryCustomerKYCRequest() {
        return new QueryCustomerKYCRequest();
    }

    /**
     * Create an instance of {@link QueryCustomerInfoRequest }
     * 
     */
    public QueryCustomerInfoRequest createQueryCustomerInfoRequest() {
        return new QueryCustomerInfoRequest();
    }

    /**
     * Create an instance of {@link QueryCustomerProductsRequest }
     * 
     */
    public QueryCustomerProductsRequest createQueryCustomerProductsRequest() {
        return new QueryCustomerProductsRequest();
    }

    /**
     * Create an instance of {@link QueryCustomerBalanceRequest }
     * 
     */
    public QueryCustomerBalanceRequest createQueryCustomerBalanceRequest() {
        return new QueryCustomerBalanceRequest();
    }

    /**
     * Create an instance of {@link QueryOrganizationKYCRequest }
     * 
     */
    public QueryOrganizationKYCRequest createQueryOrganizationKYCRequest() {
        return new QueryOrganizationKYCRequest();
    }

    /**
     * Create an instance of {@link QueryOrganizationInfoRequest }
     * 
     */
    public QueryOrganizationInfoRequest createQueryOrganizationInfoRequest() {
        return new QueryOrganizationInfoRequest();
    }

    /**
     * Create an instance of {@link QueryOrganizationProductsRequest }
     * 
     */
    public QueryOrganizationProductsRequest createQueryOrganizationProductsRequest() {
        return new QueryOrganizationProductsRequest();
    }

    /**
     * Create an instance of {@link QueryOrganizationBalanceRequest }
     * 
     */
    public QueryOrganizationBalanceRequest createQueryOrganizationBalanceRequest() {
        return new QueryOrganizationBalanceRequest();
    }

    /**
     * Create an instance of {@link ListOrganizationTillsRequest }
     * 
     */
    public ListOrganizationTillsRequest createListOrganizationTillsRequest() {
        return new ListOrganizationTillsRequest();
    }

    /**
     * Create an instance of {@link QueryOrgOperatorKYCRequest }
     * 
     */
    public QueryOrgOperatorKYCRequest createQueryOrgOperatorKYCRequest() {
        return new QueryOrgOperatorKYCRequest();
    }

    /**
     * Create an instance of {@link QueryOrgOperatorInfoRequest }
     * 
     */
    public QueryOrgOperatorInfoRequest createQueryOrgOperatorInfoRequest() {
        return new QueryOrgOperatorInfoRequest();
    }

    /**
     * Create an instance of {@link QueryTillInfoRequest }
     * 
     */
    public QueryTillInfoRequest createQueryTillInfoRequest() {
        return new QueryTillInfoRequest();
    }

    /**
     * Create an instance of {@link QueryTillProductsRequest }
     * 
     */
    public QueryTillProductsRequest createQueryTillProductsRequest() {
        return new QueryTillProductsRequest();
    }

    /**
     * Create an instance of {@link CreateTopOrgRequest }
     * 
     */
    public CreateTopOrgRequest createCreateTopOrgRequest() {
        return new CreateTopOrgRequest();
    }

    /**
     * Create an instance of {@link CreateChildOrgRequest }
     * 
     */
    public CreateChildOrgRequest createCreateChildOrgRequest() {
        return new CreateChildOrgRequest();
    }

    /**
     * Create an instance of {@link CreateTillRequest }
     * 
     */
    public CreateTillRequest createCreateTillRequest() {
        return new CreateTillRequest();
    }

    /**
     * Create an instance of {@link CreateOrgOperatorRequest }
     * 
     */
    public CreateOrgOperatorRequest createCreateOrgOperatorRequest() {
        return new CreateOrgOperatorRequest();
    }

    /**
     * Create an instance of {@link ChangeCustomerStatusRequest }
     * 
     */
    public ChangeCustomerStatusRequest createChangeCustomerStatusRequest() {
        return new ChangeCustomerStatusRequest();
    }

    /**
     * Create an instance of {@link ChangeOrganizationStatusRequest }
     * 
     */
    public ChangeOrganizationStatusRequest createChangeOrganizationStatusRequest() {
        return new ChangeOrganizationStatusRequest();
    }

    /**
     * Create an instance of {@link ChangeTillStatusRequest }
     * 
     */
    public ChangeTillStatusRequest createChangeTillStatusRequest() {
        return new ChangeTillStatusRequest();
    }

    /**
     * Create an instance of {@link ChangeTillDefaultOperatorIDRequest }
     * 
     */
    public ChangeTillDefaultOperatorIDRequest createChangeTillDefaultOperatorIDRequest() {
        return new ChangeTillDefaultOperatorIDRequest();
    }

    /**
     * Create an instance of {@link ChangeSPOperatorStatusRequest }
     * 
     */
    public ChangeSPOperatorStatusRequest createChangeSPOperatorStatusRequest() {
        return new ChangeSPOperatorStatusRequest();
    }

    /**
     * Create an instance of {@link ChangeOrgOperatorStatusRequest }
     * 
     */
    public ChangeOrgOperatorStatusRequest createChangeOrgOperatorStatusRequest() {
        return new ChangeOrgOperatorStatusRequest();
    }

    /**
     * Create an instance of {@link UpdateSPOperatorKYCRequest }
     * 
     */
    public UpdateSPOperatorKYCRequest createUpdateSPOperatorKYCRequest() {
        return new UpdateSPOperatorKYCRequest();
    }

    /**
     * Create an instance of {@link UpdateOrgOperatorKYCRequest }
     * 
     */
    public UpdateOrgOperatorKYCRequest createUpdateOrgOperatorKYCRequest() {
        return new UpdateOrgOperatorKYCRequest();
    }

    /**
     * Create an instance of {@link UpdateCustomerProductsRequest }
     * 
     */
    public UpdateCustomerProductsRequest createUpdateCustomerProductsRequest() {
        return new UpdateCustomerProductsRequest();
    }

    /**
     * Create an instance of {@link UpdateOrganizationProductsRequest }
     * 
     */
    public UpdateOrganizationProductsRequest createUpdateOrganizationProductsRequest() {
        return new UpdateOrganizationProductsRequest();
    }

    /**
     * Create an instance of {@link RecycleMSISDNRequest }
     * 
     */
    public RecycleMSISDNRequest createRecycleMSISDNRequest() {
        return new RecycleMSISDNRequest();
    }

    /**
     * Create an instance of {@link ListOrganizationChildStoresRequest }
     * 
     */
    public ListOrganizationChildStoresRequest createListOrganizationChildStoresRequest() {
        return new ListOrganizationChildStoresRequest();
    }

    /**
     * Create an instance of {@link ListOrganizationOperatorsRequest }
     * 
     */
    public ListOrganizationOperatorsRequest createListOrganizationOperatorsRequest() {
        return new ListOrganizationOperatorsRequest();
    }

    /**
     * Create an instance of {@link UpdateSPOperatorRoleRequest }
     * 
     */
    public UpdateSPOperatorRoleRequest createUpdateSPOperatorRoleRequest() {
        return new UpdateSPOperatorRoleRequest();
    }

    /**
     * Create an instance of {@link UpdateOrgOperatorRoleRequest }
     * 
     */
    public UpdateOrgOperatorRoleRequest createUpdateOrgOperatorRoleRequest() {
        return new UpdateOrgOperatorRoleRequest();
    }

    /**
     * Create an instance of {@link UpdateOrgTaxExemptionRequest }
     * 
     */
    public UpdateOrgTaxExemptionRequest createUpdateOrgTaxExemptionRequest() {
        return new UpdateOrgTaxExemptionRequest();
    }

    /**
     * Create an instance of {@link QueryO2CLinkRequest }
     * 
     */
    public QueryO2CLinkRequest createQueryO2CLinkRequest() {
        return new QueryO2CLinkRequest();
    }

    /**
     * Create an instance of {@link DeleteO2CLinkRequest }
     * 
     */
    public DeleteO2CLinkRequest createDeleteO2CLinkRequest() {
        return new DeleteO2CLinkRequest();
    }

    /**
     * Create an instance of {@link UnlockCustomerPINRequest }
     * 
     */
    public UnlockCustomerPINRequest createUnlockCustomerPINRequest() {
        return new UnlockCustomerPINRequest();
    }

    /**
     * Create an instance of {@link UnlockOrgOperatorPINRequest }
     * 
     */
    public UnlockOrgOperatorPINRequest createUnlockOrgOperatorPINRequest() {
        return new UnlockOrgOperatorPINRequest();
    }

    /**
     * Create an instance of {@link UnlockOrgOperatorPasswordRequest }
     * 
     */
    public UnlockOrgOperatorPasswordRequest createUnlockOrgOperatorPasswordRequest() {
        return new UnlockOrgOperatorPasswordRequest();
    }

    /**
     * Create an instance of {@link ResetCustomerPINRequest }
     * 
     */
    public ResetCustomerPINRequest createResetCustomerPINRequest() {
        return new ResetCustomerPINRequest();
    }

    /**
     * Create an instance of {@link ResetOrgOperatorPINRequest }
     * 
     */
    public ResetOrgOperatorPINRequest createResetOrgOperatorPINRequest() {
        return new ResetOrgOperatorPINRequest();
    }

    /**
     * Create an instance of {@link ResetOrgOperatorPasswordRequest }
     * 
     */
    public ResetOrgOperatorPasswordRequest createResetOrgOperatorPasswordRequest() {
        return new ResetOrgOperatorPasswordRequest();
    }

    /**
     * Create an instance of {@link ResetCustomerSecretWordRequest }
     * 
     */
    public ResetCustomerSecretWordRequest createResetCustomerSecretWordRequest() {
        return new ResetCustomerSecretWordRequest();
    }

    /**
     * Create an instance of {@link ReleaseCustomerCCSuspendStatusRequest }
     * 
     */
    public ReleaseCustomerCCSuspendStatusRequest createReleaseCustomerCCSuspendStatusRequest() {
        return new ReleaseCustomerCCSuspendStatusRequest();
    }

    /**
     * Create an instance of {@link ReleaseOrgOperatorCCSuspendStatusRequest }
     * 
     */
    public ReleaseOrgOperatorCCSuspendStatusRequest createReleaseOrgOperatorCCSuspendStatusRequest() {
        return new ReleaseOrgOperatorCCSuspendStatusRequest();
    }

    /**
     * Create an instance of {@link SearchTransactionRequest }
     * 
     */
    public SearchTransactionRequest createSearchTransactionRequest() {
        return new SearchTransactionRequest();
    }

    /**
     * Create an instance of {@link ReverseTransactionRequest }
     * 
     */
    public ReverseTransactionRequest createReverseTransactionRequest() {
        return new ReverseTransactionRequest();
    }

    /**
     * Create an instance of {@link ConfirmTransactionRequest }
     * 
     */
    public ConfirmTransactionRequest createConfirmTransactionRequest() {
        return new ConfirmTransactionRequest();
    }

    /**
     * Create an instance of {@link QueryCustomerAccountStatementsRequest }
     * 
     */
    public QueryCustomerAccountStatementsRequest createQueryCustomerAccountStatementsRequest() {
        return new QueryCustomerAccountStatementsRequest();
    }

    /**
     * Create an instance of {@link QueryCustomerTransactionsRequest }
     * 
     */
    public QueryCustomerTransactionsRequest createQueryCustomerTransactionsRequest() {
        return new QueryCustomerTransactionsRequest();
    }

    /**
     * Create an instance of {@link QueryOrganizationAccountStatementsRequest }
     * 
     */
    public QueryOrganizationAccountStatementsRequest createQueryOrganizationAccountStatementsRequest() {
        return new QueryOrganizationAccountStatementsRequest();
    }

    /**
     * Create an instance of {@link QueryOrganizationTransactionsRequest }
     * 
     */
    public QueryOrganizationTransactionsRequest createQueryOrganizationTransactionsRequest() {
        return new QueryOrganizationTransactionsRequest();
    }

    /**
     * Create an instance of {@link QueryResultMessageRequest }
     * 
     */
    public QueryResultMessageRequest createQueryResultMessageRequest() {
        return new QueryResultMessageRequest();
    }

    /**
     * Create an instance of {@link UpdateTransactionStatusRequest }
     * 
     */
    public UpdateTransactionStatusRequest createUpdateTransactionStatusRequest() {
        return new UpdateTransactionStatusRequest();
    }

    /**
     * Create an instance of {@link QueryMiniStatementsRequest }
     * 
     */
    public QueryMiniStatementsRequest createQueryMiniStatementsRequest() {
        return new QueryMiniStatementsRequest();
    }

    /**
     * Create an instance of {@link ChangeCustomerPINRequest }
     * 
     */
    public ChangeCustomerPINRequest createChangeCustomerPINRequest() {
        return new ChangeCustomerPINRequest();
    }

    /**
     * Create an instance of {@link ChangeOrgOperatorPINRequest }
     * 
     */
    public ChangeOrgOperatorPINRequest createChangeOrgOperatorPINRequest() {
        return new ChangeOrgOperatorPINRequest();
    }

    /**
     * Create an instance of {@link ChangeCustomerSecretWordRequest }
     * 
     */
    public ChangeCustomerSecretWordRequest createChangeCustomerSecretWordRequest() {
        return new ChangeCustomerSecretWordRequest();
    }

    /**
     * Create an instance of {@link ChangeOrgOperatorSecretWordRequest }
     * 
     */
    public ChangeOrgOperatorSecretWordRequest createChangeOrgOperatorSecretWordRequest() {
        return new ChangeOrgOperatorSecretWordRequest();
    }

    /**
     * Create an instance of {@link ChangeCustomerLanguageRequest }
     * 
     */
    public ChangeCustomerLanguageRequest createChangeCustomerLanguageRequest() {
        return new ChangeCustomerLanguageRequest();
    }

    /**
     * Create an instance of {@link ChangeOrgOperatorLanguageRequest }
     * 
     */
    public ChangeOrgOperatorLanguageRequest createChangeOrgOperatorLanguageRequest() {
        return new ChangeOrgOperatorLanguageRequest();
    }

    /**
     * Create an instance of {@link ChangeSPOperatorLanguageRequest }
     * 
     */
    public ChangeSPOperatorLanguageRequest createChangeSPOperatorLanguageRequest() {
        return new ChangeSPOperatorLanguageRequest();
    }

    /**
     * Create an instance of {@link ChangeOrgnNameRequest }
     * 
     */
    public ChangeOrgnNameRequest createChangeOrgnNameRequest() {
        return new ChangeOrgnNameRequest();
    }

    /**
     * Create an instance of {@link ActivateCustomerRequest }
     * 
     */
    public ActivateCustomerRequest createActivateCustomerRequest() {
        return new ActivateCustomerRequest();
    }

    /**
     * Create an instance of {@link ActivateTillRequest }
     * 
     */
    public ActivateTillRequest createActivateTillRequest() {
        return new ActivateTillRequest();
    }

    /**
     * Create an instance of {@link QueryCashupStatementsRequest }
     * 
     */
    public QueryCashupStatementsRequest createQueryCashupStatementsRequest() {
        return new QueryCashupStatementsRequest();
    }

    /**
     * Create an instance of {@link ApplyVoucherRequest }
     * 
     */
    public ApplyVoucherRequest createApplyVoucherRequest() {
        return new ApplyVoucherRequest();
    }

    /**
     * Create an instance of {@link CancelIssuedVoucherRequest }
     * 
     */
    public CancelIssuedVoucherRequest createCancelIssuedVoucherRequest() {
        return new CancelIssuedVoucherRequest();
    }

    /**
     * Create an instance of {@link CreateDirectDebitMandateByPayeeRequest }
     * 
     */
    public CreateDirectDebitMandateByPayeeRequest createCreateDirectDebitMandateByPayeeRequest() {
        return new CreateDirectDebitMandateByPayeeRequest();
    }

    /**
     * Create an instance of {@link CreateDirectDebitMandateByPayerRequest }
     * 
     */
    public CreateDirectDebitMandateByPayerRequest createCreateDirectDebitMandateByPayerRequest() {
        return new CreateDirectDebitMandateByPayerRequest();
    }

    /**
     * Create an instance of {@link ActivateDirectDebitMandateRequest }
     * 
     */
    public ActivateDirectDebitMandateRequest createActivateDirectDebitMandateRequest() {
        return new ActivateDirectDebitMandateRequest();
    }

    /**
     * Create an instance of {@link CancelDirectDebitMandateByPayerRequest }
     * 
     */
    public CancelDirectDebitMandateByPayerRequest createCancelDirectDebitMandateByPayerRequest() {
        return new CancelDirectDebitMandateByPayerRequest();
    }

    /**
     * Create an instance of {@link CancelDirectDebitMandateByPayeeRequest }
     * 
     */
    public CancelDirectDebitMandateByPayeeRequest createCancelDirectDebitMandateByPayeeRequest() {
        return new CancelDirectDebitMandateByPayeeRequest();
    }

    /**
     * Create an instance of {@link ReactivateDirectDebitMandateByPayerRequest }
     * 
     */
    public ReactivateDirectDebitMandateByPayerRequest createReactivateDirectDebitMandateByPayerRequest() {
        return new ReactivateDirectDebitMandateByPayerRequest();
    }

    /**
     * Create an instance of {@link ReactivateDirectDebitMandateByPayeeRequest }
     * 
     */
    public ReactivateDirectDebitMandateByPayeeRequest createReactivateDirectDebitMandateByPayeeRequest() {
        return new ReactivateDirectDebitMandateByPayeeRequest();
    }

    /**
     * Create an instance of {@link EditDirectDebitMandateByPayerRequest }
     * 
     */
    public EditDirectDebitMandateByPayerRequest createEditDirectDebitMandateByPayerRequest() {
        return new EditDirectDebitMandateByPayerRequest();
    }

    /**
     * Create an instance of {@link EditDirectDebitMandateByPayeeRequest }
     * 
     */
    public EditDirectDebitMandateByPayeeRequest createEditDirectDebitMandateByPayeeRequest() {
        return new EditDirectDebitMandateByPayeeRequest();
    }

    /**
     * Create an instance of {@link QueryDirectDebitMandateByPayerRequest }
     * 
     */
    public QueryDirectDebitMandateByPayerRequest createQueryDirectDebitMandateByPayerRequest() {
        return new QueryDirectDebitMandateByPayerRequest();
    }

    /**
     * Create an instance of {@link ViewDirectDebitMandateByPayerRequest }
     * 
     */
    public ViewDirectDebitMandateByPayerRequest createViewDirectDebitMandateByPayerRequest() {
        return new ViewDirectDebitMandateByPayerRequest();
    }

    /**
     * Create an instance of {@link ViewDirectDebitMandateByPayeeRequest }
     * 
     */
    public ViewDirectDebitMandateByPayeeRequest createViewDirectDebitMandateByPayeeRequest() {
        return new ViewDirectDebitMandateByPayeeRequest();
    }

    /**
     * Create an instance of {@link AddCustomerBeneficiaryRequest }
     * 
     */
    public AddCustomerBeneficiaryRequest createAddCustomerBeneficiaryRequest() {
        return new AddCustomerBeneficiaryRequest();
    }

    /**
     * Create an instance of {@link AddOrgBeneficiaryRequest }
     * 
     */
    public AddOrgBeneficiaryRequest createAddOrgBeneficiaryRequest() {
        return new AddOrgBeneficiaryRequest();
    }

    /**
     * Create an instance of {@link DeleteCustomerBeneficiaryRequest }
     * 
     */
    public DeleteCustomerBeneficiaryRequest createDeleteCustomerBeneficiaryRequest() {
        return new DeleteCustomerBeneficiaryRequest();
    }

    /**
     * Create an instance of {@link DeleteOrgBeneficiaryRequest }
     * 
     */
    public DeleteOrgBeneficiaryRequest createDeleteOrgBeneficiaryRequest() {
        return new DeleteOrgBeneficiaryRequest();
    }

    /**
     * Create an instance of {@link LookupCustomerBeneficiaryRequest }
     * 
     */
    public LookupCustomerBeneficiaryRequest createLookupCustomerBeneficiaryRequest() {
        return new LookupCustomerBeneficiaryRequest();
    }

    /**
     * Create an instance of {@link LookupOrgBeneficiaryRequest }
     * 
     */
    public LookupOrgBeneficiaryRequest createLookupOrgBeneficiaryRequest() {
        return new LookupOrgBeneficiaryRequest();
    }

    /**
     * Create an instance of {@link AddGroupBeneficiaryRequest }
     * 
     */
    public AddGroupBeneficiaryRequest createAddGroupBeneficiaryRequest() {
        return new AddGroupBeneficiaryRequest();
    }

    /**
     * Create an instance of {@link DeleteGroupBeneficiaryRequest }
     * 
     */
    public DeleteGroupBeneficiaryRequest createDeleteGroupBeneficiaryRequest() {
        return new DeleteGroupBeneficiaryRequest();
    }

    /**
     * Create an instance of {@link LookupGroupBeneficiaryRequest }
     * 
     */
    public LookupGroupBeneficiaryRequest createLookupGroupBeneficiaryRequest() {
        return new LookupGroupBeneficiaryRequest();
    }

    /**
     * Create an instance of {@link CustomerSelfRegistrationRequest }
     * 
     */
    public CustomerSelfRegistrationRequest createCustomerSelfRegistrationRequest() {
        return new CustomerSelfRegistrationRequest();
    }

    /**
     * Create an instance of {@link VerifyCustomerLoginRequest }
     * 
     */
    public VerifyCustomerLoginRequest createVerifyCustomerLoginRequest() {
        return new VerifyCustomerLoginRequest();
    }

    /**
     * Create an instance of {@link InitTransportKeyRequest }
     * 
     */
    public InitTransportKeyRequest createInitTransportKeyRequest() {
        return new InitTransportKeyRequest();
    }

    /**
     * Create an instance of {@link ChangeCustomerPasswordRequest }
     * 
     */
    public ChangeCustomerPasswordRequest createChangeCustomerPasswordRequest() {
        return new ChangeCustomerPasswordRequest();
    }

    /**
     * Create an instance of {@link RecipientLookUpRequest }
     * 
     */
    public RecipientLookUpRequest createRecipientLookUpRequest() {
        return new RecipientLookUpRequest();
    }

    /**
     * Create an instance of {@link RegistrationStatusLookUpRequest }
     * 
     */
    public RegistrationStatusLookUpRequest createRegistrationStatusLookUpRequest() {
        return new RegistrationStatusLookUpRequest();
    }

    /**
     * Create an instance of {@link ActiveFSIProductsRequest }
     * 
     */
    public ActiveFSIProductsRequest createActiveFSIProductsRequest() {
        return new ActiveFSIProductsRequest();
    }

    /**
     * Create an instance of {@link AcceptFSIAgreementRequest }
     * 
     */
    public AcceptFSIAgreementRequest createAcceptFSIAgreementRequest() {
        return new AcceptFSIAgreementRequest();
    }

    /**
     * Create an instance of {@link QueryFSIResultRequest }
     * 
     */
    public QueryFSIResultRequest createQueryFSIResultRequest() {
        return new QueryFSIResultRequest();
    }

    /**
     * Create an instance of {@link SMSVCSendRequest }
     * 
     */
    public SMSVCSendRequest createSMSVCSendRequest() {
        return new SMSVCSendRequest();
    }

    /**
     * Create an instance of {@link CustomerForgetPasswordRequest }
     * 
     */
    public CustomerForgetPasswordRequest createCustomerForgetPasswordRequest() {
        return new CustomerForgetPasswordRequest();
    }

    /**
     * Create an instance of {@link VerifyOperatorLoginRequest }
     * 
     */
    public VerifyOperatorLoginRequest createVerifyOperatorLoginRequest() {
        return new VerifyOperatorLoginRequest();
    }

    /**
     * Create an instance of {@link CCHIdentifyCustomerRequest }
     * 
     */
    public CCHIdentifyCustomerRequest createCCHIdentifyCustomerRequest() {
        return new CCHIdentifyCustomerRequest();
    }

    /**
     * Create an instance of {@link CCHReversalRequest }
     * 
     */
    public CCHReversalRequest createCCHReversalRequest() {
        return new CCHReversalRequest();
    }

    /**
     * Create an instance of {@link CCHSendCustomerStartKeyRequest }
     * 
     */
    public CCHSendCustomerStartKeyRequest createCCHSendCustomerStartKeyRequest() {
        return new CCHSendCustomerStartKeyRequest();
    }

    /**
     * Create an instance of {@link CCHUnlockCustomerPINRequest }
     * 
     */
    public CCHUnlockCustomerPINRequest createCCHUnlockCustomerPINRequest() {
        return new CCHUnlockCustomerPINRequest();
    }

    /**
     * Create an instance of {@link CCHCollectCustomerDoBRequest }
     * 
     */
    public CCHCollectCustomerDoBRequest createCCHCollectCustomerDoBRequest() {
        return new CCHCollectCustomerDoBRequest();
    }

    /**
     * Create an instance of {@link CCHIdentifyOperatorRequest }
     * 
     */
    public CCHIdentifyOperatorRequest createCCHIdentifyOperatorRequest() {
        return new CCHIdentifyOperatorRequest();
    }

    /**
     * Create an instance of {@link CCHSendOperatorStartKeyRequest }
     * 
     */
    public CCHSendOperatorStartKeyRequest createCCHSendOperatorStartKeyRequest() {
        return new CCHSendOperatorStartKeyRequest();
    }

    /**
     * Create an instance of {@link CCHUnlockOperatorPINRequest }
     * 
     */
    public CCHUnlockOperatorPINRequest createCCHUnlockOperatorPINRequest() {
        return new CCHUnlockOperatorPINRequest();
    }

    /**
     * Create an instance of {@link ChangeOperatorPasswordRequest }
     * 
     */
    public ChangeOperatorPasswordRequest createChangeOperatorPasswordRequest() {
        return new ChangeOperatorPasswordRequest();
    }

    /**
     * Create an instance of {@link QueryGroupBalanceRequest }
     * 
     */
    public QueryGroupBalanceRequest createQueryGroupBalanceRequest() {
        return new QueryGroupBalanceRequest();
    }

    /**
     * Create an instance of {@link QueryGroupAccountStatementsRequest }
     * 
     */
    public QueryGroupAccountStatementsRequest createQueryGroupAccountStatementsRequest() {
        return new QueryGroupAccountStatementsRequest();
    }

    /**
     * Create an instance of {@link QueryGroupTransactionsRequest }
     * 
     */
    public QueryGroupTransactionsRequest createQueryGroupTransactionsRequest() {
        return new QueryGroupTransactionsRequest();
    }

    /**
     * Create an instance of {@link QueryCustomerPointsRequest }
     * 
     */
    public QueryCustomerPointsRequest createQueryCustomerPointsRequest() {
        return new QueryCustomerPointsRequest();
    }

    /**
     * Create an instance of {@link QueryOrganizationPointsRequest }
     * 
     */
    public QueryOrganizationPointsRequest createQueryOrganizationPointsRequest() {
        return new QueryOrganizationPointsRequest();
    }

    /**
     * Create an instance of {@link QueryTransferPointsFeeRequest }
     * 
     */
    public QueryTransferPointsFeeRequest createQueryTransferPointsFeeRequest() {
        return new QueryTransferPointsFeeRequest();
    }

    /**
     * Create an instance of {@link QueryRedeemBalanceRateRequest }
     * 
     */
    public QueryRedeemBalanceRateRequest createQueryRedeemBalanceRateRequest() {
        return new QueryRedeemBalanceRateRequest();
    }

    /**
     * Create an instance of {@link TransferPointsRequest }
     * 
     */
    public TransferPointsRequest createTransferPointsRequest() {
        return new TransferPointsRequest();
    }

    /**
     * Create an instance of {@link RedeemPointsToGoodsRequest }
     * 
     */
    public RedeemPointsToGoodsRequest createRedeemPointsToGoodsRequest() {
        return new RedeemPointsToGoodsRequest();
    }

    /**
     * Create an instance of {@link RedeemPointsToBalanceRequest }
     * 
     */
    public RedeemPointsToBalanceRequest createRedeemPointsToBalanceRequest() {
        return new RedeemPointsToBalanceRequest();
    }

    /**
     * Create an instance of {@link RedeemPointsWithVoucherRequest }
     * 
     */
    public RedeemPointsWithVoucherRequest createRedeemPointsWithVoucherRequest() {
        return new RedeemPointsWithVoucherRequest();
    }

    /**
     * Create an instance of {@link CustomerAuthenticationRequest }
     * 
     */
    public CustomerAuthenticationRequest createCustomerAuthenticationRequest() {
        return new CustomerAuthenticationRequest();
    }

    /**
     * Create an instance of {@link CreateGroupRequest }
     * 
     */
    public CreateGroupRequest createCreateGroupRequest() {
        return new CreateGroupRequest();
    }

    /**
     * Create an instance of {@link CreateGroupByCustomerRequest }
     * 
     */
    public CreateGroupByCustomerRequest createCreateGroupByCustomerRequest() {
        return new CreateGroupByCustomerRequest();
    }

    /**
     * Create an instance of {@link UpdateGroupKYCRequest }
     * 
     */
    public UpdateGroupKYCRequest createUpdateGroupKYCRequest() {
        return new UpdateGroupKYCRequest();
    }

    /**
     * Create an instance of {@link ChangeGroupStatusRequest }
     * 
     */
    public ChangeGroupStatusRequest createChangeGroupStatusRequest() {
        return new ChangeGroupStatusRequest();
    }

    /**
     * Create an instance of {@link AddGroupMemberRequest }
     * 
     */
    public AddGroupMemberRequest createAddGroupMemberRequest() {
        return new AddGroupMemberRequest();
    }

    /**
     * Create an instance of {@link AddGroupMemberByGroupLeaderRequest }
     * 
     */
    public AddGroupMemberByGroupLeaderRequest createAddGroupMemberByGroupLeaderRequest() {
        return new AddGroupMemberByGroupLeaderRequest();
    }

    /**
     * Create an instance of {@link RemoveGroupMemberRequest }
     * 
     */
    public RemoveGroupMemberRequest createRemoveGroupMemberRequest() {
        return new RemoveGroupMemberRequest();
    }

    /**
     * Create an instance of {@link RemoveGroupMemberByGroupLeaderRequest }
     * 
     */
    public RemoveGroupMemberByGroupLeaderRequest createRemoveGroupMemberByGroupLeaderRequest() {
        return new RemoveGroupMemberByGroupLeaderRequest();
    }

    /**
     * Create an instance of {@link ChangeGroupMemberRolesRequest }
     * 
     */
    public ChangeGroupMemberRolesRequest createChangeGroupMemberRolesRequest() {
        return new ChangeGroupMemberRolesRequest();
    }

    /**
     * Create an instance of {@link ChangeGroupMemberRolesByGroupLeaderRequest }
     * 
     */
    public ChangeGroupMemberRolesByGroupLeaderRequest createChangeGroupMemberRolesByGroupLeaderRequest() {
        return new ChangeGroupMemberRolesByGroupLeaderRequest();
    }

    /**
     * Create an instance of {@link ConfirmGroupMembershipRequest }
     * 
     */
    public ConfirmGroupMembershipRequest createConfirmGroupMembershipRequest() {
        return new ConfirmGroupMembershipRequest();
    }

    /**
     * Create an instance of {@link ApproveGroupActionOrTransactionRequest }
     * 
     */
    public ApproveGroupActionOrTransactionRequest createApproveGroupActionOrTransactionRequest() {
        return new ApproveGroupActionOrTransactionRequest();
    }

    /**
     * Create an instance of {@link SearchMyGroupsRequest }
     * 
     */
    public SearchMyGroupsRequest createSearchMyGroupsRequest() {
        return new SearchMyGroupsRequest();
    }

    /**
     * Create an instance of {@link QueryGroupInfoRequest }
     * 
     */
    public QueryGroupInfoRequest createQueryGroupInfoRequest() {
        return new QueryGroupInfoRequest();
    }

    /**
     * Create an instance of {@link QueryGroupKYCRequest }
     * 
     */
    public QueryGroupKYCRequest createQueryGroupKYCRequest() {
        return new QueryGroupKYCRequest();
    }

    /**
     * Create an instance of {@link QueryGroupProductsRequest }
     * 
     */
    public QueryGroupProductsRequest createQueryGroupProductsRequest() {
        return new QueryGroupProductsRequest();
    }

    /**
     * Create an instance of {@link ListGroupMembersRequest }
     * 
     */
    public ListGroupMembersRequest createListGroupMembersRequest() {
        return new ListGroupMembersRequest();
    }

    /**
     * Create an instance of {@link ListGroupMembersByCustomerRequest }
     * 
     */
    public ListGroupMembersByCustomerRequest createListGroupMembersByCustomerRequest() {
        return new ListGroupMembersByCustomerRequest();
    }

    /**
     * Create an instance of {@link ChangeGroupRuleProfileRequest }
     * 
     */
    public ChangeGroupRuleProfileRequest createChangeGroupRuleProfileRequest() {
        return new ChangeGroupRuleProfileRequest();
    }

    /**
     * Create an instance of {@link ChangeGroupChargeProfileRequest }
     * 
     */
    public ChangeGroupChargeProfileRequest createChangeGroupChargeProfileRequest() {
        return new ChangeGroupChargeProfileRequest();
    }

    /**
     * Create an instance of {@link ChangeGroupAccountRuleProfileRequest }
     * 
     */
    public ChangeGroupAccountRuleProfileRequest createChangeGroupAccountRuleProfileRequest() {
        return new ChangeGroupAccountRuleProfileRequest();
    }

    /**
     * Create an instance of {@link IdentifyCustomerRequest }
     * 
     */
    public IdentifyCustomerRequest createIdentifyCustomerRequest() {
        return new IdentifyCustomerRequest();
    }

    /**
     * Create an instance of {@link CreateCustomerBundleRequest }
     * 
     */
    public CreateCustomerBundleRequest createCreateCustomerBundleRequest() {
        return new CreateCustomerBundleRequest();
    }

    /**
     * Create an instance of {@link CreateOrganizationBundleRequest }
     * 
     */
    public CreateOrganizationBundleRequest createCreateOrganizationBundleRequest() {
        return new CreateOrganizationBundleRequest();
    }

    /**
     * Create an instance of {@link CreateExternalProviderBundleRequest }
     * 
     */
    public CreateExternalProviderBundleRequest createCreateExternalProviderBundleRequest() {
        return new CreateExternalProviderBundleRequest();
    }

    /**
     * Create an instance of {@link CreateGroupBundleRequest }
     * 
     */
    public CreateGroupBundleRequest createCreateGroupBundleRequest() {
        return new CreateGroupBundleRequest();
    }

    /**
     * Create an instance of {@link QueryIdentityBundleRequest }
     * 
     */
    public QueryIdentityBundleRequest createQueryIdentityBundleRequest() {
        return new QueryIdentityBundleRequest();
    }

    /**
     * Create an instance of {@link RaiseDisputedTxnReversalRequest }
     * 
     */
    public RaiseDisputedTxnReversalRequest createRaiseDisputedTxnReversalRequest() {
        return new RaiseDisputedTxnReversalRequest();
    }

    /**
     * Create an instance of {@link CreateBankAccountRequest }
     * 
     */
    public CreateBankAccountRequest createCreateBankAccountRequest() {
        return new CreateBankAccountRequest();
    }

    /**
     * Create an instance of {@link DeleteBankAccountRequest }
     * 
     */
    public DeleteBankAccountRequest createDeleteBankAccountRequest() {
        return new DeleteBankAccountRequest();
    }

    /**
     * Create an instance of {@link SetDefaultBankAccountRequest }
     * 
     */
    public SetDefaultBankAccountRequest createSetDefaultBankAccountRequest() {
        return new SetDefaultBankAccountRequest();
    }

    /**
     * Create an instance of {@link CreateReminderScheduleRequest }
     * 
     */
    public CreateReminderScheduleRequest createCreateReminderScheduleRequest() {
        return new CreateReminderScheduleRequest();
    }

    /**
     * Create an instance of {@link QueryReminderScheduleRequest }
     * 
     */
    public QueryReminderScheduleRequest createQueryReminderScheduleRequest() {
        return new QueryReminderScheduleRequest();
    }

    /**
     * Create an instance of {@link DeleteIndividualReminderScheduleRequest }
     * 
     */
    public DeleteIndividualReminderScheduleRequest createDeleteIndividualReminderScheduleRequest() {
        return new DeleteIndividualReminderScheduleRequest();
    }

    /**
     * Create an instance of {@link CCHChangeCustKYCRequest }
     * 
     */
    public CCHChangeCustKYCRequest createCCHChangeCustKYCRequest() {
        return new CCHChangeCustKYCRequest();
    }

    /**
     * Create an instance of {@link CCHChangeOrgOperatorKYCRequest }
     * 
     */
    public CCHChangeOrgOperatorKYCRequest createCCHChangeOrgOperatorKYCRequest() {
        return new CCHChangeOrgOperatorKYCRequest();
    }

    /**
     * Create an instance of {@link CustomerRegisterCardRequest }
     * 
     */
    public CustomerRegisterCardRequest createCustomerRegisterCardRequest() {
        return new CustomerRegisterCardRequest();
    }

    /**
     * Create an instance of {@link OrgRegisterCardRequest }
     * 
     */
    public OrgRegisterCardRequest createOrgRegisterCardRequest() {
        return new OrgRegisterCardRequest();
    }

    /**
     * Create an instance of {@link GroupRegisterCardRequest }
     * 
     */
    public GroupRegisterCardRequest createGroupRegisterCardRequest() {
        return new GroupRegisterCardRequest();
    }

    /**
     * Create an instance of {@link RegisterCard4CustomerRequest }
     * 
     */
    public RegisterCard4CustomerRequest createRegisterCard4CustomerRequest() {
        return new RegisterCard4CustomerRequest();
    }

    /**
     * Create an instance of {@link RegisterCard4OrgRequest }
     * 
     */
    public RegisterCard4OrgRequest createRegisterCard4OrgRequest() {
        return new RegisterCard4OrgRequest();
    }

    /**
     * Create an instance of {@link RegisterCard4GroupRequest }
     * 
     */
    public RegisterCard4GroupRequest createRegisterCard4GroupRequest() {
        return new RegisterCard4GroupRequest();
    }

    /**
     * Create an instance of {@link CustomerActivateCardRequest }
     * 
     */
    public CustomerActivateCardRequest createCustomerActivateCardRequest() {
        return new CustomerActivateCardRequest();
    }

    /**
     * Create an instance of {@link OrgActivateCardRequest }
     * 
     */
    public OrgActivateCardRequest createOrgActivateCardRequest() {
        return new OrgActivateCardRequest();
    }

    /**
     * Create an instance of {@link GroupActivateCardRequest }
     * 
     */
    public GroupActivateCardRequest createGroupActivateCardRequest() {
        return new GroupActivateCardRequest();
    }

    /**
     * Create an instance of {@link CustomerCancelCardRequest }
     * 
     */
    public CustomerCancelCardRequest createCustomerCancelCardRequest() {
        return new CustomerCancelCardRequest();
    }

    /**
     * Create an instance of {@link OrgCancelCardRequest }
     * 
     */
    public OrgCancelCardRequest createOrgCancelCardRequest() {
        return new OrgCancelCardRequest();
    }

    /**
     * Create an instance of {@link GroupCancelCardRequest }
     * 
     */
    public GroupCancelCardRequest createGroupCancelCardRequest() {
        return new GroupCancelCardRequest();
    }

    /**
     * Create an instance of {@link PreValidationConfirmationRequest }
     * 
     */
    public PreValidationConfirmationRequest createPreValidationConfirmationRequest() {
        return new PreValidationConfirmationRequest();
    }

    /**
     * Create an instance of {@link CreateOrgLoyaltyAccountRequest }
     * 
     */
    public CreateOrgLoyaltyAccountRequest createCreateOrgLoyaltyAccountRequest() {
        return new CreateOrgLoyaltyAccountRequest();
    }

    /**
     * Create an instance of {@link CreateCustLoyaltyAccountRequest }
     * 
     */
    public CreateCustLoyaltyAccountRequest createCreateCustLoyaltyAccountRequest() {
        return new CreateCustLoyaltyAccountRequest();
    }

    /**
     * Create an instance of {@link CreateGroupLoyaltyAccountRequest }
     * 
     */
    public CreateGroupLoyaltyAccountRequest createCreateGroupLoyaltyAccountRequest() {
        return new CreateGroupLoyaltyAccountRequest();
    }

    /**
     * Create an instance of {@link QueryCustLoyaltyPointRequest }
     * 
     */
    public QueryCustLoyaltyPointRequest createQueryCustLoyaltyPointRequest() {
        return new QueryCustLoyaltyPointRequest();
    }

    /**
     * Create an instance of {@link QueryOrgLoyaltyPointRequest }
     * 
     */
    public QueryOrgLoyaltyPointRequest createQueryOrgLoyaltyPointRequest() {
        return new QueryOrgLoyaltyPointRequest();
    }

    /**
     * Create an instance of {@link QueryGroupLoyaltyPointRequest }
     * 
     */
    public QueryGroupLoyaltyPointRequest createQueryGroupLoyaltyPointRequest() {
        return new QueryGroupLoyaltyPointRequest();
    }

    /**
     * Create an instance of {@link QueryLoyaltyConsumerRequest }
     * 
     */
    public QueryLoyaltyConsumerRequest createQueryLoyaltyConsumerRequest() {
        return new QueryLoyaltyConsumerRequest();
    }

    /**
     * Create an instance of {@link QueryCustLoyaltyPointStatementRequest }
     * 
     */
    public QueryCustLoyaltyPointStatementRequest createQueryCustLoyaltyPointStatementRequest() {
        return new QueryCustLoyaltyPointStatementRequest();
    }

    /**
     * Create an instance of {@link QueryOrgLoyaltyPointStatementRequest }
     * 
     */
    public QueryOrgLoyaltyPointStatementRequest createQueryOrgLoyaltyPointStatementRequest() {
        return new QueryOrgLoyaltyPointStatementRequest();
    }

    /**
     * Create an instance of {@link QueryGroupLoyaltyPointStatementRequest }
     * 
     */
    public QueryGroupLoyaltyPointStatementRequest createQueryGroupLoyaltyPointStatementRequest() {
        return new QueryGroupLoyaltyPointStatementRequest();
    }

    /**
     * Create an instance of {@link QueryLoyaltyConsumerStatementRequest }
     * 
     */
    public QueryLoyaltyConsumerStatementRequest createQueryLoyaltyConsumerStatementRequest() {
        return new QueryLoyaltyConsumerStatementRequest();
    }

    /**
     * Create an instance of {@link UpdateOrgOperatorOwnKYCRequest }
     * 
     */
    public UpdateOrgOperatorOwnKYCRequest createUpdateOrgOperatorOwnKYCRequest() {
        return new UpdateOrgOperatorOwnKYCRequest();
    }

    /**
     * Create an instance of {@link QuerySavingPlanForCustomerRequest }
     * 
     */
    public QuerySavingPlanForCustomerRequest createQuerySavingPlanForCustomerRequest() {
        return new QuerySavingPlanForCustomerRequest();
    }

    /**
     * Create an instance of {@link QuerySavingPlanForGroupRequest }
     * 
     */
    public QuerySavingPlanForGroupRequest createQuerySavingPlanForGroupRequest() {
        return new QuerySavingPlanForGroupRequest();
    }

    /**
     * Create an instance of {@link QuerySavingPlanForOrganizationRequest }
     * 
     */
    public QuerySavingPlanForOrganizationRequest createQuerySavingPlanForOrganizationRequest() {
        return new QuerySavingPlanForOrganizationRequest();
    }

    /**
     * Create an instance of {@link SubscribeSavingPlanForCustomerRequest }
     * 
     */
    public SubscribeSavingPlanForCustomerRequest createSubscribeSavingPlanForCustomerRequest() {
        return new SubscribeSavingPlanForCustomerRequest();
    }

    /**
     * Create an instance of {@link SubscribeSavingPlanForGroupRequest }
     * 
     */
    public SubscribeSavingPlanForGroupRequest createSubscribeSavingPlanForGroupRequest() {
        return new SubscribeSavingPlanForGroupRequest();
    }

    /**
     * Create an instance of {@link SubscribeSavingPlanForOrgRequest }
     * 
     */
    public SubscribeSavingPlanForOrgRequest createSubscribeSavingPlanForOrgRequest() {
        return new SubscribeSavingPlanForOrgRequest();
    }

    /**
     * Create an instance of {@link UnSubscribeSavingPlanForCustomerRequest }
     * 
     */
    public UnSubscribeSavingPlanForCustomerRequest createUnSubscribeSavingPlanForCustomerRequest() {
        return new UnSubscribeSavingPlanForCustomerRequest();
    }

    /**
     * Create an instance of {@link UnSubscribeSavingPlanForGroupRequest }
     * 
     */
    public UnSubscribeSavingPlanForGroupRequest createUnSubscribeSavingPlanForGroupRequest() {
        return new UnSubscribeSavingPlanForGroupRequest();
    }

    /**
     * Create an instance of {@link UnSubscribeSavingPlanForOrgRequest }
     * 
     */
    public UnSubscribeSavingPlanForOrgRequest createUnSubscribeSavingPlanForOrgRequest() {
        return new UnSubscribeSavingPlanForOrgRequest();
    }

    /**
     * Create an instance of {@link ValidateTokenRequest }
     * 
     */
    public ValidateTokenRequest createValidateTokenRequest() {
        return new ValidateTokenRequest();
    }

    /**
     * Create an instance of {@link ChangeOrgOperatorMSISDNRequest }
     * 
     */
    public ChangeOrgOperatorMSISDNRequest createChangeOrgOperatorMSISDNRequest() {
        return new ChangeOrgOperatorMSISDNRequest();
    }

    /**
     * Create an instance of {@link Request.Body.Verification }
     * 
     */
    public Request.Body.Verification createRequestBodyVerification() {
        return new Request.Body.Verification();
    }

    /**
     * Create an instance of {@link Request.Body.ReferenceData }
     * 
     */
    public Request.Body.ReferenceData createRequestBodyReferenceData() {
        return new Request.Body.ReferenceData();
    }

    /**
     * Create an instance of {@link Request.Body.TransactionRequest.Parameters }
     * 
     */
    public Request.Body.TransactionRequest.Parameters createRequestBodyTransactionRequestParameters() {
        return new Request.Body.TransactionRequest.Parameters();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.Requester }
     * 
     */
    public Request.Body.Identity.Requester createRequestBodyIdentityRequester() {
        return new Request.Body.Identity.Requester();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.SimpleKYC }
     * 
     */
    public Request.Body.Identity.ReceiverParty.ReceiverKYC.SimpleKYC createRequestBodyIdentityReceiverPartyReceiverKYCSimpleKYC() {
        return new Request.Body.Identity.ReceiverParty.ReceiverKYC.SimpleKYC();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.IDDetails }
     * 
     */
    public Request.Body.Identity.ReceiverParty.ReceiverKYC.IDDetails createRequestBodyIdentityReceiverPartyReceiverKYCIDDetails() {
        return new Request.Body.Identity.ReceiverParty.ReceiverKYC.IDDetails();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.ContactDetails }
     * 
     */
    public Request.Body.Identity.ReceiverParty.ReceiverKYC.ContactDetails createRequestBodyIdentityReceiverPartyReceiverKYCContactDetails() {
        return new Request.Body.Identity.ReceiverParty.ReceiverKYC.ContactDetails();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.CertificateDetails }
     * 
     */
    public Request.Body.Identity.ReceiverParty.ReceiverKYC.CertificateDetails createRequestBodyIdentityReceiverPartyReceiverKYCCertificateDetails() {
        return new Request.Body.Identity.ReceiverParty.ReceiverKYC.CertificateDetails();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.SimpleKYC }
     * 
     */
    public Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.SimpleKYC createRequestBodyIdentityPrimaryPartyPrimaryPartyKYCSimpleKYC() {
        return new Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.SimpleKYC();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.IDDetails }
     * 
     */
    public Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.IDDetails createRequestBodyIdentityPrimaryPartyPrimaryPartyKYCIDDetails() {
        return new Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.IDDetails();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.ContactDetails }
     * 
     */
    public Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.ContactDetails createRequestBodyIdentityPrimaryPartyPrimaryPartyKYCContactDetails() {
        return new Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.ContactDetails();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.CertificateDetails }
     * 
     */
    public Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.CertificateDetails createRequestBodyIdentityPrimaryPartyPrimaryPartyKYCCertificateDetails() {
        return new Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.CertificateDetails();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.Initiator.InitiatorKYC.SimpleKYC }
     * 
     */
    public Request.Body.Identity.Initiator.InitiatorKYC.SimpleKYC createRequestBodyIdentityInitiatorInitiatorKYCSimpleKYC() {
        return new Request.Body.Identity.Initiator.InitiatorKYC.SimpleKYC();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.Initiator.InitiatorKYC.IDDetails }
     * 
     */
    public Request.Body.Identity.Initiator.InitiatorKYC.IDDetails createRequestBodyIdentityInitiatorInitiatorKYCIDDetails() {
        return new Request.Body.Identity.Initiator.InitiatorKYC.IDDetails();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.Initiator.InitiatorKYC.ContactDetails }
     * 
     */
    public Request.Body.Identity.Initiator.InitiatorKYC.ContactDetails createRequestBodyIdentityInitiatorInitiatorKYCContactDetails() {
        return new Request.Body.Identity.Initiator.InitiatorKYC.ContactDetails();
    }

    /**
     * Create an instance of {@link Request.Body.Identity.Initiator.InitiatorKYC.CertificateDetails }
     * 
     */
    public Request.Body.Identity.Initiator.InitiatorKYC.CertificateDetails createRequestBodyIdentityInitiatorInitiatorKYCCertificateDetails() {
        return new Request.Body.Identity.Initiator.InitiatorKYC.CertificateDetails();
    }

    /**
     * Create an instance of {@link Request.Header.Caller }
     * 
     */
    public Request.Header.Caller createRequestHeaderCaller() {
        return new Request.Header.Caller();
    }

    /**
     * Create an instance of {@link Request.Header.AccessDevice }
     * 
     */
    public Request.Header.AccessDevice createRequestHeaderAccessDevice() {
        return new Request.Header.AccessDevice();
    }

    /**
     * Create an instance of {@link Request.Header.HeaderExtension }
     * 
     */
    public Request.Header.HeaderExtension createRequestHeaderHeaderExtension() {
        return new Request.Header.HeaderExtension();
    }

    /**
     * Create an instance of {@link PreValidationRequest.RequestContext }
     * 
     */
    public PreValidationRequest.RequestContext createPreValidationRequestRequestContext() {
        return new PreValidationRequest.RequestContext();
    }

    /**
     * Create an instance of {@link PreValidationRequest.AdditionalData }
     * 
     */
    public PreValidationRequest.AdditionalData createPreValidationRequestAdditionalData() {
        return new PreValidationRequest.AdditionalData();
    }

    /**
     * Create an instance of {@link UnlinkIdentitiesRequest.Identity }
     * 
     */
    public UnlinkIdentitiesRequest.Identity createUnlinkIdentitiesRequestIdentity() {
        return new UnlinkIdentitiesRequest.Identity();
    }

    /**
     * Create an instance of {@link LinkingIdentitiesRequest.Identity }
     * 
     */
    public LinkingIdentitiesRequest.Identity createLinkingIdentitiesRequestIdentity() {
        return new LinkingIdentitiesRequest.Identity();
    }

    /**
     * Create an instance of {@link AdjustOrganizationPointsRequest.PointList.Point }
     * 
     */
    public AdjustOrganizationPointsRequest.PointList.Point createAdjustOrganizationPointsRequestPointListPoint() {
        return new AdjustOrganizationPointsRequest.PointList.Point();
    }

    /**
     * Create an instance of {@link AdjustCustomerPointsRequest.PointList.Point }
     * 
     */
    public AdjustCustomerPointsRequest.PointList.Point createAdjustCustomerPointsRequestPointListPoint() {
        return new AdjustCustomerPointsRequest.PointList.Point();
    }

    /**
     * Create an instance of {@link QueryOrganizationPointsLogRequest.ByPage }
     * 
     */
    public QueryOrganizationPointsLogRequest.ByPage createQueryOrganizationPointsLogRequestByPage() {
        return new QueryOrganizationPointsLogRequest.ByPage();
    }

    /**
     * Create an instance of {@link QueryCustomerPointsLogRequest.ByPage }
     * 
     */
    public QueryCustomerPointsLogRequest.ByPage createQueryCustomerPointsLogRequestByPage() {
        return new QueryCustomerPointsLogRequest.ByPage();
    }

    /**
     * Create an instance of {@link CustomerGetStartPINRequest.KYCDataVerification }
     * 
     */
    public CustomerGetStartPINRequest.KYCDataVerification createCustomerGetStartPINRequestKYCDataVerification() {
        return new CustomerGetStartPINRequest.KYCDataVerification();
    }

    /**
     * Create an instance of {@link BulkTaskRequest.Parameters }
     * 
     */
    public BulkTaskRequest.Parameters createBulkTaskRequestParameters() {
        return new BulkTaskRequest.Parameters();
    }

    /**
     * Create an instance of {@link CustomerCertificationRequest.PersonalDetails }
     * 
     */
    public CustomerCertificationRequest.PersonalDetails createCustomerCertificationRequestPersonalDetails() {
        return new CustomerCertificationRequest.PersonalDetails();
    }

    /**
     * Create an instance of {@link CustomerCertificationRequest.IDDetails }
     * 
     */
    public CustomerCertificationRequest.IDDetails createCustomerCertificationRequestIDDetails() {
        return new CustomerCertificationRequest.IDDetails();
    }

    /**
     * Create an instance of {@link CustomerCertificationRequest.ContactDetails }
     * 
     */
    public CustomerCertificationRequest.ContactDetails createCustomerCertificationRequestContactDetails() {
        return new CustomerCertificationRequest.ContactDetails();
    }

    /**
     * Create an instance of {@link CustomerSelfRegistration4PINRequest.SIMDeviceData }
     * 
     */
    public CustomerSelfRegistration4PINRequest.SIMDeviceData createCustomerSelfRegistration4PINRequestSIMDeviceData() {
        return new CustomerSelfRegistration4PINRequest.SIMDeviceData();
    }

    /**
     * Create an instance of {@link VerifyCCCallerRequest.SecurityQuestionAnswers }
     * 
     */
    public VerifyCCCallerRequest.SecurityQuestionAnswers createVerifyCCCallerRequestSecurityQuestionAnswers() {
        return new VerifyCCCallerRequest.SecurityQuestionAnswers();
    }

    /**
     * Create an instance of {@link AddO2CLinkRequest.O2CLinkAddData }
     * 
     */
    public AddO2CLinkRequest.O2CLinkAddData createAddO2CLinkRequestO2CLinkAddData() {
        return new AddO2CLinkRequest.O2CLinkAddData();
    }

    /**
     * Create an instance of {@link RegisterCustomerRequest.SIMDeviceData }
     * 
     */
    public RegisterCustomerRequest.SIMDeviceData createRegisterCustomerRequestSIMDeviceData() {
        return new RegisterCustomerRequest.SIMDeviceData();
    }

    /**
     * Create an instance of {@link UpdateTillProductsRequest.ProductUpdateData.AddProduct }
     * 
     */
    public UpdateTillProductsRequest.ProductUpdateData.AddProduct createUpdateTillProductsRequestProductUpdateDataAddProduct() {
        return new UpdateTillProductsRequest.ProductUpdateData.AddProduct();
    }

    /**
     * Create an instance of {@link UpdateTillProductsRequest.ProductUpdateData.RemoveProduct }
     * 
     */
    public UpdateTillProductsRequest.ProductUpdateData.RemoveProduct createUpdateTillProductsRequestProductUpdateDataRemoveProduct() {
        return new UpdateTillProductsRequest.ProductUpdateData.RemoveProduct();
    }

    /**
     * Create an instance of {@link QuestionAnswerType.AccountBalance }
     * 
     */
    public QuestionAnswerType.AccountBalance createQuestionAnswerTypeAccountBalance() {
        return new QuestionAnswerType.AccountBalance();
    }

    /**
     * Create an instance of {@link QuestionAnswerType.TransactionAmount }
     * 
     */
    public QuestionAnswerType.TransactionAmount createQuestionAnswerTypeTransactionAmount() {
        return new QuestionAnswerType.TransactionAmount();
    }

    /**
     * Create an instance of {@link QuestionAnswerType.TransactionCreditParty.CreditParty }
     * 
     */
    public QuestionAnswerType.TransactionCreditParty.CreditParty createQuestionAnswerTypeTransactionCreditPartyCreditParty() {
        return new QuestionAnswerType.TransactionCreditParty.CreditParty();
    }

    /**
     * Create an instance of {@link O2CLinkDeleteDataType.O2CLinkItem }
     * 
     */
    public O2CLinkDeleteDataType.O2CLinkItem createO2CLinkDeleteDataTypeO2CLinkItem() {
        return new O2CLinkDeleteDataType.O2CLinkItem();
    }

    /**
     * Create an instance of {@link TaxExemptionDataType.TaxCodeItem }
     * 
     */
    public TaxExemptionDataType.TaxCodeItem createTaxExemptionDataTypeTaxCodeItem() {
        return new TaxExemptionDataType.TaxCodeItem();
    }

    /**
     * Create an instance of {@link RoleUpdateDataType.RoleItem }
     * 
     */
    public RoleUpdateDataType.RoleItem createRoleUpdateDataTypeRoleItem() {
        return new RoleUpdateDataType.RoleItem();
    }

    /**
     * Create an instance of {@link ProductUpdateDataType.AddProduct }
     * 
     */
    public ProductUpdateDataType.AddProduct createProductUpdateDataTypeAddProduct() {
        return new ProductUpdateDataType.AddProduct();
    }

    /**
     * Create an instance of {@link ProductUpdateDataType.ModifyProduct }
     * 
     */
    public ProductUpdateDataType.ModifyProduct createProductUpdateDataTypeModifyProduct() {
        return new ProductUpdateDataType.ModifyProduct();
    }

    /**
     * Create an instance of {@link ContactRecordConditionType.Record }
     * 
     */
    public ContactRecordConditionType.Record createContactRecordConditionTypeRecord() {
        return new ContactRecordConditionType.Record();
    }

}
