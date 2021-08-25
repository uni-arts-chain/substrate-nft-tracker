#!/usr/bin/env bash
# For docker

CMD=$1
BLOCK=$2
if (( $CMD == "pangolin" )) 
then
  pangolin $BLOCK
fi

