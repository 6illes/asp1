FROM debian
MAINTAINER Gilles
RUN apt-get update && apt-get upgrade -y && apt-get install -y nano openssh-server apache2 mysql-server
ENV ASPERA aspera
CMD mkdir /opt/${ASPERA}
CMD mkdir /opt/${ASPERA}/etc
CMD cd /opt/${ASPERA}
ENV CLOUDWATT https://storage.fr1.cloudwatt.com/v1/AUTH_f462168636b34441ac49c9dbf6d9f57d/
ENV ASPERAPKG aspera-server.deb
ADD ${CLOUDWATT}/ASPERA/${ASPERAPKG} /opt/${ASPERA}/
CMD dpkg -i ${ASPERAPKG} 
ENV ASPERALIC aspera-server.lic
ADD ${CLOUDWATT}/ASPERA/${ASPERALIC} /opt/${ASPERA}/
RUN ascp -A
