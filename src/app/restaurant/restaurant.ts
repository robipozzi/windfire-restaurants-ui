export class Restaurant {
  id: string;
  name: string;
  
  constructor(private _id: string, private _name: string) { 
    this.id = _id,
    this.name = _name
  }
}