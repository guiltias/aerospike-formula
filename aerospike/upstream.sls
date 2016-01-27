{# Currently this script works only on ubuntu 12.04/14.04 #}
{% if grains['os_family'] == 'Debian' %}
/usr/src/aerospike:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

download-aerospike-distr:
  cmd.run:
    - cwd: '/usr/src/aerospike'
    - name: 'wget -O /usr/src/aerospike/aerospike-server-community-3.7.2-ubuntu{{ grains['osrelease'] }}.tgz http://www.aerospike.com/artifacts/aerospike-server-community/3.7.2/aerospike-server-community-3.7.2-ubuntu{{ grains['osrelease'] }}.tgz'
    - creates: '/usr/src/aerospike/aerospike-server-community-3.7.2-ubuntu{{ grains['osrelease'] }}.tgz'

extract-aerospike-distr:
  cmd.run:
    - cwd: '/usr/src/aerospike'
    - name: 'tar -xf /usr/src/aerospike/aerospike-server-community-3.7.2-ubuntu{{ grains['osrelease'] }}.tgz'
    - creates: '/usr/src/aerospike/aerospike-server-community-3.7.2-ubuntu{{ grains['osrelease'] }}'

install-aerospike:
  cmd.run:
    - cwd: '/usr/src/aerospike/aerospike-server-community-3.7.2-ubuntu{{ grains['osrelease'] }}'
    - name: '/usr/src/aerospike/aerospike-server-community-3.7.2-ubuntu{{ grains['osrelease'] }}/asinstall'
    - creates: '/usr/bin/asd'
    - require:
      - cmd: extract-aerospike-distr
      - cmd: download-aerospike-distr
      - file: /usr/src/aerospike
{% endif %}

