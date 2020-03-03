# Secrets directory (`.secrets`)

**Note:**

* To prevent accidentally committing secrets into source control, all files in this directory except this one (`README.md`) will be **excluded** from git. (Do not store any actual secrets in this readme file.)

## Sample AWS credentials file

* [ ] TODO: for new projects, copy-paste the below into a new `credentials` file.

```ini
[default]

aws_access_key_id={{access_key}}
aws_secret_access_key={{secret_key}}
```

## Sample secrets file for terraform

* [ ] TODO: for new projects, copy-paste the below into a new `aws-secrets-manager-secrets.yml` file.

`aws-secrets-manager-secrets.yml`

```yml
# Secrets stored here (`aws-secrets-manager-secrets.yml`) will automatically be deployed to AWS Secrets Manager.
# Secrets will be created in secret manager as follows:
#           arn:aws:secretsmanager:us-east-2::secret:MY-APP-ID-ygkLPL

SAMPLE_TAP_username: my-username
SAMPLE_TAP_password: my-pass

S3_CSV_aws_access_key_id:     asdf******
S3_CSV_aws_secret_access_key: asdf******
```
