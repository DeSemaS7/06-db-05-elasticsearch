FROM centos:7

RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch; 

RUN echo $'[elasticsearch]\n\
name=Elasticsearch repository for 7.x packages\n\
baseurl=https://artifacts.elastic.co/packages/7.x/yum\n\
gpgcheck=1\n\
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch\n\
enabled=0\n\
autorefresh=1\n\
type=rpm-md\n\
' | tee /etc/yum.repos.d/elasticsearch.repo;

RUN yum install --enablerepo=elasticsearch -y elasticsearch \
&& yum clean all


RUN sed -i 's/#network.host: 192.168.0.1/network.host: 127.0.0.1/g' /etc/elasticsearch/elasticsearch.yml; 
RUN sed -i 's/#node.name: node-1/node.name: netology_test/g' /etc/elasticsearch/elasticsearch.yml;
RUN sed -i '/network.host: 127.0.0.1/a http.host: 0.0.0.0' etc/elasticsearch/elasticsearch.yml;
#RUN sed -i 's/path.data: /var/lib/elasticsearch//path.data: /var/lib/g' /etc/elasticsearch/elasticsearch.yml;

USER elasticsearch
EXPOSE 9200

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]