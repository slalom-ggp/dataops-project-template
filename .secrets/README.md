# Secrets directory (`.secrets`)

**Important:**

* To prevent accidentally committing secrets into source control, Git will ignore all files in this
directory EXCEPT files that end in `.template` and this `README.md` file. (Do not store any actual
secrets in templates or in this readme file.)

## Sample AWS credentials file

* [ ] TODO: For new projects which require AWS, rename `aws-credentials.template` to `aws-credentials`
and populate the file with your AWS credentials.

    ```ini
    [default]

    aws_access_key_id={{access_key}}
    aws_secret_access_key={{secret_key}}
    ```

## Sample secrets file for terraform

* [ ] TODO: Optional. For new projects which require custom AWS secrets, rename `aws-secrets-manager-secrets.yml.template` to `aws-secrets-manager-secrets.yml` and populate the file with any credentials or keys needed by your project.

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
