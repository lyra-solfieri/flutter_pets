class Pet {
  String name;
  String species;
  int price;
  String picture;
  var food;

  Pet({this.name, this.species, this.price, this.picture, this.food});

  Pet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    species = json['species'];
    price = json['price'];
    picture = json['picture'];
    food = json['foods'];
  }
}
