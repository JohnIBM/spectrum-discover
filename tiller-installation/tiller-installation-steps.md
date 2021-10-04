# Installing Helm v2.17.0 for Spectrum Discover

<!--- cSpell: helm tiller allowfullscreen -->


###  The following steps must be performed on a client with access to the OpenShift cluster 
###  using the OpenShift Command Line Interface (oc) 

### Step 1 - Create the tiller namespace, retrieve the install package and initialize the helm client:

```
oc new-project tiller
export TILLER_NAMESPACE=tiller
curl -s https://get.helm.sh/helm-v2.17.0-linux-amd64.tar.gz | tar xz
cd linux-amd64/
./helm init --client-only
```

### Step 2 - Install the server side components in OpenShift

The Helm v2 images are now deprecated and the image location has changed, see https://github.com/helm/helm/issues/8346
The command in the documentation is no longer valid:
```
oc process -f https://github.com/openshift/origin/raw/master/examples/helm/tiller-template.yaml -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" -p HELM_VERSION=v2.17.0 | oc create -f -
```
To correct this, use the tiller-template.yaml file provided. The following correction has been made and provided in the tiller-template.yaml file:
```
image: gcr.io/kubernetes-helm/tiller:${HELM_VERSION}
has been corrected to:
image: ghcr.io/helm/tiller:${HELM_VERSION}
```

Run the following command to install the correct version:
```
oc process -f tiller-template.yaml -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" -p HELM_VERSION=v2.17.0 | oc create -f -
```
Monitor the install as follows:
```
oc rollout status deployment tiller
```

Copy the updated binary to the local path and validate the versions:
```
cp ./helm /usr/bin/
./helm version
```

You should see the following output:
```
Client: &version.Version{SemVer:"v2.17.0", GitCommit:"a690bad98af45b015bd3da1a41f6218b1a451dbe", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.17.0", GitCommit:"a690bad98af45b015bd3da1a41f6218b1a451dbe", GitTreeState:"clean"}
```
   
Next Step: [Storage Definitions for IBM Spectrum Scale](../README.md#storage_definitions)