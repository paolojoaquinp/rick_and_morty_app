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
      itemBackgroundColor =
          paletteGenerator.dominantColor?.color ?? Colors.yellow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: itemBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 40,
                    spreadRadius: -15,
                    offset: Offset(35, 35))
              ]),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: Image.network(
                  widget.character.image,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).width * 0.8,
                ),
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Species | ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.character.species,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Text(
                  widget.character.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8), // Espaciado
                Row(
                  children: [
                    const Text(
                      'Origin',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      ' | ${widget.character.origin.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Espaciado
                Text(
                  'Location | ${widget.character.location.name}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
