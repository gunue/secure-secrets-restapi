#!/bin/bash
openssl s_client -connect c.swo.local:443 \
  -showcerts </dev/null 2> /dev/null | \
  awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/ {print $0}' \
  > "conjur.pem"

