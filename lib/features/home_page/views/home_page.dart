import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/home_page/cubits/cubit/characters_cubit.dart';
import 'package:rick_and_morty_app/features/home_page/services/characters_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersCubit>(
      create: (context) => CharactersCubit(
        characterService: CharacterService(
          Dio(),
        ),
      )..fetchInitialCharacters(),
      child: Scaffold(
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CharactersLoaded) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.characters.length,
            itemBuilder: (context, index) {
              final character = state.characters[index];
              return Card(
                child: Text(character.name),
              );
            },
          );
        }
        if (state is CharactersEmpty) {
          return const Center(
            child: Text('No characters found'),
          );
        }
        if (state is CharactersError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
