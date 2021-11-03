OpenShift registry must be configured correctly and exposed:
https://docs.openshift.com/container-platform/4.8/registry/configuring_registry_storage/configuring-registry-storage-vsphere.html
https://docs.openshift.com/container-platform/4.8/registry/securing-exposing-registry.html



```
[root@rh83 spectrum-discover-install]# oc get configs.imageregistry.operator.openshift.io cluster -oyaml | grep manage
  managedFields:
        f:managementState: {}
    manager: cluster-image-registry-operator
    manager: kubectl-patch
  managementState: Removed
```

```
oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"managementState":"Managed"}}'
```
oc get configs.imageregistry.operator.openshift.io cluster -oyaml | grep manage
```
 managedFields:
    manager: cluster-image-registry-operator
        f:managementState: {}
    manager: kubectl-patch
  managementState: Managed
```
