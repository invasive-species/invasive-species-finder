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
}
