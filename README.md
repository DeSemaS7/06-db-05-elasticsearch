### Задача 1
Dockerfile в репе
<br>Ссылка на hub: https://hub.docker.com/repository/docker/desemas7/06-db-05-elasticsearch
<br>JSON ответ:
```json
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "MYtnbxnCSoWujXVAwWK6YQ",
  "version" : {
    "number" : "7.12.1",
    "build_flavor" : "default",
    "build_type" : "rpm",
    "build_hash" : "3186837139b9c6b6d23c3200870651f10d3343b7",
    "build_date" : "2021-04-20T20:56:39.040728659Z",
    "build_snapshot" : false,
    "lucene_version" : "8.8.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

### Задача 2
curl localhost:9200/_cat/indices
```sh
green  open ind-1 YtTdC4tzR--SQMx0WHjHTA 1 0 0 0 208b 208b
yellow open ind-3 vqn_HWG9QsyJtzMQ2gwoIw 4 2 0 0 832b 832b
yellow open ind-2 YK53MwMzSSWmPrETn56-GQ 2 1 0 0 416b 416b
```
curl http://localhost:9200/_cluster/health?pretty
```json
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}
```

### Задача 3

curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
```json
{
  "type": "fs",
  "settings": {
    "location": "/var/lib/elasticsearch/snapshots"
  }
}
'
{
  "acknowledged" : true
}
```

green open test Q6GqCN4ZSpyFO1OR3AuYBg 1 0 0 0 208b 208b

```sh
-rw-r--r-- 1 elasticsearch elasticsearch   505 May 22 15:49 index-0
-rw-r--r-- 1 elasticsearch elasticsearch     8 May 22 15:49 index.latest
drwxr-sr-x 3 elasticsearch elasticsearch  4096 May 22 15:49 indices
-rw-r--r-- 1 elasticsearch elasticsearch 26151 May 22 15:49 meta-NVojSQbnTxSnVIkJavhi0Q.dat
-rw-r--r-- 1 elasticsearch elasticsearch   283 May 22 15:49 snap-NVojSQbnTxSnVIkJavhi0Q.dat
```


curl localhost:9200/_cat/indices?pretty
```sh
green open test2 OnptU5mhQuuoUkn8Y2qwgg 1 0 0 0 208b 208b
```

curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_1/_restore?pretty"
<br>curl localhost:9200/_cat/indices?pretty
```sh
green open test2 OnptU5mhQuuoUkn8Y2qwgg 1 0 0 0 208b 208b
green open test  d_0682OCSUWM7cb3WoUD9Q 1 0 0 0 208b 208b
```
