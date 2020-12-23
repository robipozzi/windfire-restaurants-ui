import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { RestaurantComponent } from './restaurant/restaurant.component';
import { RestaurantAddComponent } from './restaurant/add/restaurant-add.component';
// Import AuthGuard to protect specific routes
import { AuthGuard } from '@auth0/auth0-angular';

const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'home', component: HomeComponent, canActivate: [AuthGuard] },
  { path: 'restaurants', component: RestaurantComponent, canActivate: [AuthGuard] },
  { path: 'add', component: RestaurantAddComponent, canActivate: [AuthGuard] }
];

@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    RouterModule.forRoot(routes)
  ],
  exports: [ RouterModule ],
})
export class AppRoutingModule { }