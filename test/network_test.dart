import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/util/network.dart';

import 'network_test.mocks.dart';


@GenerateMocks([Network])
void main() {
  group('Provider Test', () {
    test('Should return List of Restaurants when completed', () async {
      // arrange
      var network = MockNetwork();

      // act
      var list = await network.getList();

      // assert
      var result = list.restaurants.isNotEmpty;
      expect(result, true);
    });

    test('Should return List of Restaurants that contains the query on their name when completed', () async {
      // arrange
      var network = MockNetwork();

      // act
      var query = 'kafe';
      var list = await network.getSearch(query);

      // assert
      var result = true;
      for (var element in list.restaurants) {
        if(!element.name.toLowerCase().contains(query)) result = false;
      }
      expect(result, true);
    });


  });
}