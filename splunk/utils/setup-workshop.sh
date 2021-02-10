echo "*** Updating OS..."
sudo apt-get -y update

echo "*** Installing Docker..."
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "*** Installing kubectl..."
sudo apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get -y update
sudo apt-get install -y kubectl

echo "*** Installing kind..."
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.9.0/kind-$(uname)-amd64"
chmod +x ./kind
sudo mv ./kind /usr/bin/kind

echo "*** Installing skaffold..."
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
sudo install skaffold /usr/local/bin/
rm skaffold

echo "*** Downloading the workshop content..."
cd ~
git clone https://github.com/billg-splunk/microservices-demo