#!/bin/bash
environment="$1"
architecture="$2"
if [ -z "$environment" ]
then
    echo "Usage: deploy.sh <environment> <architecture>"
    echo "architecture must be 'arm64' or 'x86_64'"
    exit 1
fi

if [ -z "$architecture" ]
then
    echo "Usage: deploy.sh <environment> <architecture>"
    echo "architecture must be 'arm64' or 'x86_64'"
    exit 1
fi

compiler_arch=$architecture
if [ $architecture = "arm64" ]
then
    compiler_arch="aarch64"
fi

rustup target add "$compiler_arch-unknown-linux-musl"
if [ $? -ne 0 ]
then
    echo "rustup target add failed"
    exit 1
fi

echo -e "\n+++++ Starting deployment +++++\n"

rm -rf ./bin
mkdir ./bin
mkdir ./bin/render

echo "+++++ build rust packages +++++"

cd rust/render

TARGET_CC="$compiler_arch-linux-musl-gcc" \
RUSTFLAGS="-C linker=$compiler_arch-linux-musl-gcc" \
cargo build --release --target "$compiler_arch-unknown-linux-musl"
if [ $? -ne 0 ]
then
    echo "cargo build failed"
    exit 1
fi

cp "target/$compiler_arch-unknown-linux-musl/release/render" ../../bin/render/bootstrap

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
    --var "aws_region=$aws_region" \
    --var "architecture=$architecture"

echo -e "\n+++++ Deployment done +++++\n"