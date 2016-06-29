#!/usr/bin/env python

import commands
import string

def to_stat_name(s):
    name = s.replace("/", "_").replace(">", "g")
    return "aerospike.latency.%s" % name

output = commands.getstatusoutput("asinfo -v 'latency:hist=reads;back=40'")[1]
arr = map(lambda s: string.split(s, ","), string.split(output, ";"))
raw_stats = zip(arr[0], arr[1])[1:]

for k, v in raw_stats:
    print("%s:%s|g" % (to_stat_name(k), v))
