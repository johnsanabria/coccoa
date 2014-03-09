#!/usr/bin/python
#
# This script is used to create the file nodes required by Chef
# The hosts file must follow a syntax similar to this
# 10.10.10.1 master.demo.org master
# 10.10.10.2 worker-01.demo.org worker-01
# 10.10.10.3 worker-02.demo.org worker-02
#
# The very first line will be the master. The third field in that line
# is the alias of the master and it must be known by all other nodes in
# the cluster.
#
import sys
import re

def findandchangefield(att,subatt,value,lines): 
	i = 0
	while (i < len(lines)):
		line = lines[i]
		# LOOK, I assume that subattribute are unique in other words
		# I assume that this configuration is not possible
		# "attx": {
		#	"att": "x"
		# },
		# "atty": {
		#	"att": "x"
		# }
		# which is a misassumption
		if subatt in line:
			line = re.sub('<TYPE IT>',value,line)
			lines[i] = line
			break
		i = i + 1
	return lines

if (len(sys.argv) < 3):
	print "Provide a hosts file (e.g. hosts) and file where attributes reside (e.g. attributes.tp)"
	sys.exit()

_hostfile = open(sys.argv[1],'r')
_hostlines = _hostfile.readlines()
_hostfile.close()
i = 0
_master = ""
while (i < len(_hostlines)):
	line = _hostlines[i]
	i = i + 1
	_filenode = line.split()[0] + ".json"
	_nodename = line.split()[2]
	if (_master == ""):
		_master = line.split()[2]
	print "To create %s"%(_filenode)
	_tmpfile = open("nodes/" + _filenode,'w')
	_attributesfile = open(sys.argv[2],'r')
	_attributelines = _attributesfile.readlines()
	_attributesfile.close()
	_attributelines = findandchangefield("hostconf","hostname",_nodename,_attributelines)
	_attributelines = findandchangefield("hostconf","hostmaster",_master,_attributelines)
	_tmpfile.write("{\n")
	j = 0
	while (j < len(_attributelines)):
		_tmpfile.write(_attributelines[j])
		j = j + 1
	if (_master == _nodename):
		_tmpfile.write("\"run_list\": [\"role[mpich-master]\"]\n}\n")
	else:
		_tmpfile.write("\"run_list\": [\"role[mpich-node]\"]\n}\n")
	_tmpfile.close()

