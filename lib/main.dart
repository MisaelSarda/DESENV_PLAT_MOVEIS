import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Turismo na Suíça';
    return MaterialApp(
      title: appTitle,
      
      theme: ThemeData(
        primarySwatch: Colors.green, 
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(image: 'images/lake.jpg'),
              TitleSection(
                name: 'Acampamento do Lago Oeschinen',
                location: 'Kandersteg, Suíça',
              ),
              ButtonSection(),
              TextSection(
                description:
                    'O Lago Oeschinen fica aos pés do Blüemlisalp, nos Alpes Berneses.'
                    ' Situado a 1.578 metros acima do nível do mar, é um dos maiores lagos alpinos.'
                    ' Um passeio de gôndola saindo de Kandersteg, seguido por uma caminhada de meia hora por pastos e florestas de pinheiros,'
                    ' leva você ao lago, que chega a 20 graus Celsius no verão. As atividades disponíveis aqui incluem remo e tobogã no verão.',
              ),
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
  int _favoriteCount = 41;

  
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  widget.location,
                  style: TextStyle(color: Colors.grey[500]),
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
                  color: _isFavorited ? Colors.red[500] : Colors.grey, 
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
            icon: Icons.call,
            label: 'LIGUE',
            onPressed: () {
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Iniciando chamada...')),
              );
            },
          ),
          ButtonWithText(
            color: color,
            icon: Icons.near_me,
            label: 'ROTA',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mostrando rota no mapa...')),
              );
            },
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: 'COMPARTILHAR',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Abrindo opções de compartilhamento...')),
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
      child: Text(description, softWrap: true),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, width: 600, height: 240, fit: BoxFit.cover);
  }
}