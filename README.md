# Fixed Terraform Project (S3 remote state for multiple modules)

This repo contains:
- backend/     -> Terraform to create the S3 backend bucket and DynamoDB lock table (run once)
- ec2/         -> Terraform module to create EC2 (no backend block); generates TLS key, key-pair, saves `tf-key.pem`, creates EC2, and outputs details.
- s3/          -> Terraform module to create example S3 bucket (no backend block); outputs bucket name.
- .github/workflows/terraform.yml -> CI workflow that initializes module backends in S3, checks for state existence, applies/destroys, collects outputs, uploads PEM

Quick flow
1. Create the backend bucket (locally or via CI) from `backend/`:
   cd backend && terraform init && terraform apply -auto-approve
   Note the `backend_bucket_name` output.
2. Run the GitHub Actions workflow and provide `backend_bucket` from step 1.
3. Choose `resource` = ec2 | s3 | all and `destroy` = yes | no.
4. After run: download PEM from workflow artifacts and review outputs in email / artifacts.
