docker build -t harrychang12/multi-client:latest -t harrychang12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t harrychang12/multi-server:latest -t harrychang12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t harrychang12/multi-worker:latest -t harrychang12/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push harrychang12/multi-client:latest
docker push harrychang12/multi-server:latest
docker push harrychang12/multi-worker:latest

docker push harrychang12/multi-client:$SHA
docker push harrychang12/multi-server:$SHA
docker push harrychang12/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=harrychang12/multi-client:$SHA
kubectl set image deployments/server-deployment server=harrychang12/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=harrychang12/multi-worker:$SHA