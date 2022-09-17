# slide
Simple, Light and Incredible Dev Environment

![slide](https://raw.githubusercontent.com/saymoncoppi/slide_dev_env/main/slide.png "slide")

Mix de algumas ideias para testar com o Tony.

## Bases:
https://github.com/tonylampada/buserdev

https://github.com/saymoncoppi/linuxslide

## Runnig on windows:


## Steps
Install Docker

Run docker pull ubuntu

docker run -itd --name slide --restart on-failure ubuntu

docker attach slide

cat /etc/lsb-release

apt update

apt-get install --yes --no-install-recommends wget gpg

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

wget -O install.sh https://raw.githubusercontent.com/saymoncoppi/slide_dev_env/main/install.sh; bash install.sh


## Other references:
- https://www.youtube.com/watch?v=BDilFZ9C9mw
- https://www.oficinadanet.com.br/windows/39013-como-baixar-iso-windows-10-21h2
- https://medium.com/@potatowagon/how-to-use-gui-apps-in-linux-docker-container-from-windows-host-485d3e1c64a3
- https://medium.com/@potatowagon/how-to-use-gui-apps-on-aws-linux-server-over-ssh-with-x11-forwarding-from-windows-1e80cd9571a8
- https://www.youtube.com/watch?v=AQlZGmSQn_Q
- http://www.macpczone.co.uk/content/running-x11-gui-applications-windows-subsystem-gnu-wsl-windows-10-opensuse
- https://ubunlog.com/pt/vcxsrv-nos-permite-usar-apps-de-linux-con-interfaz-de-usuario-en-windows-10/