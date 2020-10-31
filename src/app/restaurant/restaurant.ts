export class Restaurant {
  _id: string;
  name: string;
  restaurant_id: string;
  city: string;
  
  constructor(private id: string, private _name: string, private _restaurant_id: string, private _city: string) { 
    this._id = id,
    this.name = _name,
    this.restaurant_id = _restaurant_id,
    this.city = _city;
  }
}