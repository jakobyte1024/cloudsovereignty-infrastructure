# Cloud-sovereignty showcase original

This terraform script deploys the cloudsovereignty showcase without column-level-encryption

Run the following commands to start everything up:

1. Configure your STACKIT service account (`sa-key.json` in the root folder of this repository).

2. Switch to the `infrastructure` folder to initialize the infrastructure

3. Run `terraform init` to initialize the workspace.
4. Run `terraform apply` to provision the infrastructure.

5. Switch to the `platform` folder to deploy the helm-charts to the cluster.

6. Run `terraform init` to initialize the workspace.
7. Run `terraform apply` to deploy the applications.