import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_starships_response.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/list_response_base_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_starship_response_entity.dart';

import '../../../../../helpers/json_reader.dart';

void main() {
  group('list starships test inheritance\n\t', () {
    final Map<String, dynamic> jsonMap = json.decode(readJson(
        'helpers/dummy_data/starship/dummy_list_starships_response.json'));
    final jsonResult = ListStarshipsResponse.fromJson(jsonMap).toEntity();
    //test if it is a subclass of list starship response entity
    test('should be a subclass of list starship response entity', () {
      //assert
      debugPrint('$jsonResult');
      expect(jsonResult, isA<ListStarshipsResponseEntity>());
    });
    // test if is is a sub-subclass of base list response
    test('should be sub-subclass of base list response', () {
      expect(jsonResult, isA<ListResponseBaseEntity>());
    });
  });

  test('list starships test from json\n\t', () {});
}
