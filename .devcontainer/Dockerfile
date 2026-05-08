# Flutter Web Dev Container
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install Flutter SDK
RUN curl -sL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz | tar xJ -C /opt
RUN ln -s /opt/flutter/bin/flutter /usr/local/bin/flutter
RUN ln -s /opt/flutter/bin/dart /usr/local/bin/dart

# Enable web
RUN flutter config --enable-web