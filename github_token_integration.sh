#!/bin/bash
#############################################
# Developed with Love by Priyank Vaidya
# Version v1.0
# Date: 19-03-2023
# Project Details: Bash Script used to communicate and retrieve information from Github for Automation in CI/CD and Repositories
# Please provide your GitHub Token and RestAPI to the script as input
##############################################

set -x #Switch to Debug Mode
set -e #Termination if error occurs

echo "
░██████╗░██╗████████╗░█████╗░██╗░░░██╗████████╗░█████╗░███╗░░░███╗░█████╗░████████╗░█████╗░
██╔════╝░██║╚══██╔══╝██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗████╗░████║██╔══██╗╚══██╔══╝██╔══██╗
██║░░██╗░██║░░░██║░░░███████║██║░░░██║░░░██║░░░██║░░██║██╔████╔██║███████║░░░██║░░░███████║
██║░░╚██╗██║░░░██║░░░██╔══██║██║░░░██║░░░██║░░░██║░░██║██║╚██╔╝██║██╔══██║░░░██║░░░██╔══██║
╚██████╔╝██║░░░██║░░░██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██║░╚═╝░██║██║░░██║░░░██║░░░██║░░██║
░╚═════╝░╚═╝░░░╚═╝░░░╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝"

if  [ ${#@} -lt 2 ]; then
	echo "Usage: $0 [YOUR GITHUB ACCESS TOKEN] [YOUR GITHUB REST API]"
	exit 1;
fi

GITHUB_TOKEN=$1
GITHUB_API_REST=$2

GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

# We use temp file in order to save the reponse of curl in local temp file, and all operations in future can be perfomed with that temp file
# Ensure: Your Linux has permissions to access /tmp dir

#temp= `basename $0`
#TMPFILE= `mktemp /tmp/${temp}.XXXXX` || exit 1


function rest_call {

	curl -s $1 -H "${GITHUB_API_HEADER_ACCEPT}" -H "Authorization: token $GITHUB_TOKEN"

}

#Single Page Result with (No Pagination), have no links section & no grep results

last_page= `curl -s -I "https://api.github.com${GITHUB_API_REST}" -H "${GITHUB_API_HEADER_ACCEPT}" -H "{Authorization: token $GITHUB_TOKEN}" | grep '^Link:' | sed -e 's/^Link:.*page=//g' -e 's/>.*$//g'`

#Finding if the Result is in single page
if [ -z "$last_page" ]; then
	#Result has only one page
	rest_call "https://api.github.com${GITHUB_API_REST}"
else
	#Response on multiple pages
	for p in `seq 1 $last_page`; do
		rest_call "https://api.github.com${GITHUB_API_REST}?page=$p"
	done
fi

echo "Response received"
