#!/bin/bash

# Read Maven version from user input
read -p "Enter the Maven version you want to install (e.g., 3.9.8): " MAVEN_VERSION

# Download URL
MAVEN_DOWNLOAD_URL=https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip

# Installation directory
INSTALL_DIR=/opt/apache-maven-${MAVEN_VERSION}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Java is installed
if command_exists java; then
    echo "Java is already installed."
else
    echo "Java is not installed. Installing Java..."
    sudo apt-get update -y
    sudo apt-get install -y openjdk-8-jdk
fi

# Verify Java installation
if command_exists java; then
    echo "Java installation verified."
    JAVA_VER=$(java -version 2>&1 >/dev/null | egrep "\S+\s+version" | awk '{print $3}' | tr -d '"') | echo "$JAVA_VER"
else
    echo "Java installation failed. Exiting."
    exit 1
fi

# Check if Maven is already installed
if [ -d "$INSTALL_DIR" ]; then
  echo "Maven $MAVEN_VERSION is already installed in $INSTALL_DIR"
  exit 0
fi

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install necessary packages
echo "Installing necessary packages..."
sudo apt-get install -y wget zip

# Download Maven
echo "Downloading Maven $MAVEN_VERSION..."
wget -q $MAVEN_DOWNLOAD_URL -O /tmp/apache-maven-${MAVEN_VERSION}-bin.zip

# Extract Maven
echo "Extracting Maven..."
sudo unzip /tmp/apache-maven-${MAVEN_VERSION}-bin.zip -d /opt

# Set up environment variables in ~/.bashrc
echo "Setting up environment variables in ~/.bashrc..."
echo "export M2_HOME=/opt/apache-maven-${MAVEN_VERSION}" >> ~/.bashrc
echo "export PATH=\${M2_HOME}/bin:\${PATH}" >> ~/.bashrc

# Source ~/.bashrc to apply changes
echo "Applying environment changes..."
source ~/.bashrc

# Verify installation
echo "Verifying Maven installation..."
mvn -version

# Clean up
echo "Cleaning up..."
rm /tmp/apache-maven-${MAVEN_VERSION}-bin.zip

echo "Maven $MAVEN_VERSION installation completed."
