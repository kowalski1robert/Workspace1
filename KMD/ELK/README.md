Having Java installed is a prerequisite for installing any of the ELK stack components. It can be achieved by running the **install_java.sh** script.


TODO:

 - [x] add config script for Logstash
 - [ ] add mutual TLS between Logstash and Elasticsearch in logstash.yml - TLS between Logstasha and Elasticsearch is set in the pipeline config file and the only way to do it is by providing CA cert and user (username and password) - no mutual TLS (by the official Elastic docs)
 - [x] move installing java to separate script
 