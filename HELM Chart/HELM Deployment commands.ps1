# Install HELM https://helm.sh/docs/intro/install/
winget install helm.helm

# ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
# ■ Deploy and test application ■

#            ReleaseName Folder
helm upgrade sm-connector . --install
# Combine value file (excluded from source control)
helm upgrade sm-connector . --install --values values.yaml --values values.yaml.user
# Test the application
helm test sm-connector

# ■■■■■■■■■■■■■■■■■■■■■■■■■
# ■ Uninstall application ■

#              ReleaseName
helm uninstall sm-connector
kubectl delete -n default pod sm-connector-sm-connector-test-connection