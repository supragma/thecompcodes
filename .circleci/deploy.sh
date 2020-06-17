#!/bin/bash

# Later we need to replace ip with domain names

if [ $1 == "master" ]
then
	echo "Deploying to $1"
	ssh -o StrictHostKeyChecking=no -i id_rsa belwasetech@comp.codes "bash -s" <./.circleci/commands.sh $1
elif [ $1 == "stage" ]
then
	echo "Deploying to $1"
	ssh -o StrictHostKeyChecking=no -i id_rsa belwasetech@stage.comp.codes "bash -s" <./.circleci/commands.sh $1
else
	echo "Deploying to $1"
	ssh -o StrictHostKeyChecking=no -i id_rsa belwasetech@dev.comp.codes "bash -s" <./.circleci/commands.sh $1
fi
