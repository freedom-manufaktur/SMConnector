$PublicPort = 8000
Write-Output "Application:  http://localhost:$PublicPort/"
Write-Output "Debug:        http://localhost:$PublicPort/Debug"
Write-Output "Health check: http://localhost:$PublicPort/healthcheck"
kubectl --namespace default port-forward svc/sm-connector ${PublicPort}:8080
