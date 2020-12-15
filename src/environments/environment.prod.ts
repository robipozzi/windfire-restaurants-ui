import { domain, clientId } from '../../auth_config.json';
export const environment = {
  production: true,
  environment: 'prod',
  mock: false,
  auth: {
    domain,
    clientId,
    redirectUri: window.location.origin,
  }
  // This strategy for environment configuration is currently **** NOT USED ****
  //restaurantServiceBaseUrl: window["env"]["restaurantServiceBaseUrl"] || "http://prod:9988"
};
