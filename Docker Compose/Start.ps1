# Start interactively (attachted to terminal)
if ((Test-Path -Path "compose.env.user"))
{
  docker compose --env-file ./compose.env --env-file ./compose.env.user up
}
else
{
  docker compose --env-file ./compose.env up
}