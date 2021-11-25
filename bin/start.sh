#!/bin/bash
#
name=$0
echo "Execute location: $0"
CUBES_PATH=$(dirname ${name})
export MODELS_PATH=$CUBES_PATH/../models
export LOGS_PATH=$CUBES_PATH/../logs/cubes.log
export CUBES_PATH=$CUBES_PATH

export POSTGRES_PASSWORD=`grep POSTGRES_PASSWORD ~/.bashrc | awk -F "=" '{print $2}'`
export POSTGRES_HOST=`grep POSTGRES_HOST ~/.bashrc | awk -F "=" '{print $2}'`
export POSTGRES_USER_NAME=`grep POSTGRES_USER_NAME ~/.bashrc | awk -F "=" '{print $2}'`

virtualenv --python=/usr/bin/python2.7 $CUBES_PATH/env
source $CUBES_PATH/env/bin/activate

echo "installing python packages for cubes"
pip install -r $CUBES_PATH/requirements.txt

echo "replacing db credentials"
ruby $CUBES_PATH/replace_db_credentials.rb

echo "starting slicer server"
nohup slicer serve $CUBES_PATH/slicer.ini &
