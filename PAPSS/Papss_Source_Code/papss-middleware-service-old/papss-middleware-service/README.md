# PAPSS Middleware Service

## Overview
The PAPSS (Pan-African Payment and Settlement System) Middleware Service is a Java-based application that facilitates communication between financial institutions and the PAPSS network. It serves as an intermediary layer that handles message transformation, routing, and processing for cross-border payments across African countries.

This middleware enables secure, certificate-based communication with the PAPSS network, supports polling for inbound messages, and exposes REST APIs for outgoing transactions and status checks.

## Features
- **ISO20022 Message Processing**: Handles standard financial message formats for interoperability
- **Secure Communication**: Certificate-based authentication with the PAPSS network
- **Multi-Participant Support**: Configurable for multiple financial institutions across different countries
- **Bidirectional Communication**:
  - Outbound: REST APIs for credit transfers, name enquiries, and transaction status
  - Inbound: Scheduled polling for incoming messages from PAPSS
- **Transaction Logging**: Persistent storage of all transactions and messages
- **Docker Support**: Containerized deployment with database service

## Technical Stack
- **Java**: JDK 21 (with compiler compatibility for JDK 17+)
- **Framework**: Spring Boot 3.4.5
- **Database**: PostgreSQL (with support for Oracle, MariaDB, MySQL, MS SQL Server)
- **Dependencies**: JPA, Validation, HTTP Client, JAXB, OpenAPI tools
- **Message Templates**: Mustache-based templating for ISO20022 messages
- **API Documentation**: OpenAPI/Swagger

## Project Structure
- **Source Code**: Located under `src/main/java`
  - `config`: Spring configuration classes (ParticipantsConfig, SystemConfig)
  - `controller`: REST controllers for name enquiry, credit transfer, etc.
  - `service`: Core services for signature creation, message sending, and processing
  - `service/outbound` & `service/inbound`: ISO20022 message generation and processing
  - `utils`: Helper utilities for templating, HTTP access, parsing, etc.
- **Resources**: Located under `src/main/resources`
  - Templates and XSDs for message formats and JAXB bindings
  - Configuration files

## Key Concepts

### Participants Configuration
The `application.yml` defines participants with certificates, API keys, and keystore information. These entries are loaded via `ParticipantsConfig` to validate requests and manage SSL connections.

### Message Handling
- **Outbound**: Services use Mustache templates to build XML messages signed by PapssSignature
- **Inbound**: `MessageExecutorService` periodically polls PAPSS, dispatching messages to processors based on message type

### Logging & Persistence
Transactions and inbound messages are stored via JPA entities (`Transaction` and `PapssMessage`), with `LoggerService` updating or inserting records based on processing outcome.

### API Endpoints
Key APIs include name enquiry, credit transfer, and transaction status, each with specific request/response formats.

## Setup and Installation

### Prerequisites
- JDK 21 (or JDK 17+)
- PostgreSQL database
- SSL certificates for PAPSS communication

### Configuration
1. Configure database connection in `application.yml`
2. Set up participant details with proper certificates and API keys
3. Configure core banking integration URLs

### Running the Application
#### Using Maven
```bash
./mvnw spring-boot:run
```

#### Using Docker
```bash
docker-compose up -d
```

## Getting Started for Developers

### 1. Review the Configuration
Examine `application.yml` for participant definitions, system settings, and core banking URLs. Understanding these values is essential to run the service locally or in Docker.

### 2. Understand Message Templates and Utilities
Look at files in `src/main/resources/templates` along with `RequestUtils` and `ResponseUtils` to see how ISO20022 messages are generated and parsed.

### 3. Explore Inbound vs Outbound Services
Study `CreditTransferService`, `NameEnquiryService`, and inbound processors such as `NameEnquiryProcessor` or `TransactionComfirmationProcessor` to grasp the flow from receiving a message to responding or logging.

### 4. Check Scheduled Execution
`MessageExecutorService` uses a scheduled method to poll PAPSS at regular intervals. Understanding this mechanism is key for processing inbound messages.

### 5. Deepen ISO20022 Knowledge
Since message formats rely on ISO20022 schemas, familiarity with these standards will help when extending or troubleshooting the system.
