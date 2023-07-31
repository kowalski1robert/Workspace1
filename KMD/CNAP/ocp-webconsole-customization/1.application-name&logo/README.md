0. Login to OCP

Create configMap with logo:
1. Prepare logo.png[^1]
2. Encode logo to base64, one-line string[^2]
3. Create configMap with logo by replacing \<one-line-encoded-logo\> with encoded string 

Apply changes to console by changing console/cluster:
1. run:\
`oc get console/cluster -o yaml > current-console-cluster.yaml && cp current-console-cluster.yaml wip-console-cluster.yaml` \
(so you can have back-up config in current-console-cluster.yaml)
2. add to wip-console-cluster.yaml specs from console-cluster.yaml
3. run:\
`oc apply -f wip-console-cluster.yaml`


[^1]: the height of the logo cannot exceed 60px\
[^2]: you can use available encoder.py