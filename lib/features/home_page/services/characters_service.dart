import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oxidized/oxidized.dart';
import 'package:rick_and_morty_app/features/home_page/models/character_model.dart';

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class Error implements Exception {
  final String message;
  Error(this.message);
}

class CharacterService {
  CharacterService(this._dio);

  final Dio _dio;

  Future<Result<List<CharacterModel>, Exception>> fetchCharacters() async {
    try {
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character',
      );

      if (response.statusCode == 200) {
        final data = response.data['results'] as List;
        final characters = data
            .map(
                (item) => CharacterModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return Ok(characters);
      } else {
        return Err(Exception(
            'Error when fetching characters: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      if(e.type == DioExceptionType.connectionError) {
        return Result.err(NetworkException('No Internet connection'));
      }
      return Result.err(Error('Something Is wrong'));
    } catch (e) {
      return Result.err(Error('Something Is wrong'));
    }
  }
}
