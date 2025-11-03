# mullvad-docker

Mullvad VPN docker container

## Usage

Clone repository to local directory:

```sh
git clone https://github.com/x13a/mullvad-docker mullvad
```

Change directory to recently clonned repository:

```sh
cd mullvad
```

Edit *mullvad.env* file with your settings:

```sh
# Set to your Mullvad account number
MULLVAD_ACCOUNT=
# Set to 2-chat country code you want to connect to, ex: de / nl / fi 
MULLVAD_LOCATION=se
```

Run *init.sh* file:

```sh
./init.sh
```

All done, test proxy with curl:

```sh
curl -x socks5h://127.0.0.1:1080 https://ipinfo.io
```

## License

MIT
