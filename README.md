# rust-aws-lambda-terraform

This project uses Terraform deploy a Rust AWS Lambda function to us-east-1.

# requirements

* Linux (also works from [AWS](https://aws.amazon.com/cloudshell/)/[Google](https://shell.cloud.google.com/?show=ide%2Cterminal) Cloud Shell)
* [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [~/.aws/credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

# development

```
# 1. Install Rust
curl https://sh.rustup.rs -sSf | sh
# 2. Install x86_64-unknown-linux-musl toolchain
rustup target add x86_64-unknown-linux-musl
# 3. Install musl-tools
sudo apt install musl-tools
# 4. deploy to AWS
deploy.sh dev
```