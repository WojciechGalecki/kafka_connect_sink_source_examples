#!/bin/bash

# Start our kafka cluster
docker-compose up kafka-cluster

##############################################################################################################
# FileStreamSourceConnector in STANDALONE MODE

# We start a hosted tools, mapped on our code
# Linux / Mac
docker run --rm -it -v "$(pwd)":/tutorial --net=host landoop/fast-data-dev:cp3.3.0 bash

# we launch the kafka connector in standalone mode:
cd /tutorial/source/demo-1
# create the topic we write to with 3 partitions
kafka-topics --create --topic demo-1-standalone --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
# Usage is connect-standalone worker.properties connector1.properties [connector2.properties connector3.properties]
connect-standalone worker.properties file-stream-demo-standalone.properties
# INFO Created connector file-stream-demo-standalone (org.apache.kafka.connect.cli.ConnectStandalone:112)
# standalone.offsets file will be created - to avoid consuming file again
##############################################################################################################

# FileStreamSourceConnector in DISTRIBUTED MODE:
# create the topic we're going to write to
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
kafka-topics --create --topic demo-2-distributed --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
# you can now close the new shell

# head over to 127.0.0.1:3030 -> Connect UI
# Create a new connector -> File Source
# Paste the configuration at source/demo-2/file-stream-demo-distributed.properties

# Now that the configuration is launched, we need to create the file demo-file.txt in the docker container
docker ps
docker exec -it <containerId> bash
touch demo-file.txt
echo "hi" >> demo-file.txt
echo "hello" >> demo-file.txt
echo "from the other side" >> demo-file.txt

# Read the topic data
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
kafka-console-consumer --topic demo-2-distributed --from-beginning --bootstrap-server 127.0.0.1:9092
##############################################################################################################

# TwitterSourceConnector in distributed mode:
# create the topic we're going to write to
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
kafka-topics --create --topic twitter-data --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
# Start a console consumer on that topic
kafka-console-consumer --topic twitter-data --bootstrap-server 127.0.0.1:9092
##############################################################################################################

# Blockchain Source
# create topic
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
kafka-topics --create --topic blockchain-data --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
# Start a console consumer on that topic
kafka-console-consumer --topic blockchain-data --bootstrap-server 127.0.0.1:9092
##############################################################################################################

# JDBC Source
# create the topic we're going to write to
docker run --rm -it --net=host landoop/fast-data-dev:cp3.3.0 bash
kafka-topics --create --topic jdbc-data --partitions 3 --replication-factor 1 --zookeeper 127.0.0.1:2181
# Start a console consumer on that topic
kafka-console-consumer --topic jdbc-data --bootstrap-server 127.0.0.1:9092