#!/bin/sh
set -e

#===================================================================== arguments
CSP_CODE_FOLDER=${1}        	# Folder to deploy project source code
CSP_CODE_FOLDER=/var/www       	# Folder to deploy project source code
#========================================================================== main

#=== Init
	# Phinx
	cd ${CSP_CODE_FOLDER} && ./vendor/bin/phinx migrate
	cd ${CSP_CODE_FOLDER} && ./vendor/bin/phinx seed:run -s CspContext -s CspOriginType -s CspRuleType -s CspRoles -s CspUser 

    # Socket
    cd ${CSP_CODE_FOLDER}/app/sockets/cs-frontend && npm intall && pm2 stop server.js && pm2 start server.js

# first arg is `-f` or `--some-option`
#if [ "${1#-}" != "$1" ]; then
	set -- clientscape-frontend "$@"
#fi

#exec clientscape-frontend
exec "$@"
