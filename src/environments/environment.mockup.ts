export const environment = {
  production: false,
  environment: 'mockup',
  mock: true,
  auth: {
    domain: "robipozzi.eu.auth0.com",
    clientId: "Gh3X311uWdYBG0xmUcmzB8vsPito52iw",
    redirectUri: window.location.origin
  }
  // This strategy for environment configuration is currently **** NOT USED ****
  //restaurantServiceBaseUrl: window["env"]["restaurantServiceBaseUrl"] || "http://prod:9997"
};