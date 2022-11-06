#!/bin/bash
environment="$1"
if [ -z "$environment" ]
then
    echo "Usage: deploy.sh <environment>"
    exit 1
fi

echo -e "\n+++++ Starting deployment +++++\n"

rm -rf ./bin
mkdir ./bin
mkdir ./bin/render

echo "+++++ build rust packages +++++"

cd rust/render
cargo build --release --target x86_64-unknown-linux-musl
if [ $? -ne 0 ]
then
    echo "cargo build failed"
    exit 1
fi

cp target/x86_64-unknown-linux-musl/release/render ../../bin/render/bootstrap

echo "+++++ apply terraform +++++"
cd ../../terraform
terraform init
if [ $? -ne 0 ]
then
    echo "terraform init failed"
    exit 1
fi

terraform workspace new $environment
terraform workspace select $environment

aws_region="us-east-1"

terraform apply --auto-approve \
    --var "aws_region=$aws_region"

echo -e "\n+++++ Deployment done +++++\n"