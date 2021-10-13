

export TILLER_NAMESPACE=tiller
oc new-project $TILLER_NAMESPACE
curl -s https://get.helm.sh/helm-v2.17.0-linux-amd64.tar.gz|tar xz 
cd linux-amd64/
# Client install
./helm init --client-only
cp ./helm /usr/bin/

# Server Install
wget -q https://github.com/openshift/origin/raw/master/examples/helm/tiller-template.yaml
# The following step corrects the image location for Helm v2
sed -i 's|gcr.io\/kubernetes-helm\/tiller|ghcr.io\/helm\/tiller|g' tiller-template.yaml
oc process -f tiller-template.yaml -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" -p HELM_VERSION=v2.17.0 | oc create -f -


helm version 
# You should see:
# Client: &version.Version{SemVer:"v2.17.0", GitCommit:"a690bad98af45b015bd3da1a41f6218b1a451dbe", GitTreeState:"clean"}
# Server: &version.Version{SemVer:"v2.17.0", GitCommit:"a690bad98af45b015bd3da1a41f6218b1a451dbe", GitTreeState:"clean"}
