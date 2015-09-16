FROM phusion/baseimage:0.9.17
MAINTAINER "Shigawire"

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install --yes wget unzip screen telnet nano

RUN dpkg --add-architecture i386 && apt-get update && apt-get install --yes lib32z1 lib32ncurses5 lib32bz2-1.0 libc6:i386 libncurses5:i386 libstdc++6:i386 libncursesw5:i386

RUN mkdir ~/data && wget http://linux.mtasa.com/dl/150/multitheftauto_linux-1.5.0.tar.gz && tar -xzf multitheft* -C ~/data && cd ~/data && mv multitheftauto*/* . && rm -rf multitheftauto

RUN cd ~/data && wget http://linux.mtasa.com/dl/150/baseconfig-1.5.0.tar.gz && tar -xzvf baseconfig* -C ~/data/mods/deathmatch && cd ~/data/mods/deathmatch && mv baseconfig/* . && rm -rf baseconfig

RUN mkdir ~/data/mods/deathmatch/resources && wget http://mirror.mtasa.com/mtasa/resources/mtasa-resources-latest.zip && unzip mtasa-resources-latest.zip -d  ~/data/mods/deathmatch/resources

RUN wget -O /usr/lib/libmysqlclient.so.16 https://nightly.mtasa.com/files/modules/32/libmysqlclient.so.16

#run -v /data --name="server-data" busybox sh -c 'echo Hi Derek! > /data/testing.txt'

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /etc/service/mtasa
ADD start.sh /etc/service/mtasa/run

EXPOSE 22003 22126 22005
VOLUME /data
