Linnux
A. ZooKeeper
	Installing Zookeeper
		sudo apt-get install zookeeperd
		Now, ZooKeeper is installed, and it will be started as a daemon automatically.
	
	Starting Zookeeper Manually
		
		sudo chmod -R 777 /usr/share/zookeeper/
		sudo chmod -R 777 /var/log/zookeeper/
		sudo chmod -R 777 /var/lib/zookeeper/

		$ cd /usr/share/zookeeper/bin 
		$ ./zkServer.sh start

		sudo netstat -nlpt | grep ':2181'
	
	Stoping Zookeeper Manually
		$ cd /usr/share/zookeeper/bin 
		$ ./zkServer.sh stop

B. Kafka
	Download the latest kafka release and un-tar it.

	$ tar -xzf kafka_2.12-2.4.0.tgz 
	$ sudo mkdir /opt/kafka
	$ sudo mv kafka_2.12-2.4.0 /opt/kafka
	
	To be able to delete topic
		cd /opt/kafka/kafka_2.12-2.4.0/config
		vim server.properties
		# Switch to enable topic deletion or not, default value is false
		delete.topic.enable=true
		
	Starting Kafka
		1. Start Zookeper
            > bin/zookeeper-server-start.sh config/zookeeper.properties
		2. Start kafka manually:
			$ cd /opt/kafka/kafka_2.12-2.4.0 
			$ bin/kafka-server-start.sh config/server.properties
			
	Now, we can check listening ports:
		netstat -nlpt
			tcp6       0      0 :::9092                 :::*                    LISTEN      30610/java      
			tcp6       0      0 :::2181                 :::*                    LISTEN      28712/java  
			
	Stopping Kafka server (broker)
		After performing all the operations, we can stop the server using the following command:
			$ cd /opt/kafka/kafka_2.12-2.4.0 
			$ bin/kafka-server-stop.sh config/server.properties		

C. Create Kafka Topic
		$ cd /opt/kafka/kafka_2.12-2.4.0 
		$ bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic myFirstTopic --partitions 1 --replication-factor 1

D. Deleting Kafka Topic
	From server properties file:
		cd /opt/kafka/kafka_2.12-2.4.0/config
		vim server.properties
		# Switch to enable topic deletion or not, default value is false
		delete.topic.enable=true
			
		$ cd /opt/kafka/kafka_2.12-2.4.0 
		$ bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic testTopic
		
E. Listing Kafka Topics
		$ cd /opt/kafka/kafka_2.12-2.4.0 
		$ bin/kafka-topics.sh --zookeeper localhost:2181 --list
	
F. Describing all topics
		$ cd /opt/kafka/kafka_2.12-2.4.0 
		$ bin/kafka-topics.sh --zookeeper localhost:2181 --describe
		
		This command gives the whole description of a topic with the number of partitions, leader, replicas and, ISR.
		
G. Describing a specific topic	
		$ cd /opt/kafka/kafka_2.12-2.4.0 
		$ bin/kafka-topics.sh --zookeeper localhost:2181 --describe --topic myFirstTopic
		
H. Sending data to Kafka Topics
	In order to send data to the Kafka topic, a producer is required. 
	The role of the producer is to send or write data/messages to the Kafka topics.
	
	NoTe:	1. A 'broker-list' (Broker Address) and a 'topic id' is required to produce a message. 
				Remember, Broker is the server/host/machine that house kafka. One broker is one server	
			2. The Console in kafka-console is just to show that we are sending/ receiving messages through console.	
				
		
	H.1 Creating/ Starting a Producer
		$ cd /opt/kafka/kafka_2.12-2.4.0 
		$ bin/kafka-console-producer.sh --broker-list localhost:9092 --topic myFirstTopic
			>This is my first Kafka message
			>This is the second line
			>
	
	H.2 Creating/ Starting a Consumer
		A 'bootstrap-server' is required for the consumer to get connected to the Kafka topics. 
		'bootstrap-server' is another name of producer 'broker-list' / broker address
		Also, a 'topic_id' is required to know from which topic the consumer will read the messages.	
			
		NoTe:	1. A Kafka consumer will consume only those messages which are produced only when the consumer was in the active state. 
				This can be categorized as a disadvantage of Apache Kafka.	
				2. However, you can include '--from-beginning' to read the whole message even when the consumer was inactive
		
		$ cd /opt/kafka/kafka_2.12-2.4.0 
		$ bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic myFirstTopic
			This is the second line
			
		Note: 	'This is my first Kafka message' is not displayed since at that time, consumer was not started/ inactive state.
				To show the whole message, includ the '--from-beginning'.
			
			$ cd /opt/kafka/kafka_2.12-2.4.0 
			$ bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic myFirstTopic --from-beginning
				This is my first Kafka message
				This is the second line


		
		
I. Multi-node Kafka Cluster
	To be able to demonstrate one Leader and two Followers, I need a three-node Kafka cluster. In an ideal Cluster, we install one Broker on one computer. 
	But for a demonstration or a development activity, we can start multiple Brokers on a single machine. So let's do it.
		
	Steps:
		1. Since we cannot start multiple Brokers using the same properties, we must make copies of the server properties file and modify them accordingly.
			$ cd /opt/kafka/kafka_2.12-2.4.0 
			$ cp config/server.properties config/server-1.properties
			$ cp config/server.properties config/server-2.properties
			
			Now we have 3 server properties file
			
			$ ll config/server*
				-rwxrwxr-x 1 kennedy kennedy 6938 Feb 10 06:01 config/server-1.properties*
				-rwxrwxr-x 1 kennedy kennedy 6938 Feb 10 06:01 config/server-2.properties*
				-rwxrwxrwx 1 root    root    6938 Feb  9 14:52 config/server.properties*
				
		2. Change the following 3 properties in the properties files newly created:
			1. Broker id
				Broker id is a unique identifier for the Broker. 
				The default values for the first broker is zero, so we will change it to 1 for the second broker, and 2 for the third Broker. 
				This change is to provide a unique identification to each broker.
			2. Broker port		
				Broker port is a network port number to which Broker will bind itself. 
				The Broker will use this port number to communicate with producers and consumers. 
				We will just increment it to whatever the default value is there (Default is 9092).  
					
				Note:	When you start brokers on separate systems, you donnot need to change this port number, but since we are starting them on a single machine, 						we need to change it. 
						Otherwise, all brokers will start reading and writing on the same port number.
			3. Broker log directory 		
				Broker log directory is the main data directory of a Broker. 
				We donnot want all of the brokers to write into the same directory, so we need to change this value as well.
		
		3. Once done, start all the brokers:
			a. Start zookeeper.
			b. 	$ cd /opt/kafka/kafka_2.12-2.4.0 
				$ bin/kafka-server-start.sh config/server.properties 
				$ bin/kafka-server-start.sh config/server-1.properties 
				$ bin/kafka-server-start.sh config/server-2.properties 
			c. Check processes: 
				$ netstat -nlpt | grep ':90'
					(Not all processes could be identified, non-owned process info
					 will not be shown, you would have to be root to see it all.)
					tcp6       0      0 :::9092                 :::*                    LISTEN      14580/java      
					tcp6       0      0 :::9093                 :::*                    LISTEN      15013/java      
					tcp6       0      0 :::9094                 :::*                    LISTEN      15438/java 
	
		4. Create Topics with replication factor of 3:
			$ cd /opt/kafka/kafka_2.12-2.4.0 
			$ bin/kafka-topics.sh --create --zookeeper localhost:2181 --partitions 3 --replication-factor 3 --topic testTopic02


		5. Describe the topic:
			$ bin/kafka-topics.sh --zookeeper localhost:2181 --describe --topic testTopic02
				Topic: testTopic02	PartitionCount: 3	ReplicationFactor: 3	Configs: 

				Topic: testTopic02	Partition: 0	Leader: 1	Replicas: 1,2,0	Isr: 1,2,0
				Topic: testTopic02	Partition: 1	Leader: 2	Replicas: 2,0,1	Isr: 2,0,1
				Topic: testTopic02	Partition: 2	Leader: 0	Replicas: 0,1,2	Isr: 0,1,2

					
			NOTE: If we created 2 partitions instead, we could have two partitions on this Topic; two rows, one for each partition.
				
			Partition id
				The id for the first partition in our example is 0, 1 for the second and it is 2 for the third partition.
					
			Leader
				So, for the first partition, Broker 1 is the leader. 
				What does that mean? That means that the Broker 1 will store and maintain the first copy of this partition and it will also fulfil all client 					requests for this partition. 
				Similarly, the Broker 2 and 3 are the leaders of the second and third partitions respectively.
					
			Replicas
				For the first partition, you will see three copies, Broker 1 maintains the first copy, and that one is the leader also. Broker 2 manages second 				copy, and Broker 0 holds the third copy. The Broker 2 and Broker 0 are the followers.

			What is the ISR?
				The ISR is a list of In Sync Replicas. You might have three copies, but one of them may not be in sync with the leader. 
				So, The ISR shows the list of replicas that are in sync with the Leader. 
				In our case, all three are in sync.		
			
Windows	
	

A. Running a Kafka Server
	Important: Please ensure that your ZooKeeper instance is up and running before starting a Kafka server.
		1. Go to your Kafka installation directory: C:\kafka_2.13-2.4.0\
		2. Open a command prompt here by pressing Shift + right click and choose the “Open command window here” option).
		3. Now type .\bin\windows\kafka-server-start.bat .\config\server.properties and press Enter.
		
B. Stopping Kafka Server		
			C:\kafka_2.13-2.4.0>cd bin
			C:\kafka_2.13-2.4.0\bin>.\kafka-server-stop.sh
			C:\kafka_2.13-2.4.0\bin>

C. Creating Kafka Topics
	1. Creating a Topic
		Create a topic with the name “File_Reader” and a replication factor of 1, as we have only one Kafka server running. If you have a cluster with more than one Kafka server running, you can increase the replication-factor accordingly, which will increase the data availability and act like a fault-tolerant system.

			1. Open a new command prompt in the location C:\kafka_2.13-2.4.0\bin\windows.

			2. Type the following command and hit Enter:
				kafka-topics.bat --create --zookeeper localhost:5181 --replication-factor 1 --partitions 1 --topic File_Reader

	2. Deleting the Topic
		kafka-topics.bat --delete --zookeeper localhost:5181  --topic File_Reader
		
	3. Listing the number of Topics
		kafka-topics.bat --zookeeper localhost:5181 --list
		
	4. Describing all topics
		kafka-topics.bat --zookeeper localhost:5181 --describe
		This command gives the whole description of a topic with the number of partitions, leader, replicas and, ISR.
		
	5. Describing a specific topic	
		kafka-topics.bat --zookeeper localhost:5181 --describe --topic File_Reader
		
E. Sending data to Kafka Topics
	In order to send data to the Kafka topic, a producer is required. 
	The role of the producer is to send or write data/messages to the Kafka topics.
	
	NoTe: A 'broker-list' and a 'topic id' is required to produce a message. 
		Remember, Broker is the server/host/machine that house kafka. One broker is one server	
		
	1. Presenting a Message to a Topic
		kafka-console-producer.bat --broker-list localhost:9092 --topic Test01
		
		Remember Default Kafka Port = 9092
		
			C:\kafka_2.13-2.4.0\bin\windows>kafka-console-producer.bat --broker-list localhost:9092 --topic Test01
			>This is my First Message... hahaha
			>This is the second line of the Message
			>Terminate batch job (Y/N)? y

			C:\kafka_2.13-2.4.0\bin\windows>

F. Kafka Console Consumer
	How a consumer consumes or reads the messages from the Kafka topics.
	A 'bootstrap-server' is required for the consumer to get connected to the Kafka topics. 
	Also, a 'topic_id' is required to know from which topic the consumer will read the messages.	
	
	1. Fetching message from Kafka Topic
		kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic Test01
		
		NoTe: A Kafka consumer will consume only those messages which are produced only when the consumer was in the active state. 
		This can be categorized as a disadvantage of Apache Kafka.	
		
	2. Reading Whole Message
		Apache Kafka allows to produce millions of messages. 
		Sometimes, a consumer may require to read whole messages from a particular topic.
		
		kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic Test01 --from-beginning
					
		C:\kafka_2.13-2.4.0\bin\windows>kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic Test01 --from-beginning
			This is my First Message... hahaha
			This is the second line of the Message
			
G. Kafka Consumer Group
	A Kafka consumer belongs to a particular consumer group. 
	A consumer group basically represents the name of an application. 
	In order to consume messages in a consumer group, '-group' command is used.
	A Group name is also requried.	
	If '-from-beginning' command is used, all the previous messages will be displayed.
	
	kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic Test01 --group Group1--from-beginning
	
	

	
	
			