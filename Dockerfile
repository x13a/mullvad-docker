FROM dhi.io/debian-base:trixie

COPY mullvad-keyring.asc /usr/share/keyrings/
RUN <<EOF
apt-get update;
apt-get -y --no-install-recommends install dbus curl;
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$(dpkg --print-architecture)] https://repository.mullvad.net/deb/stable stable main" | tee /etc/apt/sources.list.d/mullvad.list;
apt-get update;
apt-get -y --no-install-recommends install mullvad-vpn;
apt-get -y clean;
rm -rf /var/lib/apt/lists/*;
EOF

VOLUME /config
ENV MULLVAD_SETTINGS_DIR=/config

CMD ["/usr/bin/mullvad-daemon", "-v"]
