package com.papss.middleware.utils;

import com.github.mustachejava.DefaultMustacheFactory;
import com.github.mustachejava.Mustache;
import com.github.mustachejava.MustacheFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Map;

@Slf4j
@Component
public class MustacheTemplateEngine {

    private static final String TEMPLATE_FOLDER = "templates/";
    private static final String FILE_TYPE = ".xml";
    private final MustacheFactory mustacheFactory;

    public MustacheTemplateEngine() {
        this.mustacheFactory = new DefaultMustacheFactory();
    }

    /**
     * Renders an XML Mustache template with the provided values.
     *
     * @param templateName The template filename (without extension)
     * @param templateData Map containing key-value pairs for placeholders
     * @return The rendered XML string
     */
    public String render(String templateName, Map<String, Object> templateData) {
        String templatePath = TEMPLATE_FOLDER + templateName + FILE_TYPE;

        try (InputStream inputStream = new ClassPathResource(templatePath).getInputStream()) {
            if (inputStream == null) {
                log.error("Template '{}' not found in resources!", templatePath);
                throw new FileNotFoundException("Template not found: " + templatePath);
            }

            // Read template content
            String templateContent = readInputStream(inputStream);

            // Compile and render Mustache template
            Mustache mustache = mustacheFactory.compile(new StringReader(templateContent), templateName);
            StringWriter writer = new StringWriter();
            mustache.execute(writer, templateData).flush();

            return writer.toString();
        } catch (IOException e) {
            log.error("Error rendering Mustache template '{}'", templateName, e);
            throw new RuntimeException("Failed to render template: " + templateName, e);
        }
    }

    /**
     * Reads an InputStream and converts it to a String.
     */
    private String readInputStream(InputStream inputStream) throws IOException {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
            return content.toString();
        }
    }
}
