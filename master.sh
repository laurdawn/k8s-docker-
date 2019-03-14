#！/bin/bash

docker pull openstackmagnum/kubernetes-proxy:v1.13.4
docker pull openstackmagnum/kubernetes-scheduler:v1.13.4
docker pull openstackmagnum/kubernetes-controller-manager:v1.13.4
docker pull openstackmagnum/kubernetes-apiserver:v1.13.4
docker pull coredns/coredns:1.2.6
docker pull mirrorgooglecontainers/etcd-amd64:3.2.24
docker pull mirrorgooglecontainers/pause:3.1

docker tag openstackmagnum/kubernetes-proxy:v1.13.4 k8s.gcr.io/kube-proxy:v1.13.4
docker tag openstackmagnum/kubernetes-scheduler:v1.13.4 k8s.gcr.io/kube-scheduler:v1.13.4
docker tag openstackmagnum/kubernetes-controller-manager:v1.13.4 k8s.gcr.io/kube-controller-manager:v1.13.4
docker tag openstackmagnum/kubernetes-apiserver:v1.13.4 k8s.gcr.io/kube-apiserver:v1.13.4
docker tag coredns/coredns:1.2.6 k8s.gcr.io/coredns:1.2.6
docker tag mirrorgooglecontainers/etcd-amd64:3.2.24 k8s.gcr.io/etcd:3.2.24
docker tag docker.io/mirrorgooglecontainers/pause:3.1  k8s.gcr.io/pause:3.1


docker rmi openstackmagnum/kubernetes-proxy:v1.13.4 openstackmagnum/kubernetes-scheduler:v1.13.4 openstackmagnum/kubernetes-controller-manager:v1.13.4 openstackmagnum/kubernetes-apiserver:v1.13.4 coredns/coredns:1.2.6 mirrorgooglecontainers/etcd-amd64:3.2.24 mirrorgooglecontainers/pause:3.1
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bash_profile
source ~/.bash_profile

echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
kubeadm init --kubernetes-version=v1.13.4 --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=Swap
#安装网络组件
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#安装仪表盘
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml