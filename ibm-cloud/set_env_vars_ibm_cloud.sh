# Set Environment Variables for IBM Spectrum Discover Installation
# Master IP for the Ansible install node
export master_ip="10.240.65.28"
export SD_USER="sdadmin"
export SD_PASSWORD="Passw0rd"
export installer_path="/home/discover"
export project_name="spectrum-discover"
export db2wh_release_name="spectrum-discover-db2-release"
export db2wh_password="Passw0rd"
export kafka_storage_class="sd-kafka-sc"
export sd_storage_class="sd-sc"
export db2wh_pvc_name="db-pvc"
export data_pvc_name="sd-data-pvc"
export backup_pvc_name="sd-backup-pvc"
# Spectrum Discover ingress host name: use spectrum-discover-ingress.apps.<OpenShift Base Domain>
# OpenShift Base Domain can be found using the following command: oc describe dns cluster | grep "Base Domain"
# Base Domain:  utex-ocp40-087f1b5ad0f770c98b8048ce098b9d43-0000.us-south.containers.appdomain.cloud

export ingress_host="spectrum-discover-ingress.apps.utex-ocp40-087f1b5ad0f770c98b8048ce098b9d43-0000.us-south.containers.appdomain.cloud"
export ingress_tls_secret_name="spectrum-discover-ingress-tls-name"
# The following hosts are selected using "oc get nodes" (choose any two nodes)
export kafka_sasl_host="10.240.0.25"
export kafka_ssl_host="10.240.65.25"
# Obtain image_repository location from "oc describe route -n openshift-image-registry | grep Host:"
# Requested Host: default-route-openshift-image-registry.utex-ocp40-087f1b5ad0f770c98b8048ce098b9d43-0000.us-south.containers.appdomain.cloud
export image_repository="default-route-openshift-image-registry.utex-ocp40-087f1b5ad0f770c98b8048ce098b9d43-0000.us-south.containers.appdomain.cloud/spectrum-discover"
export TILLER_NAMESPACE=tiller
export HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
