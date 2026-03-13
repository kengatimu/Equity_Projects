#!/bin/bash

# Database configs
export CD_SPRING_DATASOURCE_URL="#{CD-SPRING-DATASOURCE-URL}#"
export CD_SPRING_DATASOURCE_USERNAME="#{CD-SPRING-DATASOURCE-USERNAME}#"
export CD_SPRING_DATASOURCE_PASSWORD="#{SPRING-DATASOURCE-PASSWORD}#"

# Print a confirmation message

echo "Environment variables have been set."