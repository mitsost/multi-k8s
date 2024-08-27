docker build -t mitsost/multi-client:latest -t mitsost/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mitsost/multi-server:latest -t mitsost/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mitsost/multi-worker:latest -t mitsost/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mitsost/multi-client:latest
docker push mitsost/multi-server:latest
docker push mitsost/multi-worker:latest

docker push mitsost/multi-client:$SHA
docker push mitsost/multi-server:$SHA
docker push mitsost/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mitsost/multi-server:$SHA
kubectl set image deployments/client-deployment client=mitsost/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mitsost/multi-worker:$SHA
