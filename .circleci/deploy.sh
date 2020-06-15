#!/bin/bash

# Later we need to replace ip with domain names

if [ $1 == "master" ]
then
	echo "Deploying to $1"
	ssh -o StrictHostKeyChecking=no -i id_rsa belwasetech@34.71.79.243 "bash -s" <./.circleci/commands.sh $1
elif [ $1 == "stage" ]
then
	echo "Deploying to $1"
	ssh -o StrictHostKeyChecking=no -i id_rsa belwasetech@34.72.200.164 "bash -s" <./.circleci/commands.sh $1
else
	echo "Deploying to $1"
	ssh -o StrictHostKeyChecking=no -i id_rsa belwasetech@104.198.152.241 "bash -s" <./.circleci/commands.sh $1
fi
