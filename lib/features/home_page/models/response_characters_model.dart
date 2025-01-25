import 'package:rick_and_morty_app/features/home_page/models/character_model.dart';
import 'package:rick_and_morty_app/features/home_page/models/info_model.dart';

class ResponseCharactersModel {
  final InfoModel info;
  final List<CharacterModel> results;

  const ResponseCharactersModel({
    required this.info,
    required this.results,
  });

  factory ResponseCharactersModel.fromJson(Map<String, dynamic> json) {
    return ResponseCharactersModel(
      info: InfoModel.fromJson(json['info'] as Map<String, dynamic>? ?? {}),
      results: (json['results'] as List?)
              ?.map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info.toJson(),
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}