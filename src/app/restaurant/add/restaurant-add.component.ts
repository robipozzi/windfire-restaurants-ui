import { Component, OnInit } from '@angular/core';
import { Restaurant } from '../model/restaurant';
import { RestaurantService } from '../services/restaurant.service';

@Component({
  selector: 'app-restaurant-add',
  templateUrl: './restaurant-add.component.html',
  styleUrls: ['./restaurant-add.component.css']
})
export class RestaurantAddComponent implements OnInit {

  constructor(private restaurantService: RestaurantService) { }

  ngOnInit(): void {
  }

  submitted = false;
  model = new Restaurant('', '', '', '', '', '', '');

  add(): void {
    this.submitted = true; 
    this.restaurantService.addRestaurant(this.model);
  }
  
  reset() {
    this.model = new Restaurant('', '', '', '', '', '', '');
  }

}