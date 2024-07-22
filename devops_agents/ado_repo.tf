locals {
  config_fileset_path   = "repo"
  pipeline_fileset_path = "repo/tools/pipelines"
  config_fileset        = fileset(local.config_fileset_path, "*")
  pipeline_fileset      = fileset(local.pipeline_fileset_path, "*")
}

data "local_file" "pipelines" {
  for_each = local.pipeline_fileset

  filename = "${local.pipeline_fileset_path}/${each.key}"
}

data "local_file" "configs" {
  for_each = local.config_fileset

  filename = "${local.config_fileset_path}/${each.key}"
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
    ignore_changes = [commit_message]
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
    ignore_changes = [commit_message]
  }
}
