FROM mandrean/drone-kubernetes-helm:v0.3.0-k8s-v1.6-4-helm-v2.4.2

# Environment variables
ARG K8S_VERSION=1.9.3
ARG HELM_VERSION=2.9.1
ARG KUBE_PATH="/root/.kube/"

# Install kubectl & helm
RUN curl -#SL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v$K8S_VERSION/bin/linux/amd64/kubectl \
&& chmod +x /usr/local/bin/kubectl \
&& curl -#SL https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz | tar zxvf - \
&& mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 \
&& chmod +x /usr/local/bin/helm \
&& helm init -c

ENTRYPOINT /bin/sh
