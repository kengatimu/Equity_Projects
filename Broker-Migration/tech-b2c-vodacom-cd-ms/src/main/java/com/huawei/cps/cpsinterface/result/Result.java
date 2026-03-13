
package com.huawei.cps.cpsinterface.result;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.ParameterType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Transaction或BO的结果消息
 * 
 * <p>Java class for Result complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="Result"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Header"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="Version" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                   &lt;element name="OriginatorConversationID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *                   &lt;element name="ConversationID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                   &lt;element name="HeaderExtension" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="Extension" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="Body"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="ResultType" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *                   &lt;element name="ResultCode"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="10"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="ResultDesc" minOccurs="0"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="1024"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="ResultParameters" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="ParameterItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="TaskID" minOccurs="0"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="64"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="WorkflowID" minOccurs="0"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="64"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;choice minOccurs="0"&gt;
 *                     &lt;element name="EncryptedParameters" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/&gt;
 *                     &lt;choice&gt;
 *                       &lt;element name="TransactionResult"&gt;
 *                         &lt;complexType&gt;
 *                           &lt;complexContent&gt;
 *                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                               &lt;sequence&gt;
 *                                 &lt;element name="TransactionID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                                 &lt;element name="TransactionStatus" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *                                 &lt;element name="ResultParameters" minOccurs="0"&gt;
 *                                   &lt;complexType&gt;
 *                                     &lt;complexContent&gt;
 *                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                         &lt;sequence&gt;
 *                                           &lt;element name="ResultParameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
 *                                         &lt;/sequence&gt;
 *                                       &lt;/restriction&gt;
 *                                     &lt;/complexContent&gt;
 *                                   &lt;/complexType&gt;
 *                                 &lt;/element&gt;
 *                               &lt;/sequence&gt;
 *                             &lt;/restriction&gt;
 *                           &lt;/complexContent&gt;
 *                         &lt;/complexType&gt;
 *                       &lt;/element&gt;
 *                       &lt;element name="ChangeCustomerMSISDNResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerMSISDNResult"/&gt;
 *                       &lt;element name="ChangeTillMSISDNResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeTillMSISDNResult"/&gt;
 *                       &lt;element name="ChangeAccountStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeAccountStatusResult"/&gt;
 *                       &lt;element name="UpdateCustomerKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateCustomerKYCResult"/&gt;
 *                       &lt;element name="UpdateOrganizationKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrganizationKYCResult"/&gt;
 *                       &lt;element name="QueryCustomerKYCResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerKYCResult"/&gt;
 *                       &lt;element name="QueryCustomerInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerInfoResult"/&gt;
 *                       &lt;element name="QueryCustomerProductsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerProductsResult"/&gt;
 *                       &lt;element name="QueryCustomerBalanceResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerBalanceResult"/&gt;
 *                       &lt;element name="QueryOrganizationKYCResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationKYCResult"/&gt;
 *                       &lt;element name="QueryOrganizationInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationInfoResult"/&gt;
 *                       &lt;element name="QueryOrganizationProductsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationProductsResult"/&gt;
 *                       &lt;element name="QueryOrganizationBalanceResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationBalanceResult"/&gt;
 *                       &lt;element name="ListOrganizationTillsResult" type="{http://cps.huawei.com/cpsinterface/result}ListOrganizationTillsResult"/&gt;
 *                       &lt;element name="QueryOrgOperatorKYCResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrgOperatorKYCResult"/&gt;
 *                       &lt;element name="QueryOrgOperatorInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrgOperatorInfoResult"/&gt;
 *                       &lt;element name="QueryTillInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryTillInfoResult"/&gt;
 *                       &lt;element name="QueryTillProductsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryTillProductsResult"/&gt;
 *                       &lt;element name="ChangeCustomerStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerStatusResult"/&gt;
 *                       &lt;element name="ChangeOrganizationStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrganizationStatusResult"/&gt;
 *                       &lt;element name="ChangeTillStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeTillStatusResult"/&gt;
 *                       &lt;element name="ChangeSPOperatorStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeSPOperatorStatusResult"/&gt;
 *                       &lt;element name="ChangeOrgOperatorStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgOperatorStatusResult"/&gt;
 *                       &lt;element name="UpdateSPOperatorKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateSPOperatorKYCResult"/&gt;
 *                       &lt;element name="UpdateOrgOperatorKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrgOperatorKYCResult"/&gt;
 *                       &lt;element name="UpdateCustomerProductsResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateCustomerProductsResult"/&gt;
 *                       &lt;element name="UpdateOrganizationProductsResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrganizationProductsResult"/&gt;
 *                       &lt;element name="UpdateTillProductsResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateTillProductsResult"/&gt;
 *                       &lt;element name="RegisterCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}RegisterCustomerResult"/&gt;
 *                       &lt;element name="RecycleMSISDNResult" type="{http://cps.huawei.com/cpsinterface/result}RecycleMSISDNResult"/&gt;
 *                       &lt;element name="ListOrganizationChildStoresResult" type="{http://cps.huawei.com/cpsinterface/result}ListOrganizationChildStoresResult"/&gt;
 *                       &lt;element name="ListOrganizationOperatorsResult" type="{http://cps.huawei.com/cpsinterface/result}ListOrganizationOperatorsResult"/&gt;
 *                       &lt;element name="UpdateSPOperatorRoleResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateSPOperatorRoleResult"/&gt;
 *                       &lt;element name="UpdateOrgOperatorRoleResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrgOperatorRoleResult"/&gt;
 *                       &lt;element name="UpdateOrgTaxExemptionResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrgTaxExemptionResult"/&gt;
 *                       &lt;element name="QueryO2CLinkResult" type="{http://cps.huawei.com/cpsinterface/result}QueryO2CLinkResult"/&gt;
 *                       &lt;element name="AddO2CLinkResult" type="{http://cps.huawei.com/cpsinterface/result}AddO2CLinkResult"/&gt;
 *                       &lt;element name="DeleteO2CLinkResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteO2CLinkResult"/&gt;
 *                       &lt;element name="VerifyCCCallerResult" type="{http://cps.huawei.com/cpsinterface/result}VerifyCCCallerResult"/&gt;
 *                       &lt;element name="UnlockCustomerPINResult" type="{http://cps.huawei.com/cpsinterface/result}UnlockCustomerPINResult"/&gt;
 *                       &lt;element name="UnlockOrgOperatorPINResult" type="{http://cps.huawei.com/cpsinterface/result}UnlockOrgOperatorPINResult"/&gt;
 *                       &lt;element name="UnlockOrgOperatorPasswordResult" type="{http://cps.huawei.com/cpsinterface/result}UnlockOrgOperatorPasswordResult"/&gt;
 *                       &lt;element name="ResetCustomerPINResult" type="{http://cps.huawei.com/cpsinterface/result}ResetCustomerPINResult"/&gt;
 *                       &lt;element name="ResetOrgOperatorPINResult" type="{http://cps.huawei.com/cpsinterface/result}ResetOrgOperatorPINResult"/&gt;
 *                       &lt;element name="ResetOrgOperatorPasswordResult" type="{http://cps.huawei.com/cpsinterface/result}ResetOrgOperatorPasswordResult"/&gt;
 *                       &lt;element name="ResetCustomerSecretWordResult" type="{http://cps.huawei.com/cpsinterface/result}ResetCustomerSecretWordResult"/&gt;
 *                       &lt;element name="ReleaseCustomerCCSuspendStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ReleaseCustomerCCSuspendStatusResult"/&gt;
 *                       &lt;element name="ReleaseOrgOperatorCCSuspendStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ReleaseOrgOperatorCCSuspendStatusResult"/&gt;
 *                       &lt;element name="SearchTransactionResult" type="{http://cps.huawei.com/cpsinterface/result}SearchTransactionResult"/&gt;
 *                       &lt;element name="ReverseTransactionResult" type="{http://cps.huawei.com/cpsinterface/result}ReverseTransactionResult"/&gt;
 *                       &lt;element name="ConfirmTransactionResult" type="{http://cps.huawei.com/cpsinterface/result}ConfirmTransactionResult"/&gt;
 *                       &lt;element name="QueryCustomerAccountStatementsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerAccountStatementsResult"/&gt;
 *                       &lt;element name="QueryCustomerTransactionsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerTransactionsResult"/&gt;
 *                       &lt;element name="QueryOrganizationAccountStatementsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationAccountStatementsResult"/&gt;
 *                       &lt;element name="QueryOrganizationTransactionsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationTransactionsResult"/&gt;
 *                       &lt;element name="QueryResultMessageResult" type="{http://cps.huawei.com/cpsinterface/result}QueryResultMessageResult"/&gt;
 *                       &lt;element name="UpdateTransactionStatusResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateTransactionStatusResult"/&gt;
 *                       &lt;element name="ChangeCustomerPINResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerPINResult"/&gt;
 *                       &lt;element name="ChangeOrgOperatorPINResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgOperatorPINResult"/&gt;
 *                       &lt;element name="ChangeCustomerSecretWordResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerSecretWordResult"/&gt;
 *                       &lt;element name="ChangeOrgOperatorSecretWordResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgOperatorSecretWordResult"/&gt;
 *                       &lt;element name="ChangeCustomerLanguageResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerLanguageResult"/&gt;
 *                       &lt;element name="ChangeOrgOperatorLanguageResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgOperatorLanguageResult"/&gt;
 *                       &lt;element name="ChangeSPOperatorLanguageResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeSPOperatorLanguageResult"/&gt;
 *                       &lt;element name="ChangeOrgnNameResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgnNameResult"/&gt;
 *                       &lt;element name="ActivateCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}ActivateCustomerResult"/&gt;
 *                       &lt;element name="ActivateTillResult" type="{http://cps.huawei.com/cpsinterface/result}ActivateTillResult"/&gt;
 *                       &lt;element name="AddCustomerBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}AddCustomerBeneficiaryResult"/&gt;
 *                       &lt;element name="AddOrgBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}AddOrgBeneficiaryResult"/&gt;
 *                       &lt;element name="DeleteCustomerBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteCustomerBeneficiaryResult"/&gt;
 *                       &lt;element name="DeleteOrgBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteOrgBeneficiaryResult"/&gt;
 *                       &lt;element name="LookupCustomerBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}LookupCustomerBeneficiaryResult"/&gt;
 *                       &lt;element name="LookupOrgBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}LookupOrgBeneficiaryResult"/&gt;
 *                       &lt;element name="AddGroupBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}AddGroupBeneficiaryResult"/&gt;
 *                       &lt;element name="DeleteGroupBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteGroupBeneficiaryResult"/&gt;
 *                       &lt;element name="LookupGroupBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}LookupGroupBeneficiaryResult"/&gt;
 *                       &lt;element name="CreateTopOrgResult" type="{http://cps.huawei.com/cpsinterface/result}CreateTopOrgResult"/&gt;
 *                       &lt;element name="CreateChildOrgResult" type="{http://cps.huawei.com/cpsinterface/result}CreateChildOrgResult"/&gt;
 *                       &lt;element name="CreateTillResult" type="{http://cps.huawei.com/cpsinterface/result}CreateTillResult"/&gt;
 *                       &lt;element name="ChangeTillLanguageResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeTillLanguageResult"/&gt;
 *                       &lt;element name="CreateOrgOperatorResult" type="{http://cps.huawei.com/cpsinterface/result}CreateOrgOperatorResult"/&gt;
 *                       &lt;element name="RecipientLookUpResult" type="{http://cps.huawei.com/cpsinterface/result}RecipientLookUpResult"/&gt;
 *                       &lt;element name="BulkTaskResult" type="{http://cps.huawei.com/cpsinterface/result}BulkTaskResult"/&gt;
 *                       &lt;element name="ChangeTillDefaultOperatorIDResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeTillDefaultOperatorIDResult"/&gt;
 *                       &lt;element name="CustomerGetStartPINResult" type="{http://cps.huawei.com/cpsinterface/result}CustomerGetStartPINResult"/&gt;
 *                       &lt;element name="QueryGroupBalanceResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupBalanceResult"/&gt;
 *                       &lt;element name="QueryGroupAccountStatementsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupAccountStatementsResult"/&gt;
 *                       &lt;element name="QueryGroupTransactionsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupTransactionsResult"/&gt;
 *                       &lt;element name="QueryCustomerPointsLogResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerPointsLogResult"/&gt;
 *                       &lt;element name="QueryCustomerPointsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerPointsResult"/&gt;
 *                       &lt;element name="AdjustCustomerPointsResult" type="{http://cps.huawei.com/cpsinterface/result}AdjustCustomerPointsResult"/&gt;
 *                       &lt;element name="QueryOrganizationPointsLogResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationPointsLogResult"/&gt;
 *                       &lt;element name="QueryOrganizationPointsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationPointsResult"/&gt;
 *                       &lt;element name="AdjustOrganizationPointsResult" type="{http://cps.huawei.com/cpsinterface/result}AdjustOrganizationPointsResult"/&gt;
 *                       &lt;element name="CreateGroupResult" type="{http://cps.huawei.com/cpsinterface/result}CreateGroupResult"/&gt;
 *                       &lt;element name="CreateGroupByCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}CreateGroupByCustomerResult"/&gt;
 *                       &lt;element name="UpdateGroupKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateGroupKYCResult"/&gt;
 *                       &lt;element name="ChangeGroupStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupStatusResult"/&gt;
 *                       &lt;element name="AddGroupMemberResult" type="{http://cps.huawei.com/cpsinterface/result}AddGroupMemberResult"/&gt;
 *                       &lt;element name="AddGroupMemberByGroupLeaderResult" type="{http://cps.huawei.com/cpsinterface/result}AddGroupMemberByGroupLeaderResult"/&gt;
 *                       &lt;element name="RemoveGroupMemberResult" type="{http://cps.huawei.com/cpsinterface/result}RemoveGroupMemberResult"/&gt;
 *                       &lt;element name="RemoveGroupMemberByGroupLeaderResult" type="{http://cps.huawei.com/cpsinterface/result}RemoveGroupMemberByGroupLeaderResult"/&gt;
 *                       &lt;element name="ChangeGroupMemberRolesResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupMemberRolesResult"/&gt;
 *                       &lt;element name="ChangeGroupMemberRolesByGroupLeaderResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupMemberRolesByGroupLeaderResult"/&gt;
 *                       &lt;element name="ConfirmGroupMembershipResult" type="{http://cps.huawei.com/cpsinterface/result}ConfirmGroupMembershipResult"/&gt;
 *                       &lt;element name="ApproveGroupActionOrTransactionResult" type="{http://cps.huawei.com/cpsinterface/result}ApproveGroupActionOrTransactionResult"/&gt;
 *                       &lt;element name="SearchMyGroupsResult" type="{http://cps.huawei.com/cpsinterface/result}SearchMyGroupsResult"/&gt;
 *                       &lt;element name="QueryGroupInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupInfoResult"/&gt;
 *                       &lt;element name="QueryGroupKYCResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupKYCResult"/&gt;
 *                       &lt;element name="QueryGroupProductsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupProductsResult"/&gt;
 *                       &lt;element name="ListGroupMembersResult" type="{http://cps.huawei.com/cpsinterface/result}ListGroupMembersResult"/&gt;
 *                       &lt;element name="ListGroupMembersByCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}ListGroupMembersByCustomerResult"/&gt;
 *                       &lt;element name="ChangeGroupRuleProfileResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupRuleProfileResult"/&gt;
 *                       &lt;element name="ChangeGroupChargeProfileResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupChargeProfileResult"/&gt;
 *                       &lt;element name="ChangeGroupAccountRuleProfileResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupAccountRuleProfileResult"/&gt;
 *                       &lt;element name="IdentifyCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}IdentifyCustomerResult"/&gt;
 *                       &lt;element name="RaiseDisputedTxnReversalResult" type="{http://cps.huawei.com/cpsinterface/result}RaiseDisputedTxnReversalResult"/&gt;
 *                       &lt;element name="CancelIssuedVoucherResult" type="{http://cps.huawei.com/cpsinterface/result}CancelIssuedVoucherResult"/&gt;
 *                       &lt;element name="CreateCustomerBundleResult" type="{http://cps.huawei.com/cpsinterface/result}CreateCustomerBundleResult"/&gt;
 *                       &lt;element name="CreateOrganizationBundleResult" type="{http://cps.huawei.com/cpsinterface/result}CreateOrganizationBundleResult"/&gt;
 *                       &lt;element name="CreateExternalProviderResult" type="{http://cps.huawei.com/cpsinterface/result}CreateExternalProviderResult"/&gt;
 *                       &lt;element name="CreateGroupBundleResult" type="{http://cps.huawei.com/cpsinterface/result}CreateGroupBundleResult"/&gt;
 *                       &lt;element name="CreateBankAccountResult" type="{http://cps.huawei.com/cpsinterface/result}CreateBankAccountResult"/&gt;
 *                       &lt;element name="DeleteBankAccountResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteBankAccountResult"/&gt;
 *                       &lt;element name="SetDefaultBankAccountResult" type="{http://cps.huawei.com/cpsinterface/result}SetDefaultBankAccountResult"/&gt;
 *                       &lt;element name="QueryDirectDebitMandateResult" type="{http://cps.huawei.com/cpsinterface/result}QueryDirectDebitMandateResult"/&gt;
 *                       &lt;element name="ViewDirectDebitMandateResult" type="{http://cps.huawei.com/cpsinterface/result}ViewDirectDebitMandateResult"/&gt;
 *                       &lt;element name="QueryReminderScheduleResult" type="{http://cps.huawei.com/cpsinterface/result}QueryReminderScheduleResult"/&gt;
 *                       &lt;element name="CCHChangeCustKYCResult" type="{http://cps.huawei.com/cpsinterface/result}CCHChangeCustKYCResult"/&gt;
 *                       &lt;element name="CCHChangeOrgOperatorKYCResult" type="{http://cps.huawei.com/cpsinterface/result}CCHChangeOrgOperatorKYCResult"/&gt;
 *                       &lt;element name="PreValidationConfirmationResult" type="{http://cps.huawei.com/cpsinterface/result}PreValidationConfirmationResult"/&gt;
 *                       &lt;element name="PreValidationResult" type="{http://cps.huawei.com/cpsinterface/result}PreValidationResult"/&gt;
 *                       &lt;element name="CreateOrgLoyaltyAccountResult" type="{http://cps.huawei.com/cpsinterface/result}CreateOrgLoyaltyAccountResult"/&gt;
 *                       &lt;element name="CreateCustLoyaltyAccountResult" type="{http://cps.huawei.com/cpsinterface/result}CreateCustLoyaltyAccountResult"/&gt;
 *                       &lt;element name="CreateGroupLoyaltyAccountResult" type="{http://cps.huawei.com/cpsinterface/result}CreateGroupLoyaltyAccountResult"/&gt;
 *                       &lt;element name="QueryCustLoyaltyPointResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustLoyaltyPointResult"/&gt;
 *                       &lt;element name="QueryOrgLoyaltyPointResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrgLoyaltyPointResult"/&gt;
 *                       &lt;element name="QueryGroupLoyaltyPointResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupLoyaltyPointResult"/&gt;
 *                       &lt;element name="QueryLoyaltyConsumerByOrgOperatorResult" type="{http://cps.huawei.com/cpsinterface/result}QueryLoyaltyConsumerResult"/&gt;
 *                       &lt;element name="QueryCustLoyaltyPointStatementResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustLoyaltyPointStatementResult"/&gt;
 *                       &lt;element name="QueryOrgLoyaltyPointStatementResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrgLoyaltyPointStatementResult"/&gt;
 *                       &lt;element name="QueryGroupLoyaltyPointStatementResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupLoyaltyPointStatementResult"/&gt;
 *                       &lt;element name="QueryLoyaltyConsumerStatementByOrgOperatorResult" type="{http://cps.huawei.com/cpsinterface/result}QueryLoyaltyConsumerStatementResult"/&gt;
 *                       &lt;element name="QueryIdentityBundleResult" type="{http://cps.huawei.com/cpsinterface/result}QueryIdentityBundleResult"/&gt;
 *                       &lt;element name="CCHIdentifyCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}CCHIdentifyCustomerResult"/&gt;
 *                       &lt;element name="CCHIdentifyOperatorResult" type="{http://cps.huawei.com/cpsinterface/result}CCHIdentifyOperatorResult"/&gt;
 *                       &lt;element name="UpdateOrgOperatorOwnKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrgOperatorOwnKYCResult"/&gt;
 *                       &lt;element name="QuerySavingPlanForCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}QuerySavingPlanForCustomerResult"/&gt;
 *                       &lt;element name="QuerySavingPlanForGroupResult" type="{http://cps.huawei.com/cpsinterface/result}QuerySavingPlanForGroupResult"/&gt;
 *                       &lt;element name="QuerySavingPlanForOrganizationResult" type="{http://cps.huawei.com/cpsinterface/result}QuerySavingPlanForOrganizationResult"/&gt;
 *                       &lt;element name="QueryTransferPointsFeeResult" type="{http://cps.huawei.com/cpsinterface/result}QueryTransferPointsFeeResult"/&gt;
 *                       &lt;element name="QueryRedeemBalanceRateResult" type="{http://cps.huawei.com/cpsinterface/result}QueryRedeemBalanceRateResult"/&gt;
 *                       &lt;element name="TransferPointsResult" type="{http://cps.huawei.com/cpsinterface/result}TransferPointsResult"/&gt;
 *                       &lt;element name="RedeemPointsToGoodsResult" type="{http://cps.huawei.com/cpsinterface/result}RedeemPointsToGoodsResult"/&gt;
 *                       &lt;element name="RedeemPointsWithVoucherResult" type="{http://cps.huawei.com/cpsinterface/result}RedeemPointsWithVoucherResult"/&gt;
 *                       &lt;element name="RedeemPointsToBalanceResult" type="{http://cps.huawei.com/cpsinterface/result}RedeemPointsToBalanceResult"/&gt;
 *                       &lt;element name="SubscribeSavingPlanForCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}SubscribeSavingPlanForCustomerResult"/&gt;
 *                       &lt;element name="SubscribeSavingPlanForGroupResult" type="{http://cps.huawei.com/cpsinterface/result}SubscribeSavingPlanForGroupResult"/&gt;
 *                       &lt;element name="SubscribeSavingPlanForOrgResult" type="{http://cps.huawei.com/cpsinterface/result}SubscribeSavingPlanForOrgResult"/&gt;
 *                       &lt;element name="UnSubscribeSavingPlanForCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}UnSubscribeSavingPlanForCustomerResult"/&gt;
 *                       &lt;element name="UnSubscribeSavingPlanForGroupResult" type="{http://cps.huawei.com/cpsinterface/result}UnSubscribeSavingPlanForGroupResult"/&gt;
 *                       &lt;element name="UnSubscribeSavingPlanForOrgResult" type="{http://cps.huawei.com/cpsinterface/result}UnSubscribeSavingPlanForOrgResult"/&gt;
 *                       &lt;element name="ValidateTokenResult" type="{http://cps.huawei.com/cpsinterface/result}ValidateTokenResult"/&gt;
 *                     &lt;/choice&gt;
 *                   &lt;/choice&gt;
 *                   &lt;element name="ReferenceData" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="ReferenceItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Result", propOrder = {
    "header",
    "body"
})
public class Result {

    @XmlElement(name = "Header", required = true)
    protected Result.Header header;
    @XmlElement(name = "Body", required = true)
    protected Result.Body body;

    /**
     * Gets the value of the header property.
     * 
     * @return
     *     possible object is
     *     {@link Result.Header }
     *     
     */
    public Result.Header getHeader() {
        return header;
    }

    /**
     * Sets the value of the header property.
     * 
     * @param value
     *     allowed object is
     *     {@link Result.Header }
     *     
     */
    public void setHeader(Result.Header value) {
        this.header = value;
    }

    /**
     * Gets the value of the body property.
     * 
     * @return
     *     possible object is
     *     {@link Result.Body }
     *     
     */
    public Result.Body getBody() {
        return body;
    }

    /**
     * Sets the value of the body property.
     * 
     * @param value
     *     allowed object is
     *     {@link Result.Body }
     *     
     */
    public void setBody(Result.Body value) {
        this.body = value;
    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="ResultType" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
     *         &lt;element name="ResultCode"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="10"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="ResultDesc" minOccurs="0"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="1024"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="ResultParameters" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="ParameterItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="TaskID" minOccurs="0"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="64"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="WorkflowID" minOccurs="0"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="64"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;choice minOccurs="0"&gt;
     *           &lt;element name="EncryptedParameters" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/&gt;
     *           &lt;choice&gt;
     *             &lt;element name="TransactionResult"&gt;
     *               &lt;complexType&gt;
     *                 &lt;complexContent&gt;
     *                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                     &lt;sequence&gt;
     *                       &lt;element name="TransactionID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                       &lt;element name="TransactionStatus" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
     *                       &lt;element name="ResultParameters" minOccurs="0"&gt;
     *                         &lt;complexType&gt;
     *                           &lt;complexContent&gt;
     *                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                               &lt;sequence&gt;
     *                                 &lt;element name="ResultParameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
     *                               &lt;/sequence&gt;
     *                             &lt;/restriction&gt;
     *                           &lt;/complexContent&gt;
     *                         &lt;/complexType&gt;
     *                       &lt;/element&gt;
     *                     &lt;/sequence&gt;
     *                   &lt;/restriction&gt;
     *                 &lt;/complexContent&gt;
     *               &lt;/complexType&gt;
     *             &lt;/element&gt;
     *             &lt;element name="ChangeCustomerMSISDNResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerMSISDNResult"/&gt;
     *             &lt;element name="ChangeTillMSISDNResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeTillMSISDNResult"/&gt;
     *             &lt;element name="ChangeAccountStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeAccountStatusResult"/&gt;
     *             &lt;element name="UpdateCustomerKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateCustomerKYCResult"/&gt;
     *             &lt;element name="UpdateOrganizationKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrganizationKYCResult"/&gt;
     *             &lt;element name="QueryCustomerKYCResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerKYCResult"/&gt;
     *             &lt;element name="QueryCustomerInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerInfoResult"/&gt;
     *             &lt;element name="QueryCustomerProductsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerProductsResult"/&gt;
     *             &lt;element name="QueryCustomerBalanceResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerBalanceResult"/&gt;
     *             &lt;element name="QueryOrganizationKYCResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationKYCResult"/&gt;
     *             &lt;element name="QueryOrganizationInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationInfoResult"/&gt;
     *             &lt;element name="QueryOrganizationProductsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationProductsResult"/&gt;
     *             &lt;element name="QueryOrganizationBalanceResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationBalanceResult"/&gt;
     *             &lt;element name="ListOrganizationTillsResult" type="{http://cps.huawei.com/cpsinterface/result}ListOrganizationTillsResult"/&gt;
     *             &lt;element name="QueryOrgOperatorKYCResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrgOperatorKYCResult"/&gt;
     *             &lt;element name="QueryOrgOperatorInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrgOperatorInfoResult"/&gt;
     *             &lt;element name="QueryTillInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryTillInfoResult"/&gt;
     *             &lt;element name="QueryTillProductsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryTillProductsResult"/&gt;
     *             &lt;element name="ChangeCustomerStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerStatusResult"/&gt;
     *             &lt;element name="ChangeOrganizationStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrganizationStatusResult"/&gt;
     *             &lt;element name="ChangeTillStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeTillStatusResult"/&gt;
     *             &lt;element name="ChangeSPOperatorStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeSPOperatorStatusResult"/&gt;
     *             &lt;element name="ChangeOrgOperatorStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgOperatorStatusResult"/&gt;
     *             &lt;element name="UpdateSPOperatorKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateSPOperatorKYCResult"/&gt;
     *             &lt;element name="UpdateOrgOperatorKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrgOperatorKYCResult"/&gt;
     *             &lt;element name="UpdateCustomerProductsResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateCustomerProductsResult"/&gt;
     *             &lt;element name="UpdateOrganizationProductsResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrganizationProductsResult"/&gt;
     *             &lt;element name="UpdateTillProductsResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateTillProductsResult"/&gt;
     *             &lt;element name="RegisterCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}RegisterCustomerResult"/&gt;
     *             &lt;element name="RecycleMSISDNResult" type="{http://cps.huawei.com/cpsinterface/result}RecycleMSISDNResult"/&gt;
     *             &lt;element name="ListOrganizationChildStoresResult" type="{http://cps.huawei.com/cpsinterface/result}ListOrganizationChildStoresResult"/&gt;
     *             &lt;element name="ListOrganizationOperatorsResult" type="{http://cps.huawei.com/cpsinterface/result}ListOrganizationOperatorsResult"/&gt;
     *             &lt;element name="UpdateSPOperatorRoleResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateSPOperatorRoleResult"/&gt;
     *             &lt;element name="UpdateOrgOperatorRoleResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrgOperatorRoleResult"/&gt;
     *             &lt;element name="UpdateOrgTaxExemptionResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrgTaxExemptionResult"/&gt;
     *             &lt;element name="QueryO2CLinkResult" type="{http://cps.huawei.com/cpsinterface/result}QueryO2CLinkResult"/&gt;
     *             &lt;element name="AddO2CLinkResult" type="{http://cps.huawei.com/cpsinterface/result}AddO2CLinkResult"/&gt;
     *             &lt;element name="DeleteO2CLinkResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteO2CLinkResult"/&gt;
     *             &lt;element name="VerifyCCCallerResult" type="{http://cps.huawei.com/cpsinterface/result}VerifyCCCallerResult"/&gt;
     *             &lt;element name="UnlockCustomerPINResult" type="{http://cps.huawei.com/cpsinterface/result}UnlockCustomerPINResult"/&gt;
     *             &lt;element name="UnlockOrgOperatorPINResult" type="{http://cps.huawei.com/cpsinterface/result}UnlockOrgOperatorPINResult"/&gt;
     *             &lt;element name="UnlockOrgOperatorPasswordResult" type="{http://cps.huawei.com/cpsinterface/result}UnlockOrgOperatorPasswordResult"/&gt;
     *             &lt;element name="ResetCustomerPINResult" type="{http://cps.huawei.com/cpsinterface/result}ResetCustomerPINResult"/&gt;
     *             &lt;element name="ResetOrgOperatorPINResult" type="{http://cps.huawei.com/cpsinterface/result}ResetOrgOperatorPINResult"/&gt;
     *             &lt;element name="ResetOrgOperatorPasswordResult" type="{http://cps.huawei.com/cpsinterface/result}ResetOrgOperatorPasswordResult"/&gt;
     *             &lt;element name="ResetCustomerSecretWordResult" type="{http://cps.huawei.com/cpsinterface/result}ResetCustomerSecretWordResult"/&gt;
     *             &lt;element name="ReleaseCustomerCCSuspendStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ReleaseCustomerCCSuspendStatusResult"/&gt;
     *             &lt;element name="ReleaseOrgOperatorCCSuspendStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ReleaseOrgOperatorCCSuspendStatusResult"/&gt;
     *             &lt;element name="SearchTransactionResult" type="{http://cps.huawei.com/cpsinterface/result}SearchTransactionResult"/&gt;
     *             &lt;element name="ReverseTransactionResult" type="{http://cps.huawei.com/cpsinterface/result}ReverseTransactionResult"/&gt;
     *             &lt;element name="ConfirmTransactionResult" type="{http://cps.huawei.com/cpsinterface/result}ConfirmTransactionResult"/&gt;
     *             &lt;element name="QueryCustomerAccountStatementsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerAccountStatementsResult"/&gt;
     *             &lt;element name="QueryCustomerTransactionsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerTransactionsResult"/&gt;
     *             &lt;element name="QueryOrganizationAccountStatementsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationAccountStatementsResult"/&gt;
     *             &lt;element name="QueryOrganizationTransactionsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationTransactionsResult"/&gt;
     *             &lt;element name="QueryResultMessageResult" type="{http://cps.huawei.com/cpsinterface/result}QueryResultMessageResult"/&gt;
     *             &lt;element name="UpdateTransactionStatusResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateTransactionStatusResult"/&gt;
     *             &lt;element name="ChangeCustomerPINResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerPINResult"/&gt;
     *             &lt;element name="ChangeOrgOperatorPINResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgOperatorPINResult"/&gt;
     *             &lt;element name="ChangeCustomerSecretWordResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerSecretWordResult"/&gt;
     *             &lt;element name="ChangeOrgOperatorSecretWordResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgOperatorSecretWordResult"/&gt;
     *             &lt;element name="ChangeCustomerLanguageResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeCustomerLanguageResult"/&gt;
     *             &lt;element name="ChangeOrgOperatorLanguageResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgOperatorLanguageResult"/&gt;
     *             &lt;element name="ChangeSPOperatorLanguageResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeSPOperatorLanguageResult"/&gt;
     *             &lt;element name="ChangeOrgnNameResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeOrgnNameResult"/&gt;
     *             &lt;element name="ActivateCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}ActivateCustomerResult"/&gt;
     *             &lt;element name="ActivateTillResult" type="{http://cps.huawei.com/cpsinterface/result}ActivateTillResult"/&gt;
     *             &lt;element name="AddCustomerBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}AddCustomerBeneficiaryResult"/&gt;
     *             &lt;element name="AddOrgBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}AddOrgBeneficiaryResult"/&gt;
     *             &lt;element name="DeleteCustomerBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteCustomerBeneficiaryResult"/&gt;
     *             &lt;element name="DeleteOrgBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteOrgBeneficiaryResult"/&gt;
     *             &lt;element name="LookupCustomerBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}LookupCustomerBeneficiaryResult"/&gt;
     *             &lt;element name="LookupOrgBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}LookupOrgBeneficiaryResult"/&gt;
     *             &lt;element name="AddGroupBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}AddGroupBeneficiaryResult"/&gt;
     *             &lt;element name="DeleteGroupBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteGroupBeneficiaryResult"/&gt;
     *             &lt;element name="LookupGroupBeneficiaryResult" type="{http://cps.huawei.com/cpsinterface/result}LookupGroupBeneficiaryResult"/&gt;
     *             &lt;element name="CreateTopOrgResult" type="{http://cps.huawei.com/cpsinterface/result}CreateTopOrgResult"/&gt;
     *             &lt;element name="CreateChildOrgResult" type="{http://cps.huawei.com/cpsinterface/result}CreateChildOrgResult"/&gt;
     *             &lt;element name="CreateTillResult" type="{http://cps.huawei.com/cpsinterface/result}CreateTillResult"/&gt;
     *             &lt;element name="ChangeTillLanguageResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeTillLanguageResult"/&gt;
     *             &lt;element name="CreateOrgOperatorResult" type="{http://cps.huawei.com/cpsinterface/result}CreateOrgOperatorResult"/&gt;
     *             &lt;element name="RecipientLookUpResult" type="{http://cps.huawei.com/cpsinterface/result}RecipientLookUpResult"/&gt;
     *             &lt;element name="BulkTaskResult" type="{http://cps.huawei.com/cpsinterface/result}BulkTaskResult"/&gt;
     *             &lt;element name="ChangeTillDefaultOperatorIDResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeTillDefaultOperatorIDResult"/&gt;
     *             &lt;element name="CustomerGetStartPINResult" type="{http://cps.huawei.com/cpsinterface/result}CustomerGetStartPINResult"/&gt;
     *             &lt;element name="QueryGroupBalanceResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupBalanceResult"/&gt;
     *             &lt;element name="QueryGroupAccountStatementsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupAccountStatementsResult"/&gt;
     *             &lt;element name="QueryGroupTransactionsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupTransactionsResult"/&gt;
     *             &lt;element name="QueryCustomerPointsLogResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerPointsLogResult"/&gt;
     *             &lt;element name="QueryCustomerPointsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustomerPointsResult"/&gt;
     *             &lt;element name="AdjustCustomerPointsResult" type="{http://cps.huawei.com/cpsinterface/result}AdjustCustomerPointsResult"/&gt;
     *             &lt;element name="QueryOrganizationPointsLogResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationPointsLogResult"/&gt;
     *             &lt;element name="QueryOrganizationPointsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrganizationPointsResult"/&gt;
     *             &lt;element name="AdjustOrganizationPointsResult" type="{http://cps.huawei.com/cpsinterface/result}AdjustOrganizationPointsResult"/&gt;
     *             &lt;element name="CreateGroupResult" type="{http://cps.huawei.com/cpsinterface/result}CreateGroupResult"/&gt;
     *             &lt;element name="CreateGroupByCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}CreateGroupByCustomerResult"/&gt;
     *             &lt;element name="UpdateGroupKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateGroupKYCResult"/&gt;
     *             &lt;element name="ChangeGroupStatusResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupStatusResult"/&gt;
     *             &lt;element name="AddGroupMemberResult" type="{http://cps.huawei.com/cpsinterface/result}AddGroupMemberResult"/&gt;
     *             &lt;element name="AddGroupMemberByGroupLeaderResult" type="{http://cps.huawei.com/cpsinterface/result}AddGroupMemberByGroupLeaderResult"/&gt;
     *             &lt;element name="RemoveGroupMemberResult" type="{http://cps.huawei.com/cpsinterface/result}RemoveGroupMemberResult"/&gt;
     *             &lt;element name="RemoveGroupMemberByGroupLeaderResult" type="{http://cps.huawei.com/cpsinterface/result}RemoveGroupMemberByGroupLeaderResult"/&gt;
     *             &lt;element name="ChangeGroupMemberRolesResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupMemberRolesResult"/&gt;
     *             &lt;element name="ChangeGroupMemberRolesByGroupLeaderResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupMemberRolesByGroupLeaderResult"/&gt;
     *             &lt;element name="ConfirmGroupMembershipResult" type="{http://cps.huawei.com/cpsinterface/result}ConfirmGroupMembershipResult"/&gt;
     *             &lt;element name="ApproveGroupActionOrTransactionResult" type="{http://cps.huawei.com/cpsinterface/result}ApproveGroupActionOrTransactionResult"/&gt;
     *             &lt;element name="SearchMyGroupsResult" type="{http://cps.huawei.com/cpsinterface/result}SearchMyGroupsResult"/&gt;
     *             &lt;element name="QueryGroupInfoResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupInfoResult"/&gt;
     *             &lt;element name="QueryGroupKYCResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupKYCResult"/&gt;
     *             &lt;element name="QueryGroupProductsResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupProductsResult"/&gt;
     *             &lt;element name="ListGroupMembersResult" type="{http://cps.huawei.com/cpsinterface/result}ListGroupMembersResult"/&gt;
     *             &lt;element name="ListGroupMembersByCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}ListGroupMembersByCustomerResult"/&gt;
     *             &lt;element name="ChangeGroupRuleProfileResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupRuleProfileResult"/&gt;
     *             &lt;element name="ChangeGroupChargeProfileResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupChargeProfileResult"/&gt;
     *             &lt;element name="ChangeGroupAccountRuleProfileResult" type="{http://cps.huawei.com/cpsinterface/result}ChangeGroupAccountRuleProfileResult"/&gt;
     *             &lt;element name="IdentifyCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}IdentifyCustomerResult"/&gt;
     *             &lt;element name="RaiseDisputedTxnReversalResult" type="{http://cps.huawei.com/cpsinterface/result}RaiseDisputedTxnReversalResult"/&gt;
     *             &lt;element name="CancelIssuedVoucherResult" type="{http://cps.huawei.com/cpsinterface/result}CancelIssuedVoucherResult"/&gt;
     *             &lt;element name="CreateCustomerBundleResult" type="{http://cps.huawei.com/cpsinterface/result}CreateCustomerBundleResult"/&gt;
     *             &lt;element name="CreateOrganizationBundleResult" type="{http://cps.huawei.com/cpsinterface/result}CreateOrganizationBundleResult"/&gt;
     *             &lt;element name="CreateExternalProviderResult" type="{http://cps.huawei.com/cpsinterface/result}CreateExternalProviderResult"/&gt;
     *             &lt;element name="CreateGroupBundleResult" type="{http://cps.huawei.com/cpsinterface/result}CreateGroupBundleResult"/&gt;
     *             &lt;element name="CreateBankAccountResult" type="{http://cps.huawei.com/cpsinterface/result}CreateBankAccountResult"/&gt;
     *             &lt;element name="DeleteBankAccountResult" type="{http://cps.huawei.com/cpsinterface/result}DeleteBankAccountResult"/&gt;
     *             &lt;element name="SetDefaultBankAccountResult" type="{http://cps.huawei.com/cpsinterface/result}SetDefaultBankAccountResult"/&gt;
     *             &lt;element name="QueryDirectDebitMandateResult" type="{http://cps.huawei.com/cpsinterface/result}QueryDirectDebitMandateResult"/&gt;
     *             &lt;element name="ViewDirectDebitMandateResult" type="{http://cps.huawei.com/cpsinterface/result}ViewDirectDebitMandateResult"/&gt;
     *             &lt;element name="QueryReminderScheduleResult" type="{http://cps.huawei.com/cpsinterface/result}QueryReminderScheduleResult"/&gt;
     *             &lt;element name="CCHChangeCustKYCResult" type="{http://cps.huawei.com/cpsinterface/result}CCHChangeCustKYCResult"/&gt;
     *             &lt;element name="CCHChangeOrgOperatorKYCResult" type="{http://cps.huawei.com/cpsinterface/result}CCHChangeOrgOperatorKYCResult"/&gt;
     *             &lt;element name="PreValidationConfirmationResult" type="{http://cps.huawei.com/cpsinterface/result}PreValidationConfirmationResult"/&gt;
     *             &lt;element name="PreValidationResult" type="{http://cps.huawei.com/cpsinterface/result}PreValidationResult"/&gt;
     *             &lt;element name="CreateOrgLoyaltyAccountResult" type="{http://cps.huawei.com/cpsinterface/result}CreateOrgLoyaltyAccountResult"/&gt;
     *             &lt;element name="CreateCustLoyaltyAccountResult" type="{http://cps.huawei.com/cpsinterface/result}CreateCustLoyaltyAccountResult"/&gt;
     *             &lt;element name="CreateGroupLoyaltyAccountResult" type="{http://cps.huawei.com/cpsinterface/result}CreateGroupLoyaltyAccountResult"/&gt;
     *             &lt;element name="QueryCustLoyaltyPointResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustLoyaltyPointResult"/&gt;
     *             &lt;element name="QueryOrgLoyaltyPointResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrgLoyaltyPointResult"/&gt;
     *             &lt;element name="QueryGroupLoyaltyPointResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupLoyaltyPointResult"/&gt;
     *             &lt;element name="QueryLoyaltyConsumerByOrgOperatorResult" type="{http://cps.huawei.com/cpsinterface/result}QueryLoyaltyConsumerResult"/&gt;
     *             &lt;element name="QueryCustLoyaltyPointStatementResult" type="{http://cps.huawei.com/cpsinterface/result}QueryCustLoyaltyPointStatementResult"/&gt;
     *             &lt;element name="QueryOrgLoyaltyPointStatementResult" type="{http://cps.huawei.com/cpsinterface/result}QueryOrgLoyaltyPointStatementResult"/&gt;
     *             &lt;element name="QueryGroupLoyaltyPointStatementResult" type="{http://cps.huawei.com/cpsinterface/result}QueryGroupLoyaltyPointStatementResult"/&gt;
     *             &lt;element name="QueryLoyaltyConsumerStatementByOrgOperatorResult" type="{http://cps.huawei.com/cpsinterface/result}QueryLoyaltyConsumerStatementResult"/&gt;
     *             &lt;element name="QueryIdentityBundleResult" type="{http://cps.huawei.com/cpsinterface/result}QueryIdentityBundleResult"/&gt;
     *             &lt;element name="CCHIdentifyCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}CCHIdentifyCustomerResult"/&gt;
     *             &lt;element name="CCHIdentifyOperatorResult" type="{http://cps.huawei.com/cpsinterface/result}CCHIdentifyOperatorResult"/&gt;
     *             &lt;element name="UpdateOrgOperatorOwnKYCResult" type="{http://cps.huawei.com/cpsinterface/result}UpdateOrgOperatorOwnKYCResult"/&gt;
     *             &lt;element name="QuerySavingPlanForCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}QuerySavingPlanForCustomerResult"/&gt;
     *             &lt;element name="QuerySavingPlanForGroupResult" type="{http://cps.huawei.com/cpsinterface/result}QuerySavingPlanForGroupResult"/&gt;
     *             &lt;element name="QuerySavingPlanForOrganizationResult" type="{http://cps.huawei.com/cpsinterface/result}QuerySavingPlanForOrganizationResult"/&gt;
     *             &lt;element name="QueryTransferPointsFeeResult" type="{http://cps.huawei.com/cpsinterface/result}QueryTransferPointsFeeResult"/&gt;
     *             &lt;element name="QueryRedeemBalanceRateResult" type="{http://cps.huawei.com/cpsinterface/result}QueryRedeemBalanceRateResult"/&gt;
     *             &lt;element name="TransferPointsResult" type="{http://cps.huawei.com/cpsinterface/result}TransferPointsResult"/&gt;
     *             &lt;element name="RedeemPointsToGoodsResult" type="{http://cps.huawei.com/cpsinterface/result}RedeemPointsToGoodsResult"/&gt;
     *             &lt;element name="RedeemPointsWithVoucherResult" type="{http://cps.huawei.com/cpsinterface/result}RedeemPointsWithVoucherResult"/&gt;
     *             &lt;element name="RedeemPointsToBalanceResult" type="{http://cps.huawei.com/cpsinterface/result}RedeemPointsToBalanceResult"/&gt;
     *             &lt;element name="SubscribeSavingPlanForCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}SubscribeSavingPlanForCustomerResult"/&gt;
     *             &lt;element name="SubscribeSavingPlanForGroupResult" type="{http://cps.huawei.com/cpsinterface/result}SubscribeSavingPlanForGroupResult"/&gt;
     *             &lt;element name="SubscribeSavingPlanForOrgResult" type="{http://cps.huawei.com/cpsinterface/result}SubscribeSavingPlanForOrgResult"/&gt;
     *             &lt;element name="UnSubscribeSavingPlanForCustomerResult" type="{http://cps.huawei.com/cpsinterface/result}UnSubscribeSavingPlanForCustomerResult"/&gt;
     *             &lt;element name="UnSubscribeSavingPlanForGroupResult" type="{http://cps.huawei.com/cpsinterface/result}UnSubscribeSavingPlanForGroupResult"/&gt;
     *             &lt;element name="UnSubscribeSavingPlanForOrgResult" type="{http://cps.huawei.com/cpsinterface/result}UnSubscribeSavingPlanForOrgResult"/&gt;
     *             &lt;element name="ValidateTokenResult" type="{http://cps.huawei.com/cpsinterface/result}ValidateTokenResult"/&gt;
     *           &lt;/choice&gt;
     *         &lt;/choice&gt;
     *         &lt;element name="ReferenceData" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="ReferenceItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "resultType",
        "resultCode",
        "resultDesc",
        "resultParameters",
        "taskID",
        "workflowID",
        "encryptedParameters",
        "transactionResult",
        "changeCustomerMSISDNResult",
        "changeTillMSISDNResult",
        "changeAccountStatusResult",
        "updateCustomerKYCResult",
        "updateOrganizationKYCResult",
        "queryCustomerKYCResult",
        "queryCustomerInfoResult",
        "queryCustomerProductsResult",
        "queryCustomerBalanceResult",
        "queryOrganizationKYCResult",
        "queryOrganizationInfoResult",
        "queryOrganizationProductsResult",
        "queryOrganizationBalanceResult",
        "listOrganizationTillsResult",
        "queryOrgOperatorKYCResult",
        "queryOrgOperatorInfoResult",
        "queryTillInfoResult",
        "queryTillProductsResult",
        "changeCustomerStatusResult",
        "changeOrganizationStatusResult",
        "changeTillStatusResult",
        "changeSPOperatorStatusResult",
        "changeOrgOperatorStatusResult",
        "updateSPOperatorKYCResult",
        "updateOrgOperatorKYCResult",
        "updateCustomerProductsResult",
        "updateOrganizationProductsResult",
        "updateTillProductsResult",
        "registerCustomerResult",
        "recycleMSISDNResult",
        "listOrganizationChildStoresResult",
        "listOrganizationOperatorsResult",
        "updateSPOperatorRoleResult",
        "updateOrgOperatorRoleResult",
        "updateOrgTaxExemptionResult",
        "queryO2CLinkResult",
        "addO2CLinkResult",
        "deleteO2CLinkResult",
        "verifyCCCallerResult",
        "unlockCustomerPINResult",
        "unlockOrgOperatorPINResult",
        "unlockOrgOperatorPasswordResult",
        "resetCustomerPINResult",
        "resetOrgOperatorPINResult",
        "resetOrgOperatorPasswordResult",
        "resetCustomerSecretWordResult",
        "releaseCustomerCCSuspendStatusResult",
        "releaseOrgOperatorCCSuspendStatusResult",
        "searchTransactionResult",
        "reverseTransactionResult",
        "confirmTransactionResult",
        "queryCustomerAccountStatementsResult",
        "queryCustomerTransactionsResult",
        "queryOrganizationAccountStatementsResult",
        "queryOrganizationTransactionsResult",
        "queryResultMessageResult",
        "updateTransactionStatusResult",
        "changeCustomerPINResult",
        "changeOrgOperatorPINResult",
        "changeCustomerSecretWordResult",
        "changeOrgOperatorSecretWordResult",
        "changeCustomerLanguageResult",
        "changeOrgOperatorLanguageResult",
        "changeSPOperatorLanguageResult",
        "changeOrgnNameResult",
        "activateCustomerResult",
        "activateTillResult",
        "addCustomerBeneficiaryResult",
        "addOrgBeneficiaryResult",
        "deleteCustomerBeneficiaryResult",
        "deleteOrgBeneficiaryResult",
        "lookupCustomerBeneficiaryResult",
        "lookupOrgBeneficiaryResult",
        "addGroupBeneficiaryResult",
        "deleteGroupBeneficiaryResult",
        "lookupGroupBeneficiaryResult",
        "createTopOrgResult",
        "createChildOrgResult",
        "createTillResult",
        "changeTillLanguageResult",
        "createOrgOperatorResult",
        "recipientLookUpResult",
        "bulkTaskResult",
        "changeTillDefaultOperatorIDResult",
        "customerGetStartPINResult",
        "queryGroupBalanceResult",
        "queryGroupAccountStatementsResult",
        "queryGroupTransactionsResult",
        "queryCustomerPointsLogResult",
        "queryCustomerPointsResult",
        "adjustCustomerPointsResult",
        "queryOrganizationPointsLogResult",
        "queryOrganizationPointsResult",
        "adjustOrganizationPointsResult",
        "createGroupResult",
        "createGroupByCustomerResult",
        "updateGroupKYCResult",
        "changeGroupStatusResult",
        "addGroupMemberResult",
        "addGroupMemberByGroupLeaderResult",
        "removeGroupMemberResult",
        "removeGroupMemberByGroupLeaderResult",
        "changeGroupMemberRolesResult",
        "changeGroupMemberRolesByGroupLeaderResult",
        "confirmGroupMembershipResult",
        "approveGroupActionOrTransactionResult",
        "searchMyGroupsResult",
        "queryGroupInfoResult",
        "queryGroupKYCResult",
        "queryGroupProductsResult",
        "listGroupMembersResult",
        "listGroupMembersByCustomerResult",
        "changeGroupRuleProfileResult",
        "changeGroupChargeProfileResult",
        "changeGroupAccountRuleProfileResult",
        "identifyCustomerResult",
        "raiseDisputedTxnReversalResult",
        "cancelIssuedVoucherResult",
        "createCustomerBundleResult",
        "createOrganizationBundleResult",
        "createExternalProviderResult",
        "createGroupBundleResult",
        "createBankAccountResult",
        "deleteBankAccountResult",
        "setDefaultBankAccountResult",
        "queryDirectDebitMandateResult",
        "viewDirectDebitMandateResult",
        "queryReminderScheduleResult",
        "cchChangeCustKYCResult",
        "cchChangeOrgOperatorKYCResult",
        "preValidationConfirmationResult",
        "preValidationResult",
        "createOrgLoyaltyAccountResult",
        "createCustLoyaltyAccountResult",
        "createGroupLoyaltyAccountResult",
        "queryCustLoyaltyPointResult",
        "queryOrgLoyaltyPointResult",
        "queryGroupLoyaltyPointResult",
        "queryLoyaltyConsumerByOrgOperatorResult",
        "queryCustLoyaltyPointStatementResult",
        "queryOrgLoyaltyPointStatementResult",
        "queryGroupLoyaltyPointStatementResult",
        "queryLoyaltyConsumerStatementByOrgOperatorResult",
        "queryIdentityBundleResult",
        "cchIdentifyCustomerResult",
        "cchIdentifyOperatorResult",
        "updateOrgOperatorOwnKYCResult",
        "querySavingPlanForCustomerResult",
        "querySavingPlanForGroupResult",
        "querySavingPlanForOrganizationResult",
        "queryTransferPointsFeeResult",
        "queryRedeemBalanceRateResult",
        "transferPointsResult",
        "redeemPointsToGoodsResult",
        "redeemPointsWithVoucherResult",
        "redeemPointsToBalanceResult",
        "subscribeSavingPlanForCustomerResult",
        "subscribeSavingPlanForGroupResult",
        "subscribeSavingPlanForOrgResult",
        "unSubscribeSavingPlanForCustomerResult",
        "unSubscribeSavingPlanForGroupResult",
        "unSubscribeSavingPlanForOrgResult",
        "validateTokenResult",
        "referenceData"
    })
    public static class Body {

        @XmlElement(name = "ResultType", required = true)
        protected BigInteger resultType;
        @XmlElement(name = "ResultCode", required = true)
        protected String resultCode;
        @XmlElement(name = "ResultDesc")
        protected String resultDesc;
        @XmlElement(name = "ResultParameters")
        protected Result.Body.ResultParameters resultParameters;
        @XmlElement(name = "TaskID")
        protected String taskID;
        @XmlElement(name = "WorkflowID")
        protected String workflowID;
        @XmlElement(name = "EncryptedParameters")
        protected byte[] encryptedParameters;
        @XmlElement(name = "TransactionResult")
        protected Result.Body.TransactionResult transactionResult;
        @XmlElement(name = "ChangeCustomerMSISDNResult")
        protected ChangeCustomerMSISDNResult changeCustomerMSISDNResult;
        @XmlElement(name = "ChangeTillMSISDNResult")
        protected ChangeTillMSISDNResult changeTillMSISDNResult;
        @XmlElement(name = "ChangeAccountStatusResult")
        protected ChangeAccountStatusResult changeAccountStatusResult;
        @XmlElement(name = "UpdateCustomerKYCResult")
        protected UpdateCustomerKYCResult updateCustomerKYCResult;
        @XmlElement(name = "UpdateOrganizationKYCResult")
        protected UpdateOrganizationKYCResult updateOrganizationKYCResult;
        @XmlElement(name = "QueryCustomerKYCResult")
        protected QueryCustomerKYCResult queryCustomerKYCResult;
        @XmlElement(name = "QueryCustomerInfoResult")
        protected QueryCustomerInfoResult queryCustomerInfoResult;
        @XmlElement(name = "QueryCustomerProductsResult")
        protected QueryCustomerProductsResult queryCustomerProductsResult;
        @XmlElement(name = "QueryCustomerBalanceResult")
        protected QueryCustomerBalanceResult queryCustomerBalanceResult;
        @XmlElement(name = "QueryOrganizationKYCResult")
        protected QueryOrganizationKYCResult queryOrganizationKYCResult;
        @XmlElement(name = "QueryOrganizationInfoResult")
        protected QueryOrganizationInfoResult queryOrganizationInfoResult;
        @XmlElement(name = "QueryOrganizationProductsResult")
        protected QueryOrganizationProductsResult queryOrganizationProductsResult;
        @XmlElement(name = "QueryOrganizationBalanceResult")
        protected QueryOrganizationBalanceResult queryOrganizationBalanceResult;
        @XmlElement(name = "ListOrganizationTillsResult")
        protected ListOrganizationTillsResult listOrganizationTillsResult;
        @XmlElement(name = "QueryOrgOperatorKYCResult")
        protected QueryOrgOperatorKYCResult queryOrgOperatorKYCResult;
        @XmlElement(name = "QueryOrgOperatorInfoResult")
        protected QueryOrgOperatorInfoResult queryOrgOperatorInfoResult;
        @XmlElement(name = "QueryTillInfoResult")
        protected QueryTillInfoResult queryTillInfoResult;
        @XmlElement(name = "QueryTillProductsResult")
        protected QueryTillProductsResult queryTillProductsResult;
        @XmlElement(name = "ChangeCustomerStatusResult")
        protected ChangeCustomerStatusResult changeCustomerStatusResult;
        @XmlElement(name = "ChangeOrganizationStatusResult")
        protected ChangeOrganizationStatusResult changeOrganizationStatusResult;
        @XmlElement(name = "ChangeTillStatusResult")
        protected ChangeTillStatusResult changeTillStatusResult;
        @XmlElement(name = "ChangeSPOperatorStatusResult")
        protected ChangeSPOperatorStatusResult changeSPOperatorStatusResult;
        @XmlElement(name = "ChangeOrgOperatorStatusResult")
        protected ChangeOrgOperatorStatusResult changeOrgOperatorStatusResult;
        @XmlElement(name = "UpdateSPOperatorKYCResult")
        protected UpdateSPOperatorKYCResult updateSPOperatorKYCResult;
        @XmlElement(name = "UpdateOrgOperatorKYCResult")
        protected UpdateOrgOperatorKYCResult updateOrgOperatorKYCResult;
        @XmlElement(name = "UpdateCustomerProductsResult")
        protected UpdateCustomerProductsResult updateCustomerProductsResult;
        @XmlElement(name = "UpdateOrganizationProductsResult")
        protected UpdateOrganizationProductsResult updateOrganizationProductsResult;
        @XmlElement(name = "UpdateTillProductsResult")
        protected UpdateTillProductsResult updateTillProductsResult;
        @XmlElement(name = "RegisterCustomerResult")
        protected RegisterCustomerResult registerCustomerResult;
        @XmlElement(name = "RecycleMSISDNResult")
        protected RecycleMSISDNResult recycleMSISDNResult;
        @XmlElement(name = "ListOrganizationChildStoresResult")
        protected ListOrganizationChildStoresResult listOrganizationChildStoresResult;
        @XmlElement(name = "ListOrganizationOperatorsResult")
        protected ListOrganizationOperatorsResult listOrganizationOperatorsResult;
        @XmlElement(name = "UpdateSPOperatorRoleResult")
        protected UpdateSPOperatorRoleResult updateSPOperatorRoleResult;
        @XmlElement(name = "UpdateOrgOperatorRoleResult")
        protected UpdateOrgOperatorRoleResult updateOrgOperatorRoleResult;
        @XmlElement(name = "UpdateOrgTaxExemptionResult")
        protected UpdateOrgTaxExemptionResult updateOrgTaxExemptionResult;
        @XmlElement(name = "QueryO2CLinkResult")
        protected QueryO2CLinkResult queryO2CLinkResult;
        @XmlElement(name = "AddO2CLinkResult")
        protected AddO2CLinkResult addO2CLinkResult;
        @XmlElement(name = "DeleteO2CLinkResult")
        protected DeleteO2CLinkResult deleteO2CLinkResult;
        @XmlElement(name = "VerifyCCCallerResult")
        protected VerifyCCCallerResult verifyCCCallerResult;
        @XmlElement(name = "UnlockCustomerPINResult")
        protected UnlockCustomerPINResult unlockCustomerPINResult;
        @XmlElement(name = "UnlockOrgOperatorPINResult")
        protected UnlockOrgOperatorPINResult unlockOrgOperatorPINResult;
        @XmlElement(name = "UnlockOrgOperatorPasswordResult")
        protected UnlockOrgOperatorPasswordResult unlockOrgOperatorPasswordResult;
        @XmlElement(name = "ResetCustomerPINResult")
        protected ResetCustomerPINResult resetCustomerPINResult;
        @XmlElement(name = "ResetOrgOperatorPINResult")
        protected ResetOrgOperatorPINResult resetOrgOperatorPINResult;
        @XmlElement(name = "ResetOrgOperatorPasswordResult")
        protected ResetOrgOperatorPasswordResult resetOrgOperatorPasswordResult;
        @XmlElement(name = "ResetCustomerSecretWordResult")
        protected ResetCustomerSecretWordResult resetCustomerSecretWordResult;
        @XmlElement(name = "ReleaseCustomerCCSuspendStatusResult")
        protected ReleaseCustomerCCSuspendStatusResult releaseCustomerCCSuspendStatusResult;
        @XmlElement(name = "ReleaseOrgOperatorCCSuspendStatusResult")
        protected ReleaseOrgOperatorCCSuspendStatusResult releaseOrgOperatorCCSuspendStatusResult;
        @XmlElement(name = "SearchTransactionResult")
        protected SearchTransactionResult searchTransactionResult;
        @XmlElement(name = "ReverseTransactionResult")
        protected ReverseTransactionResult reverseTransactionResult;
        @XmlElement(name = "ConfirmTransactionResult")
        protected ConfirmTransactionResult confirmTransactionResult;
        @XmlElement(name = "QueryCustomerAccountStatementsResult")
        protected QueryCustomerAccountStatementsResult queryCustomerAccountStatementsResult;
        @XmlElement(name = "QueryCustomerTransactionsResult")
        protected QueryCustomerTransactionsResult queryCustomerTransactionsResult;
        @XmlElement(name = "QueryOrganizationAccountStatementsResult")
        protected QueryOrganizationAccountStatementsResult queryOrganizationAccountStatementsResult;
        @XmlElement(name = "QueryOrganizationTransactionsResult")
        protected QueryOrganizationTransactionsResult queryOrganizationTransactionsResult;
        @XmlElement(name = "QueryResultMessageResult")
        protected QueryResultMessageResult queryResultMessageResult;
        @XmlElement(name = "UpdateTransactionStatusResult")
        protected UpdateTransactionStatusResult updateTransactionStatusResult;
        @XmlElement(name = "ChangeCustomerPINResult")
        protected ChangeCustomerPINResult changeCustomerPINResult;
        @XmlElement(name = "ChangeOrgOperatorPINResult")
        protected ChangeOrgOperatorPINResult changeOrgOperatorPINResult;
        @XmlElement(name = "ChangeCustomerSecretWordResult")
        protected ChangeCustomerSecretWordResult changeCustomerSecretWordResult;
        @XmlElement(name = "ChangeOrgOperatorSecretWordResult")
        protected ChangeOrgOperatorSecretWordResult changeOrgOperatorSecretWordResult;
        @XmlElement(name = "ChangeCustomerLanguageResult")
        protected ChangeCustomerLanguageResult changeCustomerLanguageResult;
        @XmlElement(name = "ChangeOrgOperatorLanguageResult")
        protected ChangeOrgOperatorLanguageResult changeOrgOperatorLanguageResult;
        @XmlElement(name = "ChangeSPOperatorLanguageResult")
        protected ChangeSPOperatorLanguageResult changeSPOperatorLanguageResult;
        @XmlElement(name = "ChangeOrgnNameResult")
        protected ChangeOrgnNameResult changeOrgnNameResult;
        @XmlElement(name = "ActivateCustomerResult")
        protected ActivateCustomerResult activateCustomerResult;
        @XmlElement(name = "ActivateTillResult")
        protected ActivateTillResult activateTillResult;
        @XmlElement(name = "AddCustomerBeneficiaryResult")
        protected AddCustomerBeneficiaryResult addCustomerBeneficiaryResult;
        @XmlElement(name = "AddOrgBeneficiaryResult")
        protected AddOrgBeneficiaryResult addOrgBeneficiaryResult;
        @XmlElement(name = "DeleteCustomerBeneficiaryResult")
        protected DeleteCustomerBeneficiaryResult deleteCustomerBeneficiaryResult;
        @XmlElement(name = "DeleteOrgBeneficiaryResult")
        protected DeleteOrgBeneficiaryResult deleteOrgBeneficiaryResult;
        @XmlElement(name = "LookupCustomerBeneficiaryResult")
        protected LookupCustomerBeneficiaryResult lookupCustomerBeneficiaryResult;
        @XmlElement(name = "LookupOrgBeneficiaryResult")
        protected LookupOrgBeneficiaryResult lookupOrgBeneficiaryResult;
        @XmlElement(name = "AddGroupBeneficiaryResult")
        protected AddGroupBeneficiaryResult addGroupBeneficiaryResult;
        @XmlElement(name = "DeleteGroupBeneficiaryResult")
        protected DeleteGroupBeneficiaryResult deleteGroupBeneficiaryResult;
        @XmlElement(name = "LookupGroupBeneficiaryResult")
        protected LookupGroupBeneficiaryResult lookupGroupBeneficiaryResult;
        @XmlElement(name = "CreateTopOrgResult")
        protected CreateTopOrgResult createTopOrgResult;
        @XmlElement(name = "CreateChildOrgResult")
        protected CreateChildOrgResult createChildOrgResult;
        @XmlElement(name = "CreateTillResult")
        protected CreateTillResult createTillResult;
        @XmlElement(name = "ChangeTillLanguageResult")
        protected ChangeTillLanguageResult changeTillLanguageResult;
        @XmlElement(name = "CreateOrgOperatorResult")
        protected CreateOrgOperatorResult createOrgOperatorResult;
        @XmlElement(name = "RecipientLookUpResult")
        protected RecipientLookUpResult recipientLookUpResult;
        @XmlElement(name = "BulkTaskResult")
        protected BulkTaskResult bulkTaskResult;
        @XmlElement(name = "ChangeTillDefaultOperatorIDResult")
        protected ChangeTillDefaultOperatorIDResult changeTillDefaultOperatorIDResult;
        @XmlElement(name = "CustomerGetStartPINResult")
        protected CustomerGetStartPINResult customerGetStartPINResult;
        @XmlElement(name = "QueryGroupBalanceResult")
        protected QueryGroupBalanceResult queryGroupBalanceResult;
        @XmlElement(name = "QueryGroupAccountStatementsResult")
        protected QueryGroupAccountStatementsResult queryGroupAccountStatementsResult;
        @XmlElement(name = "QueryGroupTransactionsResult")
        protected QueryGroupTransactionsResult queryGroupTransactionsResult;
        @XmlElement(name = "QueryCustomerPointsLogResult")
        protected QueryCustomerPointsLogResult queryCustomerPointsLogResult;
        @XmlElement(name = "QueryCustomerPointsResult")
        protected QueryCustomerPointsResult queryCustomerPointsResult;
        @XmlElement(name = "AdjustCustomerPointsResult")
        protected AdjustCustomerPointsResult adjustCustomerPointsResult;
        @XmlElement(name = "QueryOrganizationPointsLogResult")
        protected QueryOrganizationPointsLogResult queryOrganizationPointsLogResult;
        @XmlElement(name = "QueryOrganizationPointsResult")
        protected QueryOrganizationPointsResult queryOrganizationPointsResult;
        @XmlElement(name = "AdjustOrganizationPointsResult")
        protected AdjustOrganizationPointsResult adjustOrganizationPointsResult;
        @XmlElement(name = "CreateGroupResult")
        protected CreateGroupResult createGroupResult;
        @XmlElement(name = "CreateGroupByCustomerResult")
        protected CreateGroupByCustomerResult createGroupByCustomerResult;
        @XmlElement(name = "UpdateGroupKYCResult")
        protected UpdateGroupKYCResult updateGroupKYCResult;
        @XmlElement(name = "ChangeGroupStatusResult")
        protected ChangeGroupStatusResult changeGroupStatusResult;
        @XmlElement(name = "AddGroupMemberResult")
        protected AddGroupMemberResult addGroupMemberResult;
        @XmlElement(name = "AddGroupMemberByGroupLeaderResult")
        protected AddGroupMemberByGroupLeaderResult addGroupMemberByGroupLeaderResult;
        @XmlElement(name = "RemoveGroupMemberResult")
        protected RemoveGroupMemberResult removeGroupMemberResult;
        @XmlElement(name = "RemoveGroupMemberByGroupLeaderResult")
        protected RemoveGroupMemberByGroupLeaderResult removeGroupMemberByGroupLeaderResult;
        @XmlElement(name = "ChangeGroupMemberRolesResult")
        protected ChangeGroupMemberRolesResult changeGroupMemberRolesResult;
        @XmlElement(name = "ChangeGroupMemberRolesByGroupLeaderResult")
        protected ChangeGroupMemberRolesByGroupLeaderResult changeGroupMemberRolesByGroupLeaderResult;
        @XmlElement(name = "ConfirmGroupMembershipResult")
        protected ConfirmGroupMembershipResult confirmGroupMembershipResult;
        @XmlElement(name = "ApproveGroupActionOrTransactionResult")
        protected ApproveGroupActionOrTransactionResult approveGroupActionOrTransactionResult;
        @XmlElement(name = "SearchMyGroupsResult")
        protected SearchMyGroupsResult searchMyGroupsResult;
        @XmlElement(name = "QueryGroupInfoResult")
        protected QueryGroupInfoResult queryGroupInfoResult;
        @XmlElement(name = "QueryGroupKYCResult")
        protected QueryGroupKYCResult queryGroupKYCResult;
        @XmlElement(name = "QueryGroupProductsResult")
        protected QueryGroupProductsResult queryGroupProductsResult;
        @XmlElement(name = "ListGroupMembersResult")
        protected ListGroupMembersResult listGroupMembersResult;
        @XmlElement(name = "ListGroupMembersByCustomerResult")
        protected ListGroupMembersByCustomerResult listGroupMembersByCustomerResult;
        @XmlElement(name = "ChangeGroupRuleProfileResult")
        protected ChangeGroupRuleProfileResult changeGroupRuleProfileResult;
        @XmlElement(name = "ChangeGroupChargeProfileResult")
        protected ChangeGroupChargeProfileResult changeGroupChargeProfileResult;
        @XmlElement(name = "ChangeGroupAccountRuleProfileResult")
        protected ChangeGroupAccountRuleProfileResult changeGroupAccountRuleProfileResult;
        @XmlElement(name = "IdentifyCustomerResult")
        protected IdentifyCustomerResult identifyCustomerResult;
        @XmlElement(name = "RaiseDisputedTxnReversalResult")
        protected RaiseDisputedTxnReversalResult raiseDisputedTxnReversalResult;
        @XmlElement(name = "CancelIssuedVoucherResult")
        protected CancelIssuedVoucherResult cancelIssuedVoucherResult;
        @XmlElement(name = "CreateCustomerBundleResult")
        protected CreateCustomerBundleResult createCustomerBundleResult;
        @XmlElement(name = "CreateOrganizationBundleResult")
        protected CreateOrganizationBundleResult createOrganizationBundleResult;
        @XmlElement(name = "CreateExternalProviderResult")
        protected CreateExternalProviderResult createExternalProviderResult;
        @XmlElement(name = "CreateGroupBundleResult")
        protected CreateGroupBundleResult createGroupBundleResult;
        @XmlElement(name = "CreateBankAccountResult")
        protected CreateBankAccountResult createBankAccountResult;
        @XmlElement(name = "DeleteBankAccountResult")
        protected DeleteBankAccountResult deleteBankAccountResult;
        @XmlElement(name = "SetDefaultBankAccountResult")
        protected SetDefaultBankAccountResult setDefaultBankAccountResult;
        @XmlElement(name = "QueryDirectDebitMandateResult")
        protected QueryDirectDebitMandateResult queryDirectDebitMandateResult;
        @XmlElement(name = "ViewDirectDebitMandateResult")
        protected ViewDirectDebitMandateResult viewDirectDebitMandateResult;
        @XmlElement(name = "QueryReminderScheduleResult")
        protected QueryReminderScheduleResult queryReminderScheduleResult;
        @XmlElement(name = "CCHChangeCustKYCResult")
        protected CCHChangeCustKYCResult cchChangeCustKYCResult;
        @XmlElement(name = "CCHChangeOrgOperatorKYCResult")
        protected CCHChangeOrgOperatorKYCResult cchChangeOrgOperatorKYCResult;
        @XmlElement(name = "PreValidationConfirmationResult")
        protected PreValidationConfirmationResult preValidationConfirmationResult;
        @XmlElement(name = "PreValidationResult")
        protected PreValidationResult preValidationResult;
        @XmlElement(name = "CreateOrgLoyaltyAccountResult")
        protected CreateOrgLoyaltyAccountResult createOrgLoyaltyAccountResult;
        @XmlElement(name = "CreateCustLoyaltyAccountResult")
        protected CreateCustLoyaltyAccountResult createCustLoyaltyAccountResult;
        @XmlElement(name = "CreateGroupLoyaltyAccountResult")
        protected CreateGroupLoyaltyAccountResult createGroupLoyaltyAccountResult;
        @XmlElement(name = "QueryCustLoyaltyPointResult")
        protected QueryCustLoyaltyPointResult queryCustLoyaltyPointResult;
        @XmlElement(name = "QueryOrgLoyaltyPointResult")
        protected QueryOrgLoyaltyPointResult queryOrgLoyaltyPointResult;
        @XmlElement(name = "QueryGroupLoyaltyPointResult")
        protected QueryGroupLoyaltyPointResult queryGroupLoyaltyPointResult;
        @XmlElement(name = "QueryLoyaltyConsumerByOrgOperatorResult")
        protected QueryLoyaltyConsumerResult queryLoyaltyConsumerByOrgOperatorResult;
        @XmlElement(name = "QueryCustLoyaltyPointStatementResult")
        protected QueryCustLoyaltyPointStatementResult queryCustLoyaltyPointStatementResult;
        @XmlElement(name = "QueryOrgLoyaltyPointStatementResult")
        protected QueryOrgLoyaltyPointStatementResult queryOrgLoyaltyPointStatementResult;
        @XmlElement(name = "QueryGroupLoyaltyPointStatementResult")
        protected QueryGroupLoyaltyPointStatementResult queryGroupLoyaltyPointStatementResult;
        @XmlElement(name = "QueryLoyaltyConsumerStatementByOrgOperatorResult")
        protected QueryLoyaltyConsumerStatementResult queryLoyaltyConsumerStatementByOrgOperatorResult;
        @XmlElement(name = "QueryIdentityBundleResult")
        protected QueryIdentityBundleResult queryIdentityBundleResult;
        @XmlElement(name = "CCHIdentifyCustomerResult")
        protected CCHIdentifyCustomerResult cchIdentifyCustomerResult;
        @XmlElement(name = "CCHIdentifyOperatorResult")
        protected CCHIdentifyOperatorResult cchIdentifyOperatorResult;
        @XmlElement(name = "UpdateOrgOperatorOwnKYCResult")
        protected UpdateOrgOperatorOwnKYCResult updateOrgOperatorOwnKYCResult;
        @XmlElement(name = "QuerySavingPlanForCustomerResult")
        protected QuerySavingPlanForCustomerResult querySavingPlanForCustomerResult;
        @XmlElement(name = "QuerySavingPlanForGroupResult")
        protected QuerySavingPlanForGroupResult querySavingPlanForGroupResult;
        @XmlElement(name = "QuerySavingPlanForOrganizationResult")
        protected QuerySavingPlanForOrganizationResult querySavingPlanForOrganizationResult;
        @XmlElement(name = "QueryTransferPointsFeeResult")
        protected QueryTransferPointsFeeResult queryTransferPointsFeeResult;
        @XmlElement(name = "QueryRedeemBalanceRateResult")
        protected QueryRedeemBalanceRateResult queryRedeemBalanceRateResult;
        @XmlElement(name = "TransferPointsResult")
        protected TransferPointsResult transferPointsResult;
        @XmlElement(name = "RedeemPointsToGoodsResult")
        protected RedeemPointsToGoodsResult redeemPointsToGoodsResult;
        @XmlElement(name = "RedeemPointsWithVoucherResult")
        protected RedeemPointsWithVoucherResult redeemPointsWithVoucherResult;
        @XmlElement(name = "RedeemPointsToBalanceResult")
        protected RedeemPointsToBalanceResult redeemPointsToBalanceResult;
        @XmlElement(name = "SubscribeSavingPlanForCustomerResult")
        protected SubscribeSavingPlanForCustomerResult subscribeSavingPlanForCustomerResult;
        @XmlElement(name = "SubscribeSavingPlanForGroupResult")
        protected SubscribeSavingPlanForGroupResult subscribeSavingPlanForGroupResult;
        @XmlElement(name = "SubscribeSavingPlanForOrgResult")
        protected SubscribeSavingPlanForOrgResult subscribeSavingPlanForOrgResult;
        @XmlElement(name = "UnSubscribeSavingPlanForCustomerResult")
        protected UnSubscribeSavingPlanForCustomerResult unSubscribeSavingPlanForCustomerResult;
        @XmlElement(name = "UnSubscribeSavingPlanForGroupResult")
        protected UnSubscribeSavingPlanForGroupResult unSubscribeSavingPlanForGroupResult;
        @XmlElement(name = "UnSubscribeSavingPlanForOrgResult")
        protected UnSubscribeSavingPlanForOrgResult unSubscribeSavingPlanForOrgResult;
        @XmlElement(name = "ValidateTokenResult")
        protected ValidateTokenResult validateTokenResult;
        @XmlElement(name = "ReferenceData")
        protected Result.Body.ReferenceData referenceData;

        /**
         * Gets the value of the resultType property.
         * 
         * @return
         *     possible object is
         *     {@link BigInteger }
         *     
         */
        public BigInteger getResultType() {
            return resultType;
        }

        /**
         * Sets the value of the resultType property.
         * 
         * @param value
         *     allowed object is
         *     {@link BigInteger }
         *     
         */
        public void setResultType(BigInteger value) {
            this.resultType = value;
        }

        /**
         * Gets the value of the resultCode property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getResultCode() {
            return resultCode;
        }

        /**
         * Sets the value of the resultCode property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setResultCode(String value) {
            this.resultCode = value;
        }

        /**
         * Gets the value of the resultDesc property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getResultDesc() {
            return resultDesc;
        }

        /**
         * Sets the value of the resultDesc property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setResultDesc(String value) {
            this.resultDesc = value;
        }

        /**
         * Gets the value of the resultParameters property.
         * 
         * @return
         *     possible object is
         *     {@link Result.Body.ResultParameters }
         *     
         */
        public Result.Body.ResultParameters getResultParameters() {
            return resultParameters;
        }

        /**
         * Sets the value of the resultParameters property.
         * 
         * @param value
         *     allowed object is
         *     {@link Result.Body.ResultParameters }
         *     
         */
        public void setResultParameters(Result.Body.ResultParameters value) {
            this.resultParameters = value;
        }

        /**
         * Gets the value of the taskID property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getTaskID() {
            return taskID;
        }

        /**
         * Sets the value of the taskID property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setTaskID(String value) {
            this.taskID = value;
        }

        /**
         * Gets the value of the workflowID property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getWorkflowID() {
            return workflowID;
        }

        /**
         * Sets the value of the workflowID property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setWorkflowID(String value) {
            this.workflowID = value;
        }

        /**
         * Gets the value of the encryptedParameters property.
         * 
         * @return
         *     possible object is
         *     byte[]
         */
        public byte[] getEncryptedParameters() {
            return encryptedParameters;
        }

        /**
         * Sets the value of the encryptedParameters property.
         * 
         * @param value
         *     allowed object is
         *     byte[]
         */
        public void setEncryptedParameters(byte[] value) {
            this.encryptedParameters = value;
        }

        /**
         * Gets the value of the transactionResult property.
         * 
         * @return
         *     possible object is
         *     {@link Result.Body.TransactionResult }
         *     
         */
        public Result.Body.TransactionResult getTransactionResult() {
            return transactionResult;
        }

        /**
         * Sets the value of the transactionResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link Result.Body.TransactionResult }
         *     
         */
        public void setTransactionResult(Result.Body.TransactionResult value) {
            this.transactionResult = value;
        }

        /**
         * Gets the value of the changeCustomerMSISDNResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerMSISDNResult }
         *     
         */
        public ChangeCustomerMSISDNResult getChangeCustomerMSISDNResult() {
            return changeCustomerMSISDNResult;
        }

        /**
         * Sets the value of the changeCustomerMSISDNResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerMSISDNResult }
         *     
         */
        public void setChangeCustomerMSISDNResult(ChangeCustomerMSISDNResult value) {
            this.changeCustomerMSISDNResult = value;
        }

        /**
         * Gets the value of the changeTillMSISDNResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeTillMSISDNResult }
         *     
         */
        public ChangeTillMSISDNResult getChangeTillMSISDNResult() {
            return changeTillMSISDNResult;
        }

        /**
         * Sets the value of the changeTillMSISDNResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeTillMSISDNResult }
         *     
         */
        public void setChangeTillMSISDNResult(ChangeTillMSISDNResult value) {
            this.changeTillMSISDNResult = value;
        }

        /**
         * Gets the value of the changeAccountStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeAccountStatusResult }
         *     
         */
        public ChangeAccountStatusResult getChangeAccountStatusResult() {
            return changeAccountStatusResult;
        }

        /**
         * Sets the value of the changeAccountStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeAccountStatusResult }
         *     
         */
        public void setChangeAccountStatusResult(ChangeAccountStatusResult value) {
            this.changeAccountStatusResult = value;
        }

        /**
         * Gets the value of the updateCustomerKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateCustomerKYCResult }
         *     
         */
        public UpdateCustomerKYCResult getUpdateCustomerKYCResult() {
            return updateCustomerKYCResult;
        }

        /**
         * Sets the value of the updateCustomerKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateCustomerKYCResult }
         *     
         */
        public void setUpdateCustomerKYCResult(UpdateCustomerKYCResult value) {
            this.updateCustomerKYCResult = value;
        }

        /**
         * Gets the value of the updateOrganizationKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrganizationKYCResult }
         *     
         */
        public UpdateOrganizationKYCResult getUpdateOrganizationKYCResult() {
            return updateOrganizationKYCResult;
        }

        /**
         * Sets the value of the updateOrganizationKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrganizationKYCResult }
         *     
         */
        public void setUpdateOrganizationKYCResult(UpdateOrganizationKYCResult value) {
            this.updateOrganizationKYCResult = value;
        }

        /**
         * Gets the value of the queryCustomerKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerKYCResult }
         *     
         */
        public QueryCustomerKYCResult getQueryCustomerKYCResult() {
            return queryCustomerKYCResult;
        }

        /**
         * Sets the value of the queryCustomerKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerKYCResult }
         *     
         */
        public void setQueryCustomerKYCResult(QueryCustomerKYCResult value) {
            this.queryCustomerKYCResult = value;
        }

        /**
         * Gets the value of the queryCustomerInfoResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerInfoResult }
         *     
         */
        public QueryCustomerInfoResult getQueryCustomerInfoResult() {
            return queryCustomerInfoResult;
        }

        /**
         * Sets the value of the queryCustomerInfoResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerInfoResult }
         *     
         */
        public void setQueryCustomerInfoResult(QueryCustomerInfoResult value) {
            this.queryCustomerInfoResult = value;
        }

        /**
         * Gets the value of the queryCustomerProductsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerProductsResult }
         *     
         */
        public QueryCustomerProductsResult getQueryCustomerProductsResult() {
            return queryCustomerProductsResult;
        }

        /**
         * Sets the value of the queryCustomerProductsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerProductsResult }
         *     
         */
        public void setQueryCustomerProductsResult(QueryCustomerProductsResult value) {
            this.queryCustomerProductsResult = value;
        }

        /**
         * Gets the value of the queryCustomerBalanceResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerBalanceResult }
         *     
         */
        public QueryCustomerBalanceResult getQueryCustomerBalanceResult() {
            return queryCustomerBalanceResult;
        }

        /**
         * Sets the value of the queryCustomerBalanceResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerBalanceResult }
         *     
         */
        public void setQueryCustomerBalanceResult(QueryCustomerBalanceResult value) {
            this.queryCustomerBalanceResult = value;
        }

        /**
         * Gets the value of the queryOrganizationKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationKYCResult }
         *     
         */
        public QueryOrganizationKYCResult getQueryOrganizationKYCResult() {
            return queryOrganizationKYCResult;
        }

        /**
         * Sets the value of the queryOrganizationKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationKYCResult }
         *     
         */
        public void setQueryOrganizationKYCResult(QueryOrganizationKYCResult value) {
            this.queryOrganizationKYCResult = value;
        }

        /**
         * Gets the value of the queryOrganizationInfoResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationInfoResult }
         *     
         */
        public QueryOrganizationInfoResult getQueryOrganizationInfoResult() {
            return queryOrganizationInfoResult;
        }

        /**
         * Sets the value of the queryOrganizationInfoResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationInfoResult }
         *     
         */
        public void setQueryOrganizationInfoResult(QueryOrganizationInfoResult value) {
            this.queryOrganizationInfoResult = value;
        }

        /**
         * Gets the value of the queryOrganizationProductsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationProductsResult }
         *     
         */
        public QueryOrganizationProductsResult getQueryOrganizationProductsResult() {
            return queryOrganizationProductsResult;
        }

        /**
         * Sets the value of the queryOrganizationProductsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationProductsResult }
         *     
         */
        public void setQueryOrganizationProductsResult(QueryOrganizationProductsResult value) {
            this.queryOrganizationProductsResult = value;
        }

        /**
         * Gets the value of the queryOrganizationBalanceResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationBalanceResult }
         *     
         */
        public QueryOrganizationBalanceResult getQueryOrganizationBalanceResult() {
            return queryOrganizationBalanceResult;
        }

        /**
         * Sets the value of the queryOrganizationBalanceResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationBalanceResult }
         *     
         */
        public void setQueryOrganizationBalanceResult(QueryOrganizationBalanceResult value) {
            this.queryOrganizationBalanceResult = value;
        }

        /**
         * Gets the value of the listOrganizationTillsResult property.
         * 
         * @return
         *     possible object is
         *     {@link ListOrganizationTillsResult }
         *     
         */
        public ListOrganizationTillsResult getListOrganizationTillsResult() {
            return listOrganizationTillsResult;
        }

        /**
         * Sets the value of the listOrganizationTillsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListOrganizationTillsResult }
         *     
         */
        public void setListOrganizationTillsResult(ListOrganizationTillsResult value) {
            this.listOrganizationTillsResult = value;
        }

        /**
         * Gets the value of the queryOrgOperatorKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrgOperatorKYCResult }
         *     
         */
        public QueryOrgOperatorKYCResult getQueryOrgOperatorKYCResult() {
            return queryOrgOperatorKYCResult;
        }

        /**
         * Sets the value of the queryOrgOperatorKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrgOperatorKYCResult }
         *     
         */
        public void setQueryOrgOperatorKYCResult(QueryOrgOperatorKYCResult value) {
            this.queryOrgOperatorKYCResult = value;
        }

        /**
         * Gets the value of the queryOrgOperatorInfoResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrgOperatorInfoResult }
         *     
         */
        public QueryOrgOperatorInfoResult getQueryOrgOperatorInfoResult() {
            return queryOrgOperatorInfoResult;
        }

        /**
         * Sets the value of the queryOrgOperatorInfoResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrgOperatorInfoResult }
         *     
         */
        public void setQueryOrgOperatorInfoResult(QueryOrgOperatorInfoResult value) {
            this.queryOrgOperatorInfoResult = value;
        }

        /**
         * Gets the value of the queryTillInfoResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryTillInfoResult }
         *     
         */
        public QueryTillInfoResult getQueryTillInfoResult() {
            return queryTillInfoResult;
        }

        /**
         * Sets the value of the queryTillInfoResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryTillInfoResult }
         *     
         */
        public void setQueryTillInfoResult(QueryTillInfoResult value) {
            this.queryTillInfoResult = value;
        }

        /**
         * Gets the value of the queryTillProductsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryTillProductsResult }
         *     
         */
        public QueryTillProductsResult getQueryTillProductsResult() {
            return queryTillProductsResult;
        }

        /**
         * Sets the value of the queryTillProductsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryTillProductsResult }
         *     
         */
        public void setQueryTillProductsResult(QueryTillProductsResult value) {
            this.queryTillProductsResult = value;
        }

        /**
         * Gets the value of the changeCustomerStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerStatusResult }
         *     
         */
        public ChangeCustomerStatusResult getChangeCustomerStatusResult() {
            return changeCustomerStatusResult;
        }

        /**
         * Sets the value of the changeCustomerStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerStatusResult }
         *     
         */
        public void setChangeCustomerStatusResult(ChangeCustomerStatusResult value) {
            this.changeCustomerStatusResult = value;
        }

        /**
         * Gets the value of the changeOrganizationStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrganizationStatusResult }
         *     
         */
        public ChangeOrganizationStatusResult getChangeOrganizationStatusResult() {
            return changeOrganizationStatusResult;
        }

        /**
         * Sets the value of the changeOrganizationStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrganizationStatusResult }
         *     
         */
        public void setChangeOrganizationStatusResult(ChangeOrganizationStatusResult value) {
            this.changeOrganizationStatusResult = value;
        }

        /**
         * Gets the value of the changeTillStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeTillStatusResult }
         *     
         */
        public ChangeTillStatusResult getChangeTillStatusResult() {
            return changeTillStatusResult;
        }

        /**
         * Sets the value of the changeTillStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeTillStatusResult }
         *     
         */
        public void setChangeTillStatusResult(ChangeTillStatusResult value) {
            this.changeTillStatusResult = value;
        }

        /**
         * Gets the value of the changeSPOperatorStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeSPOperatorStatusResult }
         *     
         */
        public ChangeSPOperatorStatusResult getChangeSPOperatorStatusResult() {
            return changeSPOperatorStatusResult;
        }

        /**
         * Sets the value of the changeSPOperatorStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeSPOperatorStatusResult }
         *     
         */
        public void setChangeSPOperatorStatusResult(ChangeSPOperatorStatusResult value) {
            this.changeSPOperatorStatusResult = value;
        }

        /**
         * Gets the value of the changeOrgOperatorStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgOperatorStatusResult }
         *     
         */
        public ChangeOrgOperatorStatusResult getChangeOrgOperatorStatusResult() {
            return changeOrgOperatorStatusResult;
        }

        /**
         * Sets the value of the changeOrgOperatorStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgOperatorStatusResult }
         *     
         */
        public void setChangeOrgOperatorStatusResult(ChangeOrgOperatorStatusResult value) {
            this.changeOrgOperatorStatusResult = value;
        }

        /**
         * Gets the value of the updateSPOperatorKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateSPOperatorKYCResult }
         *     
         */
        public UpdateSPOperatorKYCResult getUpdateSPOperatorKYCResult() {
            return updateSPOperatorKYCResult;
        }

        /**
         * Sets the value of the updateSPOperatorKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateSPOperatorKYCResult }
         *     
         */
        public void setUpdateSPOperatorKYCResult(UpdateSPOperatorKYCResult value) {
            this.updateSPOperatorKYCResult = value;
        }

        /**
         * Gets the value of the updateOrgOperatorKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrgOperatorKYCResult }
         *     
         */
        public UpdateOrgOperatorKYCResult getUpdateOrgOperatorKYCResult() {
            return updateOrgOperatorKYCResult;
        }

        /**
         * Sets the value of the updateOrgOperatorKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrgOperatorKYCResult }
         *     
         */
        public void setUpdateOrgOperatorKYCResult(UpdateOrgOperatorKYCResult value) {
            this.updateOrgOperatorKYCResult = value;
        }

        /**
         * Gets the value of the updateCustomerProductsResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateCustomerProductsResult }
         *     
         */
        public UpdateCustomerProductsResult getUpdateCustomerProductsResult() {
            return updateCustomerProductsResult;
        }

        /**
         * Sets the value of the updateCustomerProductsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateCustomerProductsResult }
         *     
         */
        public void setUpdateCustomerProductsResult(UpdateCustomerProductsResult value) {
            this.updateCustomerProductsResult = value;
        }

        /**
         * Gets the value of the updateOrganizationProductsResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrganizationProductsResult }
         *     
         */
        public UpdateOrganizationProductsResult getUpdateOrganizationProductsResult() {
            return updateOrganizationProductsResult;
        }

        /**
         * Sets the value of the updateOrganizationProductsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrganizationProductsResult }
         *     
         */
        public void setUpdateOrganizationProductsResult(UpdateOrganizationProductsResult value) {
            this.updateOrganizationProductsResult = value;
        }

        /**
         * Gets the value of the updateTillProductsResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateTillProductsResult }
         *     
         */
        public UpdateTillProductsResult getUpdateTillProductsResult() {
            return updateTillProductsResult;
        }

        /**
         * Sets the value of the updateTillProductsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateTillProductsResult }
         *     
         */
        public void setUpdateTillProductsResult(UpdateTillProductsResult value) {
            this.updateTillProductsResult = value;
        }

        /**
         * Gets the value of the registerCustomerResult property.
         * 
         * @return
         *     possible object is
         *     {@link RegisterCustomerResult }
         *     
         */
        public RegisterCustomerResult getRegisterCustomerResult() {
            return registerCustomerResult;
        }

        /**
         * Sets the value of the registerCustomerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link RegisterCustomerResult }
         *     
         */
        public void setRegisterCustomerResult(RegisterCustomerResult value) {
            this.registerCustomerResult = value;
        }

        /**
         * Gets the value of the recycleMSISDNResult property.
         * 
         * @return
         *     possible object is
         *     {@link RecycleMSISDNResult }
         *     
         */
        public RecycleMSISDNResult getRecycleMSISDNResult() {
            return recycleMSISDNResult;
        }

        /**
         * Sets the value of the recycleMSISDNResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link RecycleMSISDNResult }
         *     
         */
        public void setRecycleMSISDNResult(RecycleMSISDNResult value) {
            this.recycleMSISDNResult = value;
        }

        /**
         * Gets the value of the listOrganizationChildStoresResult property.
         * 
         * @return
         *     possible object is
         *     {@link ListOrganizationChildStoresResult }
         *     
         */
        public ListOrganizationChildStoresResult getListOrganizationChildStoresResult() {
            return listOrganizationChildStoresResult;
        }

        /**
         * Sets the value of the listOrganizationChildStoresResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListOrganizationChildStoresResult }
         *     
         */
        public void setListOrganizationChildStoresResult(ListOrganizationChildStoresResult value) {
            this.listOrganizationChildStoresResult = value;
        }

        /**
         * Gets the value of the listOrganizationOperatorsResult property.
         * 
         * @return
         *     possible object is
         *     {@link ListOrganizationOperatorsResult }
         *     
         */
        public ListOrganizationOperatorsResult getListOrganizationOperatorsResult() {
            return listOrganizationOperatorsResult;
        }

        /**
         * Sets the value of the listOrganizationOperatorsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListOrganizationOperatorsResult }
         *     
         */
        public void setListOrganizationOperatorsResult(ListOrganizationOperatorsResult value) {
            this.listOrganizationOperatorsResult = value;
        }

        /**
         * Gets the value of the updateSPOperatorRoleResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateSPOperatorRoleResult }
         *     
         */
        public UpdateSPOperatorRoleResult getUpdateSPOperatorRoleResult() {
            return updateSPOperatorRoleResult;
        }

        /**
         * Sets the value of the updateSPOperatorRoleResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateSPOperatorRoleResult }
         *     
         */
        public void setUpdateSPOperatorRoleResult(UpdateSPOperatorRoleResult value) {
            this.updateSPOperatorRoleResult = value;
        }

        /**
         * Gets the value of the updateOrgOperatorRoleResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrgOperatorRoleResult }
         *     
         */
        public UpdateOrgOperatorRoleResult getUpdateOrgOperatorRoleResult() {
            return updateOrgOperatorRoleResult;
        }

        /**
         * Sets the value of the updateOrgOperatorRoleResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrgOperatorRoleResult }
         *     
         */
        public void setUpdateOrgOperatorRoleResult(UpdateOrgOperatorRoleResult value) {
            this.updateOrgOperatorRoleResult = value;
        }

        /**
         * Gets the value of the updateOrgTaxExemptionResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrgTaxExemptionResult }
         *     
         */
        public UpdateOrgTaxExemptionResult getUpdateOrgTaxExemptionResult() {
            return updateOrgTaxExemptionResult;
        }

        /**
         * Sets the value of the updateOrgTaxExemptionResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrgTaxExemptionResult }
         *     
         */
        public void setUpdateOrgTaxExemptionResult(UpdateOrgTaxExemptionResult value) {
            this.updateOrgTaxExemptionResult = value;
        }

        /**
         * Gets the value of the queryO2CLinkResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryO2CLinkResult }
         *     
         */
        public QueryO2CLinkResult getQueryO2CLinkResult() {
            return queryO2CLinkResult;
        }

        /**
         * Sets the value of the queryO2CLinkResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryO2CLinkResult }
         *     
         */
        public void setQueryO2CLinkResult(QueryO2CLinkResult value) {
            this.queryO2CLinkResult = value;
        }

        /**
         * Gets the value of the addO2CLinkResult property.
         * 
         * @return
         *     possible object is
         *     {@link AddO2CLinkResult }
         *     
         */
        public AddO2CLinkResult getAddO2CLinkResult() {
            return addO2CLinkResult;
        }

        /**
         * Sets the value of the addO2CLinkResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddO2CLinkResult }
         *     
         */
        public void setAddO2CLinkResult(AddO2CLinkResult value) {
            this.addO2CLinkResult = value;
        }

        /**
         * Gets the value of the deleteO2CLinkResult property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteO2CLinkResult }
         *     
         */
        public DeleteO2CLinkResult getDeleteO2CLinkResult() {
            return deleteO2CLinkResult;
        }

        /**
         * Sets the value of the deleteO2CLinkResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteO2CLinkResult }
         *     
         */
        public void setDeleteO2CLinkResult(DeleteO2CLinkResult value) {
            this.deleteO2CLinkResult = value;
        }

        /**
         * Gets the value of the verifyCCCallerResult property.
         * 
         * @return
         *     possible object is
         *     {@link VerifyCCCallerResult }
         *     
         */
        public VerifyCCCallerResult getVerifyCCCallerResult() {
            return verifyCCCallerResult;
        }

        /**
         * Sets the value of the verifyCCCallerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link VerifyCCCallerResult }
         *     
         */
        public void setVerifyCCCallerResult(VerifyCCCallerResult value) {
            this.verifyCCCallerResult = value;
        }

        /**
         * Gets the value of the unlockCustomerPINResult property.
         * 
         * @return
         *     possible object is
         *     {@link UnlockCustomerPINResult }
         *     
         */
        public UnlockCustomerPINResult getUnlockCustomerPINResult() {
            return unlockCustomerPINResult;
        }

        /**
         * Sets the value of the unlockCustomerPINResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnlockCustomerPINResult }
         *     
         */
        public void setUnlockCustomerPINResult(UnlockCustomerPINResult value) {
            this.unlockCustomerPINResult = value;
        }

        /**
         * Gets the value of the unlockOrgOperatorPINResult property.
         * 
         * @return
         *     possible object is
         *     {@link UnlockOrgOperatorPINResult }
         *     
         */
        public UnlockOrgOperatorPINResult getUnlockOrgOperatorPINResult() {
            return unlockOrgOperatorPINResult;
        }

        /**
         * Sets the value of the unlockOrgOperatorPINResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnlockOrgOperatorPINResult }
         *     
         */
        public void setUnlockOrgOperatorPINResult(UnlockOrgOperatorPINResult value) {
            this.unlockOrgOperatorPINResult = value;
        }

        /**
         * Gets the value of the unlockOrgOperatorPasswordResult property.
         * 
         * @return
         *     possible object is
         *     {@link UnlockOrgOperatorPasswordResult }
         *     
         */
        public UnlockOrgOperatorPasswordResult getUnlockOrgOperatorPasswordResult() {
            return unlockOrgOperatorPasswordResult;
        }

        /**
         * Sets the value of the unlockOrgOperatorPasswordResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnlockOrgOperatorPasswordResult }
         *     
         */
        public void setUnlockOrgOperatorPasswordResult(UnlockOrgOperatorPasswordResult value) {
            this.unlockOrgOperatorPasswordResult = value;
        }

        /**
         * Gets the value of the resetCustomerPINResult property.
         * 
         * @return
         *     possible object is
         *     {@link ResetCustomerPINResult }
         *     
         */
        public ResetCustomerPINResult getResetCustomerPINResult() {
            return resetCustomerPINResult;
        }

        /**
         * Sets the value of the resetCustomerPINResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ResetCustomerPINResult }
         *     
         */
        public void setResetCustomerPINResult(ResetCustomerPINResult value) {
            this.resetCustomerPINResult = value;
        }

        /**
         * Gets the value of the resetOrgOperatorPINResult property.
         * 
         * @return
         *     possible object is
         *     {@link ResetOrgOperatorPINResult }
         *     
         */
        public ResetOrgOperatorPINResult getResetOrgOperatorPINResult() {
            return resetOrgOperatorPINResult;
        }

        /**
         * Sets the value of the resetOrgOperatorPINResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ResetOrgOperatorPINResult }
         *     
         */
        public void setResetOrgOperatorPINResult(ResetOrgOperatorPINResult value) {
            this.resetOrgOperatorPINResult = value;
        }

        /**
         * Gets the value of the resetOrgOperatorPasswordResult property.
         * 
         * @return
         *     possible object is
         *     {@link ResetOrgOperatorPasswordResult }
         *     
         */
        public ResetOrgOperatorPasswordResult getResetOrgOperatorPasswordResult() {
            return resetOrgOperatorPasswordResult;
        }

        /**
         * Sets the value of the resetOrgOperatorPasswordResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ResetOrgOperatorPasswordResult }
         *     
         */
        public void setResetOrgOperatorPasswordResult(ResetOrgOperatorPasswordResult value) {
            this.resetOrgOperatorPasswordResult = value;
        }

        /**
         * Gets the value of the resetCustomerSecretWordResult property.
         * 
         * @return
         *     possible object is
         *     {@link ResetCustomerSecretWordResult }
         *     
         */
        public ResetCustomerSecretWordResult getResetCustomerSecretWordResult() {
            return resetCustomerSecretWordResult;
        }

        /**
         * Sets the value of the resetCustomerSecretWordResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ResetCustomerSecretWordResult }
         *     
         */
        public void setResetCustomerSecretWordResult(ResetCustomerSecretWordResult value) {
            this.resetCustomerSecretWordResult = value;
        }

        /**
         * Gets the value of the releaseCustomerCCSuspendStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link ReleaseCustomerCCSuspendStatusResult }
         *     
         */
        public ReleaseCustomerCCSuspendStatusResult getReleaseCustomerCCSuspendStatusResult() {
            return releaseCustomerCCSuspendStatusResult;
        }

        /**
         * Sets the value of the releaseCustomerCCSuspendStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ReleaseCustomerCCSuspendStatusResult }
         *     
         */
        public void setReleaseCustomerCCSuspendStatusResult(ReleaseCustomerCCSuspendStatusResult value) {
            this.releaseCustomerCCSuspendStatusResult = value;
        }

        /**
         * Gets the value of the releaseOrgOperatorCCSuspendStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link ReleaseOrgOperatorCCSuspendStatusResult }
         *     
         */
        public ReleaseOrgOperatorCCSuspendStatusResult getReleaseOrgOperatorCCSuspendStatusResult() {
            return releaseOrgOperatorCCSuspendStatusResult;
        }

        /**
         * Sets the value of the releaseOrgOperatorCCSuspendStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ReleaseOrgOperatorCCSuspendStatusResult }
         *     
         */
        public void setReleaseOrgOperatorCCSuspendStatusResult(ReleaseOrgOperatorCCSuspendStatusResult value) {
            this.releaseOrgOperatorCCSuspendStatusResult = value;
        }

        /**
         * Gets the value of the searchTransactionResult property.
         * 
         * @return
         *     possible object is
         *     {@link SearchTransactionResult }
         *     
         */
        public SearchTransactionResult getSearchTransactionResult() {
            return searchTransactionResult;
        }

        /**
         * Sets the value of the searchTransactionResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link SearchTransactionResult }
         *     
         */
        public void setSearchTransactionResult(SearchTransactionResult value) {
            this.searchTransactionResult = value;
        }

        /**
         * Gets the value of the reverseTransactionResult property.
         * 
         * @return
         *     possible object is
         *     {@link ReverseTransactionResult }
         *     
         */
        public ReverseTransactionResult getReverseTransactionResult() {
            return reverseTransactionResult;
        }

        /**
         * Sets the value of the reverseTransactionResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ReverseTransactionResult }
         *     
         */
        public void setReverseTransactionResult(ReverseTransactionResult value) {
            this.reverseTransactionResult = value;
        }

        /**
         * Gets the value of the confirmTransactionResult property.
         * 
         * @return
         *     possible object is
         *     {@link ConfirmTransactionResult }
         *     
         */
        public ConfirmTransactionResult getConfirmTransactionResult() {
            return confirmTransactionResult;
        }

        /**
         * Sets the value of the confirmTransactionResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ConfirmTransactionResult }
         *     
         */
        public void setConfirmTransactionResult(ConfirmTransactionResult value) {
            this.confirmTransactionResult = value;
        }

        /**
         * Gets the value of the queryCustomerAccountStatementsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerAccountStatementsResult }
         *     
         */
        public QueryCustomerAccountStatementsResult getQueryCustomerAccountStatementsResult() {
            return queryCustomerAccountStatementsResult;
        }

        /**
         * Sets the value of the queryCustomerAccountStatementsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerAccountStatementsResult }
         *     
         */
        public void setQueryCustomerAccountStatementsResult(QueryCustomerAccountStatementsResult value) {
            this.queryCustomerAccountStatementsResult = value;
        }

        /**
         * Gets the value of the queryCustomerTransactionsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerTransactionsResult }
         *     
         */
        public QueryCustomerTransactionsResult getQueryCustomerTransactionsResult() {
            return queryCustomerTransactionsResult;
        }

        /**
         * Sets the value of the queryCustomerTransactionsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerTransactionsResult }
         *     
         */
        public void setQueryCustomerTransactionsResult(QueryCustomerTransactionsResult value) {
            this.queryCustomerTransactionsResult = value;
        }

        /**
         * Gets the value of the queryOrganizationAccountStatementsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationAccountStatementsResult }
         *     
         */
        public QueryOrganizationAccountStatementsResult getQueryOrganizationAccountStatementsResult() {
            return queryOrganizationAccountStatementsResult;
        }

        /**
         * Sets the value of the queryOrganizationAccountStatementsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationAccountStatementsResult }
         *     
         */
        public void setQueryOrganizationAccountStatementsResult(QueryOrganizationAccountStatementsResult value) {
            this.queryOrganizationAccountStatementsResult = value;
        }

        /**
         * Gets the value of the queryOrganizationTransactionsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationTransactionsResult }
         *     
         */
        public QueryOrganizationTransactionsResult getQueryOrganizationTransactionsResult() {
            return queryOrganizationTransactionsResult;
        }

        /**
         * Sets the value of the queryOrganizationTransactionsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationTransactionsResult }
         *     
         */
        public void setQueryOrganizationTransactionsResult(QueryOrganizationTransactionsResult value) {
            this.queryOrganizationTransactionsResult = value;
        }

        /**
         * Gets the value of the queryResultMessageResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryResultMessageResult }
         *     
         */
        public QueryResultMessageResult getQueryResultMessageResult() {
            return queryResultMessageResult;
        }

        /**
         * Sets the value of the queryResultMessageResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryResultMessageResult }
         *     
         */
        public void setQueryResultMessageResult(QueryResultMessageResult value) {
            this.queryResultMessageResult = value;
        }

        /**
         * Gets the value of the updateTransactionStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateTransactionStatusResult }
         *     
         */
        public UpdateTransactionStatusResult getUpdateTransactionStatusResult() {
            return updateTransactionStatusResult;
        }

        /**
         * Sets the value of the updateTransactionStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateTransactionStatusResult }
         *     
         */
        public void setUpdateTransactionStatusResult(UpdateTransactionStatusResult value) {
            this.updateTransactionStatusResult = value;
        }

        /**
         * Gets the value of the changeCustomerPINResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerPINResult }
         *     
         */
        public ChangeCustomerPINResult getChangeCustomerPINResult() {
            return changeCustomerPINResult;
        }

        /**
         * Sets the value of the changeCustomerPINResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerPINResult }
         *     
         */
        public void setChangeCustomerPINResult(ChangeCustomerPINResult value) {
            this.changeCustomerPINResult = value;
        }

        /**
         * Gets the value of the changeOrgOperatorPINResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgOperatorPINResult }
         *     
         */
        public ChangeOrgOperatorPINResult getChangeOrgOperatorPINResult() {
            return changeOrgOperatorPINResult;
        }

        /**
         * Sets the value of the changeOrgOperatorPINResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgOperatorPINResult }
         *     
         */
        public void setChangeOrgOperatorPINResult(ChangeOrgOperatorPINResult value) {
            this.changeOrgOperatorPINResult = value;
        }

        /**
         * Gets the value of the changeCustomerSecretWordResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerSecretWordResult }
         *     
         */
        public ChangeCustomerSecretWordResult getChangeCustomerSecretWordResult() {
            return changeCustomerSecretWordResult;
        }

        /**
         * Sets the value of the changeCustomerSecretWordResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerSecretWordResult }
         *     
         */
        public void setChangeCustomerSecretWordResult(ChangeCustomerSecretWordResult value) {
            this.changeCustomerSecretWordResult = value;
        }

        /**
         * Gets the value of the changeOrgOperatorSecretWordResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgOperatorSecretWordResult }
         *     
         */
        public ChangeOrgOperatorSecretWordResult getChangeOrgOperatorSecretWordResult() {
            return changeOrgOperatorSecretWordResult;
        }

        /**
         * Sets the value of the changeOrgOperatorSecretWordResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgOperatorSecretWordResult }
         *     
         */
        public void setChangeOrgOperatorSecretWordResult(ChangeOrgOperatorSecretWordResult value) {
            this.changeOrgOperatorSecretWordResult = value;
        }

        /**
         * Gets the value of the changeCustomerLanguageResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerLanguageResult }
         *     
         */
        public ChangeCustomerLanguageResult getChangeCustomerLanguageResult() {
            return changeCustomerLanguageResult;
        }

        /**
         * Sets the value of the changeCustomerLanguageResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerLanguageResult }
         *     
         */
        public void setChangeCustomerLanguageResult(ChangeCustomerLanguageResult value) {
            this.changeCustomerLanguageResult = value;
        }

        /**
         * Gets the value of the changeOrgOperatorLanguageResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgOperatorLanguageResult }
         *     
         */
        public ChangeOrgOperatorLanguageResult getChangeOrgOperatorLanguageResult() {
            return changeOrgOperatorLanguageResult;
        }

        /**
         * Sets the value of the changeOrgOperatorLanguageResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgOperatorLanguageResult }
         *     
         */
        public void setChangeOrgOperatorLanguageResult(ChangeOrgOperatorLanguageResult value) {
            this.changeOrgOperatorLanguageResult = value;
        }

        /**
         * Gets the value of the changeSPOperatorLanguageResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeSPOperatorLanguageResult }
         *     
         */
        public ChangeSPOperatorLanguageResult getChangeSPOperatorLanguageResult() {
            return changeSPOperatorLanguageResult;
        }

        /**
         * Sets the value of the changeSPOperatorLanguageResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeSPOperatorLanguageResult }
         *     
         */
        public void setChangeSPOperatorLanguageResult(ChangeSPOperatorLanguageResult value) {
            this.changeSPOperatorLanguageResult = value;
        }

        /**
         * Gets the value of the changeOrgnNameResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgnNameResult }
         *     
         */
        public ChangeOrgnNameResult getChangeOrgnNameResult() {
            return changeOrgnNameResult;
        }

        /**
         * Sets the value of the changeOrgnNameResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgnNameResult }
         *     
         */
        public void setChangeOrgnNameResult(ChangeOrgnNameResult value) {
            this.changeOrgnNameResult = value;
        }

        /**
         * Gets the value of the activateCustomerResult property.
         * 
         * @return
         *     possible object is
         *     {@link ActivateCustomerResult }
         *     
         */
        public ActivateCustomerResult getActivateCustomerResult() {
            return activateCustomerResult;
        }

        /**
         * Sets the value of the activateCustomerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ActivateCustomerResult }
         *     
         */
        public void setActivateCustomerResult(ActivateCustomerResult value) {
            this.activateCustomerResult = value;
        }

        /**
         * Gets the value of the activateTillResult property.
         * 
         * @return
         *     possible object is
         *     {@link ActivateTillResult }
         *     
         */
        public ActivateTillResult getActivateTillResult() {
            return activateTillResult;
        }

        /**
         * Sets the value of the activateTillResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ActivateTillResult }
         *     
         */
        public void setActivateTillResult(ActivateTillResult value) {
            this.activateTillResult = value;
        }

        /**
         * Gets the value of the addCustomerBeneficiaryResult property.
         * 
         * @return
         *     possible object is
         *     {@link AddCustomerBeneficiaryResult }
         *     
         */
        public AddCustomerBeneficiaryResult getAddCustomerBeneficiaryResult() {
            return addCustomerBeneficiaryResult;
        }

        /**
         * Sets the value of the addCustomerBeneficiaryResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddCustomerBeneficiaryResult }
         *     
         */
        public void setAddCustomerBeneficiaryResult(AddCustomerBeneficiaryResult value) {
            this.addCustomerBeneficiaryResult = value;
        }

        /**
         * Gets the value of the addOrgBeneficiaryResult property.
         * 
         * @return
         *     possible object is
         *     {@link AddOrgBeneficiaryResult }
         *     
         */
        public AddOrgBeneficiaryResult getAddOrgBeneficiaryResult() {
            return addOrgBeneficiaryResult;
        }

        /**
         * Sets the value of the addOrgBeneficiaryResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddOrgBeneficiaryResult }
         *     
         */
        public void setAddOrgBeneficiaryResult(AddOrgBeneficiaryResult value) {
            this.addOrgBeneficiaryResult = value;
        }

        /**
         * Gets the value of the deleteCustomerBeneficiaryResult property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteCustomerBeneficiaryResult }
         *     
         */
        public DeleteCustomerBeneficiaryResult getDeleteCustomerBeneficiaryResult() {
            return deleteCustomerBeneficiaryResult;
        }

        /**
         * Sets the value of the deleteCustomerBeneficiaryResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteCustomerBeneficiaryResult }
         *     
         */
        public void setDeleteCustomerBeneficiaryResult(DeleteCustomerBeneficiaryResult value) {
            this.deleteCustomerBeneficiaryResult = value;
        }

        /**
         * Gets the value of the deleteOrgBeneficiaryResult property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteOrgBeneficiaryResult }
         *     
         */
        public DeleteOrgBeneficiaryResult getDeleteOrgBeneficiaryResult() {
            return deleteOrgBeneficiaryResult;
        }

        /**
         * Sets the value of the deleteOrgBeneficiaryResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteOrgBeneficiaryResult }
         *     
         */
        public void setDeleteOrgBeneficiaryResult(DeleteOrgBeneficiaryResult value) {
            this.deleteOrgBeneficiaryResult = value;
        }

        /**
         * Gets the value of the lookupCustomerBeneficiaryResult property.
         * 
         * @return
         *     possible object is
         *     {@link LookupCustomerBeneficiaryResult }
         *     
         */
        public LookupCustomerBeneficiaryResult getLookupCustomerBeneficiaryResult() {
            return lookupCustomerBeneficiaryResult;
        }

        /**
         * Sets the value of the lookupCustomerBeneficiaryResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link LookupCustomerBeneficiaryResult }
         *     
         */
        public void setLookupCustomerBeneficiaryResult(LookupCustomerBeneficiaryResult value) {
            this.lookupCustomerBeneficiaryResult = value;
        }

        /**
         * Gets the value of the lookupOrgBeneficiaryResult property.
         * 
         * @return
         *     possible object is
         *     {@link LookupOrgBeneficiaryResult }
         *     
         */
        public LookupOrgBeneficiaryResult getLookupOrgBeneficiaryResult() {
            return lookupOrgBeneficiaryResult;
        }

        /**
         * Sets the value of the lookupOrgBeneficiaryResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link LookupOrgBeneficiaryResult }
         *     
         */
        public void setLookupOrgBeneficiaryResult(LookupOrgBeneficiaryResult value) {
            this.lookupOrgBeneficiaryResult = value;
        }

        /**
         * Gets the value of the addGroupBeneficiaryResult property.
         * 
         * @return
         *     possible object is
         *     {@link AddGroupBeneficiaryResult }
         *     
         */
        public AddGroupBeneficiaryResult getAddGroupBeneficiaryResult() {
            return addGroupBeneficiaryResult;
        }

        /**
         * Sets the value of the addGroupBeneficiaryResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddGroupBeneficiaryResult }
         *     
         */
        public void setAddGroupBeneficiaryResult(AddGroupBeneficiaryResult value) {
            this.addGroupBeneficiaryResult = value;
        }

        /**
         * Gets the value of the deleteGroupBeneficiaryResult property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteGroupBeneficiaryResult }
         *     
         */
        public DeleteGroupBeneficiaryResult getDeleteGroupBeneficiaryResult() {
            return deleteGroupBeneficiaryResult;
        }

        /**
         * Sets the value of the deleteGroupBeneficiaryResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteGroupBeneficiaryResult }
         *     
         */
        public void setDeleteGroupBeneficiaryResult(DeleteGroupBeneficiaryResult value) {
            this.deleteGroupBeneficiaryResult = value;
        }

        /**
         * Gets the value of the lookupGroupBeneficiaryResult property.
         * 
         * @return
         *     possible object is
         *     {@link LookupGroupBeneficiaryResult }
         *     
         */
        public LookupGroupBeneficiaryResult getLookupGroupBeneficiaryResult() {
            return lookupGroupBeneficiaryResult;
        }

        /**
         * Sets the value of the lookupGroupBeneficiaryResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link LookupGroupBeneficiaryResult }
         *     
         */
        public void setLookupGroupBeneficiaryResult(LookupGroupBeneficiaryResult value) {
            this.lookupGroupBeneficiaryResult = value;
        }

        /**
         * Gets the value of the createTopOrgResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateTopOrgResult }
         *     
         */
        public CreateTopOrgResult getCreateTopOrgResult() {
            return createTopOrgResult;
        }

        /**
         * Sets the value of the createTopOrgResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateTopOrgResult }
         *     
         */
        public void setCreateTopOrgResult(CreateTopOrgResult value) {
            this.createTopOrgResult = value;
        }

        /**
         * Gets the value of the createChildOrgResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateChildOrgResult }
         *     
         */
        public CreateChildOrgResult getCreateChildOrgResult() {
            return createChildOrgResult;
        }

        /**
         * Sets the value of the createChildOrgResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateChildOrgResult }
         *     
         */
        public void setCreateChildOrgResult(CreateChildOrgResult value) {
            this.createChildOrgResult = value;
        }

        /**
         * Gets the value of the createTillResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateTillResult }
         *     
         */
        public CreateTillResult getCreateTillResult() {
            return createTillResult;
        }

        /**
         * Sets the value of the createTillResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateTillResult }
         *     
         */
        public void setCreateTillResult(CreateTillResult value) {
            this.createTillResult = value;
        }

        /**
         * Gets the value of the changeTillLanguageResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeTillLanguageResult }
         *     
         */
        public ChangeTillLanguageResult getChangeTillLanguageResult() {
            return changeTillLanguageResult;
        }

        /**
         * Sets the value of the changeTillLanguageResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeTillLanguageResult }
         *     
         */
        public void setChangeTillLanguageResult(ChangeTillLanguageResult value) {
            this.changeTillLanguageResult = value;
        }

        /**
         * Gets the value of the createOrgOperatorResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateOrgOperatorResult }
         *     
         */
        public CreateOrgOperatorResult getCreateOrgOperatorResult() {
            return createOrgOperatorResult;
        }

        /**
         * Sets the value of the createOrgOperatorResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateOrgOperatorResult }
         *     
         */
        public void setCreateOrgOperatorResult(CreateOrgOperatorResult value) {
            this.createOrgOperatorResult = value;
        }

        /**
         * Gets the value of the recipientLookUpResult property.
         * 
         * @return
         *     possible object is
         *     {@link RecipientLookUpResult }
         *     
         */
        public RecipientLookUpResult getRecipientLookUpResult() {
            return recipientLookUpResult;
        }

        /**
         * Sets the value of the recipientLookUpResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link RecipientLookUpResult }
         *     
         */
        public void setRecipientLookUpResult(RecipientLookUpResult value) {
            this.recipientLookUpResult = value;
        }

        /**
         * Gets the value of the bulkTaskResult property.
         * 
         * @return
         *     possible object is
         *     {@link BulkTaskResult }
         *     
         */
        public BulkTaskResult getBulkTaskResult() {
            return bulkTaskResult;
        }

        /**
         * Sets the value of the bulkTaskResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link BulkTaskResult }
         *     
         */
        public void setBulkTaskResult(BulkTaskResult value) {
            this.bulkTaskResult = value;
        }

        /**
         * Gets the value of the changeTillDefaultOperatorIDResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeTillDefaultOperatorIDResult }
         *     
         */
        public ChangeTillDefaultOperatorIDResult getChangeTillDefaultOperatorIDResult() {
            return changeTillDefaultOperatorIDResult;
        }

        /**
         * Sets the value of the changeTillDefaultOperatorIDResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeTillDefaultOperatorIDResult }
         *     
         */
        public void setChangeTillDefaultOperatorIDResult(ChangeTillDefaultOperatorIDResult value) {
            this.changeTillDefaultOperatorIDResult = value;
        }

        /**
         * Gets the value of the customerGetStartPINResult property.
         * 
         * @return
         *     possible object is
         *     {@link CustomerGetStartPINResult }
         *     
         */
        public CustomerGetStartPINResult getCustomerGetStartPINResult() {
            return customerGetStartPINResult;
        }

        /**
         * Sets the value of the customerGetStartPINResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CustomerGetStartPINResult }
         *     
         */
        public void setCustomerGetStartPINResult(CustomerGetStartPINResult value) {
            this.customerGetStartPINResult = value;
        }

        /**
         * Gets the value of the queryGroupBalanceResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupBalanceResult }
         *     
         */
        public QueryGroupBalanceResult getQueryGroupBalanceResult() {
            return queryGroupBalanceResult;
        }

        /**
         * Sets the value of the queryGroupBalanceResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupBalanceResult }
         *     
         */
        public void setQueryGroupBalanceResult(QueryGroupBalanceResult value) {
            this.queryGroupBalanceResult = value;
        }

        /**
         * Gets the value of the queryGroupAccountStatementsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupAccountStatementsResult }
         *     
         */
        public QueryGroupAccountStatementsResult getQueryGroupAccountStatementsResult() {
            return queryGroupAccountStatementsResult;
        }

        /**
         * Sets the value of the queryGroupAccountStatementsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupAccountStatementsResult }
         *     
         */
        public void setQueryGroupAccountStatementsResult(QueryGroupAccountStatementsResult value) {
            this.queryGroupAccountStatementsResult = value;
        }

        /**
         * Gets the value of the queryGroupTransactionsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupTransactionsResult }
         *     
         */
        public QueryGroupTransactionsResult getQueryGroupTransactionsResult() {
            return queryGroupTransactionsResult;
        }

        /**
         * Sets the value of the queryGroupTransactionsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupTransactionsResult }
         *     
         */
        public void setQueryGroupTransactionsResult(QueryGroupTransactionsResult value) {
            this.queryGroupTransactionsResult = value;
        }

        /**
         * Gets the value of the queryCustomerPointsLogResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerPointsLogResult }
         *     
         */
        public QueryCustomerPointsLogResult getQueryCustomerPointsLogResult() {
            return queryCustomerPointsLogResult;
        }

        /**
         * Sets the value of the queryCustomerPointsLogResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerPointsLogResult }
         *     
         */
        public void setQueryCustomerPointsLogResult(QueryCustomerPointsLogResult value) {
            this.queryCustomerPointsLogResult = value;
        }

        /**
         * Gets the value of the queryCustomerPointsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerPointsResult }
         *     
         */
        public QueryCustomerPointsResult getQueryCustomerPointsResult() {
            return queryCustomerPointsResult;
        }

        /**
         * Sets the value of the queryCustomerPointsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerPointsResult }
         *     
         */
        public void setQueryCustomerPointsResult(QueryCustomerPointsResult value) {
            this.queryCustomerPointsResult = value;
        }

        /**
         * Gets the value of the adjustCustomerPointsResult property.
         * 
         * @return
         *     possible object is
         *     {@link AdjustCustomerPointsResult }
         *     
         */
        public AdjustCustomerPointsResult getAdjustCustomerPointsResult() {
            return adjustCustomerPointsResult;
        }

        /**
         * Sets the value of the adjustCustomerPointsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link AdjustCustomerPointsResult }
         *     
         */
        public void setAdjustCustomerPointsResult(AdjustCustomerPointsResult value) {
            this.adjustCustomerPointsResult = value;
        }

        /**
         * Gets the value of the queryOrganizationPointsLogResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationPointsLogResult }
         *     
         */
        public QueryOrganizationPointsLogResult getQueryOrganizationPointsLogResult() {
            return queryOrganizationPointsLogResult;
        }

        /**
         * Sets the value of the queryOrganizationPointsLogResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationPointsLogResult }
         *     
         */
        public void setQueryOrganizationPointsLogResult(QueryOrganizationPointsLogResult value) {
            this.queryOrganizationPointsLogResult = value;
        }

        /**
         * Gets the value of the queryOrganizationPointsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationPointsResult }
         *     
         */
        public QueryOrganizationPointsResult getQueryOrganizationPointsResult() {
            return queryOrganizationPointsResult;
        }

        /**
         * Sets the value of the queryOrganizationPointsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationPointsResult }
         *     
         */
        public void setQueryOrganizationPointsResult(QueryOrganizationPointsResult value) {
            this.queryOrganizationPointsResult = value;
        }

        /**
         * Gets the value of the adjustOrganizationPointsResult property.
         * 
         * @return
         *     possible object is
         *     {@link AdjustOrganizationPointsResult }
         *     
         */
        public AdjustOrganizationPointsResult getAdjustOrganizationPointsResult() {
            return adjustOrganizationPointsResult;
        }

        /**
         * Sets the value of the adjustOrganizationPointsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link AdjustOrganizationPointsResult }
         *     
         */
        public void setAdjustOrganizationPointsResult(AdjustOrganizationPointsResult value) {
            this.adjustOrganizationPointsResult = value;
        }

        /**
         * Gets the value of the createGroupResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateGroupResult }
         *     
         */
        public CreateGroupResult getCreateGroupResult() {
            return createGroupResult;
        }

        /**
         * Sets the value of the createGroupResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateGroupResult }
         *     
         */
        public void setCreateGroupResult(CreateGroupResult value) {
            this.createGroupResult = value;
        }

        /**
         * Gets the value of the createGroupByCustomerResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateGroupByCustomerResult }
         *     
         */
        public CreateGroupByCustomerResult getCreateGroupByCustomerResult() {
            return createGroupByCustomerResult;
        }

        /**
         * Sets the value of the createGroupByCustomerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateGroupByCustomerResult }
         *     
         */
        public void setCreateGroupByCustomerResult(CreateGroupByCustomerResult value) {
            this.createGroupByCustomerResult = value;
        }

        /**
         * Gets the value of the updateGroupKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateGroupKYCResult }
         *     
         */
        public UpdateGroupKYCResult getUpdateGroupKYCResult() {
            return updateGroupKYCResult;
        }

        /**
         * Sets the value of the updateGroupKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateGroupKYCResult }
         *     
         */
        public void setUpdateGroupKYCResult(UpdateGroupKYCResult value) {
            this.updateGroupKYCResult = value;
        }

        /**
         * Gets the value of the changeGroupStatusResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupStatusResult }
         *     
         */
        public ChangeGroupStatusResult getChangeGroupStatusResult() {
            return changeGroupStatusResult;
        }

        /**
         * Sets the value of the changeGroupStatusResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupStatusResult }
         *     
         */
        public void setChangeGroupStatusResult(ChangeGroupStatusResult value) {
            this.changeGroupStatusResult = value;
        }

        /**
         * Gets the value of the addGroupMemberResult property.
         * 
         * @return
         *     possible object is
         *     {@link AddGroupMemberResult }
         *     
         */
        public AddGroupMemberResult getAddGroupMemberResult() {
            return addGroupMemberResult;
        }

        /**
         * Sets the value of the addGroupMemberResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddGroupMemberResult }
         *     
         */
        public void setAddGroupMemberResult(AddGroupMemberResult value) {
            this.addGroupMemberResult = value;
        }

        /**
         * Gets the value of the addGroupMemberByGroupLeaderResult property.
         * 
         * @return
         *     possible object is
         *     {@link AddGroupMemberByGroupLeaderResult }
         *     
         */
        public AddGroupMemberByGroupLeaderResult getAddGroupMemberByGroupLeaderResult() {
            return addGroupMemberByGroupLeaderResult;
        }

        /**
         * Sets the value of the addGroupMemberByGroupLeaderResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddGroupMemberByGroupLeaderResult }
         *     
         */
        public void setAddGroupMemberByGroupLeaderResult(AddGroupMemberByGroupLeaderResult value) {
            this.addGroupMemberByGroupLeaderResult = value;
        }

        /**
         * Gets the value of the removeGroupMemberResult property.
         * 
         * @return
         *     possible object is
         *     {@link RemoveGroupMemberResult }
         *     
         */
        public RemoveGroupMemberResult getRemoveGroupMemberResult() {
            return removeGroupMemberResult;
        }

        /**
         * Sets the value of the removeGroupMemberResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link RemoveGroupMemberResult }
         *     
         */
        public void setRemoveGroupMemberResult(RemoveGroupMemberResult value) {
            this.removeGroupMemberResult = value;
        }

        /**
         * Gets the value of the removeGroupMemberByGroupLeaderResult property.
         * 
         * @return
         *     possible object is
         *     {@link RemoveGroupMemberByGroupLeaderResult }
         *     
         */
        public RemoveGroupMemberByGroupLeaderResult getRemoveGroupMemberByGroupLeaderResult() {
            return removeGroupMemberByGroupLeaderResult;
        }

        /**
         * Sets the value of the removeGroupMemberByGroupLeaderResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link RemoveGroupMemberByGroupLeaderResult }
         *     
         */
        public void setRemoveGroupMemberByGroupLeaderResult(RemoveGroupMemberByGroupLeaderResult value) {
            this.removeGroupMemberByGroupLeaderResult = value;
        }

        /**
         * Gets the value of the changeGroupMemberRolesResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupMemberRolesResult }
         *     
         */
        public ChangeGroupMemberRolesResult getChangeGroupMemberRolesResult() {
            return changeGroupMemberRolesResult;
        }

        /**
         * Sets the value of the changeGroupMemberRolesResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupMemberRolesResult }
         *     
         */
        public void setChangeGroupMemberRolesResult(ChangeGroupMemberRolesResult value) {
            this.changeGroupMemberRolesResult = value;
        }

        /**
         * Gets the value of the changeGroupMemberRolesByGroupLeaderResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupMemberRolesByGroupLeaderResult }
         *     
         */
        public ChangeGroupMemberRolesByGroupLeaderResult getChangeGroupMemberRolesByGroupLeaderResult() {
            return changeGroupMemberRolesByGroupLeaderResult;
        }

        /**
         * Sets the value of the changeGroupMemberRolesByGroupLeaderResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupMemberRolesByGroupLeaderResult }
         *     
         */
        public void setChangeGroupMemberRolesByGroupLeaderResult(ChangeGroupMemberRolesByGroupLeaderResult value) {
            this.changeGroupMemberRolesByGroupLeaderResult = value;
        }

        /**
         * Gets the value of the confirmGroupMembershipResult property.
         * 
         * @return
         *     possible object is
         *     {@link ConfirmGroupMembershipResult }
         *     
         */
        public ConfirmGroupMembershipResult getConfirmGroupMembershipResult() {
            return confirmGroupMembershipResult;
        }

        /**
         * Sets the value of the confirmGroupMembershipResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ConfirmGroupMembershipResult }
         *     
         */
        public void setConfirmGroupMembershipResult(ConfirmGroupMembershipResult value) {
            this.confirmGroupMembershipResult = value;
        }

        /**
         * Gets the value of the approveGroupActionOrTransactionResult property.
         * 
         * @return
         *     possible object is
         *     {@link ApproveGroupActionOrTransactionResult }
         *     
         */
        public ApproveGroupActionOrTransactionResult getApproveGroupActionOrTransactionResult() {
            return approveGroupActionOrTransactionResult;
        }

        /**
         * Sets the value of the approveGroupActionOrTransactionResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ApproveGroupActionOrTransactionResult }
         *     
         */
        public void setApproveGroupActionOrTransactionResult(ApproveGroupActionOrTransactionResult value) {
            this.approveGroupActionOrTransactionResult = value;
        }

        /**
         * Gets the value of the searchMyGroupsResult property.
         * 
         * @return
         *     possible object is
         *     {@link SearchMyGroupsResult }
         *     
         */
        public SearchMyGroupsResult getSearchMyGroupsResult() {
            return searchMyGroupsResult;
        }

        /**
         * Sets the value of the searchMyGroupsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link SearchMyGroupsResult }
         *     
         */
        public void setSearchMyGroupsResult(SearchMyGroupsResult value) {
            this.searchMyGroupsResult = value;
        }

        /**
         * Gets the value of the queryGroupInfoResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupInfoResult }
         *     
         */
        public QueryGroupInfoResult getQueryGroupInfoResult() {
            return queryGroupInfoResult;
        }

        /**
         * Sets the value of the queryGroupInfoResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupInfoResult }
         *     
         */
        public void setQueryGroupInfoResult(QueryGroupInfoResult value) {
            this.queryGroupInfoResult = value;
        }

        /**
         * Gets the value of the queryGroupKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupKYCResult }
         *     
         */
        public QueryGroupKYCResult getQueryGroupKYCResult() {
            return queryGroupKYCResult;
        }

        /**
         * Sets the value of the queryGroupKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupKYCResult }
         *     
         */
        public void setQueryGroupKYCResult(QueryGroupKYCResult value) {
            this.queryGroupKYCResult = value;
        }

        /**
         * Gets the value of the queryGroupProductsResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupProductsResult }
         *     
         */
        public QueryGroupProductsResult getQueryGroupProductsResult() {
            return queryGroupProductsResult;
        }

        /**
         * Sets the value of the queryGroupProductsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupProductsResult }
         *     
         */
        public void setQueryGroupProductsResult(QueryGroupProductsResult value) {
            this.queryGroupProductsResult = value;
        }

        /**
         * Gets the value of the listGroupMembersResult property.
         * 
         * @return
         *     possible object is
         *     {@link ListGroupMembersResult }
         *     
         */
        public ListGroupMembersResult getListGroupMembersResult() {
            return listGroupMembersResult;
        }

        /**
         * Sets the value of the listGroupMembersResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListGroupMembersResult }
         *     
         */
        public void setListGroupMembersResult(ListGroupMembersResult value) {
            this.listGroupMembersResult = value;
        }

        /**
         * Gets the value of the listGroupMembersByCustomerResult property.
         * 
         * @return
         *     possible object is
         *     {@link ListGroupMembersByCustomerResult }
         *     
         */
        public ListGroupMembersByCustomerResult getListGroupMembersByCustomerResult() {
            return listGroupMembersByCustomerResult;
        }

        /**
         * Sets the value of the listGroupMembersByCustomerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListGroupMembersByCustomerResult }
         *     
         */
        public void setListGroupMembersByCustomerResult(ListGroupMembersByCustomerResult value) {
            this.listGroupMembersByCustomerResult = value;
        }

        /**
         * Gets the value of the changeGroupRuleProfileResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupRuleProfileResult }
         *     
         */
        public ChangeGroupRuleProfileResult getChangeGroupRuleProfileResult() {
            return changeGroupRuleProfileResult;
        }

        /**
         * Sets the value of the changeGroupRuleProfileResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupRuleProfileResult }
         *     
         */
        public void setChangeGroupRuleProfileResult(ChangeGroupRuleProfileResult value) {
            this.changeGroupRuleProfileResult = value;
        }

        /**
         * Gets the value of the changeGroupChargeProfileResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupChargeProfileResult }
         *     
         */
        public ChangeGroupChargeProfileResult getChangeGroupChargeProfileResult() {
            return changeGroupChargeProfileResult;
        }

        /**
         * Sets the value of the changeGroupChargeProfileResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupChargeProfileResult }
         *     
         */
        public void setChangeGroupChargeProfileResult(ChangeGroupChargeProfileResult value) {
            this.changeGroupChargeProfileResult = value;
        }

        /**
         * Gets the value of the changeGroupAccountRuleProfileResult property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupAccountRuleProfileResult }
         *     
         */
        public ChangeGroupAccountRuleProfileResult getChangeGroupAccountRuleProfileResult() {
            return changeGroupAccountRuleProfileResult;
        }

        /**
         * Sets the value of the changeGroupAccountRuleProfileResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupAccountRuleProfileResult }
         *     
         */
        public void setChangeGroupAccountRuleProfileResult(ChangeGroupAccountRuleProfileResult value) {
            this.changeGroupAccountRuleProfileResult = value;
        }

        /**
         * Gets the value of the identifyCustomerResult property.
         * 
         * @return
         *     possible object is
         *     {@link IdentifyCustomerResult }
         *     
         */
        public IdentifyCustomerResult getIdentifyCustomerResult() {
            return identifyCustomerResult;
        }

        /**
         * Sets the value of the identifyCustomerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link IdentifyCustomerResult }
         *     
         */
        public void setIdentifyCustomerResult(IdentifyCustomerResult value) {
            this.identifyCustomerResult = value;
        }

        /**
         * Gets the value of the raiseDisputedTxnReversalResult property.
         * 
         * @return
         *     possible object is
         *     {@link RaiseDisputedTxnReversalResult }
         *     
         */
        public RaiseDisputedTxnReversalResult getRaiseDisputedTxnReversalResult() {
            return raiseDisputedTxnReversalResult;
        }

        /**
         * Sets the value of the raiseDisputedTxnReversalResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link RaiseDisputedTxnReversalResult }
         *     
         */
        public void setRaiseDisputedTxnReversalResult(RaiseDisputedTxnReversalResult value) {
            this.raiseDisputedTxnReversalResult = value;
        }

        /**
         * Gets the value of the cancelIssuedVoucherResult property.
         * 
         * @return
         *     possible object is
         *     {@link CancelIssuedVoucherResult }
         *     
         */
        public CancelIssuedVoucherResult getCancelIssuedVoucherResult() {
            return cancelIssuedVoucherResult;
        }

        /**
         * Sets the value of the cancelIssuedVoucherResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CancelIssuedVoucherResult }
         *     
         */
        public void setCancelIssuedVoucherResult(CancelIssuedVoucherResult value) {
            this.cancelIssuedVoucherResult = value;
        }

        /**
         * Gets the value of the createCustomerBundleResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateCustomerBundleResult }
         *     
         */
        public CreateCustomerBundleResult getCreateCustomerBundleResult() {
            return createCustomerBundleResult;
        }

        /**
         * Sets the value of the createCustomerBundleResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateCustomerBundleResult }
         *     
         */
        public void setCreateCustomerBundleResult(CreateCustomerBundleResult value) {
            this.createCustomerBundleResult = value;
        }

        /**
         * Gets the value of the createOrganizationBundleResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateOrganizationBundleResult }
         *     
         */
        public CreateOrganizationBundleResult getCreateOrganizationBundleResult() {
            return createOrganizationBundleResult;
        }

        /**
         * Sets the value of the createOrganizationBundleResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateOrganizationBundleResult }
         *     
         */
        public void setCreateOrganizationBundleResult(CreateOrganizationBundleResult value) {
            this.createOrganizationBundleResult = value;
        }

        /**
         * Gets the value of the createExternalProviderResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateExternalProviderResult }
         *     
         */
        public CreateExternalProviderResult getCreateExternalProviderResult() {
            return createExternalProviderResult;
        }

        /**
         * Sets the value of the createExternalProviderResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateExternalProviderResult }
         *     
         */
        public void setCreateExternalProviderResult(CreateExternalProviderResult value) {
            this.createExternalProviderResult = value;
        }

        /**
         * Gets the value of the createGroupBundleResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateGroupBundleResult }
         *     
         */
        public CreateGroupBundleResult getCreateGroupBundleResult() {
            return createGroupBundleResult;
        }

        /**
         * Sets the value of the createGroupBundleResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateGroupBundleResult }
         *     
         */
        public void setCreateGroupBundleResult(CreateGroupBundleResult value) {
            this.createGroupBundleResult = value;
        }

        /**
         * Gets the value of the createBankAccountResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateBankAccountResult }
         *     
         */
        public CreateBankAccountResult getCreateBankAccountResult() {
            return createBankAccountResult;
        }

        /**
         * Sets the value of the createBankAccountResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateBankAccountResult }
         *     
         */
        public void setCreateBankAccountResult(CreateBankAccountResult value) {
            this.createBankAccountResult = value;
        }

        /**
         * Gets the value of the deleteBankAccountResult property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteBankAccountResult }
         *     
         */
        public DeleteBankAccountResult getDeleteBankAccountResult() {
            return deleteBankAccountResult;
        }

        /**
         * Sets the value of the deleteBankAccountResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteBankAccountResult }
         *     
         */
        public void setDeleteBankAccountResult(DeleteBankAccountResult value) {
            this.deleteBankAccountResult = value;
        }

        /**
         * Gets the value of the setDefaultBankAccountResult property.
         * 
         * @return
         *     possible object is
         *     {@link SetDefaultBankAccountResult }
         *     
         */
        public SetDefaultBankAccountResult getSetDefaultBankAccountResult() {
            return setDefaultBankAccountResult;
        }

        /**
         * Sets the value of the setDefaultBankAccountResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link SetDefaultBankAccountResult }
         *     
         */
        public void setSetDefaultBankAccountResult(SetDefaultBankAccountResult value) {
            this.setDefaultBankAccountResult = value;
        }

        /**
         * Gets the value of the queryDirectDebitMandateResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryDirectDebitMandateResult }
         *     
         */
        public QueryDirectDebitMandateResult getQueryDirectDebitMandateResult() {
            return queryDirectDebitMandateResult;
        }

        /**
         * Sets the value of the queryDirectDebitMandateResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryDirectDebitMandateResult }
         *     
         */
        public void setQueryDirectDebitMandateResult(QueryDirectDebitMandateResult value) {
            this.queryDirectDebitMandateResult = value;
        }

        /**
         * Gets the value of the viewDirectDebitMandateResult property.
         * 
         * @return
         *     possible object is
         *     {@link ViewDirectDebitMandateResult }
         *     
         */
        public ViewDirectDebitMandateResult getViewDirectDebitMandateResult() {
            return viewDirectDebitMandateResult;
        }

        /**
         * Sets the value of the viewDirectDebitMandateResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ViewDirectDebitMandateResult }
         *     
         */
        public void setViewDirectDebitMandateResult(ViewDirectDebitMandateResult value) {
            this.viewDirectDebitMandateResult = value;
        }

        /**
         * Gets the value of the queryReminderScheduleResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryReminderScheduleResult }
         *     
         */
        public QueryReminderScheduleResult getQueryReminderScheduleResult() {
            return queryReminderScheduleResult;
        }

        /**
         * Sets the value of the queryReminderScheduleResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryReminderScheduleResult }
         *     
         */
        public void setQueryReminderScheduleResult(QueryReminderScheduleResult value) {
            this.queryReminderScheduleResult = value;
        }

        /**
         * Gets the value of the cchChangeCustKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link CCHChangeCustKYCResult }
         *     
         */
        public CCHChangeCustKYCResult getCCHChangeCustKYCResult() {
            return cchChangeCustKYCResult;
        }

        /**
         * Sets the value of the cchChangeCustKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CCHChangeCustKYCResult }
         *     
         */
        public void setCCHChangeCustKYCResult(CCHChangeCustKYCResult value) {
            this.cchChangeCustKYCResult = value;
        }

        /**
         * Gets the value of the cchChangeOrgOperatorKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link CCHChangeOrgOperatorKYCResult }
         *     
         */
        public CCHChangeOrgOperatorKYCResult getCCHChangeOrgOperatorKYCResult() {
            return cchChangeOrgOperatorKYCResult;
        }

        /**
         * Sets the value of the cchChangeOrgOperatorKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CCHChangeOrgOperatorKYCResult }
         *     
         */
        public void setCCHChangeOrgOperatorKYCResult(CCHChangeOrgOperatorKYCResult value) {
            this.cchChangeOrgOperatorKYCResult = value;
        }

        /**
         * Gets the value of the preValidationConfirmationResult property.
         * 
         * @return
         *     possible object is
         *     {@link PreValidationConfirmationResult }
         *     
         */
        public PreValidationConfirmationResult getPreValidationConfirmationResult() {
            return preValidationConfirmationResult;
        }

        /**
         * Sets the value of the preValidationConfirmationResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link PreValidationConfirmationResult }
         *     
         */
        public void setPreValidationConfirmationResult(PreValidationConfirmationResult value) {
            this.preValidationConfirmationResult = value;
        }

        /**
         * Gets the value of the preValidationResult property.
         * 
         * @return
         *     possible object is
         *     {@link PreValidationResult }
         *     
         */
        public PreValidationResult getPreValidationResult() {
            return preValidationResult;
        }

        /**
         * Sets the value of the preValidationResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link PreValidationResult }
         *     
         */
        public void setPreValidationResult(PreValidationResult value) {
            this.preValidationResult = value;
        }

        /**
         * Gets the value of the createOrgLoyaltyAccountResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateOrgLoyaltyAccountResult }
         *     
         */
        public CreateOrgLoyaltyAccountResult getCreateOrgLoyaltyAccountResult() {
            return createOrgLoyaltyAccountResult;
        }

        /**
         * Sets the value of the createOrgLoyaltyAccountResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateOrgLoyaltyAccountResult }
         *     
         */
        public void setCreateOrgLoyaltyAccountResult(CreateOrgLoyaltyAccountResult value) {
            this.createOrgLoyaltyAccountResult = value;
        }

        /**
         * Gets the value of the createCustLoyaltyAccountResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateCustLoyaltyAccountResult }
         *     
         */
        public CreateCustLoyaltyAccountResult getCreateCustLoyaltyAccountResult() {
            return createCustLoyaltyAccountResult;
        }

        /**
         * Sets the value of the createCustLoyaltyAccountResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateCustLoyaltyAccountResult }
         *     
         */
        public void setCreateCustLoyaltyAccountResult(CreateCustLoyaltyAccountResult value) {
            this.createCustLoyaltyAccountResult = value;
        }

        /**
         * Gets the value of the createGroupLoyaltyAccountResult property.
         * 
         * @return
         *     possible object is
         *     {@link CreateGroupLoyaltyAccountResult }
         *     
         */
        public CreateGroupLoyaltyAccountResult getCreateGroupLoyaltyAccountResult() {
            return createGroupLoyaltyAccountResult;
        }

        /**
         * Sets the value of the createGroupLoyaltyAccountResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateGroupLoyaltyAccountResult }
         *     
         */
        public void setCreateGroupLoyaltyAccountResult(CreateGroupLoyaltyAccountResult value) {
            this.createGroupLoyaltyAccountResult = value;
        }

        /**
         * Gets the value of the queryCustLoyaltyPointResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustLoyaltyPointResult }
         *     
         */
        public QueryCustLoyaltyPointResult getQueryCustLoyaltyPointResult() {
            return queryCustLoyaltyPointResult;
        }

        /**
         * Sets the value of the queryCustLoyaltyPointResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustLoyaltyPointResult }
         *     
         */
        public void setQueryCustLoyaltyPointResult(QueryCustLoyaltyPointResult value) {
            this.queryCustLoyaltyPointResult = value;
        }

        /**
         * Gets the value of the queryOrgLoyaltyPointResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrgLoyaltyPointResult }
         *     
         */
        public QueryOrgLoyaltyPointResult getQueryOrgLoyaltyPointResult() {
            return queryOrgLoyaltyPointResult;
        }

        /**
         * Sets the value of the queryOrgLoyaltyPointResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrgLoyaltyPointResult }
         *     
         */
        public void setQueryOrgLoyaltyPointResult(QueryOrgLoyaltyPointResult value) {
            this.queryOrgLoyaltyPointResult = value;
        }

        /**
         * Gets the value of the queryGroupLoyaltyPointResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupLoyaltyPointResult }
         *     
         */
        public QueryGroupLoyaltyPointResult getQueryGroupLoyaltyPointResult() {
            return queryGroupLoyaltyPointResult;
        }

        /**
         * Sets the value of the queryGroupLoyaltyPointResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupLoyaltyPointResult }
         *     
         */
        public void setQueryGroupLoyaltyPointResult(QueryGroupLoyaltyPointResult value) {
            this.queryGroupLoyaltyPointResult = value;
        }

        /**
         * Gets the value of the queryLoyaltyConsumerByOrgOperatorResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryLoyaltyConsumerResult }
         *     
         */
        public QueryLoyaltyConsumerResult getQueryLoyaltyConsumerByOrgOperatorResult() {
            return queryLoyaltyConsumerByOrgOperatorResult;
        }

        /**
         * Sets the value of the queryLoyaltyConsumerByOrgOperatorResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryLoyaltyConsumerResult }
         *     
         */
        public void setQueryLoyaltyConsumerByOrgOperatorResult(QueryLoyaltyConsumerResult value) {
            this.queryLoyaltyConsumerByOrgOperatorResult = value;
        }

        /**
         * Gets the value of the queryCustLoyaltyPointStatementResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustLoyaltyPointStatementResult }
         *     
         */
        public QueryCustLoyaltyPointStatementResult getQueryCustLoyaltyPointStatementResult() {
            return queryCustLoyaltyPointStatementResult;
        }

        /**
         * Sets the value of the queryCustLoyaltyPointStatementResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustLoyaltyPointStatementResult }
         *     
         */
        public void setQueryCustLoyaltyPointStatementResult(QueryCustLoyaltyPointStatementResult value) {
            this.queryCustLoyaltyPointStatementResult = value;
        }

        /**
         * Gets the value of the queryOrgLoyaltyPointStatementResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrgLoyaltyPointStatementResult }
         *     
         */
        public QueryOrgLoyaltyPointStatementResult getQueryOrgLoyaltyPointStatementResult() {
            return queryOrgLoyaltyPointStatementResult;
        }

        /**
         * Sets the value of the queryOrgLoyaltyPointStatementResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrgLoyaltyPointStatementResult }
         *     
         */
        public void setQueryOrgLoyaltyPointStatementResult(QueryOrgLoyaltyPointStatementResult value) {
            this.queryOrgLoyaltyPointStatementResult = value;
        }

        /**
         * Gets the value of the queryGroupLoyaltyPointStatementResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupLoyaltyPointStatementResult }
         *     
         */
        public QueryGroupLoyaltyPointStatementResult getQueryGroupLoyaltyPointStatementResult() {
            return queryGroupLoyaltyPointStatementResult;
        }

        /**
         * Sets the value of the queryGroupLoyaltyPointStatementResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupLoyaltyPointStatementResult }
         *     
         */
        public void setQueryGroupLoyaltyPointStatementResult(QueryGroupLoyaltyPointStatementResult value) {
            this.queryGroupLoyaltyPointStatementResult = value;
        }

        /**
         * Gets the value of the queryLoyaltyConsumerStatementByOrgOperatorResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryLoyaltyConsumerStatementResult }
         *     
         */
        public QueryLoyaltyConsumerStatementResult getQueryLoyaltyConsumerStatementByOrgOperatorResult() {
            return queryLoyaltyConsumerStatementByOrgOperatorResult;
        }

        /**
         * Sets the value of the queryLoyaltyConsumerStatementByOrgOperatorResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryLoyaltyConsumerStatementResult }
         *     
         */
        public void setQueryLoyaltyConsumerStatementByOrgOperatorResult(QueryLoyaltyConsumerStatementResult value) {
            this.queryLoyaltyConsumerStatementByOrgOperatorResult = value;
        }

        /**
         * Gets the value of the queryIdentityBundleResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryIdentityBundleResult }
         *     
         */
        public QueryIdentityBundleResult getQueryIdentityBundleResult() {
            return queryIdentityBundleResult;
        }

        /**
         * Sets the value of the queryIdentityBundleResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryIdentityBundleResult }
         *     
         */
        public void setQueryIdentityBundleResult(QueryIdentityBundleResult value) {
            this.queryIdentityBundleResult = value;
        }

        /**
         * Gets the value of the cchIdentifyCustomerResult property.
         * 
         * @return
         *     possible object is
         *     {@link CCHIdentifyCustomerResult }
         *     
         */
        public CCHIdentifyCustomerResult getCCHIdentifyCustomerResult() {
            return cchIdentifyCustomerResult;
        }

        /**
         * Sets the value of the cchIdentifyCustomerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CCHIdentifyCustomerResult }
         *     
         */
        public void setCCHIdentifyCustomerResult(CCHIdentifyCustomerResult value) {
            this.cchIdentifyCustomerResult = value;
        }

        /**
         * Gets the value of the cchIdentifyOperatorResult property.
         * 
         * @return
         *     possible object is
         *     {@link CCHIdentifyOperatorResult }
         *     
         */
        public CCHIdentifyOperatorResult getCCHIdentifyOperatorResult() {
            return cchIdentifyOperatorResult;
        }

        /**
         * Sets the value of the cchIdentifyOperatorResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link CCHIdentifyOperatorResult }
         *     
         */
        public void setCCHIdentifyOperatorResult(CCHIdentifyOperatorResult value) {
            this.cchIdentifyOperatorResult = value;
        }

        /**
         * Gets the value of the updateOrgOperatorOwnKYCResult property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrgOperatorOwnKYCResult }
         *     
         */
        public UpdateOrgOperatorOwnKYCResult getUpdateOrgOperatorOwnKYCResult() {
            return updateOrgOperatorOwnKYCResult;
        }

        /**
         * Sets the value of the updateOrgOperatorOwnKYCResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrgOperatorOwnKYCResult }
         *     
         */
        public void setUpdateOrgOperatorOwnKYCResult(UpdateOrgOperatorOwnKYCResult value) {
            this.updateOrgOperatorOwnKYCResult = value;
        }

        /**
         * Gets the value of the querySavingPlanForCustomerResult property.
         * 
         * @return
         *     possible object is
         *     {@link QuerySavingPlanForCustomerResult }
         *     
         */
        public QuerySavingPlanForCustomerResult getQuerySavingPlanForCustomerResult() {
            return querySavingPlanForCustomerResult;
        }

        /**
         * Sets the value of the querySavingPlanForCustomerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QuerySavingPlanForCustomerResult }
         *     
         */
        public void setQuerySavingPlanForCustomerResult(QuerySavingPlanForCustomerResult value) {
            this.querySavingPlanForCustomerResult = value;
        }

        /**
         * Gets the value of the querySavingPlanForGroupResult property.
         * 
         * @return
         *     possible object is
         *     {@link QuerySavingPlanForGroupResult }
         *     
         */
        public QuerySavingPlanForGroupResult getQuerySavingPlanForGroupResult() {
            return querySavingPlanForGroupResult;
        }

        /**
         * Sets the value of the querySavingPlanForGroupResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QuerySavingPlanForGroupResult }
         *     
         */
        public void setQuerySavingPlanForGroupResult(QuerySavingPlanForGroupResult value) {
            this.querySavingPlanForGroupResult = value;
        }

        /**
         * Gets the value of the querySavingPlanForOrganizationResult property.
         * 
         * @return
         *     possible object is
         *     {@link QuerySavingPlanForOrganizationResult }
         *     
         */
        public QuerySavingPlanForOrganizationResult getQuerySavingPlanForOrganizationResult() {
            return querySavingPlanForOrganizationResult;
        }

        /**
         * Sets the value of the querySavingPlanForOrganizationResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QuerySavingPlanForOrganizationResult }
         *     
         */
        public void setQuerySavingPlanForOrganizationResult(QuerySavingPlanForOrganizationResult value) {
            this.querySavingPlanForOrganizationResult = value;
        }

        /**
         * Gets the value of the queryTransferPointsFeeResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryTransferPointsFeeResult }
         *     
         */
        public QueryTransferPointsFeeResult getQueryTransferPointsFeeResult() {
            return queryTransferPointsFeeResult;
        }

        /**
         * Sets the value of the queryTransferPointsFeeResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryTransferPointsFeeResult }
         *     
         */
        public void setQueryTransferPointsFeeResult(QueryTransferPointsFeeResult value) {
            this.queryTransferPointsFeeResult = value;
        }

        /**
         * Gets the value of the queryRedeemBalanceRateResult property.
         * 
         * @return
         *     possible object is
         *     {@link QueryRedeemBalanceRateResult }
         *     
         */
        public QueryRedeemBalanceRateResult getQueryRedeemBalanceRateResult() {
            return queryRedeemBalanceRateResult;
        }

        /**
         * Sets the value of the queryRedeemBalanceRateResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryRedeemBalanceRateResult }
         *     
         */
        public void setQueryRedeemBalanceRateResult(QueryRedeemBalanceRateResult value) {
            this.queryRedeemBalanceRateResult = value;
        }

        /**
         * Gets the value of the transferPointsResult property.
         * 
         * @return
         *     possible object is
         *     {@link TransferPointsResult }
         *     
         */
        public TransferPointsResult getTransferPointsResult() {
            return transferPointsResult;
        }

        /**
         * Sets the value of the transferPointsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link TransferPointsResult }
         *     
         */
        public void setTransferPointsResult(TransferPointsResult value) {
            this.transferPointsResult = value;
        }

        /**
         * Gets the value of the redeemPointsToGoodsResult property.
         * 
         * @return
         *     possible object is
         *     {@link RedeemPointsToGoodsResult }
         *     
         */
        public RedeemPointsToGoodsResult getRedeemPointsToGoodsResult() {
            return redeemPointsToGoodsResult;
        }

        /**
         * Sets the value of the redeemPointsToGoodsResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link RedeemPointsToGoodsResult }
         *     
         */
        public void setRedeemPointsToGoodsResult(RedeemPointsToGoodsResult value) {
            this.redeemPointsToGoodsResult = value;
        }

        /**
         * Gets the value of the redeemPointsWithVoucherResult property.
         * 
         * @return
         *     possible object is
         *     {@link RedeemPointsWithVoucherResult }
         *     
         */
        public RedeemPointsWithVoucherResult getRedeemPointsWithVoucherResult() {
            return redeemPointsWithVoucherResult;
        }

        /**
         * Sets the value of the redeemPointsWithVoucherResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link RedeemPointsWithVoucherResult }
         *     
         */
        public void setRedeemPointsWithVoucherResult(RedeemPointsWithVoucherResult value) {
            this.redeemPointsWithVoucherResult = value;
        }

        /**
         * Gets the value of the redeemPointsToBalanceResult property.
         * 
         * @return
         *     possible object is
         *     {@link RedeemPointsToBalanceResult }
         *     
         */
        public RedeemPointsToBalanceResult getRedeemPointsToBalanceResult() {
            return redeemPointsToBalanceResult;
        }

        /**
         * Sets the value of the redeemPointsToBalanceResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link RedeemPointsToBalanceResult }
         *     
         */
        public void setRedeemPointsToBalanceResult(RedeemPointsToBalanceResult value) {
            this.redeemPointsToBalanceResult = value;
        }

        /**
         * Gets the value of the subscribeSavingPlanForCustomerResult property.
         * 
         * @return
         *     possible object is
         *     {@link SubscribeSavingPlanForCustomerResult }
         *     
         */
        public SubscribeSavingPlanForCustomerResult getSubscribeSavingPlanForCustomerResult() {
            return subscribeSavingPlanForCustomerResult;
        }

        /**
         * Sets the value of the subscribeSavingPlanForCustomerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link SubscribeSavingPlanForCustomerResult }
         *     
         */
        public void setSubscribeSavingPlanForCustomerResult(SubscribeSavingPlanForCustomerResult value) {
            this.subscribeSavingPlanForCustomerResult = value;
        }

        /**
         * Gets the value of the subscribeSavingPlanForGroupResult property.
         * 
         * @return
         *     possible object is
         *     {@link SubscribeSavingPlanForGroupResult }
         *     
         */
        public SubscribeSavingPlanForGroupResult getSubscribeSavingPlanForGroupResult() {
            return subscribeSavingPlanForGroupResult;
        }

        /**
         * Sets the value of the subscribeSavingPlanForGroupResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link SubscribeSavingPlanForGroupResult }
         *     
         */
        public void setSubscribeSavingPlanForGroupResult(SubscribeSavingPlanForGroupResult value) {
            this.subscribeSavingPlanForGroupResult = value;
        }

        /**
         * Gets the value of the subscribeSavingPlanForOrgResult property.
         * 
         * @return
         *     possible object is
         *     {@link SubscribeSavingPlanForOrgResult }
         *     
         */
        public SubscribeSavingPlanForOrgResult getSubscribeSavingPlanForOrgResult() {
            return subscribeSavingPlanForOrgResult;
        }

        /**
         * Sets the value of the subscribeSavingPlanForOrgResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link SubscribeSavingPlanForOrgResult }
         *     
         */
        public void setSubscribeSavingPlanForOrgResult(SubscribeSavingPlanForOrgResult value) {
            this.subscribeSavingPlanForOrgResult = value;
        }

        /**
         * Gets the value of the unSubscribeSavingPlanForCustomerResult property.
         * 
         * @return
         *     possible object is
         *     {@link UnSubscribeSavingPlanForCustomerResult }
         *     
         */
        public UnSubscribeSavingPlanForCustomerResult getUnSubscribeSavingPlanForCustomerResult() {
            return unSubscribeSavingPlanForCustomerResult;
        }

        /**
         * Sets the value of the unSubscribeSavingPlanForCustomerResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnSubscribeSavingPlanForCustomerResult }
         *     
         */
        public void setUnSubscribeSavingPlanForCustomerResult(UnSubscribeSavingPlanForCustomerResult value) {
            this.unSubscribeSavingPlanForCustomerResult = value;
        }

        /**
         * Gets the value of the unSubscribeSavingPlanForGroupResult property.
         * 
         * @return
         *     possible object is
         *     {@link UnSubscribeSavingPlanForGroupResult }
         *     
         */
        public UnSubscribeSavingPlanForGroupResult getUnSubscribeSavingPlanForGroupResult() {
            return unSubscribeSavingPlanForGroupResult;
        }

        /**
         * Sets the value of the unSubscribeSavingPlanForGroupResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnSubscribeSavingPlanForGroupResult }
         *     
         */
        public void setUnSubscribeSavingPlanForGroupResult(UnSubscribeSavingPlanForGroupResult value) {
            this.unSubscribeSavingPlanForGroupResult = value;
        }

        /**
         * Gets the value of the unSubscribeSavingPlanForOrgResult property.
         * 
         * @return
         *     possible object is
         *     {@link UnSubscribeSavingPlanForOrgResult }
         *     
         */
        public UnSubscribeSavingPlanForOrgResult getUnSubscribeSavingPlanForOrgResult() {
            return unSubscribeSavingPlanForOrgResult;
        }

        /**
         * Sets the value of the unSubscribeSavingPlanForOrgResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnSubscribeSavingPlanForOrgResult }
         *     
         */
        public void setUnSubscribeSavingPlanForOrgResult(UnSubscribeSavingPlanForOrgResult value) {
            this.unSubscribeSavingPlanForOrgResult = value;
        }

        /**
         * Gets the value of the validateTokenResult property.
         * 
         * @return
         *     possible object is
         *     {@link ValidateTokenResult }
         *     
         */
        public ValidateTokenResult getValidateTokenResult() {
            return validateTokenResult;
        }

        /**
         * Sets the value of the validateTokenResult property.
         * 
         * @param value
         *     allowed object is
         *     {@link ValidateTokenResult }
         *     
         */
        public void setValidateTokenResult(ValidateTokenResult value) {
            this.validateTokenResult = value;
        }

        /**
         * Gets the value of the referenceData property.
         * 
         * @return
         *     possible object is
         *     {@link Result.Body.ReferenceData }
         *     
         */
        public Result.Body.ReferenceData getReferenceData() {
            return referenceData;
        }

        /**
         * Sets the value of the referenceData property.
         * 
         * @param value
         *     allowed object is
         *     {@link Result.Body.ReferenceData }
         *     
         */
        public void setReferenceData(Result.Body.ReferenceData value) {
            this.referenceData = value;
        }


        /**
         * <p>Java class for anonymous complex type.
         * 
         * <p>The following schema fragment specifies the expected content contained within this class.
         * 
         * <pre>
         * &lt;complexType&gt;
         *   &lt;complexContent&gt;
         *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *       &lt;sequence&gt;
         *         &lt;element name="ReferenceItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
         *       &lt;/sequence&gt;
         *     &lt;/restriction&gt;
         *   &lt;/complexContent&gt;
         * &lt;/complexType&gt;
         * </pre>
         * 
         * 
         */
        @XmlAccessorType(XmlAccessType.FIELD)
        @XmlType(name = "", propOrder = {
            "referenceItem"
        })
        public static class ReferenceData {

            @XmlElement(name = "ReferenceItem", required = true)
            protected List<ParameterType> referenceItem;

            /**
             * Gets the value of the referenceItem property.
             * 
             * <p>
             * This accessor method returns a reference to the live list,
             * not a snapshot. Therefore any modification you make to the
             * returned list will be present inside the Jakarta XML Binding object.
             * This is why there is not a <CODE>set</CODE> method for the referenceItem property.
             * 
             * <p>
             * For example, to add a new item, do as follows:
             * <pre>
             *    getReferenceItem().add(newItem);
             * </pre>
             * 
             * 
             * <p>
             * Objects of the following type(s) are allowed in the list
             * {@link ParameterType }
             * 
             * 
             */
            public List<ParameterType> getReferenceItem() {
                if (referenceItem == null) {
                    referenceItem = new ArrayList<ParameterType>();
                }
                return this.referenceItem;
            }

        }


        /**
         * <p>Java class for anonymous complex type.
         * 
         * <p>The following schema fragment specifies the expected content contained within this class.
         * 
         * <pre>
         * &lt;complexType&gt;
         *   &lt;complexContent&gt;
         *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *       &lt;sequence&gt;
         *         &lt;element name="ParameterItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
         *       &lt;/sequence&gt;
         *     &lt;/restriction&gt;
         *   &lt;/complexContent&gt;
         * &lt;/complexType&gt;
         * </pre>
         * 
         * 
         */
        @XmlAccessorType(XmlAccessType.FIELD)
        @XmlType(name = "", propOrder = {
            "parameterItem"
        })
        public static class ResultParameters {

            @XmlElement(name = "ParameterItem", required = true)
            protected List<ParameterType> parameterItem;

            /**
             * Gets the value of the parameterItem property.
             * 
             * <p>
             * This accessor method returns a reference to the live list,
             * not a snapshot. Therefore any modification you make to the
             * returned list will be present inside the Jakarta XML Binding object.
             * This is why there is not a <CODE>set</CODE> method for the parameterItem property.
             * 
             * <p>
             * For example, to add a new item, do as follows:
             * <pre>
             *    getParameterItem().add(newItem);
             * </pre>
             * 
             * 
             * <p>
             * Objects of the following type(s) are allowed in the list
             * {@link ParameterType }
             * 
             * 
             */
            public List<ParameterType> getParameterItem() {
                if (parameterItem == null) {
                    parameterItem = new ArrayList<ParameterType>();
                }
                return this.parameterItem;
            }

        }


        /**
         * <p>Java class for anonymous complex type.
         * 
         * <p>The following schema fragment specifies the expected content contained within this class.
         * 
         * <pre>
         * &lt;complexType&gt;
         *   &lt;complexContent&gt;
         *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *       &lt;sequence&gt;
         *         &lt;element name="TransactionID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *         &lt;element name="TransactionStatus" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
         *         &lt;element name="ResultParameters" minOccurs="0"&gt;
         *           &lt;complexType&gt;
         *             &lt;complexContent&gt;
         *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                 &lt;sequence&gt;
         *                   &lt;element name="ResultParameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
         *                 &lt;/sequence&gt;
         *               &lt;/restriction&gt;
         *             &lt;/complexContent&gt;
         *           &lt;/complexType&gt;
         *         &lt;/element&gt;
         *       &lt;/sequence&gt;
         *     &lt;/restriction&gt;
         *   &lt;/complexContent&gt;
         * &lt;/complexType&gt;
         * </pre>
         * 
         * 
         */
        @XmlAccessorType(XmlAccessType.FIELD)
        @XmlType(name = "", propOrder = {
            "transactionID",
            "transactionStatus",
            "resultParameters"
        })
        public static class TransactionResult {

            @XmlElement(name = "TransactionID", required = true)
            protected String transactionID;
            @XmlElement(name = "TransactionStatus")
            protected String transactionStatus;
            @XmlElement(name = "ResultParameters")
            protected Result.Body.TransactionResult.ResultParameters resultParameters;

            /**
             * Gets the value of the transactionID property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getTransactionID() {
                return transactionID;
            }

            /**
             * Sets the value of the transactionID property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setTransactionID(String value) {
                this.transactionID = value;
            }

            /**
             * Gets the value of the transactionStatus property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getTransactionStatus() {
                return transactionStatus;
            }

            /**
             * Sets the value of the transactionStatus property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setTransactionStatus(String value) {
                this.transactionStatus = value;
            }

            /**
             * Gets the value of the resultParameters property.
             * 
             * @return
             *     possible object is
             *     {@link Result.Body.TransactionResult.ResultParameters }
             *     
             */
            public Result.Body.TransactionResult.ResultParameters getResultParameters() {
                return resultParameters;
            }

            /**
             * Sets the value of the resultParameters property.
             * 
             * @param value
             *     allowed object is
             *     {@link Result.Body.TransactionResult.ResultParameters }
             *     
             */
            public void setResultParameters(Result.Body.TransactionResult.ResultParameters value) {
                this.resultParameters = value;
            }


            /**
             * <p>Java class for anonymous complex type.
             * 
             * <p>The following schema fragment specifies the expected content contained within this class.
             * 
             * <pre>
             * &lt;complexType&gt;
             *   &lt;complexContent&gt;
             *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *       &lt;sequence&gt;
             *         &lt;element name="ResultParameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
             *       &lt;/sequence&gt;
             *     &lt;/restriction&gt;
             *   &lt;/complexContent&gt;
             * &lt;/complexType&gt;
             * </pre>
             * 
             * 
             */
            @XmlAccessorType(XmlAccessType.FIELD)
            @XmlType(name = "", propOrder = {
                "resultParameter"
            })
            public static class ResultParameters {

                @XmlElement(name = "ResultParameter", required = true)
                protected List<ParameterType> resultParameter;

                /**
                 * Gets the value of the resultParameter property.
                 * 
                 * <p>
                 * This accessor method returns a reference to the live list,
                 * not a snapshot. Therefore any modification you make to the
                 * returned list will be present inside the Jakarta XML Binding object.
                 * This is why there is not a <CODE>set</CODE> method for the resultParameter property.
                 * 
                 * <p>
                 * For example, to add a new item, do as follows:
                 * <pre>
                 *    getResultParameter().add(newItem);
                 * </pre>
                 * 
                 * 
                 * <p>
                 * Objects of the following type(s) are allowed in the list
                 * {@link ParameterType }
                 * 
                 * 
                 */
                public List<ParameterType> getResultParameter() {
                    if (resultParameter == null) {
                        resultParameter = new ArrayList<ParameterType>();
                    }
                    return this.resultParameter;
                }

            }

        }

    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="Version" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *         &lt;element name="OriginatorConversationID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
     *         &lt;element name="ConversationID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *         &lt;element name="HeaderExtension" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="Extension" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "version",
        "originatorConversationID",
        "conversationID",
        "headerExtension"
    })
    public static class Header {

        @XmlElement(name = "Version", required = true)
        protected String version;
        @XmlElement(name = "OriginatorConversationID")
        protected String originatorConversationID;
        @XmlElement(name = "ConversationID", required = true)
        protected String conversationID;
        @XmlElement(name = "HeaderExtension")
        protected Result.Header.HeaderExtension headerExtension;

        /**
         * Gets the value of the version property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getVersion() {
            return version;
        }

        /**
         * Sets the value of the version property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setVersion(String value) {
            this.version = value;
        }

        /**
         * Gets the value of the originatorConversationID property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getOriginatorConversationID() {
            return originatorConversationID;
        }

        /**
         * Sets the value of the originatorConversationID property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setOriginatorConversationID(String value) {
            this.originatorConversationID = value;
        }

        /**
         * Gets the value of the conversationID property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getConversationID() {
            return conversationID;
        }

        /**
         * Sets the value of the conversationID property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setConversationID(String value) {
            this.conversationID = value;
        }

        /**
         * Gets the value of the headerExtension property.
         * 
         * @return
         *     possible object is
         *     {@link Result.Header.HeaderExtension }
         *     
         */
        public Result.Header.HeaderExtension getHeaderExtension() {
            return headerExtension;
        }

        /**
         * Sets the value of the headerExtension property.
         * 
         * @param value
         *     allowed object is
         *     {@link Result.Header.HeaderExtension }
         *     
         */
        public void setHeaderExtension(Result.Header.HeaderExtension value) {
            this.headerExtension = value;
        }


        /**
         * <p>Java class for anonymous complex type.
         * 
         * <p>The following schema fragment specifies the expected content contained within this class.
         * 
         * <pre>
         * &lt;complexType&gt;
         *   &lt;complexContent&gt;
         *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *       &lt;sequence&gt;
         *         &lt;element name="Extension" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
         *       &lt;/sequence&gt;
         *     &lt;/restriction&gt;
         *   &lt;/complexContent&gt;
         * &lt;/complexType&gt;
         * </pre>
         * 
         * 
         */
        @XmlAccessorType(XmlAccessType.FIELD)
        @XmlType(name = "", propOrder = {
            "extension"
        })
        public static class HeaderExtension {

            @XmlElement(name = "Extension", required = true)
            protected List<ParameterType> extension;

            /**
             * Gets the value of the extension property.
             * 
             * <p>
             * This accessor method returns a reference to the live list,
             * not a snapshot. Therefore any modification you make to the
             * returned list will be present inside the Jakarta XML Binding object.
             * This is why there is not a <CODE>set</CODE> method for the extension property.
             * 
             * <p>
             * For example, to add a new item, do as follows:
             * <pre>
             *    getExtension().add(newItem);
             * </pre>
             * 
             * 
             * <p>
             * Objects of the following type(s) are allowed in the list
             * {@link ParameterType }
             * 
             * 
             */
            public List<ParameterType> getExtension() {
                if (extension == null) {
                    extension = new ArrayList<ParameterType>();
                }
                return this.extension;
            }

        }

    }

}
