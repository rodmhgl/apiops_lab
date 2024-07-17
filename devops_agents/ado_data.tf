data "azuredevops_users" "all_vsts_svc_users" {
  origin        = "vsts"
  subject_types = ["svc"]

  depends_on = [
    azuredevops_project.this
  ]
}

data "azuredevops_users" "me" {
  principal_name = var.ado_principal_name

  depends_on = [
    azuredevops_project.this
  ]
}

data "azuredevops_feed" "this" {
  name = var.ado_org_name

  depends_on = [
    azuredevops_project.this
  ]
}
