#!/bin/bash

## Install Java
## Authors: Antonina Lewicka ejn@kmd.dk, Julia Lewicka jll@kmd.dk
## Version: 1.0

# parameters
JAVA_VERSION = 7

# install java
sudo yum install java-$JAVA_VERSION-openjdk

# add java to ~/.bashrc
echo "export JAVA_HOME=\$(dirname \$(dirname \$(readlink \$(readlink \$(which javac)))))" >> ~/.bashrc

# and run
source ~/.bashrc