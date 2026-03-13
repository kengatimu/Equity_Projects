# Oracle Database Configuration for Arabic Support

This document provides instructions for configuring the PAPSS Middleware Service to work with Oracle Database with proper support for Arabic character sets.

## Prerequisites

1. Oracle Database (11g or later) installed and configured
2. The database should be created with one of the following character sets:
   - AL32UTF8 character set (recommended for multilingual support including Arabic)
   - AR8MSWIN1256 character set (specific for Arabic Windows code page 1256 support)

## Oracle Database Configuration

### Check Current Character Set

To check the current character set of your Oracle database:

```sql
SELECT value FROM nls_database_parameters WHERE parameter = 'NLS_CHARACTERSET';
```

The recommended character set for multilingual support including Arabic is `AL32UTF8`. However, if you specifically need to support the Windows code page 1256 for Arabic, you can use `AR8MSWIN1256`.

### Check NLS Parameters

To check the NLS parameters:

```sql
SELECT * FROM nls_database_parameters WHERE parameter LIKE 'NLS%';
```

### Set NLS Parameters for Arabic Support

If you need to set NLS parameters at the session level:

```sql
ALTER SESSION SET NLS_LANGUAGE = 'ARABIC';
ALTER SESSION SET NLS_TERRITORY = 'SAUDI ARABIA';
```

## Application Configuration

### Using the Oracle Profile

To use the Oracle configuration with Arabic support, run the application with the `oracle` profile:

```bash
java -jar papss-middleware-service.jar --spring.profiles.active=oracle
```

Or set the environment variable:

```bash
export SPRING_PROFILES_ACTIVE=oracle
```

### Configuration Properties

The Oracle configuration is defined in `application-oracle.yml`. Key settings include:

1. JDBC URL for Oracle connection:
   ```yaml
   url: jdbc:oracle:thin:@//localhost:1521/XEPDB1
   ```

2. HikariCP data source properties for AR8MSWIN1256 character set support:
   ```yaml
   data-source-properties:
     oracle.jdbc.defaultNChar: true
     oracle.jdbc.convertNcharLiterals: true
     oracle.jdbc.defaultNCharCharacterSet: AR8MSWIN1256
     oracle.jdbc.JavaCharSet: AR8MSWIN1256
   ```

   These properties configure the Oracle JDBC driver to use the AR8MSWIN1256 character set for handling Arabic characters:
   - `oracle.jdbc.defaultNChar`: Enables NCHAR conversion
   - `oracle.jdbc.convertNcharLiterals`: Converts literals to NCHAR
   - `oracle.jdbc.defaultNCharCharacterSet`: Sets the character set for NCHAR, NVARCHAR2, and NCLOB data types
   - `oracle.jdbc.JavaCharSet`: Sets the character set for the Java side of the connection

### Customizing the Configuration

You can customize the Oracle configuration by setting the following environment variables:

- `PAPSS_DB_URL`: The JDBC URL for the Oracle database
- `PAPSS_DB_USERNAME`: The database username
- `PAPSS_DB_PASSWORD`: The database password

Example:

```bash
export PAPSS_DB_URL=jdbc:oracle:thin:@//your-oracle-server:1521/YOUR_SERVICE
export PAPSS_DB_USERNAME=your_username
export PAPSS_DB_PASSWORD=your_password
export SPRING_PROFILES_ACTIVE=oracle
```

Note that the character set configuration is handled by the HikariCP data source properties in the application-oracle.yml file, not in the JDBC URL.

## Database Schema Considerations

When working with Arabic data, consider using NVARCHAR2 data type for columns that will store Arabic text. This ensures proper storage and retrieval of Arabic characters.

Example:

```sql
CREATE TABLE customer (
    id NUMBER PRIMARY KEY,
    name NVARCHAR2(100),
    address NVARCHAR2(200)
);
```

## Troubleshooting

### Character Encoding Issues

If you encounter character encoding issues:

1. Verify that the Oracle database is using the correct character set:
   - AL32UTF8 for multilingual support
   - AR8MSWIN1256 for Windows code page 1256 Arabic support
2. Check that the HikariCP data source properties are correctly configured for AR8MSWIN1256:
   ```yaml
   data-source-properties:
     oracle.jdbc.defaultNChar: true
     oracle.jdbc.convertNcharLiterals: true
     oracle.jdbc.defaultNCharCharacterSet: AR8MSWIN1256
     oracle.jdbc.JavaCharSet: AR8MSWIN1256
   ```
3. Ensure that the orai18n.jar is in the classpath (included in the project dependencies)
4. Verify that the data is being stored using NVARCHAR2 data type for Arabic text

### Connection Issues

If you encounter connection issues:

1. Verify that the Oracle service name is correct in the JDBC URL
2. Check that the username and password are correct
3. Ensure that the Oracle JDBC driver is in the classpath
4. Verify that the Oracle database is running and accessible from the application server

## References

- [Oracle Database Globalization Support Guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/nlspg/index.html)
- [Oracle JDBC Driver Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/19/jjdbc/index.html)