# Installing Helm v2.17.0 for Spectrum Discover

<!--- cSpell: helm tiller allowfullscreen -->


###  The following steps must be performed on a client with access to the OpenShift cluster 
###  using the OpenShift Command Line Interface (oc) 

### Step 1 - Create the tiller namespace, retrieve the install package and initialize the helm client:

```
export TILLER_NAMESPACE=tiller
oc new-project $TILLER_NAMESPACE
curl -s https://get.helm.sh/helm-v2.17.0-linux-amd64.tar.gz|tar xz 
cd linux-amd64/
# Client install
./helm init --client-only
cp ./helm /usr/bin/
```

### Step 2 - Install the server side components in OpenShift

The Helm v2 images are now deprecated and the image location has changed, see https://github.com/helm/helm/issues/8346
The command in the documentation is no longer valid:
```
oc process -f https://github.com/openshift/origin/raw/master/examples/helm/tiller-template.yaml -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" -p HELM_VERSION=v2.17.0 | oc create -f -
```
To correct this, the following steps with download and correct the tiller-template.yaml file:
```
image: gcr.io/kubernetes-helm/tiller:${HELM_VERSION}
has been corrected to:
image: ghcr.io/helm/tiller:${HELM_VERSION}
```

Run the following command to install the correct version:
```
# Server Install
wget -q https://github.com/openshift/origin/raw/master/examples/helm/tiller-template.yaml
# The following step corrects the image location for Helm v2
sed -i 's|gcr.io\/kubernetes-helm\/tiller|ghcr.io\/helm\/tiller|g' tiller-template.yaml
oc process -f tiller-template.yaml -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" -p HELM_VERSION=v2.17.0 | oc create -f -
rm -f tiller-template.yaml
```

Monitor the install as follows:
```
oc rollout status deployment tiller
```

Validate the versions:
```
./helm version
```

You should see the following output:
```
Client: &version.Version{SemVer:"v2.17.0", GitCommit:"a690bad98af45b015bd3da1a41f6218b1a451dbe", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.17.0", GitCommit:"a690bad98af45b015bd3da1a41f6218b1a451dbe", GitTreeState:"clean"}
```
   
Next Step: [Storage Definitions for IBM Spectrum Scale](../README.md#storage_definitions)