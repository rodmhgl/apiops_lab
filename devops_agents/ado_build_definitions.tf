resource "azuredevops_build_definition" "extractor" {
  project_id = azuredevops_project.this.id
  name       = "Run Extractor"
  path       = "\\"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_git_repository.apiops.id
    branch_name = "main"
    yml_path    = "tools/pipelines/run-extractor.yaml"
  }

  variable_groups = [
    azuredevops_variable_group.apiops.id
  ]

  depends_on = [
    azuredevops_git_repository_file.configs,
    azuredevops_git_repository_file.pipelines
  ]
}

resource "azuredevops_build_definition" "publisher" {
  project_id = azuredevops_project.this.id
  name       = "Run Publisher"
  path       = "\\"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_git_repository.apiops.id
    branch_name = "main"
    yml_path    = "tools/pipelines/run-publisher.yaml"
  }

  variable_groups = [
    azuredevops_variable_group.apiops.id
  ]

  depends_on = [
    azuredevops_git_repository_file.configs,
    azuredevops_git_repository_file.pipelines
  ]
}