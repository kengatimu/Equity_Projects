#!/bin/bash

# Export the Jasypt secret key as an environment variable
export CD_SPRING_DATASOURCE_URL="#{CD-SPRING-DATASOURCE-URL}#"
export CD_SPRING_DATASOURCE_USERNAME="#{CD-SPRING-DATASOURCE-USERNAME}#"
export CD_SPRING_DATASOURCE_PASSWORD="#{SPRING-DATASOURCE-PASSWORD}#"
export CD_SSL_KEYSTORE_LOCATION="/u01/gag/drcb2c/certs/equitybank.co.ke.p12"
#export CD_SSL_KEYSTORE_LOCATION="/u01/gag/pipelines/certs/equitybank.co.ke.p12"
export CD_SSL_KEYSTORE_PASSWORD="456123"
export CD_SSL_KEYSTORE_ALIAS="1"

export CD_SECURITY_JWT_SECRET_KEY="icUIRr1mA+NjF944xIsVO1b47I1PgCZjCGoJxSgtAds="
export CD_SECURITY_JWT_USERNAME="uat"
export CD_SECURITY_JWT_PASSWORD="R7\$wY9xt*bdQ&z5w"
export CD_SECURITY_CHANNELS_CERTIFICATE_FOLDER="/u01/gag/certs/EQUITY-CHANNELS/"
export CD_FINACLE_FI_ENDPOINT="https://finaclepreprodweb.ebsafrica.com:11500/FISERVLET/fihttp"

# Print a confirmation message
echo "Environment variables have been set."