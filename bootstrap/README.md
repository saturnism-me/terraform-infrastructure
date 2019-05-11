# Bootstrap

You can have multiple projects within an organization. You need a boostrap project that contains a Google Cloud Storage bucket to store Terraform states.

## Enable APIs
1. `gcloud services enable cloudresourcemanager.googleapis.com cloudbilling.googleapis.com serviceusage.googleapis.com`

## Terraform
1. Configure variables in `terraform.tfvars`

   ```
   admin_project = "..."
   org_id = "..."
   billing_account = "..."
   terraform_backend_bucket = "..."
   terraform_backend_project = "..."
   ```

1. Initialize: `terraform init`
1. Plan: `terraform plan bootstrap/`
1. Apply: `terraform apply -auto-approve`

