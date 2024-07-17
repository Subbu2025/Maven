#!/bin/bash

# Uninstall Java
sudo apt-get remove --purge openjdk-8-jdk openjdk-8-jre
sudo apt-get autoremove
sudo apt-get autoclean

# Uninstall Maven
sudo rm -rf /opt/apache-maven-*
# Remove Maven environment variables from ~/.bashrc if present

# Clean up temporary files
sudo rm -rf /tmp/*
sudo apt-get clean

echo "Java and Maven uninstallation completed."
