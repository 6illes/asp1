FROM debian
MAINTAINER Gilles
RUN apt-get update && apt-get upgrade -y && apt-get install -y nano openssh-server apache2 mysql-server
ENV CLOUDWATT https://storage.fr1.cloudwatt.com/v1/AUTH_f462168636b34441ac49c9dbf6d9f57d
ENV ASPERA aspera
ENV ASPERADIR /opt/${ASPERA}
ENV ASPERAPKG aspera-server.deb
ENV ASPERALIC aspera-server.lic
CMD mkdir ${ASPERADIR}
CMD mkdir ${ASPERADIR}/etc
CMD cd ${ASPERADIR}
ADD ${CLOUDWATT}/ASPERA/${ASPERAPKG} ${ASPERADIR}/
ADD ${CLOUDWATT}/ASPERA/${ASPERALIC} ${ASPERADIR}/
CMD dpkg -i ${ASPERADIR}/${ASPERAPKG} 
RUN ascp -A
