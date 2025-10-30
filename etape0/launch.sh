#!/usr/bin/env bash
set -euo pipefail

1.docker container ls -aq
resultat : 
6d05e68c50cf
c16b985c5c4b
8b3b9e46b2b6
e117b9931651
d138e1aac85e
c94f4e5158e7
d17dc499e86d
623ed197951d
1f92b8d3d5b6
e541d146368c

2.docker container rm -f $(docker container ls -aq)
