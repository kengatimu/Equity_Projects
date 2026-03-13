#!/bin/bash

# Export the Jasypt secret key as an environment variable
export CD_SPRING_DATASOURCE_URL="#{CD-SPRING-DATASOURCE-URL}#"
export CD_SPRING_DATASOURCE_USERNAME="#{CD-SPRING-DATASOURCE-USERNAME}#"
export CD_SPRING_DATASOURCE_PASSWORD="#{SPRING-DATASOURCE-PASSWORD}#"

#export SS_MTN_SSL_KEYSTORE_LOCATION="#{SS-MTN_SSL-KEYSTORE-LOCATION}#"
#export SS_MTN_SSL_KEYSTORE_PASSWORD="#{SS-MTN-SSL-KEYSTORE-PASSWORD}#"
#export SS_MTN_SSL_KEYSTORE_ALIAS="#{SS-MTN-SSL-KEYSTORE-ALIAS}#"

#export SS_MTN_AUTH_USERNAME="#{SS-MTN-AUTH-USERNAME}#"
#export SS_MTN_AUTH_PASSWORD="#{SS-MTN-AUTH-PASSWORD}#"

export CD_MTN_SSL_KEYSTORE_LOCATION="/u01/gag/drcb2c/certs/equity-mtn-ss-b2c.p12"
export CD_MTN_SSL_KEYSTORE_PASSWORD="equity123"
export CD_MTN_SSL_KEYSTORE_ALIAS="equitybankgroup.com"

export SS_MTN_AUTH_USERNAME="equity_user"
export SS_MTN_AUTH_PASSWORD="equityMTN@13579!"
export SS_MTN_BUY_FLOAT_URL="https://3ppendpoint.com/bank/deposit"
export SS_MTN_FLOAT_STATUS_URL="https://3ppendpoint.com/bank/gettransactionstatus"
export SS_MTN_FLOAT_NAMECHECK_URL="https://3ppendpoint.com/bank/getaccountholderinfo"

# Print a confirmation message
echo "Environment variables have been set."