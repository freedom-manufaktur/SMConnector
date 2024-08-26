if ((Test-Path -Path "values.yaml.user"))
{
  # Combine value file (excluded from source control)
  #            ReleaseName  Folder
  helm upgrade sm-connector . --install --values values.yaml --values values.yaml.user
}
else
{
  #            ReleaseName  Folder
  helm upgrade sm-connector . --install --values values.yaml --values values.yaml.user
}