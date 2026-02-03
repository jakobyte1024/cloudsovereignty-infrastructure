# Cloud Sovereignty Infrastructure

This repository provides the necessary setup for deploying the cloud sovereignty showcase using Docker Compose or Terraform.

## Components

### Docker Compose
The `docker-compose.yml` orchestrates containerized services for local development and testing environments.

#### Services and URLs
| Service           | URL                                |
|-------------------|------------------------------------|
| Postgres Database | localhost:5432 |
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
cloudsovereignty-manufacturedomain/
cloudsovereignty-orderdomain/
cloudsovereignty-supplierdomain/
```

#### Getting Started with Docker Compose
1. Navigate to the `compose` directory.
2. Run `docker compose up` to start all services.
3. Access the services using the URLs provided above.

### Terraform
Infrastructure provisioning is managed through Terraform scripts.

#### Terraform Variables
| Variable Name       | Description                                   | Type   |
|---------------------|-----------------------------------------------|--------|
| `stackit_project_id`| STACKIT project ID                            | `string` |
| `stackit_region`    | STACKIT region                                | `string` |

#### Getting Started with Terraform
1. Configure your STACKIT service account (`sa-key.json` in the `terraform` folder).

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