resource "azuredevops_git_repository" "apiops" {
  project_id     = azuredevops_project.this.id
  name           = "apiopsdemo"
  default_branch = "refs/heads/main"

  initialization {
    init_type   = "Import"
    source_type = "Git"
    source_url  = "https://github.com/rodmhgl/apiops_starter_reop.git"
  }

  depends_on = [
    azuredevops_git_permissions.apiops
  ]
}
