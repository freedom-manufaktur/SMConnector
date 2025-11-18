# Stop
if ((Test-Path -Path "compose.env.user"))
{
  docker compose --env-file ./compose.env --env-file ./compose.env.user down
}
else
{
  docker compose --env-file ./compose.env down
}