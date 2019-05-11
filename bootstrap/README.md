# Bootstrap

You can have multiple projects within an organization. You need a boostrap project that contains a Google Cloud Storage bucket to store Terraform states.

## Get Service Account Credentials

1. Login into `gcloud` as the organization admin: `gcloud auth login`
1. Get the organization's admin project, and set it as an environmental variable: `export GOOGLE_PROJECT="..."`
1. Get the organization ID, and set it as an environmental variable: `export GOOGLE_ORG_ID="..."`
1. Set project to your organization's admin project: `gcloud config set project ${GOOGLE_PROJECT}`
1. Create a service account: `gcloud iam service-accounts create terraform-admin --display-name "Terraform Admin"`
1. Assign roles:
  1. `gcloud projects add-iam-policy-binding ${GOOGLE_PROJECT} --member serviceAccount:terraform-admin@${GOOGLE_PROJECT}.iam.gserviceaccount.com --role "roles/resourcemanager.organizationAdmin"`
  1. `gcloud organizations add-iam-policy-binding ${GOOGLE_ORG_ID} --member serviceAccount:terraform-admin@${GOOGLE_PROJECT}.iam.gserviceaccount.com --role "roles/resourcemanager.projectCreator"`
  1. `gcloud organizations add-iam-policy-binding ${GOOGLE_ORG_ID} --member serviceAccount:terraform-admin@${GOOGLE_PROJECT}.iam.gserviceaccount.com --role "roles/resourcemanager.folderAdmin"`
  1. `gcloud organizations add-iam-policy-binding ${GOOGLE_ORG_ID} --member serviceAccount:terraform-admin@${GOOGLE_PROJECT}.iam.gserviceaccount.com --role "roles/billing.admin"`
1. Create a JSON key for the service account. Treat it with care! `gcloud iam service-accounts keys create ~/terraform-admin-sa.json --iam-account=terraform-admin@${GOOGLE_PROJECT}.iam.gserviceaccount.com`
1. Set the location of JSON key: `export GOOGLE_CREDENTIALS=$HOME/terraform-admin-sa.json`

## Enable APIs
1. `gcloud services enable cloudresourcemanager.googleapis.com cloudbilling.googleapis.com`

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

## Configure Travis
1. `travis env set TF_VAR_org_id YOUR_ORG_ID`
1. `travis env set TF_VAR_billing_account YOUR_BILLING_ACCOUNT`