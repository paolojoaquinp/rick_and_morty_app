part of 'characters_cubit.dart';

sealed class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

final class CharactersInitial extends CharactersState {}

final class CharactersLoading extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  final List<CharacterModel> characters;
  final bool isLoadingMore;

  const CharactersLoaded({
    required this.characters,
    this.isLoadingMore = false,
  });

  CharactersLoaded copyWith({
    List<CharacterModel>? characters,
    bool? isLoadingMore,
  }) {
    return CharactersLoaded(
      characters: characters ?? this.characters,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [characters, isLoadingMore];
}

final class CharactersEmpty extends CharactersState {}

final class CharactersError extends CharactersState {
  final String error;

  const CharactersError({required this.error});

  @override
  List<Object> get props => [error];
}
