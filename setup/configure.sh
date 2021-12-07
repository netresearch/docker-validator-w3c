#!/usr/bin/env bash
set -ex

W3C_VALIDATOR_CONF="/etc/w3c/validator.conf"
W3C_VALIDATOR_APACHE_CONF="/etc/apache2/conf-available/w3c-markup-validator.conf"

# configure w3c validator and Apache HTTP server

# modify $W3C_VALIDATOR_CONF to allow validation of private IP addresses
cat $W3C_VALIDATOR_CONF \
	| sed 's/Allow Private IPs = no/Allow Private IPs = yes/' \
	> $W3C_VALIDATOR_CONF.tmp
mv $W3C_VALIDATOR_CONF.tmp $W3C_VALIDATOR_CONF

# modify $W3C_VALIDATOR_APACHE_CONF to enable SSILegacyExprParser for Apache 2.4.x web server (a requirement for the W3C validator app)
cat $W3C_VALIDATOR_APACHE_CONF \
	| sed 's/<Directory \/usr\/local\/validator\/htdocs\/>/<Directory \/usr\/local\/validator\/htdocs\/>\n  SSILegacyExprParser on\n/' \
	> $W3C_VALIDATOR_APACHE_CONF.tmp
mv $W3C_VALIDATOR_APACHE_CONF.tmp $W3C_VALIDATOR_APACHE_CONF

# modify $W3C_VALIDATOR_APACHE_CONF to open access for HTTP requests
cat $W3C_VALIDATOR_APACHE_CONF \
	| sed 's/<Directory \/usr\/local\/validator\/htdocs\/>/<Directory \/usr\/local\/validator\/htdocs\/>\n  Require all granted\n/' \
	| sed 's/<LocationMatch "^\/+w3c-validator\/+(check|feedback(\\.html)?)$">/<LocationMatch "^\/+w3c-validator\/+(check|feedback(\\.html)?)$">\n  Require all granted\n/' \
	> $W3C_VALIDATOR_APACHE_CONF.tmp
mv $W3C_VALIDATOR_APACHE_CONF.tmp $W3C_VALIDATOR_APACHE_CONF

# modify $W3C_VALIDATOR_APACHE_CONF so validator is accessible from http://[server]:[port]/, not http://[server]:[port]/w3c-validator/
cat $W3C_VALIDATOR_APACHE_CONF \
	| sed 's/Alias \/w3c-validator\//Alias \//' \
	| sed 's/RewriteBase \/w3c-validator\//RewriteBase \//' \
	| sed 's/Redirect \/w3c-validator\//Redirect \//' \
	| sed 's/w3c-validator\/+//' \
	| sed 's/\/w3c-validator\/check/\/check/' \
	> $W3C_VALIDATOR_APACHE_CONF.tmp
mv $W3C_VALIDATOR_APACHE_CONF.tmp $W3C_VALIDATOR_APACHE_CONF

a2enmod cgid
a2enmod expires
a2enmod include
a2enmod rewrite
a2enmod proxy_http

a2enconf server
a2enconf w3c-markup-validator

# enable validator.nu within W3C validator $W3C_VALIDATOR_CONF file
cat $W3C_VALIDATOR_CONF \
	| sed 's|#HTML5 = http://localhost:8888/html5/|HTML5 = http://vnu:8888/|' \
	| sed 's|#CompoundXML = http://localhost:8888/|CompoundXML = http://vnu:8888/|' \
	> $W3C_VALIDATOR_CONF.tmp
mv $W3C_VALIDATOR_CONF.tmp $W3C_VALIDATOR_CONF

# all done
exit 0
