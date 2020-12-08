FROM php:7.4.5-cli

# Install required
RUN apt-get update && apt-get -y --no-install-recommends install software-properties-common curl apt-transport-https wget gnupg gnupg2 gnupg1 libasound2 libegl1 libx11-6 sudo bash

# Install vscode
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - && add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN apt-get update && apt-get install -y code

# Add user needed to launch vscode propertly
RUN adduser --quiet --disabled-password dev && usermod -aG sudo dev

# Copy config
COPY ./config/ /init

RUN mv /init/sudoers.txt /etc/sudoers && chmod 440 /etc/sudoers

# Install fonts
RUN mkdir -p /home/dev/.local/share/fonts && mv /init/ttf /home/dev/.local/share/fonts && fc-cache -f -v

# Install php code sniffer
RUN pear install PHP_CodeSniffer

# Clean image
RUN rm -rf /var/lib/apt/lists/* && apt-get purge --auto-remove && apt-get clean && rm -rf /init/ttf

WORKDIR /app

ENTRYPOINT ["/init/entrypoint.sh"]