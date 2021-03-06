{% from "aerospike/map.jinja" import aerospike with context %}

include:
  - aerospike.upstream

{# configure then run aerospike server #} 

/etc/aerospike:
  file.directory:
    - user: aerospike
    - group: aerospike
    - mode: 755
    - makedirs: True
    - require:
      - cmd: install-aerospike

/etc/aerospike/aerospike.conf:
  file.managed:
    - user: aerospike
    - group: aerospike
    - mode: 640
    - source: salt://aerospike/files/aerospike.conf.jinja
    - template: jinja
    - watch_in:
      - service: run-aerospike

run-aerospike:
  service.running:
    - enable: true
    - name: aerospike
    - full_restart: True
    - require:
      - cmd: install-aerospike
      - file: /etc/aerospike/aerospike.conf

{# aerospike monitor dependling on statsd port #}
/etc/cron.d/aerospike_monitor:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://aerospike/files/aerospike_monitor

/usr/local/bin/aerospike_latency.py:
  file.managed:
    - user: root
    - group: root
    - mode: 0755
    - source: salt://aerospike/files/aerospike_latency.py
