#!/bin/bash

# Consul version example: 1.14.0-ent
# Envoy version example: v1.24.0

if [ $# -eq 0 ]; then
    echo "Syntax: convoy-build <consul version> <envoy version>"
    echo ""
    echo "Example: ./convoy-build.sh 1.14.2-ent v1.24.0"
    echo ""
    echo "  Consul versions: https://hub.docker.com/r/hashicorp/consul-enterprise/tags"
    echo "  Envoy versions: https://hub.docker.com/r/envoyproxy/envoy/tags"
    echo ""
    echo "  SebbyCorp Repo: https://hub.docker.com/r/sebbycorp/consul-envoy/tags"
    exit 1
fi

CONVER="hashicorp/consul-enterprise:$1"
ENVVER="envoyproxy/envoy:$2"

SEBBY1=$(echo $CONVER | awk -F: '{ print $2 }')
SEBBY2=$(echo $ENVVER | awk -F: '{ print $2 }')

SEBBYTAG="sebbycorp/consul-envoy:v$(echo $SEBBY1)_$(echo $SEBBY2)"

docker build --build-arg CONSUL_IMAGE=$CONVER --build-arg ENVOY_IMAGE=$ENVVER -t $SEBBYTAG  .

docker push $SEBBYTAG

