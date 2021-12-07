# Docker image for W3C/HTML5 validator


## Dependencies

* Nu Html Checker (v.Nu): <https://github.com/validator/validator>

## How to run

Use docker-compose to run this w3c validator along with v.Nu, docker-compose.yml example:

```yml
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
```

Now open <http://localhost/> in your browser.

## ToDo

* make Nu Html Checker directly available under <http://localhost/nu> , similar to <https://validator.w3.org/nu/>
