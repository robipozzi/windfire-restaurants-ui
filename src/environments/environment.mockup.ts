//import { domain, clientId, audience } from '../../auth_config.json';
export const environment = {
  production: false,
  environment: 'mockup',
  mock: true,
  auth: {
    "domain": "robipozzi.eu.auth0.com",
    "clientId": "Gh3X311uWdYBG0xmUcmzB8vsPito52iw",
    "audience": "windfire-restaurants",
    "serverUrl": "http://localhost:8082"
  }
  // This strategy for environment configuration is currently **** NOT USED ****
  //restaurantServiceBaseUrl: window["env"]["restaurantServiceBaseUrl"] || "http://prod:9997"
};