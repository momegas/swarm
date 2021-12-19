if [[ -z "$PRIMARY_DOMAIN" ]]; then
    echo "Please provide PRIMARY_DOMAIN. Example: PRIMARY_DOMAIN=example.com" 1>&2
    exit 1
fi

if [[ -z "$EMAIL" ]]; then
    echo "Please provide EMAIL. Example: EMAIL=hello@example.com" 1>&2
    exit 1
fi

export DOMAIN=traefik.$PRIMARY_DOMAIN
# export EMAIL=hello@example.com

export USERNAME=admin
export PASSWORD=admin
export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)

docker network create --driver=overlay traefik-public
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID

docker stack deploy -c traefik.yml traefik