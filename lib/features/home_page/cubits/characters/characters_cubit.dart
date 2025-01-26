import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/home_page/models/character_model.dart';
import 'package:rick_and_morty_app/features/home_page/services/characters_service.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit({required this.characterService}) : super(CharactersInitial());

  final CharacterService characterService;

  Future<void> fetchInitialCharacters() async {
    emit(CharactersLoading());
    final results = await characterService.fetchCharacters();
    results.when(
      ok: (data) {
        if (data.isNotEmpty) {
          emit(CharactersLoaded(characters: data, isLoadingMore: false));
        } else {
          emit(CharactersEmpty());
        }
      },
      err: (err) {
        if(err is NetworkException) {
          emit(CharactersError(error: err.message));
        } else {
          emit(CharactersError(error: err.toString()));
        }
      }
    );
  }
}
