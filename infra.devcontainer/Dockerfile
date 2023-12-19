FROM mcr.microsoft.com/devcontainers/go:1-1.21-bullseye

RUN sudo apt-get update -y && sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo xdg-utils -y

# kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -LS https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && chmod +x ./kubectl \
  && sudo mv ./kubectl /usr/local/bin/kubectl

# Helm
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list \
  && sudo apt-get update -y && sudo apt-get install helm -y

# Sops
RUN curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64 \
  && mv sops-v3.8.1.linux.amd64 /usr/local/bin/sops \
  && chmod +x /usr/local/bin/sops

# Helm-Secrets
RUN helm plugin install https://github.com/jkroepke/helm-secrets

# gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.asc && apt-get update -y && apt-get install google-cloud-sdk -y \
 && sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y

# install PipeCD quick starter
ENV OS=linux
RUN curl -Lo ./pipectl https://github.com/pipe-cd/pipecd/releases/download/v0.45.3/pipectl_v0.45.3_${OS}_amd64 \
  && chmod +x ./pipectl \
  && sudo mv ./pipectl /usr/local/bin/pipectl

# install Argocd CLI
RUN curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 \
  && sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd \
  && rm argocd-linux-amd64
