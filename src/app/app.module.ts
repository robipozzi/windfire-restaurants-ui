import { BrowserModule } from '@angular/platform-browser';
import { NgModule, APP_INITIALIZER } from '@angular/core';
import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { HeaderComponent } from './header/header.component';
import { FooterComponent } from './footer/footer.component';
import { LayoutComponent } from './layout/layout.component';
import { AppRoutingModule } from './app-routing.module';
import { RestaurantComponent } from './restaurant/restaurant.component';
import { RestaurantAddComponent } from './restaurant/add/restaurant-add.component';
import { ErrorComponent } from './error/error.component';
import { HttpClientModule } from '@angular/common/http';
import { AppConfigService } from './app-config.service';
// Import the module for Auth0 integration from the SDK
import { AuthModule } from '@auth0/auth0-angular';
import { LoginButtonComponent } from './components/login-button/login-button.component';
import { FormsModule } from '@angular/forms';

const appInitializerFn = (appConfig: AppConfigService) => {
  return () => {
    return appConfig.loadAppConfig();
  };
};

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    HeaderComponent,
    FooterComponent,
    LayoutComponent,
    RestaurantComponent,
    ErrorComponent,
    LoginButtonComponent,
    RestaurantAddComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    AppRoutingModule,
    // Import the module for Auth0 integration into the application, with configuration
    AuthModule.forRoot({
      "domain": "robipozzi.eu.auth0.com",
      "clientId": "Gh3X311uWdYBG0xmUcmzB8vsPito52iw"
    }),
    FormsModule
  ],
  providers: [
    AppConfigService,
    {
      provide: APP_INITIALIZER,
      useFactory: appInitializerFn,
      multi: true,
      deps: [AppConfigService]
    }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }