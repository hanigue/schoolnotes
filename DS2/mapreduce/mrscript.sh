#!/bin/bash
if [ $# -ne 2 ] 
	then
	echo "USAGE: mrskript.sh <login> <yourjavafile.java>"
	exit 1
fi
mkdir classes
javac -classpath /home/DS2/mapreduce/hadoop-common-3.1.1.jar:/home/DS2/mapreduce/hadoop-mapreduce-client-core-3.1.1.jar -d classes/ $2
jar -cvf MapReduce.jar -C classes/ .
hadoop fs -mkdir /user/$1/mapreduce
hadoop fs -mkdir /user/$1/mapreduce/input
hadoop fs -copyFromLocal ./input.txt /user/$1/mapreduce/input
hadoop jar MapReduce.jar MapReduce /user/$1/mapreduce/input /user/$1/mapreduce/output
hadoop fs -copyToLocal /user/$1/mapreduce/output/part-r-00000 result.txt
hadoop fs -rm -r /user/$1/mapreduce
rm -r classes
rm MapReduce.jar
cat result.txt
rm result.txt