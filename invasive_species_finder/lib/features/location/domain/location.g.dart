// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      id: json['id'] as String,
      userID: json['userID'] as String,
      speciesID: json['speciesID'] as String,
      name: json['name'] as String,
      attitude: (json['attitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'speciesID': instance.speciesID,
      'name': instance.name,
      'attitude': instance.attitude,
      'latitude': instance.latitude,
    };
