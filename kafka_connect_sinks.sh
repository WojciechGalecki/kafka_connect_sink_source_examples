#!/bin/bash

# Start our kafka cluster
docker-compose up kafka-cluster elasticsearch postgres

#################################################################################################################################
# A) ElasticSearch Sink
# Info here: http://docs.confluent.io/3.2.0/connect/connect-elasticsearch/docs/elasticsearch_connector.html
http://127.0.0.1:9200/
# Go to the connect UI and apply the configuration at :
sink/demo-elastic/sink-elastic-twitter-distributed.properties
# Visualize the data at:
http://127.0.0.1:9200/_plugin/dejavu
# http://docs.confluent.io/3.1.1/connect/connect-elasticsearch/docs/configuration_options.html
# Counting the number of tweets:
http://127.0.0.1:9200/twitter-data/_count
# You can download the data from the UI to see what it looks like
# We can query elasticsearch for users who have a lot of friends, see query-followers_count.json
#################################################################################################################################
# B) JDBC Sink demo
# Examples are covered from here: http://docs.confluent.io/3.2.0/connect/managing.html#common-rest-examples
# See File sink/demo-rest-api/demo-rest-api.sh
###############

###############
# C) PostgresSQL demo
# Examples are taken from here: http://docs.confluent.io/3.2.0/connect/connect-jdbc/docs/sink_connector.html#quickstart
