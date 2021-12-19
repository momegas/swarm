
if [[ -z "$USE_HOSTNAME" ]]; then
    echo "USE_HOSTNAME variable found. Setting hostname in /etc/hostname" 1>&2
    # export USE_HOSTNAME=example.com

    echo $USE_HOSTNAME > /etc/hostname
    hostname -F /etc/hostname
fi

apt-get update
apt-get upgrade -y

# Install Docker using the stable channel (instead of the default "edge")
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh

docker swarm init
# docker swarm init --advertise-addr 138.68.58.48
