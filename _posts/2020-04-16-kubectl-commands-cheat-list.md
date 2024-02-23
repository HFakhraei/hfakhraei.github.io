---
layout: post
title:  "Kubernetes, Cheat List"
tags: [ Git, Linux, WSL ]
featured_image_thumbnail: /assets/images/posts/2020/2020-04-16/kubernetes.jpg
featured_image: /assets/images/posts/2020/2020-04-16/kubernetes.jpg
featured: false
hidden: false
---
This is a list of useful kubernetes command, that I used mostly. I hope this list be useful for you too.

**Deploy Docker image in Kubernetes**
```
kubectl run hw --image=karthequian/helloworld --port=80
kubectl create -f test.yaml
kubectl apply -f test.yaml
```
**Get list of deployments**
```
kubectl get deployments
kubectl get deployment/hw -o yaml
```
**Get list of replica sets**
```
kubectl get rs
```
**Get list of pods**
```
kubectl get pods
kubectl get pods --show-all (List of pods in all namespaces)
```
**Get list of services**
```
kubectl get services
```
**Get list of all resources**
```
kubectl get all
```
**Get list of pods (Search with labels)**
```
kubectl get pods --show-labels
kubectl get pods --selector env=production
kubectl get pods -l env=production
kubectl get pods --selector env!=production
kubectl get pods --selector env=production,group=finance
kubectl get pods --selector 'release-version in (1.0,1.2)'
kubectl get pods --selector 'release-version not in (1.0,1.2)'
kubectl get pods --field-selector status.phase=Failed
```
**Tag Resources with labels**
```
kubectl  label pod/hw app=HelloWorldApp --overwrite
kubectl  label pod/hw app-
```
**Delete pods with labels**
```
kubectl delete pods -l env=production
kubectl delete pods --selector env=production
```
**Rescale Deployments**
```
kubectl scale deployment/hw --replicas=1
```
**Deploy the new Image in Deployment with Rollback feature**
```
kubectl create -f test.yaml --record
kubectl set image deployment/hw hw=karthequian/helloworld:blue
kubectl rollout history deployment/hw
kubectl rollout undo deployment/hw
kubectl rollout undo deployment/hw --to-revision =1
```
**Expose Deployment to outside Kubernetes**
```
kubectl expose deployment hw --type=NodePort
kubectl expose deployment kubernetes-dashboard --name=kubernetes-dashboard-expose --type=NodePort -n kube-system
kubectl expose deployment kubernetes-dashboard --name=kubernetes-dashboard-expose --type=NodePort --target-port=8443 -n kube-system
```
**View logs of pod**
```
kubectl logs hw-hdklajh555
```
**Execute command in a container**
```
kubectl exec -it hw-hdklajh555 /bin/bash 	    (pod with single container)
kubectl exec -it hw-hdklajh555 -c hw /bin/bash 	(pod with multi container)  
```
**Manage Config Map**
```
kubectl create configmap logger --from-literal=log_level=error
kubectl get configmaps
kubectl get configmap/logger -o yaml
```
**Manage Secrets**
```
kubectl create secret generic api-key --from-literal=api-key=123445
kubectl get secrets
kubectl get secret api-key
kubectl -n kube-system describe secret default
```
**Manage Jobs/CronJobs**
```
kubectl get jobs
kubectl get cronjobs
kubectl edit cronjobs/hellocron
```
**Describe Resources**
```
kubectl describe deployment/hw
kubectl describe pod/hw-hdklajh555
```
