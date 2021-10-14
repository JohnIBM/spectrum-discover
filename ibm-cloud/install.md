Expose OpenShift Image Registry
https://docs.openshift.com/container-platform/4.7/registry/securing-exposing-registry.html

oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge
# Verify default-route
oc get routes -n openshift-image-registry


