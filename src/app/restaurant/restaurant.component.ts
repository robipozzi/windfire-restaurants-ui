import { Component, OnInit } from '@angular/core';
import { Restaurant } from './restaurant';
import { RestaurantService } from './services/restaurant.service';

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
    this.restaurantService.getRestaurants().subscribe(obj => this.processResponse(obj));
    //this.restaurants = this.restaurantService.getRestaurantsFake();
  }

  processResponse(obj: string): void {
    console.log(obj);
    const jsonObj = JSON.parse(JSON.stringify(obj));
    const restaurantObjArray = jsonObj.restaurants;
    let index = 0;
    restaurantObjArray.forEach(restaurant => {
      this.restaurants[index++] = restaurant;
    });
  }

}