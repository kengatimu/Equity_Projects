package com.equitybank.gag.papss.ots.jpos.jposService.impl;

import com.equitybank.gag.papss.ots.jpos.jposService.TransactionManagerFileGeneratorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.nio.charset.StandardCharsets;

@Service
public class TransactionManagerFileGeneratorServiceImpl implements TransactionManagerFileGeneratorService {
    private static final Logger log = LoggerFactory.getLogger(TransactionManagerFileGeneratorServiceImpl.class);

    private final String tmFilenamePrefix;
    private final String tmQueueNamePrefix;
    private final String q2TransactionManagerDir;
    private final String tmTemplateRelativePath;
    private final String q2StatesRelativePath;

    public TransactionManagerFileGeneratorServiceImpl(@Value("${jpos.tm.tm-filename-prefix}") String tmFilenamePrefix,
                                                      @Value("${jpos.tm.tm-queue-prefix}") String tmQueueNamePrefix,
                                                      @Value("${jpos.tm.q2-tm-dir}") String q2TransactionManagerDir,
                                                      @Value("${jpos.tm.tm-template-relative-path}") String tmTemplateRelativePath,
                                                      @Value("${jpos.tm.q2-states-relative-path}") String q2StatesRelativePath) {
        this.tmFilenamePrefix = tmFilenamePrefix;
        this.tmQueueNamePrefix = tmQueueNamePrefix;
        this.q2TransactionManagerDir = q2TransactionManagerDir;
        this.tmTemplateRelativePath = tmTemplateRelativePath;
        this.q2StatesRelativePath = q2StatesRelativePath;
    }

    @Override
    public String generateTmXmlFile(String rrn, int tmIndex) {
        log.info("{}: Generating a new TM file in : {}", rrn, q2TransactionManagerDir);

        String newQueueName = tmQueueNamePrefix + tmIndex;
        String newTmXmlFilename = tmFilenamePrefix + tmIndex + ".xml";
        File newTmXmlFile = new File(q2TransactionManagerDir, newTmXmlFilename);
        File templateFile = new File(q2TransactionManagerDir, tmTemplateRelativePath);

        // Read template XML content from the file system.
        try {
            String tmXmlContent;
            try (Reader reader = new FileReader(templateFile, StandardCharsets.UTF_8)) {
                tmXmlContent = FileCopyUtils.copyToString(reader);
            }

            // Replace placeholders with actual values.
            tmXmlContent = tmXmlContent
                    .replace("${tm.index}", String.valueOf(tmIndex))
                    .replace("${q2.states.relative.path}", q2StatesRelativePath);

            // Write the transformed content to the new XML file.
            try (FileWriter writer = new FileWriter(newTmXmlFile)) {
                writer.write(tmXmlContent);
            }
            log.info("{}: Generated new TM file: {}", rrn, newTmXmlFile.getAbsolutePath());
            return newQueueName;

        } catch (IOException e) {
            log.error("{}: Failed to generate TM XML file. Exception occurred {}: {}", rrn, newTmXmlFile.getAbsolutePath(), e.getMessage());
            return null;
        }
    }
}