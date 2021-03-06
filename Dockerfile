FROM python:3.9
ARG TARGETARCH=amd64
ARG TERRAFORM_VERSION=1.1.9

RUN pip3 install ansible boto3 && \
    ansible-galaxy collection install community.aws && \
    ansible-galaxy collection install ansible.posix && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip -o /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    chmod 755 /usr/local/bin/terraform && \
    curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb


WORKDIR /terraform

ENTRYPOINT ["terraform"]