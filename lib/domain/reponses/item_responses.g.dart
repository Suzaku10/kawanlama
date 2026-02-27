// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemResponses _$ItemResponsesFromJson(Map<String, dynamic> json) =>
    ItemResponses(
      arti: json['arti'] as String?,
      asma: json['asma'] as String?,
      audio: json['audio'] as String?,
      ayat: (json['ayat'] as num?)?.toInt(),
      keterangan: json['keterangan'] as String?,
      nama: json['nama'] as String?,
      nomor: json['nomor'] as String?,
      rukuk: json['rukuk'] as String?,
      type: json['type'] as String?,
      urut: json['urut'] as String?,
    );

Map<String, dynamic> _$ItemResponsesToJson(ItemResponses instance) =>
    <String, dynamic>{
      'arti': instance.arti,
      'asma': instance.asma,
      'audio': instance.audio,
      'ayat': instance.ayat,
      'keterangan': instance.keterangan,
      'nama': instance.nama,
      'nomor': instance.nomor,
      'rukuk': instance.rukuk,
      'type': instance.type,
      'urut': instance.urut,
    };
