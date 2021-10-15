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
# Install kubectl
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/bin
```
# Set Environment Variables
```
git clone https://github.com/JohnIBM/spectrum-discover-install.git
chmod +x ./spectrum-discover-install/ibm-cloud/set_env_vars_ibm_cloud.sh
. ./spectrum-discover-install/ibm-cloud/set_env_vars_ibm_cloud.sh
```

# Step 4 Create SC/PVC
```
oc project ${project_name}
oc create -f ${installer_path}/spectrum-discover-install/ibm-cloud/
```

## Spectrum Discover Install

```
oc project ${project_name}
```
# Add spectrum-discover to the service mesh member role
```
oc edit smmr default -n istio-system
```

Complete as follows:
```
spec:
  members:
    - spectrum-discover
```




cd ${installer_path}/spectrum-discover-package/ibm-db2warehouse/ibm_cloud_pak/pak_extensions
./pre-install/clusterAdministration/createSecurityClusterPrereqs.sh
./pre-install/namespaceAdministration/createSecurityNamespacePrereqs.sh ${project_name}
oc create secret generic ${db2wh_release_name}-db2u-ldap-bluadmin --from-literal=password="${db2wh_password}"
oc create secret generic ${db2wh_release_name}-db2u-instance --from-literal=password="${db2wh_password}"

