docker build -t erwangauduchon/multi-client:latest -t erwangauduchon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t erwangauduchon/multi-server:latest -t erwangauduchon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t erwangauduchon/multi-worker:latest -t erwangauduchon/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push erwangauduchon/multi-client:latest
docker push erwangauduchon/multi-server:latest
docker push erwangauduchon/multi-worker:latest

docker push erwangauduchon/multi-client:$SHA
docker push erwangauduchon/multi-server:$SHA
docker push erwangauduchon/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=erwangauduchon/multi-server:$SHA
kubectl set image deployments/client-deployment client=erwangauduchon/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=erwangauduchon/multi-worker:$SHA