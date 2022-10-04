#!/bin/sh -x

# update mahimahi source line and package listings when necessary
add-apt-repository -y ppa:keithw/mahimahi
apt-get update

# install required packages
apt-get -y install mahimahi ntp ntpdate texlive python-pip
pip install matplotlib numpy tabulate pyyaml

# install pantheon tunnel
apt-get -y install debhelper autotools-dev dh-autoreconf iptables \
                        pkg-config iproute2

CURRDIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $CURRDIR/../third_party/pantheon-tunnel && ./autogen.sh && ./configure \
&& make -j && make install
