# Check to see if nodes are labeled
for node in jmasc-ocp-h9p4v-compute-4 jmasc-ocp-h9p4v-compute-5 jmasc-ocp-h9p4v-compute-6; do oc label node $node scale=true; done
