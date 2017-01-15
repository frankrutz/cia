FROM centos
COPY msprod.repo     /etc/yum.repos.d/
COPY sql-server.repo /etc/yum.repos.d/
COPY testdriver.ksh  /usr/local/bin/
CMD  /usr/local/bin/testdriver.ksh
