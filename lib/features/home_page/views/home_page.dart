import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/detail_characters/views/detail_characters_page.dart';
import 'package:rick_and_morty_app/features/home_page/cubits/cubit/characters_cubit.dart';
import 'package:rick_and_morty_app/features/home_page/services/characters_service.dart';
import 'package:rick_and_morty_app/features/home_page/views/widgets/card_character.dart';

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
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            child: Text('Hola mundo'),
          ),
          Expanded(
            child: BlocConsumer<CharactersCubit, CharactersState>(
              listener: (context, state) {
                if (state is CharactersError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
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
                      return SizedBox(
                        height: 120,
                        child: CharacterCard(
                          character: character,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => DetailCharactersPage(
                                character: character,
                              ),)
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                if (state is CharactersEmpty) {
                  return const Center(
                    child: Text('No characters found'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
