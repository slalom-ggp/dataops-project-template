# Terraform will read environment variables in the form of TF_VAR_name to find the value for a variable. For example, the TF_VAR_region variable can be set to set the region variable.

name_prefix = "PTB-"
region      = "us-east-2"
shared_tags = {
    contact = "aj.steers@slalom.com"
}
