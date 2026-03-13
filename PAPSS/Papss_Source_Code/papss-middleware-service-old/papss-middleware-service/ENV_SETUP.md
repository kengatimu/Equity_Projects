# Environment Variables Setup for PAPSS Middleware Service

This document provides instructions on how to set up the environment variables required for the PAPSS Middleware Service after the security improvements.

## Database Configuration

The following environment variables need to be set for the database configuration:

```
PAPSS_DB_URL=jdbc:postgresql://your-db-host:5432/papssdb
PAPSS_DB_USERNAME=your-db-username
PAPSS_DB_PASSWORD=your-db-password
```

## Participant Configuration

For each participant, the following environment variables need to be set:

### Participant LR (Liberia)
```
PAPSS_LR_API_KEY=your-api-key
PAPSS_LR_SALT=your-salt-value
PAPSS_LR_KEY_PASS=your-key-password
```

### Participant SL (Sierra Leone)
```
PAPSS_SL_API_KEY=your-api-key
PAPSS_SL_SALT=your-salt-value
PAPSS_SL_KEY_PASS=your-key-password
```

### Other Participants

Similar environment variables need to be set for all other participants following the same pattern:

```
PAPSS_<COUNTRY_CODE>_API_KEY=your-api-key
PAPSS_<COUNTRY_CODE>_SALT=your-salt-value
PAPSS_<COUNTRY_CODE>_KEY_PASS=your-key-password
```

## Keystore Configuration

The following environment variable needs to be set for the keystore configuration:

```
PAPSS_KEYSTORE_PATH=/path/to/your/keystore.jks
```

## Setting Environment Variables

### Linux/macOS

Add the following lines to your `~/.bashrc` or `~/.zshrc` file:

```bash
# PAPSS Middleware Service Environment Variables
export PAPSS_DB_URL=jdbc:postgresql://your-db-host:5432/papssdb
export PAPSS_DB_USERNAME=your-db-username
export PAPSS_DB_PASSWORD=your-db-password

# Participant LR
export PAPSS_LR_API_KEY=your-api-key
export PAPSS_LR_SALT=your-salt-value
export PAPSS_LR_KEY_PASS=your-key-password

# Participant SL
export PAPSS_SL_API_KEY=your-api-key
export PAPSS_SL_SALT=your-salt-value
export PAPSS_SL_KEY_PASS=your-key-password

# Add similar lines for other participants

# Keystore
export PAPSS_KEYSTORE_PATH=/path/to/your/keystore.jks
```

Then run:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

### Windows

Set environment variables using the System Properties dialog:

1. Right-click on "This PC" and select "Properties"
2. Click on "Advanced system settings"
3. Click on "Environment Variables"
4. Add each variable under "System variables" or "User variables"

Alternatively, you can set them using PowerShell:

```powershell
[Environment]::SetEnvironmentVariable("PAPSS_DB_URL", "jdbc:postgresql://your-db-host:5432/papssdb", "User")
[Environment]::SetEnvironmentVariable("PAPSS_DB_USERNAME", "your-db-username", "User")
[Environment]::SetEnvironmentVariable("PAPSS_DB_PASSWORD", "your-db-password", "User")
# Add similar lines for other variables
```

### Docker

If you're using Docker, add the environment variables to your `docker-compose.yml` file:

```yaml
version: '3'
services:
  papss-middleware-service:
    image: papss-middleware-service
    environment:
      - PAPSS_DB_URL=jdbc:postgresql://db:5432/papssdb
      - PAPSS_DB_USERNAME=your-db-username
      - PAPSS_DB_PASSWORD=your-db-password
      - PAPSS_LR_API_KEY=your-api-key
      - PAPSS_LR_SALT=your-salt-value
      - PAPSS_LR_KEY_PASS=your-key-password
      # Add similar lines for other variables
    volumes:
      - /path/to/your/keystore:/var/papss/certs
```

## Important Security Notes

1. Never commit environment variables with sensitive values to version control.
2. Use a secure method to manage and distribute these environment variables in production.
3. Consider using a secrets management solution like HashiCorp Vault, AWS Secrets Manager, or Kubernetes Secrets for production environments.
4. Regularly rotate API keys and passwords.