import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Lendas da NASCAR';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange, // Cor mais associada a corridas
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(image: 'images/membros_gang.jpg'), // Imagem 1
              TitleSection(
                name: 'A Gangue do Alabama',
                location: 'Talladega Superspeedway, Alabama',
              ),
              ButtonSection(),
              TextSection(
                description:
                    'Longe de serem foras da lei, a "Gangue do Alabama" era o apelido de um grupo de pilotos lendários da NASCAR '
                    'baseados em Hueytown, Alabama. Liderados pelos irmãos Bobby e Donnie Allison e por Red Farmer, '
                    'eles eram conhecidos por sua competitividade feroz na pista e sua amizade inabalável fora dela. '
                    'Eles dominaram as corridas nas décadas de 1960, 70 e 80, e Talladega era considerada sua pista de casa. '
                    'A próxima geração, incluindo Neil Bonnett e Davey Allison, filho de Bobby, continuou o legado. '
                    'A história da Gangue do Alabama é uma das mais celebradas no automobilismo, simbolizando talento, '
                    'coragem e a camaradagem do Sul dos EUA.',
              ),
              // NOME DA IMAGEM CORRIGIDO AQUI
              ImageSection(image: 'images/pista_talladega.jpg'), // Imagem 2
            ],
          ),
        ),
      ),
    );
  }
}

class TitleSection extends StatefulWidget {
  const TitleSection({super.key, required this.name, required this.location});

  final String name;
  final String location;

  @override
  State<TitleSection> createState() => _TitleSectionState();
}

class _TitleSectionState extends State<TitleSection> {
  bool _isFavorited = true;
  int _favoriteCount = 88; // Número icônico da NASCAR

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(
                  widget.location,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _toggleFavorite,
            child: Row(
              children: [
                Icon(
                  _isFavorited ? Icons.star : Icons.star_border,
                  color:
                      _isFavorited ? Colors.orange[800] : Colors.grey,
                ),
                Text('$_favoriteCount'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(
            color: color,
            icon: Icons.sports_motorsports, // Ícone temático
            label: 'PILOTOS',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Mostrando lendas como Bobby Allison...')),
              );
            },
          ),
          ButtonWithText(
            color: color,
            icon: Icons.flag, // Ícone temático
            label: 'CORRIDAS',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Relembrando vitórias em Talladega...')),
              );
            },
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: 'COMPARTILHAR',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Compartilhando a lenda...')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(description, softWrap: true, textAlign: TextAlign.justify),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Image.asset(image, width: 600, height: 240, fit: BoxFit.cover),
    );
  }
}