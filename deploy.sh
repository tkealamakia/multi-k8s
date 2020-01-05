docker build -t tkealamakia/multi-client:latest -t tkealamakia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tkealamakia/multi-server:latest -t tkealamakia/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tkealamakia/multi-worker:latest -t tkealamakia/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tkealamakia/multi-client:latest
docker push tkealamakia/multi-server:latest
docker push tkealamakia/multi-worker:latest

docker push tkealamakia/multi-client:$SHA
docker push tkealamakia/multi-server:$SHA
docker push tkealamakia/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tkealamakia/multi-server:$SHA
kubectl set image deployments/client-deployment client=tkealamakia/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tkealamakia/multi-worker:$SHA
