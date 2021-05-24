#!/bin/sh
ZOOKEEPER=z-1.perf-test-m5-xlar.k47ng9.c2.kafka.ap-northeast-2.amazonaws.com:2181,z-3.perf-test-m5-xlar.k47ng9.c2.kafka.ap-northeast-2.amazonaws.com:2181,z-2.perf-test-m5-xlar.k47ng9.c2.kafka.ap-northeast-2.amazonaws.com:2181
echo 'Delete Partition'
/home/ec2-user/kafka_2.12-2.2.1/bin/kafka-topics.sh --delete --zookeeper $ZOOKEEPER --topic performance-test
/home/ec2-user/kafka_2.12-2.2.1/bin/kafka-topics.sh --delete --zookeeper $ZOOKEEPER --topic performance-gzip-test
/home/ec2-user/kafka_2.12-2.2.1/bin/kafka-topics.sh --delete --zookeeper $ZOOKEEPER --topic performance-lz4-test
/home/ec2-user/kafka_2.12-2.2.1/bin/kafka-topics.sh --delete --zookeeper $ZOOKEEPER --topic performance-snappy-test
echo 'Create Partition'
/home/ec2-user/kafka_2.12-2.2.1/bin/kafka-topics.sh --create --zookeeper $ZOOKEEPER --replication-factor 2 --partitions 1 --topic performance-test
/home/ec2-user/kafka_2.12-2.2.1/bin/kafka-topics.sh --create --zookeeper $ZOOKEEPER --replication-factor 2 --partitions 1 --config compression.type=gzip --topic performance-gzip-test
/home/ec2-user/kafka_2.12-2.2.1/bin/kafka-topics.sh --create --zookeeper $ZOOKEEPER --replication-factor 2 --partitions 1 --config compression.type=lz4 --topic performance-lz4-test
/home/ec2-user/kafka_2.12-2.2.1/bin/kafka-topics.sh --create --zookeeper $ZOOKEEPER --replication-factor 2 --partitions 1 --config compression.type=snappy --topic performance-snappy-test
