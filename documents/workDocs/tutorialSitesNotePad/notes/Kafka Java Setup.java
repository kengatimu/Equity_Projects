A. Creating Java Producer
	Basically, there are four steps to create a java producer:

		1. Create producer properties
		2. Create the producer
		3. Create a producer record
		4. Send the data.
		
	The required properties are:

		1. bootstrap.servers: 
			It is a list of the port pairs which are used for establishing an initial connection to the Kafka cluster. 
			The users can use the 	bootstrap servers only for making an initial connection only. This server is present in the host:port, host:port,... form.
		2. key.serializer: 
			It is a type of Serializer class of the key which is used to implement the 'org.apache.kafka.common.serialization.Serializer' interface.
		3. value.serializer: 
			It is a type of Serializer class which implements the 'org.apache.kafka.common.serialization.Serializer' interface.	
			
			
See Below Code
			
package com.bishop.ke.reflection.kafkabasics;

import java.util.Properties;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;

public class BasicKafkaImpl {

    public static void main(String[] args) {
        //1. Creating producer properties
        String bootStrapServers = "localhost:9092";
        Properties properties = new Properties();
        properties.setProperty(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootStrapServers);
        properties.setProperty(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        properties.setProperty(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());

        //2. Creating the producer
        KafkaProducer<String, String> kafkaProducer = new KafkaProducer<>(properties);

        //3. Creating a producer record - Publisher Record publishes to a Topic (Topic01)
        try {

            ProducerRecord<String, String> producerRec = new ProducerRecord<>("Topic01", "This is the First Java Message...");

            //4. Sending the data. To send Data, producer invokes the object of ProducerRecord
            System.out.println("Sending Record");
            kafkaProducer.send(producerRec);

        } catch (Exception ex) {
            System.out.println("Exception occured: " + ex);

        } finally {
            /*The flush() will force all the data to get produced and close() stops the producer. 
                If these functions are not executed, data will never be sent to the Kafka, 
                and the consumer will not be able to read it.
             */
             System.out.println("Closing kafkaRecord");
            if (kafkaProducer != null) {
                kafkaProducer.flush();
                kafkaProducer.close();
            } else {
                System.out.println("kafka producer is not null");
            }

        }
    }
}




