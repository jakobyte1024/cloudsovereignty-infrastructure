resource "terraform_data" "configure_vault" {
  # This ensures the pod is actually deployed before running the script
  depends_on = [kubernetes_deployment_v1.vault, kubernetes_service_v1.vault]

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = <<EOF
      echo "Waiting for Vault pod to be ready..."
      kubectl wait --kubeconfig=../kubeconfig-local.yaml --for=condition=ready pod -l app=vault -n ${kubernetes_namespace_v1.vault.metadata[0].name} --timeout=120s

      echo "Starting local port-forward..."
      kubectl port-forward --kubeconfig=../kubeconfig-local.yaml svc/vault -n ${kubernetes_namespace_v1.vault.metadata[0].name} 8200:8200 > /dev/null 2>&1 &
      PF_PID=$!

      # Give the port-forward a few seconds to bind
      sleep 5

      ROOT_TOKEN="${random_password.vault_root_token.result}"
      ADDR="http://127.0.0.1:8200/v1"

      echo "Configuring Vault Transit Engine..."
      # Enable Transit
      curl -s -H "X-Vault-Token: $ROOT_TOKEN" -X POST -d '{"type":"transit"}' $ADDR/sys/mounts/transit

      # Create Key
      curl -s -H "X-Vault-Token: $ROOT_TOKEN" -X POST $ADDR/transit/keys/kek

      echo "Cleaning up port-forward..."
      kill $PF_PID
    EOF
  }
}