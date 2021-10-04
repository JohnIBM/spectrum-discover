# Installing Helm / Tiller 2.17.0 for Spectrum Discover

<!--- cSpell: helm tiller allowfullscreen -->


### The following steps must be performed on a client with access to the OpenShift cluster, using the OpenShift CLI (oc)
`oc new-project tiller`

### 1 - Prereqs

1. Obtain a clean RedHat OpenShift cluster where nothing else has been installed on top. This RedHat OpenShift cluster must be composed of five worker nodes where three of these will be entirely dedicated to OpenShift Data Foundation (ODF). The storage nodes must be 16 CPUs and 64 GB RAM at least.

    ![nodes](images/ibm/nodes.png)

1. Once your RedHat OpenShift cluster is available on your IBM Cloud dashboard, you must install the OpenShift Data Foundation add-on:
    1. From the OpenShift clusters console, select the cluster where you want to install the add-on.
    1. On the cluster Overview page, click Add-ons.
    1. On the OpenShift Data Foundation card, click Install.
    ![addon](images/ibm/addon.png)

1. On the cluster Nodes page, select one node per availability zone and write down it's IP address.

    ![ips](images/ibm/ips.png)

1. Log into your RedHat OpenShift web console using the button on the top right corner of your cluster dashboard on IBM Cloud.

1. Go to the Compute --> Nodes section on the navigation index on the left hand side and for each of the nodes you picked in the previous step:

    ![oc nodes](images/ibm/oc_nodes.png){: style="max-height:750px"}
