import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { ErrorService } from 'src/app/error/services/error.service';
import { Restaurant } from '../restaurant';

@Injectable({
  providedIn: 'root'
})
export class RestaurantService {
  private restaurantServiceBaseUrl = environment.restaurantServiceBaseUrl;
  private httpOptions = {
    headers: new HttpHeaders({
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
    })
  };

  constructor(private http: HttpClient, private errorService: ErrorService) { }

  getRestaurants(): Observable<string> {
    const restaurantServiceEndpoint: string = this.restaurantServiceBaseUrl + '/restaurants';
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
    var restaurant1 = new Restaurant('1', 'Osteria del Pesce');
    var restaurant2 = new Restaurant('2', 'Il cortile del Re');
    var restaurant3 = new Restaurant('3', 'La Perla');
    restaurants[index++] = restaurant1;
    restaurants[index++] = restaurant2;
    restaurants[index++] = restaurant3;
    return restaurants;
  }
  
}