export class Restaurant {
  id: string;
  restaurant_id: string;
  name: string;
  city: string;
  street: string;
  zipcode: string;
  cuisine: string;
  
  constructor( _id: string,  _restaurant_id: string,  _name: string,  _city: string,  _street: string,  _zipcode: string,  _cuisine: string) { 
    this.id = _id,
    this.restaurant_id = _restaurant_id,
    this.name = _name,
    this.city = _city;
    this.street = _street;
    this.zipcode = _zipcode;
    this.cuisine = _cuisine;
  }
}