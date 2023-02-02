#set public-keys
oc get --raw $(oc get --raw /.well-known/openid-configuration | jq -r '.jwks_uri') > jwks.json
conjur -i variable set -i conjur/authn-jwt/ocpprod-cluster/public-keys -v "{\"type\":\"jwks\", \"value\":$(cat jwks.json)}"
#set issuer
issuer=$(oc get --raw /.well-known/openid-configuration | jq -r '.issuer')
conjur -i variable set -i conjur/authn-jwt/ocpprod-cluster/issuer -v $issuer
#set token-app-property
conjur -i variable set -i conjur/authn-jwt/ocpprod-cluster/token-app-property -v "sub"
#set identity-path
conjur -i variable set -i conjur/authn-jwt/ocpprod-cluster/identity-path -v ocpprod-apps-jwt
#set audience
conjur -i variable set -i conjur/authn-jwt/ocpprod-cluster/audience -v "https://c.swo.local"
