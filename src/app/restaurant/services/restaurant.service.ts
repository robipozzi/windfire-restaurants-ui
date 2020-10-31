import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { ErrorService } from 'src/app/error/services/error.service';
import { Restaurant } from '../restaurant';
import { AppConfigService } from 'src/app/app-config.service';

@Injectable({
  providedIn: 'root'
})
export class RestaurantService {
  private restaurantServiceBaseUrl: string;
  private httpOptions = {
    headers: new HttpHeaders({
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
    })
  };

  constructor(private http: HttpClient, private errorService: ErrorService, private appConfigService: AppConfigService) { 
    this.getEnv();
  }

  getRestaurants(): Observable<string> {
    var restaurantServiceEndpoint: string = this.restaurantServiceBaseUrl + '/restaurants';
    console.log('Calling Restaurant Service Endpoint @ ' + restaurantServiceEndpoint);
    return this.http.get<string>(restaurantServiceEndpoint, this.httpOptions)
      .pipe(
        tap(_ => console.log('Endpoint ' + restaurantServiceEndpoint + ' called, returning ...')),
        catchError(this.errorService.handleError<string>('getRestaurants()', String())));
  }

  getRestaurantsFake(): Restaurant[] {
    console.log('Returning a fake Restaurant list');
    const restaurants: Restaurant[] = [];
    var index = 0;
    //var restaurant1 = { _id : 1, name : "Hostaria Vecchio Portico", restaurant_id : 1, city: "Arona", address : {street : "Via xx, 28", zipcode : 20981. coord:{15.99988787,45.876543}}, cuisine: "Italian"};
    var restaurant1 = new Restaurant('1', 'Osteria del Pesce', '1', 'Arona');
    var restaurant2 = new Restaurant('2', 'Il cortile del Re', '2', 'Gallarate');
    var restaurant3 = new Restaurant('3', 'La Perla', '3', 'Varese');
    restaurants[index++] = restaurant1;
    restaurants[index++] = restaurant2;
    restaurants[index++] = restaurant3;
    return restaurants;
  }

  private getEnv() {
    if (environment.environment == 'dev' && !environment.mock) {
      console.log('Reading configuration from environment.ts ...')
      this.restaurantServiceBaseUrl = environment.restaurantServiceBaseUrl
    } else if (!environment.mock){
      console.log('Reading configuration from assets/config/config.json file ...')
      this.restaurantServiceBaseUrl = this.appConfigService.getConfig().RESTAURANT_SVC_BASEURL
    }
    console.log('restaurantServiceBaseUrl =  ' + this.restaurantServiceBaseUrl);
  }
  
}