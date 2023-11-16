import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'species.freezed.dart';
part 'species.g.dart';

@freezed
class Species with _$Species {
  const factory Species({
    required String id,
    required String name,
    required String description,
    required String category,
    required String imagePath,
    required String locationID,
    required String postID,
}) = _Species;

  factory Species.fromJson(Map<String, dynamic> json) => _$SpeciesFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<Species>> checkInitialData() async {
    String content =
    await rootBundle.loadString("assets/initialData/species.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Species.fromJson(jsonData)).toList();
  }
}
