if [[ -z "$PRIMARY_DOMAIN" ]]; then
    echo "Please provide PRIMARY_DOMAIN. Example: PRIMARY_DOMAIN=example.com" 1>&2
    exit 1
fi

export DOMAIN=swarmpit.$PRIMARY_DOMAIN
echo $DOMAIN

export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')

docker node update --label-add swarmpit.db-data=true $NODE_ID
docker node update --label-add swarmpit.influx-data=true $NODE_ID
docker stack deploy -c swarmpit.yml swarmpit
