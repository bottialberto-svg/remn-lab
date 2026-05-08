# Flutter Web Dev Container
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Fix git safe directory
RUN git config --global --add safe.directory /opt/flutter

# Install Flutter SDK
RUN curl -sL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz | tar xJ -C /opt
RUN ln -s /opt/flutter/bin/flutter /usr/local/bin/flutter
RUN ln -s /opt/flutter/bin/dart /usr/local/bin/dart

# Enable web and install Chrome for Linux
RUN flutter config --enable-web && \
    curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable && rm -rf /var/lib/apt/lists/*