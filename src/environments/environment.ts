// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.
export const environment = {
  production: false,
  environment: 'dev',
  mock: false,
  auth: {
    domain: "robipozzi.eu.auth0.com",
    clientId: "Gh3X311uWdYBG0xmUcmzB8vsPito52iw",
    redirectUri: window.location.origin
  }
  // This strategy for environment configuration is currently **** NOT USED ****
  //restaurantServiceBaseUrl: window["env"]["restaurantServiceBaseUrl"] || "http://localhost:8082"
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.