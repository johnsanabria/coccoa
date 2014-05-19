#!/usr/bin/python
import sys
def processLine(filename, content):
	i = 0
	x=content.split()
	_file = open(filename,'w')
	while (i < len(x)):
		_file.write("%s\t%s\t%s\n"%(x[i], x[i + 1], x[i + 2]))
		i = i + 3
	_file.close()

if (len(sys.argv) != 3):
	sys.exit("\t%s requires two arguments, filename and content file"%(sys.argv[0]))

processLine(sys.argv[1], sys.argv[2])
