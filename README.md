# Terraform Project (S3-only remote state) with GitHub Actions

This project contains:
- `backend/` - terraform to create the S3 bucket used for remote state (run this first, it uses local state)
- `ec2/` - terraform project for EC2 (uses S3 backend)
- `s3/` - terraform project for S3 object upload (uses S3 backend)
- `.github/workflows/terraform.yml` - GitHub Actions workflow to plan/apply/destroy and send email

## Quick workflow

1. **Create the backend S3 bucket** (one-time, locally or CI):
```bash
cd backend
terraform init
terraform apply -auto-approve
```
This prints the bucket name (`bucket_name`) in outputs.

2. **Use the workflow**
- Push code, or run the workflow manually in Actions -> Run workflow.
- The workflow asks:
  - `destroy` (true/false)
  - `resource` (ec2 | s3 | all)
  - `backend_bucket` (the bucket created in step 1)
  - `recipient_email` (enter recipient here)
- Add GitHub Secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `SMTP_SERVER`
  - `SMTP_PORT`
  - `SMTP_USER`
  - `SMTP_PASSWORD`

3. **What the workflow does**
- Initializes Terraform in the selected module(s) with S3 backend (uses `backend_bucket` and module-specific key)
- Runs `terraform apply` or `terraform destroy` based on input
- Collects outputs and emails them to the `recipient_email` using provided SMTP secrets

## Notes
- We intentionally do **not** use DynamoDB locks. Concurrent runs may cause state conflicts; avoid parallel runs.
- Backend bootstrap must be run once to create the S3 bucket before using the S3 backend.
- You can edit backend keys in `.github/workflows/terraform.yml` to change where each module stores its tfstate.