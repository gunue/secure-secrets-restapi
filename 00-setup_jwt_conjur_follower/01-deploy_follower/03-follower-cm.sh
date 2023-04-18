openssl s_client -showcerts -connect c.swo.local:443 < /dev/null 2> /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > conjur.pem
CONJUR_SSL_CERTIFICATE=conjur.pem
CONJUR_APPLIANCE_URL=https://c.swo.local
AUTHENTICATOR_ID=ocpprod-cluster
CONJUR_ACCOUNT=swo-uat
CONJUR_SEED_FILE_URL=$CONJUR_APPLIANCE_URL/configuration/$CONJUR_ACCOUNT/seed/follower
oc create sa authn-jwt-sa
oc create configmap follower-cm -n cyberark-conjur-jwt \
  -o yaml \
  --dry-run \
  --from-literal CONJUR_ACCOUNT=${CONJUR_ACCOUNT} \
  --from-literal CONJUR_APPLIANCE_URL=${CONJUR_APPLIANCE_URL} \
  --from-literal CONJUR_SEED_FILE_URL=${CONJUR_SEED_FILE_URL} \
  --from-literal AUTHENTICATOR_ID=${AUTHENTICATOR_ID} \
  --from-file "CONJUR_SSL_CERTIFICATE=${CONJUR_SSL_CERTIFICATE}" | kubectl apply -f -
