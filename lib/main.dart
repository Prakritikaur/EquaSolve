import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  final double equationFontSize = 50;
  final double resultFontSize = 38;

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        if (equation.length > 1) {
          equation = equation.substring(0, equation.length - 1);
        } else {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation.replaceAll("×", "*").replaceAll("÷", "/");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor, Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
            ),
            padding: const EdgeInsets.all(16),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          onPressed: () => onButtonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 20, 30, 0),
                child: Text(
                  equation,
                  style: TextStyle(fontSize: equationFontSize),
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 20, 30, 0),
                child: Text(
                  result,
                  style: TextStyle(fontSize: resultFontSize),
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox(height: 1)),  // Replaced Divider with SizedBox
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.transparent, Colors.pinkAccent),
                        buildButton("⌫", 1, Colors.transparent, Colors.pinkAccent),
                        buildButton("÷", 1, Colors.transparent, Colors.pinkAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.transparent, Colors.black87),
                        buildButton("2", 1, Colors.transparent, Colors.black87),
                        buildButton("3", 1, Colors.transparent, Colors.black87),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.transparent, Colors.black87),
                        buildButton("5", 1, Colors.transparent, Colors.black87),
                        buildButton("6", 1, Colors.transparent, Colors.black87),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.transparent, Colors.black87),
                        buildButton("8", 1, Colors.transparent, Colors.black87),
                        buildButton("9", 1, Colors.transparent, Colors.black87),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.transparent, Colors.black87),
                        buildButton("0", 1, Colors.transparent, Colors.black87),
                        buildButton("00", 1, Colors.transparent, Colors.black87),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.transparent, Colors.pinkAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.transparent, Colors.pinkAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.transparent, Colors.pinkAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.transparent, Colors.pinkAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
