import { Component, OnInit } from '@angular/core';
import { ErrorService } from 'src/app/error/services/error.service';
import { Restaurant } from '../model/restaurant';
import { RestaurantService } from '../services/restaurant.service';

@Component({
  selector: 'app-restaurant-add',
  templateUrl: './restaurant-add.component.html',
  styleUrls: ['./restaurant-add.component.css']
})
export class RestaurantAddComponent implements OnInit {
  submitted = false;
  //model = new Restaurant('', '', 'Hostaria Vecchio Portico', 'Arona', 'Piazza del Popolo 23', '20000', 'Italian');
  model = new Restaurant('', '', '', '', '', '', '');

  constructor(private restaurantService: RestaurantService, private errorService: ErrorService) { }

  ngOnInit(): void {
    this.errorService.clear();
  }

  add(): void {
    this.submitted = true;
    this.restaurantService.addRestaurant(this.model).subscribe(obj => this.processResponse(obj));
  }

  edit(): void {
    this.submitted = false;
    this.errorService.clear();
  }
  
  reset() {
    this.model = new Restaurant('', '', '', '', '', '', '');
  }

  processResponse(obj: Restaurant): void {
    console.log("######## restaurant-add.processResponse() - obj = ");
    console.log(obj);
  }

}