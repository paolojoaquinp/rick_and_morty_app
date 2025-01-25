import 'package:rick_and_morty_app/features/home_page/entities/character_entity.dart';
import 'package:rick_and_morty_app/features/home_page/models/location_model.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.origin,
    required super.location,
    required super.image,
    required super.episode,
    required super.url,
    required super.created,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': {
        'name': origin.name,
        'url': origin.url,
      },
      'location': {
        'name': location.name,
        'url': location.url,
      },
      'image': image,
      'episode': episode,
      'url': url,
      'created': created.toIso8601String(),
    };
  }

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      status: json['status'] as String? ?? '',
      species: json['species'] as String? ?? '',
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      origin: LocationModel.fromJson(json['origin'] as Map<String, dynamic>? ?? {}),
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>? ?? {}),
      image: json['image'] as String? ?? '',
      episode: (json['episode'] as List?)?.map((e) => e.toString()).toList() ?? [],
      url: json['url'] as String? ?? '',
      created: DateTime.parse(json['created'] as String? ?? DateTime.now().toIso8601String()),
    );
  }

  CharacterModel copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    LocationModel? origin,
    LocationModel? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }
}
