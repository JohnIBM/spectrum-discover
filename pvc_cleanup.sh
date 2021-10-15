# Change Policy to Delete for Cleanup
for pv in `oc get pv | grep spectrum-discover | awk '{print $1}'`; do oc patch pv $pv -p '{"spec":{"persistentVolumeReclaimPolicy":"Delete"}}'; done
# Delete PVCs
for pvc in $(oc get pvc -n ${project_name} --no-headers | awk '{print $1}'); do oc delete pvc $pvc; done


