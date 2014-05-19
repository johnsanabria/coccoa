#!/bin/bash
#
# This is a wizard which would help to the end user to generate the proper 
# scripts for deploying her computational infrastructure
#
# Written by: John Sanabria
# Date: May 14, 2014
#
# Functions used to populate the configuration scripts
#
# Function used to collect the host names
NOW=`date +"%s"`
HOSTFILENAME="host.${NOW}"
CONDORTEMPLATE="condor.tp"
# Options
condor="HTCondor"
ganglia="Ganglia"
openmpi="OpenMPI"

#
#
hostfile_f() {
	local selected_file=""
	local host_content=""
	${zen} --question --text "Use a file?"
	if [ $? == 0 ]; then
		selected_file=`${zen} --file-selection --title="Select a file"`
	else
		host_content=`${zen} --title "ip, fqdn, alias" --text-info --editable --width 500 --height 300`
	fi
	if [ "x${selected_file}" == "x" ]; then
		echo "Host content was specified"
		hostfilename=${HOSTFILENAME}
		./scripts/generateHostFile.py ${HOSTFILENAME} "${host_content}"
	else
		echo "File was selected"
		hostfilename=${selected_file}
	fi
}
#
# Function to generate HTCondor template file
#
htcondor_f() {
	local template="templates/${CONDORTEMPLATE}"
	echo "${condor} was selected"
	if [[ ! -f ${template} ]]; then
		echo "ERROR Template file \"${template}\" is not available"
		exit -1
	fi
	#
	# Collect host names which be part of your cluster
	#
	# extract a list of recipes by default
	# user should be able to select some of them
	# hostfilename contains 
	hostfile_f
	echo "-- bf cookbooks/hostsfiles/files/default/hosts" > ${CONDORTEMPLATE}.${NOW}
	cat $hostfilename >> ${CONDORTEMPLATE}.${NOW}
	echo "-- ef cookbooks/hostsfiles/files/default/hosts" >> ${CONDORTEMPLATE}.${NOW}
	# find recipes for the master
	`./scripts/retrieveRecipesFromRole.py ./templates/${CONDORTEMPLATE} master` > tmp.${NOW}
	# append recipes selected for the master
	echo "-- br roles/condor-master.json" >> ${CONDORTEMPLATE}.${NOW}
	for i in $(cat tmp.${NOW} | tr "|" "\n"); do
		echo "\"recipe[$i]\"" >> ${CONDORTEMPLATE}.${NOW}
	done
	echo "-- er roles/condor-master.json" >> ${CONDORTEMPLATE}.${NOW}
	rm tmp.${NOW}
	# find recipes for the node
	`./scripts/retrieveRecipesFromRole.py ./templates/${CONDORTEMPLATE} node` > tmp.${NOW}
	# append recipes selected for the node
	echo "-- br roles/condor-node" >> ${CONDORTEMPLATE}.${NOW}
	for i in $(cat tmp.${NOW} | tr "|" "\n"); do
		echo "\"recipe[$i]\"" >> ${CONDORTEMPLATE}.${NOW}
	done
	echo "-- er roles/condor-node" >> ${CONDORTEMPLATE}.${NOW}
	rm tmp.${NOW}


	# generate template with collected data
}
#
# # Function for Ganglia
#
ganglia_f() {
	echo "Ganglia"
}
#
# Function for OpenMPI
#
openmpi_f() {
	echo "OpenMPI"
}
#
# Main function
# GUI tool
#
zen="zenity"
#
# Validating if ${zen} is installed
#
which ${zen} >& /dev/null
if [[ ! $? == 0 ]]; then
	echo "ERROR Install \"${zen}\" first"
	exit -1
fi
#
# Selecting the recipe
#
selected=`${zen} --list --title="Recipe Generator" --radiolist --column="" --column "Tool" FALSE ${condor} FALSE ${ganglia} FALSE ${openmpi}`
case ${selected} in
	${condor})
		htcondor_f;;
	${ganglia})
		ganglia_f;;
	${openmpi})
		openmpi_f;;
esac
