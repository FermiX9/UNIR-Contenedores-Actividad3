curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.3/2023-11-14/bin/linux/amd64/kubectl
chmod +x ./kubectl 
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin 
kubectl version --client
mkdir .aws
vim .aws/credentials

[default]
aws_access_key_id=$ACCESS_KEY
aws_secret_access_key=$SECRET_KEY
aws_session_token=$TOKEN

aws eks update-kubeconfig --name Actividad3 --region us-east-1

kubectl config get-contexts
CURRENT   NAME                                                    CLUSTER                                                 AUTHINFO                                                NAMESPACE
*         arn:aws:eks:us-east-1:905418182457:cluster/Actividad3   arn:aws:eks:us-east-1:905418182457:cluster/Actividad3   arn:aws:eks:us-east-1:905418182457:cluster/Actividad3   

kubectl get nodes
NAME                            STATUS   ROLES    AGE   VERSION
ip-172-31-16-23.ec2.internal    Ready    <none>   13m   v1.33.5-eks-ecaa3a6
ip-172-31-92-198.ec2.internal   Ready    <none>   13m   v1.33.5-eks-ecaa3a6

kubectl apply -f efs-sc.yaml
kubectl apply -f efs-pv.yaml

sudo mkdir /efs
sudo bash
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 172.31.23.43:/ efs

sudo mkdir /efs/postgres
sudo mkdir /efs/redis
sudo chown -R 1001:1001 /efs/postgres  
sudo chown -R 1001:1001 /efs/redis

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh


helm install netbox-postgresql --namespace netbox-actividad3 bitnami/postgresql -f postgres-values.yaml --set global.security.allowInsecureImages=true
helm install netbox-redis --namespace netbox-actividad3 bitnami/redis -f redis-values.yaml

kubectl apply -f netbox-configmap.yaml
kubectl apply -f netbox-secrets.yaml
kubectl apply -f netbox-startup-configmap.yaml
kubectl apply -f sso-saml2.yaml
kubectl apply -f netbox-deployment.yaml
kubectl apply -f netbox-service.yaml



