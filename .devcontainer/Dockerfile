FROM twsimpson/wasi-sdk-sysroot:latest

# Install general build tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git make ninja-build cmake \
    wget build-essential utoconf autogen automake libtool && \
    rm -rf /var/lib/apt/lists/*

# Install arduino-cli:
RUN wget -O /tmp/cli.tar.gz \
      https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Linux_64bit.tar.gz && \
    tar -C /usr/local/bin -zxvf /tmp/cli.tar.gz && \
    rm /tmp/cli.tar.gz && \
    arduino-cli core update-index && \
    arduino-cli core install arduino:avr

# Install Wokwi CLI tool
RUN wget -O /usr/bin/wokwi-cli https://github.com/wokwi/wokwi-cli/releases/download/v0.29.1/wokwi-cli-linuxstatic-x64
