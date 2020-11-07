import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { ErrorService } from 'src/app/error/services/error.service';
import { Restaurant } from '../model/restaurant';
import { AppConfigService } from 'src/app/app-config.service';

@Injectable({
  providedIn: 'root'
})
export class RestaurantService {
  private restaurantServiceBaseUrl: string;
  private restaurantServiceEndpoint: string;
  private httpOptions = {
    headers: new HttpHeaders({
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
    })
  };

  constructor(private http: HttpClient, private errorService: ErrorService, private appConfigService: AppConfigService) { 
    this.setupEnv();
  }

  getRestaurants(): Observable<string> {
    console.log('getRestaurants - Calling Restaurant Service Endpoint @ ' + this.restaurantServiceEndpoint);
    return this.http.get<string>(this.restaurantServiceEndpoint, this.httpOptions)
      .pipe(
        tap(_ => console.log('Endpoint ' + this.restaurantServiceEndpoint + ' called, returning ...')),
        catchError(this.errorService.handleError<string>('getRestaurants()', String())));
  }

  addRestaurant(restaurant: Restaurant): Observable<Restaurant> {
    console.log('addRestaurant - Calling Restaurant Service Endpoint @ ' + this.restaurantServiceEndpoint);
    return this.http.post<Restaurant>(this.restaurantServiceEndpoint, restaurant, this.httpOptions)
      .pipe(
        catchError(this.errorService.handleError('addRestaurant', restaurant)));
  }

  deleteRestaurant(id: string): Observable<{}> {
    const url = `${this.restaurantServiceEndpoint}/${id}`;
    return this.http.delete(url, this.httpOptions)
      .pipe(
        catchError(this.errorService.handleError('deleteRestaurant', id)));
  }

  getRestaurantsFake(): Restaurant[] {
    console.log('Returning a fake Restaurant list');
    const restaurants: Restaurant[] = [];
    var index = 0;
    var restaurant1 = new Restaurant('1', '1', 'Taverna del Pittore', 'Arona', 'Piazza del Popolo 39', '28041', 'Pesce');
    var restaurant2 = new Restaurant('2', '2', 'La Corte del Re', 'Gallarate', 'Via Manzoni 1', '21013', 'Italian');
    var restaurant3 = new Restaurant('3', '3', 'La Perla', 'Varese', 'Via Carrobbio 19', '21100', 'Pesce');
    restaurants[index++] = restaurant1;
    restaurants[index++] = restaurant2;
    restaurants[index++] = restaurant3;
    return restaurants;
  }

  private setupEnv() {
    this.restaurantServiceBaseUrl = this.appConfigService.getConfig().RESTAURANT_SVC_BASEURL
    console.log('restaurantServiceBaseUrl =  ' + this.restaurantServiceBaseUrl);
    this.restaurantServiceEndpoint = this.restaurantServiceBaseUrl + '/restaurants';
  }
  
}