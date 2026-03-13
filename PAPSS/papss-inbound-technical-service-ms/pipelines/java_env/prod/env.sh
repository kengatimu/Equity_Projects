#!/bin/bash

# ------------------------------------------------------------
# DATABASE CONFIG
# ------------------------------------------------------------
export SPRING_DATASOURCE_URL='#{SPRING-DATASOURCE-URL}#'
export SPRING_DATASOURCE_USERNAME='#{SPRING-DATASOURCE-USERNAME}#'
export SPRING_DATASOURCE_PASSWORD='#{SPRING-DATASOURCE-PASSWORD}#'

# ------------------------------------------------------------
# PAPSS SHARED KEYSTORE (TLS + mTLS + XML SIGNING)
# ------------------------------------------------------------
export PAPSS_KEYSTORE_PASSWORD='#{PAPSS-KEYSTORE-PASSWORD}#'
export PAPSS_KEY_ALIAS='#{PAPSS-KEY-ALIAS}#'

# ------------------------------------------------------------
# PAPSS TRUSTSTORE
# ------------------------------------------------------------
export PAPSS_TRUSTSTORE_PASSWORD='#{PAPSS-TRUSTSTORE-PASSWORD}#'

# ------------------------------------------------------------
# GL ACCOUNT VALUES
# ------------------------------------------------------------
export PAPSS_SETTLEMENT_KES='#{PAPSS-SETTLEMENT-KES}#'
export PAPSS_SETTLEMENT_USD='#{PAPSS-SETTLEMENT-USD}#'
export PAPSS_BANK_INCOME_KES='#{PAPSS-BANK-INCOME-KES}#'

echo "Production environment variables have been set."
