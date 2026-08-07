import 'package:flutter/material.dart';
import 'package:palette_generator_plus/palette_generator_plus.dart';

class PaletteColor extends StatefulWidget {
  final String imagePath;
  final String? isbn;

  const PaletteColor({super.key, required this.imagePath, required this.isbn});

  @override
  State<PaletteColor> createState() => _PaletteColorState();
}

class _PaletteColorState extends State<PaletteColor> {
  Color dominantColor = const Color(0xFFFFFBEC);

  @override
  void initState() {
    super.initState();
    _generatePalette();
  }

  Future<void> _generatePalette() async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.imagePath),
      );

      if (!mounted) return;

      setState(() {
        dominantColor =
            palette.dominantColor?.color ??
            palette.vibrantColor?.color ??
            const Color(0xFFFFFBEC);
      });
    } catch (e) {
      debugPrint("Palette Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            dominantColor,
            dominantColor.withOpacity(0.75),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      // child: const Center(
      //   child: Text(
      //     "Palette Generated Background",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 22,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
    );
  }
}
