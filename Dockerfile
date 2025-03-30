# Use an official Ubuntu as a parent image
FROM ubuntu:24.04

# Set environment variables to non-interactive to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package repository and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    software-properties-common \
    apt-transport-https \
    ca-certificates

# Install OpenTofu
RUN curl -fsSL https://apt.opentofu.org/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://apt.opentofu.org/stable focal main" \
    && apt-get update \
    && apt-get install -y opentofu

# Install Ansible
RUN apt-add-repository --yes --update ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y ansible

# Install Access Credentials (assuming a placeholder command, replace with actual)
RUN echo "Installing access credentials..." \
    # Add actual command here

# Install Unifi Controller
RUN echo 'deb http://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 \
    && apt-get update \
    && apt-get install -y unifi

# Install Minio
RUN curl -O https://dl.min.io/server/minio/release/linux-amd64/minio \
    && chmod +x minio \
    && mv minio /usr/local/bin/

# Copy the repository into the Docker container
COPY . /ClusterCreator

# Expose ports for Unifi Controller and Minio
EXPOSE 8443 9000

# Set default command
CMD ["bash"]