import { Component, OnInit } from '@angular/core';
import { Restaurant } from './restaurant';
import { RestaurantService } from './services/restaurant.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-restaurant',
  templateUrl: './restaurant.component.html',
  styleUrls: ['./restaurant.component.css']
})
export class RestaurantComponent implements OnInit {
  public restaurants: Restaurant[] = [];

  constructor(private restaurantService: RestaurantService) { }

  ngOnInit() {
    this.getRestaurants();
  }

  getRestaurants(): void {
    if (environment.mock) {
      this.restaurants = this.restaurantService.getRestaurantsFake();
    } else {
      this.restaurantService.getRestaurants().subscribe(obj => this.processResponse(obj));
    }
  }

  processResponse(obj: string): void {
    console.log("######## restaurant.processResponse() - obj = ");
    console.log(obj);
    const jsonObj = JSON.parse(JSON.stringify(obj));
    console.log("######## restaurant.processResponse() - jsonObj = ");
    console.log(jsonObj);
    const restaurantObjArray = jsonObj;
    let index = 0;
    restaurantObjArray.forEach(response => {
      console.log("######## restaurant.processResponse() - response = ");
      console.log(response);
      var restaurant: Restaurant;
      restaurant = new Restaurant(response._id, response.restaurant_id, response.name, (response.borough || response.city), response.address.street, response.address.zipcode, response.cuisine);
      this.restaurants[index++] = restaurant;
    });
  }

}