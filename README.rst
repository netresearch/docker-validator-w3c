Docker image for W3C/HTML5 validator
************************************

Dependencies
============

* `Nu Html Checker (v.Nu)`__

__ https://github.com/validator/validator


How to run
==========

Use docker-compose to run this w3c validator along with v.Nu, docker-compose.yml example::

    version: '2.4'
    
    services:
      vnu:
        image: validator/validator
        restart: always
      w3c:
        build: .
        image: ghcr.io/netresearch/validator-w3c
        ports:
         - "80:80"
        restart: always
        links:
         - vnu:vnu
    
    networks:
      default:
        driver: "bridge"

Now open http://localhost/ in your browser.
