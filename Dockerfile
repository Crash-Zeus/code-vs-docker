FROM debian:10-slim

# Install required
RUN apt-get update && apt-get -y --no-install-recommends install \
    apt-transport-https \
    bash \
    ca-certificates \
    curl \
    git \
    gnupg \
    gnupg1 \
    gnupg2 \
    gnupg-agent \
    jq \
    libasound2 \
    libegl1 \
    libx11-6 \
    nano \
    software-properties-common \
    ssh \
    sudo \
    wget

# Install vscode & php
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee -a /etc/apt/sources.list.d/php.list \
    && curl https://packages.sury.org/php/apt.gpg | apt-key add && wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" && \
    apt-get update && \
    apt-get install -y code \
    php7.4-cli \
    php-pear

# Add user needed to launch vscode propertly
RUN adduser --quiet --disabled-password vscode && \
    usermod -aG sudo vscode 

# Copy config
COPY ./config/ /init

# No password for root & vscode
RUN mv /init/sudoers.txt /etc/sudoers && \
    chmod 440 /etc/sudoers

# Install fonts
RUN mkdir -p /usr/share/fonts && \
    mv /init/ttf /usr/share/fonts && \
    fc-cache -f -v

# Install php code sniffer
RUN pear install PHP_CodeSniffer

# Clean image
RUN rm -rf /var/lib/apt/lists/* && rm -rf /etc/apt/sources.list.d/* && \
    apt-get purge --auto-remove && \
    apt-get clean && rm -rf /init/ttf

# Configuration container
WORKDIR /home
ENTRYPOINT ["/init/entrypoint.sh"]
USER vscode
