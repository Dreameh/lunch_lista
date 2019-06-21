import 'dart:async';
import 'package:lunch_lista/models/Results.dart';

import 'ResultApiProvider.dart';

class Repository {
  final restaurantProvider = ResultApiProvider();
  Future<Results> fetchAll() => restaurantProvider.fetchRestaurant();
}
