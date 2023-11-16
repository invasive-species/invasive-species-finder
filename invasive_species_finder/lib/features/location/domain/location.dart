import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  const factory Location({
    required String id,
    required String userID,
    required String speciesID,
    required String name,
    required double attitude,
    required double latitude,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<Location>> checkInitialData() async {
    String content =
    await rootBundle.loadString("assets/initialData/locations.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Location.fromJson(jsonData)).toList();
  }
}
