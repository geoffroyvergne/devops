# Zipkin

## Enable Zipkin

./bin/istioctl manifest apply \
    --set values.tracing.ingress.enabled=true \
    --set values.tracing.enabled=true \
    --set values.tracing.provider=zipkin
    
## Start Dashboard

./bin/istioctl dashboard zipkin