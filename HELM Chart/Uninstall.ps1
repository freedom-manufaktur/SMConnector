#              ReleaseName
helm uninstall sm-connector
kubectl delete -n default pod sm-connector-sm-connector-test-connection --ignore-not-found=true