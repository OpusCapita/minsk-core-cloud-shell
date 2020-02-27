FROM codercom/code-server:2.1697-vsc1.39.2

USER coder

# Install utils
RUN sudo apt-get update \
  && sudo apt-get install -y jq vim netcat dnsutils mtr unzip psmisc tree silversearcher-ag

# Install kubectl
RUN cd /bin \
  && sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl \
  && sudo chown coder:coder /bin/kubectl && sudo chmod 700 /bin/kubectl \
  && echo "alias k=kubectl" >> /home/coder/.bashrc

# Install krew
# RUN ( \
#   set -x; cd "$(mktemp -d)" && \
#   curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.{tar.gz,yaml}" && \
#   tar zxvf krew.tar.gz && \
#   KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" && \
#   "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz && \
#   "$KREW" update \
#   )

# ENV PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# # Install NodeJS
# RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
#   && sudo apt-get install -y nodejs

# Install Kubernetes extension and fix dependencies.
RUN code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
COPY ./create-kubeconfig.sh /create-kubeconfig.sh

# Install MSSQL extension
RUN code-server --install-extension ms-mssql.mssql
COPY ./configure-mssql.sh /configure-mssql.sh

# Install MySQL extension
RUN code-server --install-extension formulahendry.vscode-mysql

# # Install AzureCLI
# RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# # Install Vault
# RUN curl -fsSLk -o /tmp/vault.zip https://releases.hashicorp.com/vault/1.2.2/vault_1.2.2_linux_amd64.zip \
#   && sudo unzip /tmp/vault.zip -d /bin/ \
#   && sudo chown coder:coder /bin/vault && sudo chmod 700 /bin/vault \
#   && rm -f /tmp/vault.zip

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["dumb-init", "/entrypoint.sh"]
