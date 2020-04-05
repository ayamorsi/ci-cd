FROM jenkins/jenkins:latest

# set variables 
ARG terraform_version="0.11.13"

ENV TERRAFORM_VERSION $terraform_version

# switch to install packages via apt
USER root

# install HasiCorp Terraform
RUN set +x \
  && wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && mv terraform /bin


# install Jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN set +x \
  && /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt