kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml


# Add the Helm repo
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
helm repo update

# Install the controller
helm install arc-operator actions-runner-controller/actions-runner-controller \
  --namespace actions-runner-system \
  --create-namespace


  kubectl create secret generic controller-manager \
  -n actions-runner-system \
  --from-literal=github_token=YOUR_GITHUB_TOKEN_HERE