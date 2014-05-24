#!/usr/bin/python
import sys
def isthere(line,lines):
        j = 0
        while (j < len(lines)):
                _line = lines[j]
                j = j + 1
                if (line == _line):
                        return True
        return False

if (len(sys.argv) < 2):
        sys.exit("Two files are required <newdata> <existingfile>")

_newo = open(sys.argv[1],'r')
_newlines = _newo.readlines()
_newo.close()
_existing = open(sys.argv[2],"r")
_existinglines = _existing.readlines()
_existing.close()

i = 0
j = 0
_tobeappend = ""
while (i < len(_newlines)):
        _line = _newlines[i]
        i = i + 1
        if (not isthere(_line,_existinglines)):
                _tobeappend = _tobeappend +  _line
_existing = open(sys.argv[2],"a")
_existing.write(_tobeappend)
_existing.close()

