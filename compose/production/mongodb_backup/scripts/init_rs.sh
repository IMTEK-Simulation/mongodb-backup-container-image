#!/bin/bash
# for oplog, mongod needs to run in a replica set

source init_static_params.sh

# check whether replica configuration already set up
mongo ${TLS_OPTS} ${AUTH_OPTS} --eval 'rs.conf()'
ret=$?
if [ $ret -ne 0 ]; then
    echo "Replica set not yet configured. Attempt to do so now."
    mongo ${TLS_OPTS} ${AUTH_OPTS} --eval 'rs.initiate({_id: "rs0", members: [{_id: 0, host: "'"${PUBLIC_HOST}"'"},]})'
else
    echo "Replica set already configured."
fi
