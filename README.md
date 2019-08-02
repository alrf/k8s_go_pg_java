# Go app with Postgresql, Java and custom Prometheus metrics based on k8s.

`k8s_go_app` dir - k8s manifests.

All k8s manifests are in subfolders.

`app` dir - Go application.

Used commands below for containerizing Go application:

```
docker build -t go-web-app . --network=host
docker tag go-web-app:latest alrf/go-web-app:latest
docker push alrf/go-web-app:latest
```

## How to deploy

AWS ACM and Network Load Balancer are used.

Setup proper values for ACM and DOMAIN variables in deploy.sh

```
# AWS ACM: arn:aws:acm:xxxxxxxxxxx
export ACM="arn:aws:acm:xxxxxxxxxxxxx"
# domain name for your docker registry without schema (http/https): your.docker-go-pg.com
export DOMAIN="your.docker-go-pg.com"
```

Run `bash deploy.sh`

## How to remove deployment

Run `bash undeploy.sh`
