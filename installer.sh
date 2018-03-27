#!/bin/bash

#there are something that should be done prior to calling installer.sh

# install firmware ...
echo "------------------Install related firmware-------------------------------"
sudo apt-get install bluez-firmware firmware-atheros firmware-iwlwifi firmware-linux firmware-linux-free firmware-linux-nonfree

# install bluetooth packages
echo "------------------Install bluetooth related packages---------------------"
sudo apt-get install bluez bluetooth pulseaudio-module-bluetooth pavucontrol

# install python related packages
echo "------------------Install python related packages------------------------"
sudo apt-get install python python3 ipython3 python-pip python3-pip

# install texlive-full
echo "------------------Install texlive-full-----------------------------------"
sudo apt-get install texlive-full kile*

# install git, gparted and subversion
echo "------------------Install git, gparted and subversion--------------------"
sudo apt-get install git subversion gparted thunderbird

# install emacs
echo "------------------Install emacs------------------------------------------"
sudo apt-get install emacs25

# install source code pro fonts
echo "------------------Install Source-Code-Pro--------------------------------"
sudo cp -r /home/horacio/Documents/INIT_installer/needed/fonts/OTF/* /usr/share/fonts/opentype/
sudo cp -r /home/horacio/Documents/INIT_installer/needed/fonts/TTF/* /usr/share/fonts/truetype/
sudo fc-cache -f -v

# install go
echo "------------------Install golang-----------------------------------------"
sudo tar -C /usr/local -xzf /home/horacio/Documents/INIT_installer/needed/go1.10.linux-amd64.tar.gz
echo "------------------Update PATH for go-------------------------------------"
#we are doing after ocaml do its thing
source /home/horacio/.profile

# install ocaml, opam
echo "------------------Install dependencies for ocaml----------------------"
sudo apt-get install mercurial m4 darcs aspcud 
echo "------------------Install ocaml------------------------------------------"
sudo wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh -O - | sh -s /usr/local/bin
echo "------------------Install ocaml packages---------------------------------"
eval `opam config env`
opam switch 4.06.0
opam install jbuilder merlin tuareg ocp-index ocp-indent core utop user-setup
echo "#require core;;" >> /home/horacio/.ocamlinit
eval `opam config env`
opam user-setup install

# install rust
echo "------------------Install rust-------------------------------------------"
sudo apt-get install curl
sudo curl https://sh.rustup.rs -sSf | sh
source /home/horacio/.profile

# install spacemacs
echo "------------------Install all depencecies for spacemacs------------------"
pip install --upgrade "jedi>=0.9.0" "json-rpc>=1.8.0" "service_factory>=0.1.5"
pip install flake8
pip install autoflake
pip install hy

#here we update go PATH, BIN
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile 
echo "export PATH=$PATH:$HOME/Langs/go/bin" >> ~/.profile 
echo "export GOBIN=$GOBIN:$HOME/Langs/go" >> ~/.profile 
echo "export GOBIN=$GOBIN:$HOME/Langs/go/bin" >> ~/.profile 

echo "export GOPATH=$HOME/Langs/go/bin" >> ~/.profile 

go get -u -v github.com/nsf/gocode
go get -u -v github.com/rogpeppe/guru
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v github.com/alecthomas/gometalinter
gometalinter --install
sudo apt-get install evince

echo "------------------Install spacemacs--------------------------------------"
sudo rm -r /home/horacio/.emacs.d
sudo rm -r /home/horacio/.emacs
git clone https://github.com/syl20bnr/spacemacs /home/horacio/.emacs.d

# update upgrade and autoremove
echo "------------------Update, upgrade and autoremove-------------------------"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove

echo "eval `opam config env`" >> /home/horacio/.profile
source /home/horacio/.profile
eval `opam config env`

# exiting
echo "------------------Exiting------------------------------------------------"
exit
