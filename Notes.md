
## OpenShift registry must be configured correctly and exposed:
https://docs.openshift.com/container-platform/4.8/registry/configuring_registry_storage/configuring-registry-storage-vsphere.html
https://docs.openshift.com/container-platform/4.8/registry/securing-exposing-registry.html


# Create Storage PVC
```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: image-registry-storage
  namespace: openshift-image-registry
spec:
  storageClassName: ibm-spectrum-scale-csi-remote-fileset
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 100Gi

```

# Edit image-registry-config
```
oc edit config.imageregistry.operator.openshift.io -o yaml
pvc: image-registry-storage
```

# Modify the configuration from Removed to Managed

```
oc get configs.imageregistry.operator.openshift.io cluster -oyaml | grep manage
```
Output:
  managedFields:
        f:managementState: {}
    manager: cluster-image-registry-operator
    manager: kubectl-patch
  managementState: Removed

```
oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"managementState":"Managed"}}'
oc get configs.imageregistry.operator.openshift.io cluster -oyaml | grep manage
```
Output:
  managedFields:
    manager: cluster-image-registry-operator
        f:managementState: {}
    manager: kubectl-patch
  managementState: Managed

# Check Status
```
oc get clusteroperator image-registry
```
## Configure the image registry settings

```
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
# Use the following output for external route in the next step:
echo $HOST
```

```
oc edit image.config.openshift.io/cluster
```
spec:
  registrySources:
    insecureRegistries:
    - default-route-openshift-image-registry.apps.ocp.vsphere.local


## Service Mesh
```
oc edit smmr default -n istio-system