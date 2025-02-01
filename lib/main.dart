import 'package:flutter/material.dart';
import 'calculadora.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Avançada',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Calculadora Avançada'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 106, 205, 255), // Cor de fundo azul clara
                        borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                        border: Border.all(
                          color: Colors.blue.shade700, // Borda azul escura
                          width: 4, // Espessura da borda
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade200, // Sombra azul
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: const Calculadora(),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Talento Tech',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Cor do texto azul
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}