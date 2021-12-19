if [[ -z "$PRIMARY_DOMAIN" ]]; then
    echo "Please provide PRIMARY_DOMAIN. Example: PRIMARY_DOMAIN=example.com" 1>&2
    exit 1
fi

export DOMAIN=portainer.$PRIMARY_DOMAIN

export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add portainer.portainer-data=true $NODE_ID
docker stack deploy -c portainer.yml portainer
