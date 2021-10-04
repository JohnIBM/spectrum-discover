oc new-project tiller
export TILLER_NAMESPACE=tiller
# Client side installation
curl -s https://get.helm.sh/helm-v2.17.0-linux-amd64.tar.gz | tar xz
cd linux-amd64/
./helm init --client-only


# Server side install:
# Old command
# oc process -f https://github.com/openshift/origin/raw/master/examples/helm/tiller-template.yaml -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" -p HELM_VERSION=v2.17.0 | oc create -f -
# Helm v2 images are now deprecated:
# See https://github.com/helm/helm/issues/8346

# Use the tiller-template.yaml file provided 
# image: gcr.io/kubernetes-helm/tiller:${HELM_VERSION}
# corrected to:
# image: ghcr.io/helm/tiller:${HELM_VERSION}

# New Command:
oc process -f tiller-template.yaml -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" -p HELM_VERSION=v2.17.0 | oc create -f -

oc rollout status deployment tiller
./helm version

cp ./helm /usr/bin/