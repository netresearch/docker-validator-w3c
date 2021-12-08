# Docker image for W3C/HTML5 validator

Provides W3C Markup Validation Service and Nu Html Checker (v.Nu).

## Dependencies

* Nu Html Checker (v.Nu): <https://github.com/validator/validator>

## How to run

Use Docker Compose to run this W3C validator along with Nu Html Checker (v.Nu), docker-compose.yml example:

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

Now open <http://localhost/> or <http://localhost/nu/> in your browser.

## References

* Nu Html Checker (v.Nu): <https://github.com/validator/validator>
* W3C Markup Validation Service: <https://validator.w3.org/>
  * W3C Markup Validator sources: <https://github.com/w3c/markup-validator>
  * W3C Markup Validator wiki: <https://www.w3.org/wiki/MarkupValidator>
* W3C CSS Validation: <https://jigsaw.w3.org/css-validator/>
  * W3C CSS Validator sources: <https://github.com/w3c/css-validator>
  * W3C CSS Validator wiki: <https://www.w3.org/wiki/CssValidator>
* Docker: <https://www.docker.com/>
* Moby Project sources: <https://github.com/moby/moby>
* Docker Compose: <https://docs.docker.com/compose/>
* Docker Compose sources: <https://github.com/docker/compose>

## ToDo

* Add W3C CSS Validator
