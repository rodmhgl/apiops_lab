resource "azuredevops_agent_pool" "main" {
  # If ado_pool is not set, create a pool for the agent
  count          = var.ado_pool == "" ? 1 : 0
  name           = local.agent_pool
  auto_provision = true
  auto_update    = false

  depends_on = [
    azuredevops_project.this
  ]
}
