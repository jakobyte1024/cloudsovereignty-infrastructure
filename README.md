# Cloud Sovereignty Infrastructure

This repository provides the necessary setup for deploying the cloud sovereignty showcase using Docker Compose or Terraform.

## Components

### Docker Compose
The `docker-compose.*.yml` orchestrates containerized services for local development and testing environments.

There are multiple demo deployments:

1. Completely local using Hashicorp Vault as a KMS.  
    To run this variant run the following commands.
    ```bash
    cp .env.vault.example .env
    docker compose -f docker-compose.vault.yml up -d
    ```

2. Partially local using STACKIT KMS as a KMS.  
    To run this variant run the following command to copy the example env file so it is actually used.
    ```bash
    cp .env.stackit.example .env
    ```
    After that edit the file and make sure all of the variables are set correctly.  
    Now create a STACKIT service account with the Editor role (only for demo purpouse) and put it into the root of the repository as `sa-key.json`.  
    After that run the following command to start everything:
    ```bash
    docker compose -f docker-compose.stackit.yml up -d
    ```

#### Services and URLs
| Service           | URL                                |
|-------------------|------------------------------------|
| Postgres Database | localhost:5432 |
| Hashicorp Vault   | [http://localhost:8200](http://localhost:8200/)|
| Encryption Proxy  | [http://localhost:8201](http://localhost:8201/)|
| Order Domain      | [http://localhost:8081/api/explorer/](http://localhost:8081/api/explorer/) |
| Supplier Domain   | [http://localhost:8082/api/explorer/](http://localhost:8082/api/explorer/) |
| Manufacture Domain| [http://localhost:8083/api/explorer/](http://localhost:8083/api/explorer/) |

#### Workspace Structure
Ensure your workspace follows this structure:

```
cloudsovereignty-driver/
cloudsovereignty-infra/
    compose/
        docker-compose.yml
cloudsovereignty-encryptionproxy/
cloudsovereignty-manufacturedomain/
cloudsovereignty-orderdomain/
cloudsovereignty-supplierdomain/
```

#### Getting Started with Docker Compose
1. Navigate to the `compose` directory.
2. Run `docker compose up` to start all services.
3. Access the services using the URLs provided above.

### Terraform
This repository includes two different deployments.

1. A full-cloud deployment to STACKIT using the STACKIT KMS for Column-Level-Encryption inside the DB
2. A "hybrid-cloud" like deployment to STACKIT using Hashicorp Vault for Column-Level-Encryptrion inside the DB

Infrastructure provisioning is managed through Terraform scripts.

#### Terraform Variables
| Variable Name       | Description                                   | Type   |
|---------------------|-----------------------------------------------|--------|
| `stackit_project_id`| STACKIT project ID                            | `string` |
| `stackit_region`    | STACKIT region                                | `string` |

#### Getting Started with Terraform
1. Configure your STACKIT service account (`sa-key.json` in the root folder of this repository).

2. Switch to the `terraform/infra` folder to initialize the infrastructure

3. Run `terraform init` to initialize the workspace.
4. Run `terraform apply` to provision the infrastructure.

5. Switch to the `terraform/k8s` folder to deploy the helm-charts to the cluster.

6. Run `terraform init` to initialize the workspace.
7. Run `terraform apply` to deploy the applications.

The folder-structure should look like this:

```
cloudsovereignty-driver/
cloudsovereignty-infra/
    terraform/
        infra/
        k8s/
        sa-key.json (Service Account)
cloudsovereignty-manufacturedomain/
cloudsovereignty-orderdomain/
cloudsovereignty-supplierdomain/
```