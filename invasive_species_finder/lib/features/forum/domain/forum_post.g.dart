// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForumPostImpl _$$ForumPostImplFromJson(Map<String, dynamic> json) =>
    _$ForumPostImpl(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      date: json['date'] as String,
      userID: json['userID'] as String,
      locationID: json['locationID'] as String,
      speciesID: json['speciesID'] as String,
      lastUpdate: json['lastUpdate'] as String,
    );

Map<String, dynamic> _$$ForumPostImplToJson(_$ForumPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'title': instance.title,
      'body': instance.body,
      'date': instance.date,
      'userID': instance.userID,
      'locationID': instance.locationID,
      'speciesID': instance.speciesID,
      'lastUpdate': instance.lastUpdate,
    };
