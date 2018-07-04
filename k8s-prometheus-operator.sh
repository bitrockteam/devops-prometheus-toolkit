helm init
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}' 

helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm install coreos/prometheus-operator --name prometheus-operator --namespace monitoring
helm install coreos/kube-prometheus --name kube-prometheus --set global.rbacEnable=true --namespace monitoring

# se avete problemi sull'autorizzazione delle metriche da Kubelet (kubeadm only)
# error msg: server returned HTTP status 403 Forbidden

vi /etc/systemd/system/kubelet.service.d/01-kubeadm.conf #il nome del file può cambiare

#aggiungere
Environment="KUBELET_EXTRA_ARGS=--authentication-token-webhook"

