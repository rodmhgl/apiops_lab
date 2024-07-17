locals {
  pipeline_files = [
    "repo/tools/pipelines/run-extractor.yaml",
    "repo/tools/pipelines/run-publisher.yaml",
    "repo/tools/pipelines/run-publisher-with-env.yaml",
  ]
  config_files = [
    "repo/configuration.prod.yaml"
  ]
}

data "local_file" "pipelines" {
  for_each = toset(local.pipeline_files)

  filename = each.key
}

data "local_file" "configs" {
  for_each = toset(local.config_files)

  filename = each.key
}

resource "azuredevops_git_repository" "apiops" {
  project_id     = azuredevops_project.this.id
  name           = "apiopsdemo"
  default_branch = "refs/heads/main"

  initialization {
    init_type = "Clean"
  }

  depends_on = [
    azuredevops_git_permissions.apiops
  ]
}

resource "azuredevops_git_repository_file" "pipelines" {
  for_each = data.local_file.pipelines

  repository_id       = azuredevops_git_repository.apiops.id
  file                = "tools/pipelines/${basename(each.value.filename)}"
  content             = each.value.content
  branch              = "refs/heads/main"
  commit_message      = "First commit"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [ commit_message ]
  }
}

resource "azuredevops_git_repository_file" "configs" {
  for_each = data.local_file.configs

  repository_id       = azuredevops_git_repository.apiops.id
  file                = basename(each.value.filename)
  content             = each.value.content
  branch              = "refs/heads/main"
  commit_message      = "First commit"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [ commit_message ]
  }
}
