import 'package:lunch_lista/models/Results.dart';
import 'package:lunch_lista/resources/Repository.dart';

import 'package:rxdart/rxdart.dart';

class RestaurantBloc {
  final _repository = Repository();
  final _restaurantFetcher = PublishSubject<Results>();

  Observable get allRestaurants => _restaurantFetcher.stream;
  
  fetchAllRestaurants() async {
    Results results = await _repository.fetchAll();
    _restaurantFetcher.sink.add(results);
  }

  dispose() {
    _restaurantFetcher.close();
  }
}

final bloc = RestaurantBloc();