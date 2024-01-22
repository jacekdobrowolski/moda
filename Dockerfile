FROM ghcr.io/oracle/oraclelinux8-instantclient:21
RUN yum update
RUN yum install python3 python3-devel libxslt-devel libxml2-devel gcc
COPY ./ /root/moda/
WORKDIR /root/moda
RUN python3 -m pip install --user -r requirements.txt
CMD python3 XML_reciver.py
