FROM centos
COPY msprod.repo     /etc/yum.repos.d/
COPY sql-server.repo /etc/yum.repos.d/
COPY testdriver.ksh  /usr/local/bin/
CMD  /usr/local/bin/testdriver.ksh

#WARNING this is NOT the complete appserver container image build.
#Refer to the section "Creating the AppServer Container" in the readme file.
