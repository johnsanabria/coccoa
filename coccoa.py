#!/usr/bin/python
#
# This program is used to create the proper Chef files for doing automatic
# provisioning of diverse infrastructures such as web servers, database servers,
# mpich, condor and hadoop clusters.
#
# Date: March 7, 2014
# Author: John A. Sanabria
#
import sys
import os
import shutil

#
# Parsing arguments. In this version only one argument is necessary.
# It indicates what kind of infrastructure needs to be provisioned.
#

def makeacopyoftemplate(tp, destfile):
	_destfile = os.getcwd() + "/" + destfile + ".conf"
	shutil.copy2(tp, _destfile)
	return _destfile

def parseafileentry(i, line, lines):
	#_file = open(line[6:len(line)]) # here is the filename
	_file = open(line.split()[2],'w')
	i = i + 1
	while (i < len(lines)):
		line = lines[i]
		if (line[0] == '-' and line[1] == '-' and line[3] == 'e' and line[4] == 'f'): # exit
			break
		elif (line[0] == '#'):
			i = i + 1
		else: # store this line in the file
			i = i + 1
			_file.write(line) 
	if (i >= len(lines)):
		print "Bad formed configuration file"
	_file.close()
	return i

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

mpichtp = "templates/mpich.tp"
if (len(sys.argv) < 2):
	sys.exit("Need specify an infrastructure e.g. mpich, condor, hadoop")
if (sys.argv[1] == "mpich"):
	print "Creating a copy of the template for %s project"%(sys.argv[1])
	destfile = makeacopyoftemplate(mpichtp,sys.argv[1])
	parsecreatecheffiles(destfile)
else:
	print "There is not suppot for '%s' at this time"%sys.argv[1]
