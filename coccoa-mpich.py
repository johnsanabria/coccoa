#!/usr/bin/python
#
# This script is used to create files in nodes directory.
# Those files are used by the knife-solo command. When the command
# "knife solo cook vagrant@10.10.10.1" is run, it looks for a file named
# 10.10.10.1.json in the nodes directory and runs the instruction defined there.
#
# This script recives as parameter a hosts file which is one of the very first
# alternatives used by Unix systems to find an IP given a host name.
#
# The hosts file follows a syntax similar to this
#
# 10.10.10.1 master.demo.org master
# 10.10.10.2 worker-01.demo.org worker-01
# 10.10.10.3 worker-02.demo.org worker-02
#
# The very first line in the hosts file will be selected as the master. 
# The third field in any line is the alias so the third field in the first line
# is the alias of the master node. 
#

import sys
import re

#
# findandchangefield is a method used to find an attribute then a subattribute
# and change subattribute's current value by value
#
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

#
# main method
# 
if (len(sys.argv) < 3):
	print "Provide a hosts file (e.g. hosts) and file where attributes reside (e.g. attributes.tp)"
	print "Example: "
	sys.exit("\t%s hosts attributes.tp"%(sys.argv[0]))

#
# reading a hosts file
#
_hostfile = open(sys.argv[1],'r')
_hostlines = _hostfile.readlines()
_hostfile.close()
i = 0
_master = ""
_machinefile = open("cookbooks/mpi/files/default/machinefile",'w')

#
# Reading every ip
#
while (i < len(_hostlines)):
	line = _hostlines[i]
	i = i + 1
	if (line[0] == '#'):
		continue
	_filenode = line.split()[0] + ".json"
	_nodename = line.split()[2]
	_machinefile.write(_nodename + "\n")
	if (_master == ""): # very first line
		_master = line.split()[2] # the alias of master is found
	print "To create %s"%(_filenode)
	#
	# creating a node in nodes directory, e.g. nodes/10.10.10.1.json
	#	
	_tmpfile = open("nodes/" + _filenode,'w')
	#
	# reading attributes
	#
	_attributesfile = open(sys.argv[2],'r')
	_attributelines = _attributesfile.readlines()
	_attributesfile.close()
	#
	# find the hostconf attribute and then its subattribute named as
	# hostname then replace its value by _nodename
	#
	_attributelines = findandchangefield("hostconf","hostname",_nodename,_attributelines)
	#
	# find the hostconf attribute and then its subattribute named as
	# hostname then replace its value by _master
	#
	_attributelines = findandchangefield("hostconf","hostmaster",_master,_attributelines)
	_tmpfile.write("{\n")
	j = 0
	# Writing attributes in the new nodes/<some-ip>.json file
	while (j < len(_attributelines)):
		_tmpfile.write(_attributelines[j])
		j = j + 1
	# Writing last lines of the nodes/<some-ip>.json file
	if (_master == _nodename):
		_tmpfile.write("\"run_list\": [\"role[mpich-master]\"]\n}\n")
	else:
		_tmpfile.write("\"run_list\": [\"role[mpich-node]\"]\n}\n")
	_tmpfile.close()

_machinefile.close()
