#!/bin/bash
set -e

SMTP_SERVER="$SMTP_SERVER"
SMTP_PORT="$SMTP_PORT"
SMTP_USER="$SMTP_USER"
SMTP_PASSWORD="$SMTP_PASSWORD"
RECIPIENT="$RECIPIENT"
SUBJECT="Terraform Deployment Results"

BODY="Terraform execution completed."

for f in ec2_outputs.json s3_outputs.json; do
  if [[ -f "$f" ]]; then
    BODY+="

--- $f ---
$(cat "$f")"
  fi
done

curl --ssl-reqd \
  --url "smtp://$SMTP_SERVER:$SMTP_PORT" \
  --user "$SMTP_USER:$SMTP_PASSWORD" \
  --mail-from "$SMTP_USER" \
  --mail-rcpt "$RECIPIENT" \
  --upload-file <(echo -e "Subject: $SUBJECT\n\n$BODY")

echo "✅ Email sent via curl"
