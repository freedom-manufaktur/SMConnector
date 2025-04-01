#              ReleaseName
helm uninstall sm-connector
kubectl delete -n default pod sm-connector-test-connection --ignore-not-found=true
# HELM < 3.17.2 created this name (including the release name)
kubectl delete -n default pod sm-connector-sm-connector-test-connection --ignore-not-found=true