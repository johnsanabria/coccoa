#!/usr/bin/python
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
	print line[6:len(line)] # here is the filename
	# open a file 
	i = i + 1
	while (i < len(lines)):
		line = lines[i]
		if (line[0] == '-' and line[1] == '-' and line[3] == 'e' and line[4] == 'f'):
			print "normal exit"
			break
		elif (line[0] == '#'):
			i = i + 1
		else:
			i = i + 1
			print line # store this line in the file
	if (i < len(lines)):
		# normal exit
		# close file
		print "normal exit"
	return i
		

def parsecreatecheffiles(conffile):
	cf = open(conffile,'r')
	lines = cf.readlines()
	cf.close()
	totallines = len(lines)
	i = 0
	while (i < totallines):
		line = lines[i]
		if (line[0] == '#'):
			print "it's a comment"
			i = i + 1
		elif (line[0] == '-' and line[1] == '-'):
			if (line[3] == 'b'):
				if (line[4] == 'f'):
					i = parseafileentry(i,line,lines)
#				elif (line[4] == 'r'):
#					i = parsearoleentry(i,line,lines)
#				elif (line[4] == 'a'):
#					i = parseattributeentry(i,line,lines)
				else:
					i = i + 1
			else:
				i = i + 1
		else:
			i = i + 1

mpichtp = "templates/mpich.tp"

if (len(sys.argv) < 2):
	sys.exit("Need specify an infrastructure e.g. mpich, condor, hadoop")
if (sys.argv[1] == "mpich"):
	destfile = makeacopyoftemplate(mpichtp,sys.argv[1])
	parsecreatecheffiles(destfile)
else:
	print "There is not suppot for '%s' at this time"%sys.argv[1]
