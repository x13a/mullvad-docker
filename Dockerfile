FROM dhi.io/debian-base:trixie

RUN <<EOF
apt-get update;
apt-get -y --no-install-recommends install dbus curl;
curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc;
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$(dpkg --print-architecture)] https://repository.mullvad.net/deb/stable stable main" | tee /etc/apt/sources.list.d/mullvad.list;
apt-get update;
apt-get -y --no-install-recommends install mullvad-vpn;
apt-get -y clean;
rm -rf /var/lib/apt/lists/*;
EOF

VOLUME /config
ENV MULLVAD_SETTINGS_DIR=/config

CMD ["/usr/bin/mullvad-daemon", "-v"]
