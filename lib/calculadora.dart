import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math' as math;

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Avançada',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String expressao = '';
  String resultado = '';

  void adicionarExpressao(String valor) {
    setState(() {
      expressao += valor;
    });
  }
  
  void calcularResultado() {
    try {
      String expressaoTratada = expressao
          .replaceAll('%', '/100')
          .replaceAll("x", "*")
          .replaceAll("÷", "/");

      expressaoTratada = _substituirFuncoesMatematicas(expressaoTratada);

      Parser p = Parser();
      Expression exp = p.parse(expressaoTratada);

      ContextModel cm = ContextModel();

      double res = exp.evaluate(EvaluationType.REAL, cm);

      res = _arredondar(res, 10);

      setState(() {
        resultado = res.toString();
      });
    } catch (e) {
      setState(() {
        resultado = 'Erro';
      });
    }
  }

  double _arredondar(double valor, int casasDecimais) {
    double fator = math.pow(10, casasDecimais).toDouble();
    return (valor * fator).roundToDouble() / fator;
  }

  String _substituirFuncoesMatematicas(String expressao) {
    expressao = expressao.replaceAllMapped(
      RegExp(r'sin\(([^)]+)\)'),
      (match) {
        double graus = double.parse(match.group(1)!);
        double radianos = graus * (math.pi / 180);
        return '${math.sin(radianos)}';
      },
    );

    expressao = expressao.replaceAllMapped(
      RegExp(r'cos\(([^)]+)\)'),
      (match) {
        double graus = double.parse(match.group(1)!);
        double radianos = graus * (math.pi / 180);
        return '${math.cos(radianos)}';
      },
    );

    expressao = expressao.replaceAllMapped(
      RegExp(r'tan\(([^)]+)\)'),
      (match) {
        double graus = double.parse(match.group(1)!);
        double radianos = graus * (math.pi / 180);
        return '${math.tan(radianos)}';
      },
    );

    expressao = expressao.replaceAllMapped(
      RegExp(r'log\(([^)]+)\)'),
      (match) => '${math.log(double.parse(match.group(1)!))}',
    );

    expressao = expressao.replaceAllMapped(
      RegExp(r'exp\(([^)]+)\)'),
      (match) => '${math.exp(double.parse(match.group(1)!))}',
    );

    expressao = expressao.replaceAllMapped(
      RegExp(r'sqrt\(([^)]+)\)'),
      (match) => '${math.sqrt(double.parse(match.group(1)!))}',
    );

    return expressao;
  }

  void limpar() {
    setState(() {
      expressao = '';
      resultado = '';
    });
  }

  Widget botao(String texto, {Color cor = Colors.blue, VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(6),
        backgroundColor: cor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed ?? () => adicionarExpressao(texto),
      child: Center(
        child: AutoSizeText(
          texto,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          maxLines: 2,
          minFontSize: 6,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double larguraTela = MediaQuery.of(context).size.width;
    final int crossAxisCount = larguraTela > 600 ? 6 : 4;

    final List<Widget> botoes = [
      botao('C', cor: Colors.red, onPressed: limpar),
      botao('(', cor: Colors.green),
      botao(')', cor: Colors.green),
      botao('⌫', cor: Colors.red, onPressed: () {
        if (expressao.isNotEmpty) {
          setState(() {
            expressao = expressao.substring(0, expressao.length - 1);
          });
        }
      }),
      botao('7'),
      botao('8'),
      botao('9'),
      botao('÷', cor: Colors.orange),
      botao('4'),
      botao('5'),
      botao('6'),
      botao('x', cor: Colors.orange),
      botao('1'),
      botao('2'),
      botao('3'),
      botao('-', cor: Colors.orange),
      botao('0'),
      botao('.'),
      botao('=', cor: const Color.fromARGB(255, 0, 0, 255), onPressed: calcularResultado),
      botao('+', cor: Colors.orange),
      botao('sin(', cor: Colors.green),
      botao('cos(', cor: Colors.green),
      botao('tan(', cor: Colors.green),
      botao('^', cor: Colors.green),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Define o raio das bordas arredondadas
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    expressao,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    resultado,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: botoes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return botoes[index];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}