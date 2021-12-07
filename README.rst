Docker image for W3C/HTML5 validator
************************************

Dependencies
============

* `Nu Html Checker (v.Nu)`__

__ https://github.com/validator/validator


How to run
==========

Use docker-compose to run this w3c validator along with v.Nu, docker-compose.yml example:: yaml

    ---
    version: '3.5'

    services:
      vnu:
        image: ghcr.io/validator/validator:latest
        restart: unless-stopped

      w3c:
        build: .
        image: ghcr.io/netresearch/validator-w3c
        ports:
         - "80:80"
        restart: unless-stopped


Now open http://localhost/ in your browser.
