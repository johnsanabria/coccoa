#!/usr/bin/python
import sys

if (len(sys.argv) != 3):
	sys.exit("\t%s requires two arguments, template filename and role (e.g. master or node)"%(sys.argv[0]))

listofrecipes=""
filename = sys.argv[1]
role=sys.argv[2]
zenitycommand="zenity --list --title=%s --checklist --column=\"\" --column \"Recipe\" "%(sys.argv[2])
_file = open(sys.argv[1], 'r')
_filelines = _file.readlines()
_file.close()
i = 0
flag = False
while (i < len(_filelines)):
	if flag:
		break
	line = _filelines[i]
	i = i + 1
	if (line[0] == '#' or line[0] == '\n' or line[0] == ' '):
		continue
	if (line[0] == '-' and line[1] == '-' and line[3] == 'b' and line[4] == 'r'):
		if role not in line:
			continue
		line = _filelines[i]
		recipename = line.split('[')[1]
		recipename = recipename.split(']')[0]
		listofrecipes = recipename + "|"
		zenitycommand = zenitycommand + "TRUE %s"%recipename
		
		i = i + 1
		while (i < len(_filelines)):
			line = _filelines[i]
			if (line[0] == '-' and line[1] == '-' and line[3] == 'e' and line[4] == 'r'):
				flag = True
				break
			recipename = line.split('[')[1]
			recipename = recipename.split(']')[0]
			listofrecipes = listofrecipes + recipename + "|"
			zenitycommand = zenitycommand + " TRUE %s"%recipename
			i = i + 1
	else:
		continue
		
print zenitycommand
