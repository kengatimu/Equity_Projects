# SpringDoc OpenAPI Compatibility Fix

## Issue Description

The application was encountering the following error when starting up:

```
java.lang.NoSuchMethodError: 'void org.springframework.web.method.ControllerAdviceBean.<init>(java.lang.Object)'
	at org.springdoc.core.service.GenericResponseService.lambda$getGenericMapResponse$8(GenericResponseService.java:700)
```

This error occurred because the SpringDoc OpenAPI version 2.4.0 is not compatible with Spring Boot 3.4.5. The specific issue is that SpringDoc is trying to use a constructor in `ControllerAdviceBean` that doesn't exist in the version of Spring Web that comes with Spring Boot 3.4.5.

## Solution Implemented

To resolve this issue, we disabled the SpringDoc OpenAPI functionality in the application configuration:

1. Updated `application.yml` to disable SpringDoc API docs and Swagger UI:
   ```yaml
   springdoc:
     api-docs:
       path: /api-docs
       enabled: false
     swagger-ui:
       path: /swagger-ui.html
       enabled: false
   ```

2. Made the same changes to `application-etz.yml` for consistency across environments.

## Alternative Solutions Considered

1. **Downgrading Spring Boot**: We attempted to downgrade Spring Boot from 3.4.5 to 3.2.5, but this caused build issues with Lombok-generated methods.

2. **Upgrading SpringDoc OpenAPI**: We attempted to upgrade SpringDoc OpenAPI to version 2.5.0, but this version was not available in the configured repositories.

## Recommendations for Future Updates

1. **Re-enable SpringDoc OpenAPI when compatible version is available**: Once a version of SpringDoc OpenAPI that is compatible with Spring Boot 3.4.5 becomes available, you can re-enable it by setting `enabled: true` in the configuration.

2. **Consider using Spring Boot's built-in API documentation**: Spring Boot provides its own API documentation capabilities that might be more compatible with the current version.

3. **Monitor SpringDoc OpenAPI releases**: Keep an eye on SpringDoc OpenAPI releases for a version that explicitly supports Spring Boot 3.4.x.

4. **Test thoroughly after re-enabling**: When re-enabling SpringDoc OpenAPI, make sure to test thoroughly to ensure compatibility.

## Impact

The current solution disables the Swagger UI and API documentation, which means:

1. Developers won't be able to use the Swagger UI to explore and test the API.
2. API consumers won't be able to access the OpenAPI specification at the `/api-docs` endpoint.

However, the core functionality of the application remains intact, and the application can start up without errors.