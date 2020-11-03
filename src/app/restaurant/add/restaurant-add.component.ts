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
  model = new Restaurant('', '', 'Hostaria Vecchio Portico', 'Arona', 'Piazza del Popolo 23', '20000', 'Italian');

  add(): void {
    this.submitted = true;
    this.restaurantService.addRestaurant(this.model).subscribe(obj => this.processResponse(obj));
  }
  
  reset() {
    this.model = new Restaurant('', '', '', '', '', '', '');
  }

  processResponse(obj: Restaurant): void {
    console.log("######## restaurant-add.processResponse() - obj = ");
    console.log(obj);
  }

}