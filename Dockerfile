FROM centos:7
MAINTAINER Rajasekaran Radhakrishnan
RUN yum update -y && yum install -y httpd
#RUN systemctl start httpd.service && systemctl enable httpd.service
RUN yum install mysql -y
RUN rpm -Uvh http://vault.centos.org/7.0.1406/extras/x86_64/Packages/epel-release-7-5.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum --enablerepo=remi,remi-php56 install -y php php-common
RUN yum --enablerepo=remi,remi-php56 install -y php-cli php-pear php-pdo php-mysql php-mysqlnd php-pgsql php-sqlite php-gd php-mbstring php-mcrypt php-xml php-simplexml php-curl php-zip docker-php-ext-install
COPY city-fan.repo /etc/yum.repos.d/
RUN yum install epel-release -y
RUN yum update curl.x86_64 -y
RUN yum install mod_ssl -y
COPY phpinfo.php /var/www/html/
RUN pear install http_request2
#RUN systemctl restart httpd.service
COPY Request2.php /usr/share/pear/HTTP/
RUN chown -R apache:apache /var/www/html/
RUN chmod -R 775 /var/www/
EXPOSE 80
EXPOSE 443
##CMD systemctl start httpd.service
##ENTRYPOINT systemctl start httpd.service
CMD exec httpd -DFOREGROUND
