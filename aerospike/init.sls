{% from "aerospike/map.jinja" import aerospike with context %}

#include:
#  - aerospike.upstream

{# configure then run aerospike server #} 

/etc/aerospike:
  file.directory:
    - user: aerospike
    - group: aerospike
    - mode: 755
    - makedirs: True

/etc/aerospike/aerospike.conf:
  file.managed:
    - user: aerospike
    - group: aerospike
    - mode: 640
    - source: salt://aerospike/files/aerospike.conf.jinja
    - template: jinja
