#!/usr/bin/python
#
# This program is used to create the proper Chef files for doing automatic
# provisioning of diverse infrastructures such as web servers, database servers,
# mpich, condor and hadoop clusters.
#
#
#- Make a copy of the template for the infrastructure that you want deploy, 
#  e.g. template/mpich.tp
#- Do the proper changes
#- Run coccoa.py command as follows
#	./coccoa.py <type of cluster> <configuration file>
#  <type of cluster> should have some of these values: mpich, condor, hadoop
#  <configuration file> points to a file which is a modified file taken from
#  the templates directory
#
#  coccoa.py's internals
#	1- Parses and creates all files defined in the configuration file
#	2- Parses and creates all roles defined in the configuration file
#	3- Parses and create a file with all the attributes defined in the
#	   configuration file
#
# Date: March 7, 2014
# Author: John A. Sanabria
#
import sys
import os
import os.path
import shutil

def parseafileentry(i, line, lines):
	_file = open(line.split()[2],'w')
	i = i + 1
	while (i < len(lines)):
		line = lines[i]
		if (line[0] == '-' and line[1] == '-' and line[3] == 'e' and line[4] == 'f'): # exit
			break
		elif (line[0] == '#' or line[0] == '\n'):
			i = i + 1
		else: # store this line in the file
			_file.write(line) 
			i = i + 1
	if (i >= len(lines)):
		print "Bad formed configuration file"
	_file.close()
	return i
#
# parsearoleentry creates a file with a content similar to this
#
#{
#	"name": "mpich-master",
#	"chef_type": "role",
#	"json_class": "Chef::Role",
#	"run_list": [
#		"recipe[hostsfiles]",
#		...
#		"recipe[ssh::master]"
#	]
#}
#
def parsearoleentry(i, line, lines):
	_file = open(line.split()[2],'w')
	_name = line.split('/')[1].split('.')[0]
	_header = """{
	\"name\": \"%s\",
	\"chef_type\": \"role\",
	\"json_class\": \"Chef::Role\",
	\"run_list\": [\n"""%(_name)
	i = i + 1
	prevline = ""
	_file.write(_header)
	while (i < len(lines)):
		line = lines[i]
		if (line[0] == '-' and line[1] == '-' and line[3] == 'e' and line[4] == 'r'): # exit
			break
		elif (line[0] == '#'):
			i = i + 1
		else: # store this line in the file
			i = i + 1
# http://stackoverflow.com/questions/16149649/remove-carriage-return-in-python
			if (prevline == ""):
				prevline = line
				continue
			_file.write("\t\t" + ''.join(prevline.splitlines()) + ",\n") 
			prevline = line
	if (i >= len(lines)):
		print "Bad formed configuration file"
	_file.write("\t\t" + ''.join(prevline.splitlines()) + "\n") 
	_file.write("\t]\n")
	_file.write("}\n")
	_file.close()
	return i

#
# parseattributeentry reads the definition of an attribute from configuration
# file and returns an array of strings reprsenting an attribute with its
# subattributes
#
def parseattributeentry(i,line,lines,attributes):
	_attribute = ""
	i = i + 1
	while (i < len(lines)):
		line = lines[i]
		if (line[0] == '-' and line[1] == '-' and line[3] == 'e' and line[4] == 'a'): # exit
			break
		elif (line[0] == '#'):
			i = i + 1
		else: # store this line
			if (''.join(line.splitlines()).endswith("}")):
				_attribute = _attribute + ''.join(line.splitlines()) + ",\n"
			else: 
				_attribute = _attribute + line
			i = i + 1
	attributes = attributes + _attribute
	return i, attributes

#
# parsecreatecheffiles method 
#
#        1- Parses and creates all files defined in the configuration file
#        2- Parses and creates all roles defined in the configuration file
#        3- Parses and create a file with all the attributes defined in the
#           configuration file
#
def parsecreatecheffiles(conffile):
	cf = open(conffile,'r')
	lines = cf.readlines()
	cf.close()
	totallines = len(lines)
	i = 0
	_attributes = ""
	while (i < totallines):
		line = lines[i]
		if (line[0] == '#'):
			i = i + 1
		elif (line[0] == '-' and line[1] == '-'):
			if (line[3] == 'b'):
				if (line[4] == 'f'):
					print "Creating file " + line.split()[2] 
					i = parseafileentry(i,line,lines)
				elif (line[4] == 'r'):
					print "Creating role " + line.split()[2] 
					i = parsearoleentry(i,line,lines)
				elif (line[4] == 'a'):
					print "Parsing attributes"
					i, _attributes = parseattributeentry(i,line,lines,_attributes)
				else:
					i = i + 1
			else:
				i = i + 1
		else:
			i = i + 1
	print "Writting attributes files"
	_attributefile = open("attribute.tp",'w')
	_attributefile.write(_attributes)
	_attributefile.close()

#
# Main program
#
if (len(sys.argv) < 3):
	sys.exit("Need specify an infrastructure and configuration file\n %s mpich mpich.conf"%(sys.argv[0]))
if (sys.argv[1] == "mpich" or sys.argv[1] == "condor"):
	if (os.path.isfile(sys.argv[2])):
		destfile = sys.argv[2]
	else:
		sys.exit("%s does not exist\n\t1- Copy the template/%s.tp and renamed it as %s.\n\t2- Do not forget to customized the content of the copied file"%(sys.argv[2],sys.argv[1],sys.argv[2]))

	parsecreatecheffiles(destfile)
else:
	print "There is not suppot for '%s' at this time"%sys.argv[1]
