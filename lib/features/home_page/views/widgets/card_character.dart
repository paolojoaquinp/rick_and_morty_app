import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/home_page/models/character_model.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
    required this.onPressed,
  });

  final CharacterModel character;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    character.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  character.species,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _statusIndicator(character.status),
                          Row(
                            children: [
                              Icon(character.gender == 'Male'
                                  ? Icons.male
                                  : Icons.female),
                              Text(character.gender),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _statusIndicator(String status) {
    Color color;
    switch (status) {
      case 'Alive':
        color = Colors.green;
        break;
      case 'Dead':
        color = Colors.red;
        break;
      default:
        color = Colors.yellow;
    }
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(status),
      ],
    );
  }
}
