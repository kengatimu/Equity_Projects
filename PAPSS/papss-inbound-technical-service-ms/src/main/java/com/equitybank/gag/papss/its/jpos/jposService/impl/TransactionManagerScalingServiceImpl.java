package com.equitybank.gag.papss.its.jpos.jposService.impl;

import com.equitybank.gag.papss.its.jpos.jposService.QueueMonitorService;
import com.equitybank.gag.papss.its.jpos.jposService.TransactionManagerFileGeneratorService;
import com.equitybank.gag.papss.its.jpos.jposService.TransactionManagerScalingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FilenameFilter;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.concurrent.CopyOnWriteArrayList;

@Service
public class TransactionManagerScalingServiceImpl implements TransactionManagerScalingService {
    private static final Logger log = LoggerFactory.getLogger(TransactionManagerScalingServiceImpl.class);

    private final TransactionManagerFileGeneratorService fileGeneratorService;
    private final QueueMonitorService queueMonitorService;
    private final int maxTms;
    private final String tmQueuePrefix;       // Example: "papss-credit-transfer-q"
    private final String tmFilenamePrefix;    // Example: "papss-credit-transfer-tm-"
    private final String deployDir;           // Absolute path to Q2 TM deploy directory

    // Holds the currently active TM queue names (e.g., q1, q2, q3, ...)
    private final CopyOnWriteArrayList<String> activeTmQueues;

    // Keeps track of the next available TM index to use when scaling
    private int nextTmIndex;

    public TransactionManagerScalingServiceImpl(TransactionManagerFileGeneratorService fileGeneratorService,
                                                QueueMonitorService queueMonitorService,
                                                @Value("${jpos.tm.max-tms}") int maxTms,
                                                @Value("${jpos.tm.tm-queue-prefix}") String tmQueuePrefix,
                                                @Value("${jpos.tm.tm-filename-prefix}") String tmFilenamePrefix,
                                                @Value("${jpos.tm.q2-tm-dir}") String deployDir) {
        this.fileGeneratorService = fileGeneratorService;
        this.queueMonitorService = queueMonitorService;
        this.maxTms = maxTms;
        this.tmQueuePrefix = tmQueuePrefix;
        this.tmFilenamePrefix = tmFilenamePrefix;
        this.deployDir = deployDir;

        // Initializes a sorted set to hold all unique and sorted active TM queue names.
        Set<String> uniqueDiscoveredTmQueues = new TreeSet<>();

        // Adds the default, baseline TM queues (q1 and q2) as the initial active set. TreeSet ensures uniqueness
        uniqueDiscoveredTmQueues.add(tmQueuePrefix + "1");
        uniqueDiscoveredTmQueues.add(tmQueuePrefix + "2");

        // Recovers active TMs from deploy files into the unique set and determines the next available TM index for seamless restarts.
        this.nextTmIndex = determineNextTmIndexAndPopulateQueues(deployDir, tmFilenamePrefix, tmQueuePrefix, uniqueDiscoveredTmQueues);

        // Initialize final active queue list as thread-safe CopyOnWriteArrayList
        this.activeTmQueues = new CopyOnWriteArrayList<>(uniqueDiscoveredTmQueues);
        Collections.sort(this.activeTmQueues); // Optional: ensure sorted order

        // Logs the final initialized state of active TM queues and the starting index for new TMs.
        log.info("TransactionManagerScalingService initialized with active queues: {}. Next TM index: {}", activeTmQueues, nextTmIndex);
    }

    @Override
    public String startNewTm(String rrn) {
        // Do not scale if max limit already reached
        if (activeTmQueues.size() >= maxTms) {
            log.warn("{}: Cannot start new TM. Max limit of {} reached.", rrn, maxTms);
            return null;
        }

        // Generate new TM XML file from template (e.g., tm-5.xml)
        String newQueueName = fileGeneratorService.generateTmXmlFile(rrn, nextTmIndex);
        if (newQueueName != null) {
            activeTmQueues.add(newQueueName);         // Add new queue name to active list
            Collections.sort(activeTmQueues);         // Optional: keep it sorted
            log.info("{}: Started new TM with queue '{}'. Active TMs: {}", rrn, newQueueName, activeTmQueues.size());

            nextTmIndex++;                            // Increment counter for next TM
            return newQueueName;
        } else {
            log.error("{}: Failed to generate TM file for index {}", rrn, nextTmIndex);
            return null;
        }
    }

    @Override
    public List<String> getActiveTmQueues() {
        // Return a read-only list of active queues to prevent accidental modification
        return Collections.unmodifiableList(activeTmQueues);
    }

    @Override
    // Use QueueMonitorService (JMX-backed) to get current queue depth
    public int getQueueDepth(String rrn, String queueName) {
        return queueMonitorService.getQueueDepth(rrn, queueName);
    }

    /**
     * During application startup (including after a restart), we:
     * - Scan the deploy directory for existing TM XML files (e.g., tm-3.xml, tm-4.xml)
     * - Reconstruct their corresponding queue names (e.g., q3, q4) into the set to avoid losing track
     * - Calculate the correct nextTmIndex based on the highest TM found to continue auto-scaling properly
     **/
    private int determineNextTmIndexAndPopulateQueues(String deployPath, String tmFilenamePrefix, String tmQueuePrefix, Set<String> discoveredQueuesSet) {
        File dir = new File(deployPath);
        int maxFoundIndex = 2; // Start with assumption that tm-1 and tm-2 exist

        // If directory doesn't exist or is invalid, fall back to default
        if (!dir.exists() || !dir.isDirectory()) {
            log.warn("TM deploy path '{}' not found or invalid. Defaulting nextTmIndex to 3.", deployPath);
            return maxFoundIndex + 1;
        }

        // Filter to only include files starting with prefix and ending with .xml
        FilenameFilter tmXmlFilter = new FilenameFilter() {
            @Override
            public boolean accept(File dir, String name) {
                return name.startsWith(tmFilenamePrefix) && name.endsWith(".xml");
            }
        };

        // List all files in the deploy directory that match the TM XML naming pattern (e.g., papss-credit-transfer-tm-*.xml)
        File[] files = dir.listFiles(tmXmlFilter);
        if (files != null) {
            for (File file : files) {
                String filename = file.getName(); // e.g., "papss-credit-transfer-tm-10.xml"
                try {
                    // Extract number: remove prefix and suffix
                    String suffix = filename.substring(tmFilenamePrefix.length(), filename.length() - 4);
                    int index = Integer.parseInt(suffix);

                    // Update max index if needed
                    if (index > maxFoundIndex) {
                        maxFoundIndex = index;
                    }

                    // Add discovered queue name (e.g., "papss-credit-transfer-q10")
                    discoveredQueuesSet.add(tmQueuePrefix + index);
                } catch (NumberFormatException e) {
                    // Skip files with non-numeric suffix
                    log.debug("Skipping invalid TM file '{}': cannot extract numeric index.", filename);
                }
            }
        }

        // Return the next available TM index (max found + 1)
        return maxFoundIndex + 1;
    }
}
