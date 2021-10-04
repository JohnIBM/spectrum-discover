for node in `oc get node --no-headers -lscale=true | awk '{print $1}'`; do oc debug node/$node -T -- chroot /host sh -c "sudo setenforce 0"; done

