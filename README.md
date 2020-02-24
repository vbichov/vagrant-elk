# Vagrant ELK stack

2 Hosts installation:
  - grafana host (with grafana on it)
  - elk host with elasticsearch, logstash and kibana on it


Installation Steps:

```bash
vagrant up
visit URL for kibana - http://127.0.0.1:5601
Elasticsearch - http://127.0.0.1:9200
grafana  - http://127.0.0.1:3000
```

## Installed versions 

Contains the following software 
- Elasticsearch 7.6.0
- Logstash 7.6.0
- Kibana 7.6.0


## Configuration folders

```bash
# Elasticsearch
/etc/elasticsearch/

# Logstash
/etc/logstash/conf.d

# Kibana
/etc/kibana
```
