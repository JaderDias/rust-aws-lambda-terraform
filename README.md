# rust-aws-lambda-terraform

This project uses Terraform deploy a Rust AWS Lambda function to us-east-1.

# requirements

* Linux (also works from [AWS](https://aws.amazon.com/cloudshell/)/[Google](https://shell.cloud.google.com/?show=ide%2Cterminal) Cloud Shell)
* [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [~/.aws/credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

# development

1. Install Rust
   * `curl https://sh.rustup.rs -sSf | sh`

2. Install musl-gcc
   * Linux `sudo apt install musl-tools`
   * Mac   `brew install FiloSottile/musl-cross/musl-cross --with-x86_64 --with-aarch64`

3. deploy to AWS
   * `deploy.sh dev aarch64` or
   * `deploy.sh dev x86_64`