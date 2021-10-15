# Installing IBM Spectrum Discover on RedHat OpenShift with Spectrum Scale Container Native Storage Access

## Note: These steps are intended as a supplement to the IBM Spectrum Discover documentation found [here:](https://www.ibm.com/docs/en/spectrum-discover/2.0.4?topic=configuring-deploy-spectrum-discover-red-hat-openshift)

### https://www.ibm.com/docs/en/spectrum-discover/2.0.4?topic=configuring-deploy-spectrum-discover-red-hat-openshift


## Step 1: Preparing the OpenShift Cluster

1. Install IBM Spectrum Scale Container Native Storage Access (CNSA) 5.1.1.3

   For details on this process, please see the IBM documentation here:
   https://www.ibm.com/docs/en/scalecontainernative?topic=spectrum-scale-container-native-storage-access-5113

2. Verify IBM Spectrum Scale CSI Driver is at level V2.3.0 

   This is now automatically installed during the CNSA installation. For additional information the IBM Spectrum Scale CSI driver, please see: 
   https://www.ibm.com/docs/en/spectrum-scale-csi?topic=spectrum-scale-container-storage-interface-driver-230

3. If you have labeled nodes for Spectrum Scale, validate this from the OpenShift command line as follows"
    ```
    oc get nodes -lscale=true
    ```
    The node list will appears as follows:

    ![oc get nodes -lscale=true](images/oc-get-nodes.png)

4.  SELinux

    IBM Spectrum Discover requires RWX access for the data volumes. The considerations for Spectrum Scale are described here: https://www.ibm.com/docs/en/spectrum-scale-csi?topic=pods-considerations-mounting-read-write-many-rwx-volumes

    In order to simplify access control, you may choose to disable SE Linux for the OpenShift worker nodes where IBM Spectrum Scale will run. The command is as follows:
    ```
    for node in `oc get node --no-headers -lscale=true | awk '{print $1}'`; do oc debug node/$node -T -- chroot /host sh -c "sudo setenforce 0"; done
    ```
    You can verify this with the following command:
    ```
    for node in `oc get node --no-headers -lscale=true | awk '{print $1}'`; do oc debug node/$node -T -- chroot /host sh -c "sudo getenforce"; done
    
    ```
    You should see output similar to the following:

    ![getenforce](images/getenforce1.png)

5.  kubectl
    This is required for the DB2WH scripts in step 5:
    ```
    cd ${installer_path}/spectrum-discover-package/ibm-db2warehouse/ibm_cloud_pak/pak_extensions
    ./pre-install/clusterAdministration/createSecurityClusterPrereqs.sh
    ./pre-install/namespaceAdministration/createSecurityNamespacePrereqs.sh ${project_name}
    ```

    Installation Steps:
    ```
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mv kubectl /usr/bin
    ```

6.  Install podman
    yum -y install podman
    
7. Install Istio
    https://docs.openshift.com/container-platform/4.8/service_mesh/v1x/installing-ossm.html


## Step 2: Install DB2WH and Spectrum Discover
The documentation for IBM Spectrum Discover on OpenShift can be found here:
https://www.ibm.com/docs/en/spectrum-discover/2.0.4?topic=configuring-deploy-spectrum-discover-red-hat-openshift

### Modified procedure for installing Helm 
In step #2 of the documentation, there are issues with the procedure to install Helm. The following procedure has been corrected to use Helm v2.17.0 and tested with IBM Spectrum Scale: [Click here for the installation procedure](tiller-installation/tiller-installation-steps.md)

### <a name="storage_definitions"></a>Storage Definitions for IBM Spectrum Scale
In step #4 of the documentation, you can use the StorageClass and PersistentVolumeClaim definitions provided [here.](https://github.com/JohnIBM/spectrum-discover-install/tree/main/spectrum-scale)
Please note the "permissions" parameter introduced with CSI 2.3.0 is required for subPath support. This is defined in the parameters section of the storage class as follows:
```
parameters:
    volBackendFs: "xxxx"
    clusterId: "xxxxxxxxxxxxxx"  
    uid: "1000"
    gid: "1000"
    permissions: "777"
```

If you have cloned this repository, you can create the assets using the following command:
```
oc create -f spectrum-discover-install/spectrum-scale/
```

### Next Step: Proceed with the DB2WH installation as normal, starting from step 5 here:
https://www.ibm.com/docs/en/spectrum-discover/2.0.4?topic=openshift-deploying-db2-warehouse-red-hat