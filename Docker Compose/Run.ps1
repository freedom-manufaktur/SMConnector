# Run in background (detachted from terminal)
if ((Test-Path -Path "compose.env.user"))
{
  docker compose --env-file ./compose.env --env-file ./compose.env.user up --detach
}
else
{
  docker compose --env-file ./compose.env up --detach
}