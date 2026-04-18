/**
 * Note that although Properties class inherits put() method and putAll() method from Hashtable class,
 * I wouldn't recommend you use them for the same reason as for get() method: only String values can be used in Properties.
 * The code below will not work as you wish, when you use getProperty() to get its value due to the integer value;
 * it will return null:
 *    property.put("version", 2);
 * source: (https://www.baeldung.com/java-properties)
 * Always use setProperty and getProperty methods instead.
 *
 */
package com.bishop.ke.kafkaapis;

import java.util.Properties;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;


public class KafkaImpl {

    public static void main(String[] args) {
        /* 
        * To Implement Kafka Producer API, below 4 steps are required;
        
        * Step 1 - Create a property object
        * Step 2 - Create a KafkaProducer object 
        * Step 3 - Create a ProducerRecord object
        * Step 4 - Send the record to the producer
        
         */

        basicProducerApiImpl();
    }
    //Creating Producer from Producer API

    private static void basicProducerApiImpl() {

        //creating basic producer variables
        String bootSrtapServers = "localhost:9092,localhost:9093";
        String key = "Key1";
        String value = "Java basicProducerApiImpl";
        String topicName = "basicProducerTopic";

        //Step 1 - Creating a property object
        Properties property = new Properties();

        //packaging the variables into the property object
        property.setProperty("bootstrap.servers", bootSrtapServers); 
        property.setProperty("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        property.setProperty("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        //check https://kafka.apache.org/10/javadoc/index.html?org/apache/kafka/clients/producer/KafkaProducer.html for more properties

       //Step 2 - Creating a KafkaProducer object 
        Producer<String, String> producer = new KafkaProducer<>(property);
        
        //Step 3 - Creating a ProducerRecord object
        ProducerRecord<String, String> record = new ProducerRecord<>(topicName, key, value);
        
        //Step 4 - Sending the record to the producer
        producer.send(record); 
        
        //closing the producer instance
        producer.close();
        
        System.out.println("\nSimpleProducer Completed.");
        
    }

}


Now check consumer console for the message
kennedy@kennedy-HP-ProBook-450-G5 /opt/kafka/kafka_2.12-2.4.0 $ bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic basicProducerTopic --
	from-beginning
		Java basicProducerApiImpl
		Java basicProducerApiImpl
		^CProcessed a total of 2 messages
kennedy@kennedy-HP-ProBook-450-G5 /opt/kafka/kafka_2.12-2.4.0 $ bin/kafka-console-consumer.sh --bootstrap-server localhost:9093 --topic basicProducerTopic --from-beginning
		Java basicProducerApiImpl
		Java basicProducerApiImpl
