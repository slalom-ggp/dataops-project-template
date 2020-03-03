# Secrets directory (`.secrets`)

**Important:**

* To prevent accidentally committing secrets into source control, Git will ignore all files in this directory EXCEPT files that end in `.template` and this `README.md` file. (Do not store any actual secrets in templates or in this readme file.)

## Sample AWS credentials file

* [ ] TODO: for new projects, copy-paste the below into a new `aws-credentials` file.

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
