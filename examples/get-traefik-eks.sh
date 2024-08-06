INGRESS_HOSTNAME=$(kubectl --kubeconfig kubeconfig.yaml \
    --namespace traefik get service traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")

INGRESS_IP=$(dig +short $INGRESS_HOSTNAME)

while [ -z "$INGRESS_IP" ]; do
    sleep 10
    INGRESS_HOSTNAME=$(kubectl --kubeconfig kubeconfig.yaml \
        --namespace traefik get service traefik \
        --output jsonpath="{.status.loadBalancer.ingress[0].hostname}")
    INGRESS_IP=$(dig +short $INGRESS_HOSTNAME) 
done

INGRESS_IP=$(echo $INGRESS_IP | awk '{print $1;}')

INGRESS_IP_LINES=$(echo $INGRESS_IP | wc -l | tr -d ' ')

if [ $INGRESS_IP_LINES -gt 1 ]; then
    INGRESS_IP=$(echo $INGRESS_IP | head -n 1)
fi

echo $INGRESS_IP
