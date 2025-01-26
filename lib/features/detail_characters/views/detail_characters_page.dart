import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rick_and_morty_app/features/home_page/models/character_model.dart';

class DetailCharactersPage extends StatefulWidget {
  const DetailCharactersPage({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  State<DetailCharactersPage> createState() => _DetailCharactersPageState();
}

class _DetailCharactersPageState extends State<DetailCharactersPage> {
  late PaletteGenerator paletteGenerator;
  Color itemBackgroundColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _updatePaletteGenerator();
  }

  Future<void> _updatePaletteGenerator() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.character.image),
    );
    setState(() {
      itemBackgroundColor = paletteGenerator.dominantColor?.color ?? Colors.yellow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: itemBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.character.image,
              width: 128,
              height: 128,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Statue | Rick & Morty',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'In-stock!',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Rick & Morty\nMorty',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              '\$2.250',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
