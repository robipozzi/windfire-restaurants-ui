import { Injectable } from '@angular/core';
import { RestaurantService } from './services/restaurant.service';

@Injectable()
export class RestaurantFacade {
    id: string;
    name: string;
    
    constructor(private restaurantService: RestaurantService) { 

    }
}