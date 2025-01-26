import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/detail_characters/views/detail_characters_page.dart';
import 'package:rick_and_morty_app/features/home_page/cubits/characters/characters_cubit.dart';
import 'package:rick_and_morty_app/features/home_page/cubits/search_input/search_input_cubit.dart';
import 'package:rick_and_morty_app/features/home_page/services/characters_service.dart';
import 'package:rick_and_morty_app/features/home_page/views/widgets/card_character.dart';
import 'package:rick_and_morty_app/features/home_page/views/widgets/search_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchInputCubit>(
      create: (context) => SearchInputCubit(),
      child: const Scaffold(
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
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.04,
      ),
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          SearchInput(onChanged: (newValue) {
            context.read<SearchInputCubit>().setNewValue(newValue);
          }),
          Expanded(
            child: BlocConsumer<CharactersCubit, CharactersState>(
              bloc: CharactersCubit(
                characterService: CharacterService(
                  Dio(),
                ),
              )..fetchInitialCharacters(),
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
                  final query = context.watch<SearchInputCubit>().state;
                  final filteredList = state.characters.where((character) {
                    final nameMatch = character.name
                        .toLowerCase()
                        .contains(query.toLowerCase());
                    final statusMatch = character.status
                        .toLowerCase()
                        .contains(query.toLowerCase());
                    final speciesMatch = character.species
                        .toLowerCase()
                        .contains(query.toLowerCase());
                    return nameMatch || statusMatch || speciesMatch;
                  }).toList();
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final character = filteredList[index];
                      return SizedBox(
                        height: 120,
                        child: CharacterCard(
                          character: character,
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 1200),
                                reverseTransitionDuration:
                                    const Duration(milliseconds: 1200),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return DetailCharactersPage(
                                    character: character,
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
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
