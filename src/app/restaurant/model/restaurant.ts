export class Restaurant {
  id: string;
  restaurant_id: string;
  name: string;
  city: string;
  street: string;
  zipcode: string;
  cuisine: string;
  
  constructor(private _id: string, private _restaurant_id: string, private _name: string, private _city: string, private _street: string, private _zipcode: string, private _cuisine: string) { 
    this.id = _id,
    this.restaurant_id = _restaurant_id,
    this.name = _name,
    this.city = _city;
    this.street = _street;
    this.zipcode = _zipcode;
    this.cuisine = _cuisine;
  }
}