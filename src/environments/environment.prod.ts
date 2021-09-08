//import { domain, clientId, audience } from '../../auth_config.json';
export const environment = {
  production: true,
  environment: 'prod',
  mock: false,
  auth: {
    "domain": "robipozzi.eu.auth0.com",
    "clientId": "IemyApptXPjBFiNXbtLHU5ek3AZR4chx",
    "audience": "windfire-restaurants",
    "serverUrl": "http://openshift"
  }
  /*auth: {
    domain,
    clientId,
    redirectUri: window.location.origin,
    audience
  }*/
  // This strategy for environment configuration is currently **** NOT USED ****
  //restaurantServiceBaseUrl: window["env"]["restaurantServiceBaseUrl"] || "http://prod:9988"
};