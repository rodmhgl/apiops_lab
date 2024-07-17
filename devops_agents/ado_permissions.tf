locals {
  build_service_user = [
    for k in tolist(data.azuredevops_users.all_vsts_svc_users.users) :
    k if k.display_name == "${azuredevops_project.this.name} Build Service (${var.ado_org_name})"
  ]
}

resource "azuredevops_group" "apiops" {
  scope        = azuredevops_project.this.id
  display_name = "APIOps"
  description  = "Group created to hold APIOps users."
}

resource "azuredevops_group_membership" "apiops" {
  group = azuredevops_group.apiops.descriptor
  members = [
    tolist(data.azuredevops_users.me.users)[0].descriptor,
    local.build_service_user[0].descriptor
  ]
}

resource "azuredevops_build_folder_permissions" "apiops" {
  project_id = azuredevops_project.this.id
  path       = "\\"
  principal  = azuredevops_group.apiops.id

  permissions = {
    AdministerBuildPermissions     = "NotSet"
    DeleteBuildDefinition          = "Allow"
    DeleteBuilds                   = "Allow"
    DestroyBuilds                  = "Allow"
    EditBuildDefinition            = "Allow"
    EditBuildQuality               = "Allow"
    ManageBuildQualities           = "NotSet"
    ManageBuildQueue               = "NotSet"
    OverrideBuildCheckInValidation = "NotSet"
    QueueBuilds                    = "Allow"
    RetainIndefinitely             = "Allow"
    StopBuilds                     = "Allow"
    UpdateBuildInformation         = "Allow"
    ViewBuildDefinition            = "Allow"
    ViewBuilds                     = "Allow"
  }
}

resource "azuredevops_feed_permission" "permission" {
  feed_id             = data.azuredevops_feed.this.id
  role                = "administrator"
  identity_descriptor = azuredevops_group.apiops.descriptor
  display_name        = "ApiOps"
}

resource "azuredevops_git_permissions" "apiops" {
  project_id = azuredevops_project.this.id
  principal  = azuredevops_group.apiops.id
  permissions = {
    CreateRepository      = "Allow"
    DeleteRepository      = "Allow"
    GenericContribute     = "Allow"
    ForcePush             = "Allow"
    CreateBranch          = "Allow"
    CreateTag             = "Allow"
    PullRequestContribute = "Allow"
  }
}