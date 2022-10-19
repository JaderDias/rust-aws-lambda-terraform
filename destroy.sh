#!/bin/sh
environment="$1"
if [ -z "$environment" ]
then
    echo "Usage: deploy.sh <environment>"
    exit 1
fi

cd terraform

terraform workspace new $environment
terraform workspace select $environment

terraform apply -destroy
cd ..