#!/bin/sh
KAFKA=bootstrap.servers=b-2.t3-small-test.h3gevu.c2.kafka.ap-northeast-2.amazonaws.com:9092,b-1.t3-small-test.h3gevu.c2.kafka.ap-northeast-2.amazonaws.com:9092
ZOOKEEPER=z-3.t3-small-test.h3gevu.c2.kafka.ap-northeast-2.amazonaws.com:2181,z-1.t3-small-test.h3gevu.c2.kafka.ap-northeast-2.amazonaws.com:2181,z-2.t3-small-test.h3gevu.c2.kafka.ap-northeast-2.amazonaws.com:2181
INSTANCE=t3.small
INDEX=$(seq 1 4)
for i in $INDEX
do
    PARTITION=partition-$i
    echo $PARTITION

    echo 'Delete Partition'
    ./kafka-topics.sh --delete --zookeeper $ZOOKEEPER --topic performance-test
    ./kafka-topics.sh --delete --zookeeper $ZOOKEEPER --topic performance-gzip-test
    ./kafka-topics.sh --delete --zookeeper $ZOOKEEPER --topic performance-lz4-test
    ./kafka-topics.sh --delete --zookeeper $ZOOKEEPER --topic performance-snappy-test
    echo 'Create Partition'
    ./kafka-topics.sh --create --zookeeper $ZOOKEEPER --replication-factor 2 --partitions $i --topic performance-test
    ./kafka-topics.sh --create --zookeeper $ZOOKEEPER --replication-factor 2 --partitions $i --config compression.type=gzip --topic performance-gzip-test
    ./kafka-topics.sh --create --zookeeper $ZOOKEEPER --replication-factor 2 --partitions $i --config compression.type=lz4 --topic performance-lz4-test
    ./kafka-topics.sh --create --zookeeper $ZOOKEEPER --replication-factor 2 --partitions $i --config compression.type=snappy --topic performance-snappy-test

    echo ${INSTANCE}-1
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}_1.txt
    echo ${INSTANCE}-2
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}_2.txt
    echo ${INSTANCE}-3
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}_3.txt
    echo ${INSTANCE}-4
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}_4.txt
    echo ${INSTANCE}-5
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}_5.txt
    echo ${INSTANCE}-gzip-1
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-gzip-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-gzip_1.txt
    echo ${INSTANCE}-gzip-2
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-gzip-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-gzip_2.txt
    echo ${INSTANCE}-gzip-3
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-gzip-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-gzip_3.txt
    echo ${INSTANCE}-gzip-4
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-gzip-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-gzip_4.txt
    echo ${INSTANCE}-gzip-5
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-gzip-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-gzip_5.txt
    echo ${INSTANCE}-lz4-1
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-lz4-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-lz4_1.txt
    echo ${INSTANCE}-lz4-2
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-lz4-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-lz4_2.txt
    echo ${INSTANCE}-lz4-3
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-lz4-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-lz4_3.txt
    echo ${INSTANCE}-lz4-4
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-lz4-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-lz4_4.txt
    echo ${INSTANCE}-lz4-5
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-lz4-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-lz4_5.txt
    echo ${INSTANCE}-snappy-1
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-snappy-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-snappy_1.txt
    echo ${INSTANCE}-snappy-2
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-snappy-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-snappy_2.txt
    echo ${INSTANCE}-snappy-3
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-snappy-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-snappy_3.txt
    echo ${INSTANCE}-snappy-4
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-snappy-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-snappy_4.txt
    echo ${INSTANCE}-snappy-5
    ./kafka-producer-perf-test.sh --num-records 1000000 --throughput -1 --record-size 1024 --topic performance-snappy-test --print-metrics --producer-props $KAFKA > kafka.${INSTANCE}.${PARTITION}-snappy_5.txt
done
