# Using Undertow in PAPSS Middleware Service

## Overview

This document explains the switch from the default Tomcat web server to Undertow in the PAPSS Middleware Service application.

## Implementation Details

The following changes were made to switch from Tomcat to Undertow:

1. Removed the Tomcat dependency from the `dependencyManagement` section
2. Excluded `spring-boot-starter-tomcat` from `spring-boot-starter-web`
3. Added the `spring-boot-starter-undertow` dependency

These changes allow the application to use Undertow instead of Tomcat as the embedded web server.

## Benefits of Using Undertow

### Performance

- **Lower Memory Footprint**: Undertow generally uses less memory than Tomcat, which is beneficial for containerized environments and microservices.
- **Higher Throughput**: Undertow can handle more requests per second than Tomcat in many scenarios, especially for non-blocking workloads.
- **Better Scalability**: Undertow's non-blocking architecture allows it to scale better with increasing load.

### Technical Advantages

- **Non-Blocking I/O**: Undertow is built on a fully non-blocking I/O model based on XNIO, which can lead to better performance for asynchronous operations.
- **Lightweight**: Undertow has a smaller codebase and fewer dependencies than Tomcat.
- **Flexible Handler Chain**: Undertow's handler-based architecture allows for more flexible request processing.
- **WebSockets Support**: Undertow has excellent support for WebSockets, which could be useful if the PAPSS Middleware Service needs to implement real-time features in the future.

### Specific Benefits for PAPSS Middleware Service

- **Improved Polling Performance**: The PAPSS Middleware Service uses polling to check for incoming messages. Undertow's non-blocking I/O can handle these concurrent connections more efficiently.
- **Better Resource Utilization**: With a lower memory footprint, more resources are available for processing business logic rather than handling HTTP requests.
- **Containerization**: If the service is deployed in containers (as indicated by the Dockerfile and docker-compose.yml), Undertow's lower resource usage is particularly beneficial.

## Considerations

### Potential Challenges

- **Different Configuration**: If you need to configure specific web server settings, note that Undertow's configuration options differ from Tomcat's.
- **JSP Support**: If your application uses JSP, be aware that Undertow doesn't support JSP out of the box (though this doesn't appear to be an issue for this project).
- **Servlet Container Differences**: There might be subtle differences in how the servlet container behaves, especially for advanced servlet features.

### Monitoring

Monitor the following metrics after switching to Undertow:

- Memory usage
- Response times
- Error rates
- Connection pool utilization

## Conclusion

Switching to Undertow is a good choice for the PAPSS Middleware Service due to its lower memory footprint, better performance for non-blocking operations, and excellent scalability. These characteristics align well with the service's requirements for handling multiple concurrent connections and processing financial transactions efficiently.

The implementation is straightforward and requires minimal changes to the project configuration. The Spring Boot abstraction ensures that most of the application code doesn't need to be modified to work with a different web server.