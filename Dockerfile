FROM jenkins/inbound-agent:latest

# Switch to root
USER root

# Install Docker
RUN apt update
RUN apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-cache policy docker-ce
RUN apt-get install -y docker-ce

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install

# Switch back to the jenkins user.
RUN usermod -aG docker jenkins
RUN groupadd -g 998 hostdocker
RUN usermod -aG hostdocker jenkins

USER jenkins
