resource "azuredevops_environment" "prod" {
  name        = "Prod"
  description = "Simulates production environment."
  project_id  = azuredevops_project.this.id
}

resource "azuredevops_check_approval" "example" {
  project_id            = azuredevops_project.this.id
  target_resource_id    = azuredevops_environment.prod.id
  target_resource_type  = "environment"
  requester_can_approve = true

  approvers = [tolist(data.azuredevops_users.me.users)[0].id, ]
}
