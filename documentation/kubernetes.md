# Kubernetes

Some usefull commands for Kubernetes

See all the informations from the cluster
```bash
minikube dashboard
```

## Rolling update

When you need to do a rolling update and you don't want a down time for your user, you can use the following commands:
```bash
# use a new image
kubectl set image deployment/<name-of-deployment> <name-of-conteneur>=<new-image>:<tag> # kubectl set image deployment/result-app result=therealpad/formationchatgpt-result:pad
# watch the status
kubectl rollout status deployment/<name-of-deployment> # kubectl rollout status deployment/result-app
# cancel
kubectl rollout undo deployment/<name-of-deployment> # kubectl rollout undo deployment/result-app
```

## Horizontal Pod Autoscaler (HPA)

If your application start to run slowly and you can't update the code directly, you can let Kubernetes create new pods for the horizontal optimization.

How to see all your HPA in your cluster
```bash
kubectl get hpa -n <namespace>

# to see all your actual pods
kubectl top pods
```

if you have this error ```error: Metrics API not available```

you can do the following:
```bash
kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl -n kube-system get deployment metrics-server -o yaml
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[
{
"op": "add",
"path": "/spec/template/spec/hostNetwork",
"value": true
},
{
"op": "replace",
"path": "/spec/template/spec/containers/0/args",
"value": [
"--cert-dir=/tmp",
"--secure-port=4443",
"--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname",
"--kubelet-use-node-status-port",
"--metric-resolution=15s",
"--kubelet-insecure-tls"
]
},
{
"op": "replace",
"path": "/spec/template/spec/containers/0/ports/0/containerPort",
"value": 4443
}
]'
```
