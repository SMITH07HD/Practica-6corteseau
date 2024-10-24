import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Tools App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenu(),
    );
  }
}

// Pantalla Principal
class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Tools App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToolBoxScreen()),
                );   
              },
              child: Text('Caja de Herramientas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenderPredictionScreen()),
                );
              },
              child: Text('Predicción de Género'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgePredictionScreen()),
                );
              },
              child: Text('Predicción de Edad'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UniversityScreen()),
                );
              },
              child: Text('Buscar Universidades'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherScreen()),
                );
              },
              child: Text('Clima en RD'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordPressNewsScreen()),
                );
              },
              child: Text('Noticias de WordPress'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
              child: Text('Acerca de'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla de Caja de Herramientas
class ToolBoxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caja de Herramientas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Esta app tiene varias funcionalidades:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://licoferreteria.com/cdn/shop/products/CHP-16P_600x.jpg?v=1676895998',
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla de Predicción de Género
class GenderPredictionScreen extends StatefulWidget {
  @override
  _GenderPredictionScreenState createState() => _GenderPredictionScreenState();
}

class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _gender = '';
  Color _backgroundColor = Colors.white;

  Future<void> _predictGender() async {
    String name = _nameController.text;
    if (name.isEmpty) return;

    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _gender = data['gender'] ?? 'unknown';
        if (_gender == 'male') {
          _backgroundColor = Colors.blue;
        } else if (_gender == 'female') {
          _backgroundColor = Colors.pink;
        } else {
          _backgroundColor = Colors.grey;
        }
      });
    } else {
      setState(() {
        _gender = 'error';
        _backgroundColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
      ),
      body: Container(
        color: _backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Introduce un nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _predictGender,
                child: Text('Predecir Género'),
              ),
              SizedBox(height: 20),
              if (_gender.isNotEmpty)
                Text(
                  'El género es: $_gender',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla de Predicción de Edad
class AgePredictionScreen extends StatefulWidget {
  @override
  _AgePredictionScreenState createState() => _AgePredictionScreenState();
}

class _AgePredictionScreenState extends State<AgePredictionScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _ageCategory = '';
  int _age = 0;
  String _image = '';

  Future<void> _predictAge() async {
    String name = _nameController.text;
    if (name.isEmpty) return;

    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _age = data['age'] ?? 0;
        if (_age < 18) {
          _ageCategory = 'Joven';
          _image = 'https://img.freepik.com/vector-premium/nino-feliz-dibujos-animados-levantando-mano_353337-793.jpg'; 
        } else if (_age >= 18 && _age <= 60) {
          _ageCategory = 'Adulto';
          _image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBY08UTFTatR7TIB0YBs845234WrUNCKBDfg&s';
        } else {
          _ageCategory = 'Anciano';
          _image = 'https://thumbs.dreamstime.com/b/anciano-sosteniendo-una-vara-y-saludando-aislado-en-un-fondo-blanco-207499124.jpg';
        }
      });
    } else {
      setState(() {
        _ageCategory = 'error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Introduce un nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictAge,
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20),
            if (_ageCategory.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Categoría: $_ageCategory',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Edad: $_age',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Image.network(_image, height: 300),
                ],
              ),
          ],
        ),
      ),
    );
  }
}


class UniversityScreen extends StatefulWidget {
  @override
  _UniversityScreenState createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  final TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];

  Future<void> _fetchUniversities() async {
    String country = _countryController.text;
    if (country.isEmpty) return;

    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));

    if (response.statusCode == 200) {
      setState(() {
        _universities = json.decode(response.body);
      });
    } else {
      setState(() {
        _universities = [];
      });
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Universidades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'Introduce un país',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchUniversities,
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  final university = _universities[index];
                  return ListTile(
                    title: Text(university['name'] ?? 'Nombre no disponible'), // Manejo de null
                    subtitle: Text(university['web_pages'][0] ?? 'Dominio no disponible'), // Manejo de null
                    onTap: () {
                      if (university['web_pages'].isNotEmpty) { 
                        _launchURL(university['web_pages'][0]);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Pantalla del Clima en RD
class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _weatherInfo = 'Cargando...';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final apiKey = '422a7585f0a1f089843676a1d7834730'; // clave de API
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=Dominican Republic&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weatherInfo = 'Temperatura: ${data['main']['temp']}°C\n'
                         'Descripción: ${data['weather'][0]['description']}';
        });
      } else {
        setState(() {
          _weatherInfo = 'Error al cargar el clima.';
        });
      }
    } catch (e) {
      setState(() {
        _weatherInfo = 'Error de conexión.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en RD'),
      ),
      body: Center(
        child: Text(_weatherInfo),
      ),
    );
  }
}

// Pantalla de Noticias de WordPress
class WordPressNewsScreen extends StatefulWidget {
  @override
  _WordPressNewsScreenState createState() => _WordPressNewsScreenState();
}

class _WordPressNewsScreenState extends State<WordPressNewsScreen> {
  List<dynamic> newsArticles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse('https://remolacha.net/wp-json/wp/v2/posts'));
    if (response.statusCode == 200) {
      setState(() {
        newsArticles = json.decode(response.body).take(3).toList();
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de WordPress'),
      ),
      body: newsArticles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Image.network('https://149366094.v2.pressablecdn.com/wp-content/uploads/2017/06/cropped-logo.png'), 
                  ...newsArticles.map((article) {
                    return ListTile(
                      title: Text(article['title']['rendered']),
                      subtitle: Text(article['excerpt']['rendered'].replaceAll(RegExp(r'<[^>]*>'), '')), // Limpia HTML
                      onTap: () {
                        // Aquí puedes abrir el enlace a la noticia original
                        final url = article['link'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WebViewScreen(url: url)),
                        );
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticia'),
      ),
      body: Center(
        child: Text('Abriendo: $url'),
      ),
    );
  }
}

// Pantalla de Acerca de
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/my-photo.jpg') , 
            ),
            SizedBox(height: 20),
            Text(
              'Russbell Smith Montero Turbi',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Contacto: Smithrussbell0@gmail.com',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Teléfono: +18293942943',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

