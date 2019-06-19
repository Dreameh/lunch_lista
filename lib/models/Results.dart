class Results {
  int status;
  String message;
  Cache cache;

  Results({this.status, this.message, this.cache});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      status: json['status'],
      message: json['message'],
      cache: Cache.fromJson(json['cache'])
    );
  }

  List<Restaurant> get restaurants => cache.restaurants;
  int get weekNumber => cache.weekNumber;
  String get day => cache.day;
  String get date => cache.date;
  int get timestamp => cache.timestamp;
}

class Cache {
  String day;
  int weekNumber;
  String date;
  int timestamp;
  List<Restaurant> restaurants;

  Cache({this.day, this.weekNumber, this.date, this.timestamp, this.restaurants});

  factory Cache.fromJson(Map<String, dynamic> json) {
    var list = json['restaurants'] as List;
    List<Restaurant> restaurantList = list.map((i) => Restaurant.fromJson(i)).toList();
    return Cache(
      day: json['day'],
      weekNumber: json['week_number'],
      date: json['date'],
      timestamp: json['timestamp'],
      restaurants: restaurantList
    );
  }
}

class Restaurant {
  int id;
  String image;
  String website;
  String name;
  String info;
  String address;
  String phone;
  String menu;

  Restaurant({this.id, this.image, this.website, this.name, this.info, this.address, this.phone, this.menu});

    factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      image: json['image'],
      website: json['website'],
      name: json['name'],
      info: json['info'],
      address: json['address'],
      phone: json['phone'],
      menu: json['menu']
    );
  }
}

