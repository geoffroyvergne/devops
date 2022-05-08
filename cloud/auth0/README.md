# Auth0

https://rinormaloku.com/authorization-in-istio/

## openid connect configuration

https://YOUR_DOMAIN/.well-known/openid-configuration

## Custom claims

Context objects : https://auth0.com/docs/rules/references/context-object?_ga=2.215777872.672994889.1584897562-890361934.1584897562

https://auth0.com/docs/extensions/authorization-extension/v2/rules
add rule -> custom-claims

```
function (user, context, callback) {
  var namespace = 'http://testapp/claims/'; // You can set your own namespace, but do not use an Auth0 domain

  // Add the namespaced tokens. Remove any which is not necessary for your scenario
  //context.idToken[namespace + "permissions"] = user.permissions;
  //context.idToken[namespace + "groups"] = user.groups;
  context.idToken[namespace + "user"] = user;
  //context.idToken[namespace + "context"] = context;
  context.idToken[namespace + "roles"] = context.authorization.roles;
  context.idToken[namespace + "authorization"] = context.authorization;
  
  callback(null, user, context);
}
}
```

## Implicit Flow

https://auth0.com/docs/flows/guides/implicit/add-login-implicit

https://YOUR_DOMAIN/authorize?
    response_type=YOUR_RESPONSE_TYPE&
    client_id=YOUR_CLIENT_ID&
    redirect_uri=https://YOUR_APP/callback&
    state=STATE&
    nonce=NONCE

## Client Credential

https://auth0.com/docs/api-auth/tutorials/client-credentials

curl --request POST \
  --url 'https://YOUR_DOMAIN/oauth/token' \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data grant_type=client_credentials \
  --data 'client_id=YOUR_CLIENT_ID' \
  --data client_secret=YOUR_CLIENT_SECRET \
  --data audience=YOUR_API_IDENTIFIER

{
 "access_token":"eyJz93a...k4laUWw",
 "token_type":"Bearer",
 "expires_in":86400
}

## Test API

curl --request GET \
  --url http://path_to_your_api/ \
  --header "authorization: Bearer <TOKEN>"

## Istio

````
apiVersion: authentication.istio.io/v1alpha1
kind: Policy
metadata:
  name: ingressgateway
  namespace: istio-system
spec:
  targets:
  - name: istio-ingressgateway
  peers:
  - mtls: {}
  origins:
  - jwt:
      audiences:
      - "YOUR_API_IDENTIFIER"
      issuer: "YOUR_DOMAIN"
      jwksUri: "YOUR_DOMAIN/.well-known/jwks.json"
  principalBinding: USE_ORIGIN`
````