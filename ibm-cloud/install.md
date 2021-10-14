## Expose OpenShift Image Registry
# https://docs.openshift.com/container-platform/4.7/registry/securing-exposing-registry.html
```
oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge
```
# Verify default-route
```
oc get routes -n openshift-image-registry
```
# Image Registry Login
```
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
podman login -u kubeadmin -p $(oc whoami -t) --tls-verify=false $HOST 
```
## Set Environment Variables
```
git clone https://github.com/JohnIBM/spectrum-discover-install.git
chmod +x ./spectrum-discover-install/ibm-cloud/set_env_vars_ibm_cloud.sh
. ./spectrum-discover-install/ibm-cloud/set_env_vars_ibm_cloud.sh
```


