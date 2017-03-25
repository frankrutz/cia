FROM centos

##################################################################
#INSTALL sqlcmd and mssql-tools###################################
#OBSERVE ACCEPTS EULA FOR THE MS-TOOLS, PLEASE READ AND UNDERSTAND
COPY msprod.repo     /etc/yum.repos.d/
COPY sql-server.repo /etc/yum.repos.d/
ENV ACCEPT_EULA=Y
RUN yum install -y mssql-tools
RUN ln -sfn /opt/mssql-tools/bin/sqlcmd-13.0.1.0 /usr/bin/sqlcmd
RUN ln -sfn /opt/mssql-tools/bin/bcp-13.0.1.0 /usr/bin/bcp

#################################################################
#get the testdriver and make it the standard-cmd of the container
COPY testdriver.ksh  /usr/local/bin/
RUN  chmod a+x /usr/local/bin/testdriver.ksh

CMD  /usr/local/bin/testdriver.ksh
