/// A House to display
///
/// Contains fields used to display a house
class House {
  List images;
  String lat;
  String long;
  String baths;
  String beds;
  int squareFeet;
  String year;
  double lotSize;


  House(this.images, this.lat, this.long, this.baths, this.beds, this.squareFeet, this.year, this.lotSize);

  factory House.fromJson(Map<String, dynamic> json) {
    House house = House(
      json['imageUrls'],
      json['lat'],
      json['long'],
      json['baths'],
      json['beds'],
      json['squareFeet'],
      json['year'],
      json['lotSize']
    );
    return house;
  }
}