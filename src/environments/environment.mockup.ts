import { domain, clientId, audience } from '../../auth_config.json';
export const environment = {
  production: false,
  environment: 'mockup',
  mock: true,
  auth: {
    domain,
    clientId,
    redirectUri: window.location.origin,
    audience
  }
  // This strategy for environment configuration is currently **** NOT USED ****
  //restaurantServiceBaseUrl: window["env"]["restaurantServiceBaseUrl"] || "http://prod:9997"
};