FROM php:8.0.0-cli

# Install required
RUN apt-get update && apt-get -y --no-install-recommends install software-properties-common curl apt-transport-https

# Update package & install lib vscode
RUN apt-get update && apt-get -y --no-install-recommends install libc6-dev \
    libgtk2.0-0 libgtk-3-0 libpango-1.0-0 libcairo2 libfontconfig1 libnss3 libasound2 libxtst6 unzip libglib2.0-bin \
    libcanberra-gtk-module libgl1-mesa-glx curl build-essential gettext libstdc++6 software-properties-common wget git xterm \
    automake libtool autogen nodejs libnotify-bin aspell aspell-en htop git mono-complete gvfs-bin libxss1 rxvt-unicode-256color x11-xserver-utils sudo vim libxkbfile1 libsecret-1-0 \
    gnupg libgbm1

# Install vscode & remove debian package
RUN wget -O vscode-amd64.deb  https://go.microsoft.com/fwlink/?LinkID=760868
RUN dpkg -i vscode-amd64.deb
RUN rm vscode-amd64.deb

# Add user needed to launch vscode propertly
RUN adduser --quiet --disabled-password dev

# Run install extentions
COPY ./extensions /init_extention
RUN su - dev /init_extention/install.sh

# Copy config
COPY ./config/ /init

# Install fonts
RUN mkdir -p /home/dev/.local/share/fonts && mv /init/ttf /home/dev/.local/share/fonts && fc-cache -f -v

# First run to init folder
RUN mkdir -p /home/dev/.vscode && chown -R dev /home/dev/.vscode && chmod 777 -R /home/dev/.vscode && mkdir -p /home/dev/.config/Code/User && chown -R dev /home/dev/.config && chmod 777 -R /home/dev/.config && mv /init/settings.json /home/dev/.config/Code/User/settings.json 

# Install php code sniffer
RUN pear install PHP_CodeSniffer

# Clean image
RUN rm -rf /var/lib/apt/lists/* && apt-get purge --auto-remove && apt-get clean

ENTRYPOINT ["/init/entrypoint.sh"]